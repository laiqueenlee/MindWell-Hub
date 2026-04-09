package com.secj3303.controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.secj3303.dao.ForumPostDao;
import com.secj3303.dao.ForumReplyDao;
import com.secj3303.dao.ModerationItemDao;
import com.secj3303.dao.StudentReportDao;
import com.secj3303.model.ForumPost;
import com.secj3303.model.ForumReply;
import com.secj3303.model.Report.StudentReport;
import com.secj3303.model.User;


@Controller
@RequestMapping("/student/forum")
public class ForumController {
    private static final Logger log = LoggerFactory.getLogger(ForumController.class);
    @Autowired
    private ForumPostDao postDao;

    @Autowired
    private ForumReplyDao replyDao;

    @Autowired
    private com.secj3303.dao.ForumPostLikeDao likeDao;

    @Autowired
    private StudentReportDao studentReportDao;

    @Autowired
    private ModerationItemDao moderationItemDao;


    @GetMapping
    public String forumIndex(Model model, HttpSession session) {
        List<ForumPost> posts = postDao.findAllDesc();
        int count = posts == null ? 0 : posts.size();
        log.info("[ForumController] posts fetched: {}", count);
        if (posts != null) {
            for (ForumPost pp : posts) {
                log.info("[ForumController] post id={} title='{}' likes={} replies={} createdAt={}",
                    pp.getId(), pp.getTitle(), pp.getLikes(), pp.getReplyCount(), pp.getCreatedAt());
            }
        }
        model.addAttribute("posts", posts == null ? java.util.Collections.emptyList() : posts);
        User u = (User) session.getAttribute("loggedInUser");
        java.util.Set<Long> likedPostIds = new java.util.HashSet<>();
        if (u != null && posts != null) {
            Long userId = Long.valueOf(u.getId());
            for (ForumPost pp : posts) {
                try {
                    if (likeDao.findByPostAndUser(pp.getId(), userId) != null) {
                        likedPostIds.add(pp.getId());
                    }
                } catch (Exception ex) {
                    log.debug("Error checking like for post {}: {}", pp.getId(), ex.toString());
                }
            }
        }
        model.addAttribute("likedPostIds", likedPostIds);
        return "student/peer"; 
    }

    @GetMapping("/new-post")
    public String newPostForm() {
        return "student/new-post";
    }

    @GetMapping("/post/{id}")
    public String viewPostByPath(@PathVariable Long id, Model model, HttpSession session) {
        return viewPostById(id, model, session);
    }

    @GetMapping("/post")
    public String viewPostByParam(@RequestParam(name = "id", required = false) Long id,
                                  Model model, HttpSession session) {
        return viewPostById(id, model, session);
    }

    private String viewPostById(Long id, Model model, HttpSession session) {
        if (id == null) {
            return "redirect:/student/forum";
        }
        ForumPost post = postDao.findById(id);
        if (post == null) {
            return "redirect:/student/forum";
        }
        List<ForumReply> replies = replyDao.findByPostId(post.getId());
        model.addAttribute("post", post);
        model.addAttribute("replies", replies);
        User u = (User) (session != null ? session.getAttribute("loggedInUser") : null);
        boolean liked = false;
        if (u != null) {
            try {
                com.secj3303.model.ForumPostLike existing = likeDao.findByPostAndUser(post.getId(), Long.valueOf(u.getId()));
                liked = existing != null;
            } catch (Exception ex) {
                log.debug("Error checking like for post {}: {}", post.getId(), ex.toString());
            }
        }
        model.addAttribute("liked", liked);
        return "student/post";
    }


    @PostMapping("/submit-post")
    public String submitPost(
            @RequestParam String postTitle,
            @RequestParam String postContent,
            @RequestParam String category,
            @RequestParam(required=false) String postAnonymously,
            HttpSession session,
            RedirectAttributes ra) {
        User u = (User) session.getAttribute("loggedInUser");
        String author = resolveAuthor(u, postAnonymously != null);
        String avatar = author.isEmpty() ? "A" : author.substring(0,1).toUpperCase();

        ForumPost p = new ForumPost();
        p.setTitle(postTitle);
        p.setContent(postContent);
        p.setCategory(category);
        p.setAuthorName(author);
        p.setAuthorId(u != null ? Long.valueOf(u.getId()) : null);
        p.setAvatar(avatar);
        p.setReplyCount(p.getReplyCount() == null ? 0 : p.getReplyCount());
        p.setLikes(p.getLikes() == null ? 0 : p.getLikes());
        postDao.save(p);
        ra.addFlashAttribute("newPostId", p.getId());
        return "redirect:/student/forum";
    }

    @PostMapping("/addReply")
    public String addReply(@RequestParam Long postId,
                           @RequestParam String content,
                           HttpSession session) {
        ForumPost post = postDao.findById(postId);
        if (post == null) return "redirect:/student/forum";

        User u = (User) session.getAttribute("loggedInUser");
        String author = resolveAuthor(u, false);
        String avatar = author.isEmpty() ? "U" : author.substring(0,1).toUpperCase();

        ForumReply r = new ForumReply(postId, author, avatar, content);
        r.setAuthorId(u != null ? Long.valueOf(u.getId()) : null);
        replyDao.save(r);
        Integer current = post.getReplyCount();
        post.setReplyCount((current == null ? 0 : current) + 1);
        postDao.save(post);

        return "redirect:/student/forum/post/" + postId;
    }

    @PostMapping(value = "/toggle-like", produces = "application/json")
    @org.springframework.web.bind.annotation.ResponseBody
    public java.util.Map<String, Object> toggleLike(@RequestParam Long postId, HttpSession session) {
        java.util.Map<String, Object> resp = new java.util.HashMap<>();
        User u = (User) session.getAttribute("loggedInUser");
        if (u == null) {
            resp.put("ok", false);
            resp.put("error", "not-authenticated");
            return resp;
        }

        ForumPost post = postDao.findById(postId);
        if (post == null) {
            resp.put("ok", false);
            resp.put("error", "post-not-found");
            return resp;
        }

        Long userId = Long.valueOf(u.getId());
        com.secj3303.model.ForumPostLike existing = likeDao.findByPostAndUser(postId, userId);
        if (existing != null) {
            // unike
            likeDao.delete(existing);
            Integer likes = post.getLikes() == null ? 0 : post.getLikes();
            post.setLikes(Math.max(0, likes - 1));
            postDao.save(post);
            resp.put("ok", true);
            resp.put("liked", false);
            resp.put("likes", post.getLikes());
            return resp;
        } else {
            // like
            com.secj3303.model.ForumPostLike like = new com.secj3303.model.ForumPostLike(postId, userId);
            likeDao.save(like);
            Integer likes = post.getLikes() == null ? 0 : post.getLikes();
            post.setLikes(likes + 1);
            postDao.save(post);
            resp.put("ok", true);
            resp.put("liked", true);
            resp.put("likes", post.getLikes());
            return resp;
        }
    }

    private String resolveAuthor(User u, boolean anon) {
        if (anon) return "Anonymous";
        if (u == null) return "Current User";
        if (u.getFullName() != null && !u.getFullName().isEmpty()) return u.getFullName();
        if (u.getUsername() != null && !u.getUsername().isEmpty()) return u.getUsername();
        return "Current User";
    }

    @PostMapping(value = "/report", produces = "application/json")
    @org.springframework.web.bind.annotation.ResponseBody
    public java.util.Map<String, Object> reportPostAction(@RequestParam(required=false) Long postId,
                                                           @RequestParam(required=false) Long replyId,
                                                           @RequestParam String reason,
                                                           @RequestParam(required=false) String details,
                                                           HttpSession session) {
        java.util.Map<String, Object> resp = new java.util.HashMap<>();
        User u = (User) session.getAttribute("loggedInUser");
        Integer reporterId = (u != null) ? Integer.valueOf(u.getId()) : null;
        if (postId == null && replyId == null) {
            resp.put("ok", false);
            resp.put("error", "missing-target");
            resp.put("message", "Either postId or replyId must be provided.");
            return resp;
        }

        Long persistPostId = (replyId != null) ? null : postId;
        Long persistReplyId = (replyId != null) ? replyId : null;

        StudentReport sr = new StudentReport(reporterId, persistPostId, persistReplyId, reason, details == null ? "" : details);
        try {
            studentReportDao.save(sr);
        } catch (Exception ex) {
            resp.put("ok", false);
            resp.put("error", "report-save-failed");
            return resp;
        }


        resp.put("ok", true);
        return resp;
    }

    @PostMapping("/deletePost")
    public String deletePostAction(@RequestParam Long postId, HttpSession session, RedirectAttributes ra) {
        User u = (User) session.getAttribute("loggedInUser");
        ForumPost post = postDao.findById(postId);
        if (post == null) return "redirect:/student/forum";
        if (u == null || post.getAuthorId() == null || !post.getAuthorId().equals(Long.valueOf(u.getId()))) {
            ra.addFlashAttribute("error", "Not authorized to delete this post.");
            return "redirect:/student/forum/post/" + postId;
        }
        postDao.delete(postId);
        ra.addFlashAttribute("message", "Post deleted.");
        return "redirect:/student/forum";
    }

    @PostMapping("/deleteReply")
    public String deleteReplyAction(@RequestParam Long replyId, HttpSession session, RedirectAttributes ra) {
        User u = (User) session.getAttribute("loggedInUser");
        ForumReply r = replyDao.findById(replyId);
        if (r == null) return "redirect:/student/forum";
        if (u == null || r.getAuthorId() == null || !r.getAuthorId().equals(Long.valueOf(u.getId()))) {
            ra.addFlashAttribute("error", "Not authorized to delete this reply.");
            return "redirect:/student/forum/post/" + r.getPostId();
        }
        Long postId = r.getPostId();
        replyDao.delete(replyId);
        ForumPost p = postDao.findById(postId);
        if (p != null) {
            Integer cnt = p.getReplyCount() == null ? 0 : p.getReplyCount();
            p.setReplyCount(Math.max(0, cnt - 1));
            postDao.save(p);
        }
        ra.addFlashAttribute("message", "Reply deleted.");
        return "redirect:/student/forum/post/" + postId;
    }

    @PostMapping("/editPost")
    public String editPostAction(@RequestParam Long postId, @RequestParam String title, @RequestParam String content, HttpSession session, RedirectAttributes ra) {
        User u = (User) session.getAttribute("loggedInUser");
        ForumPost post = postDao.findById(postId);
        if (post == null) return "redirect:/student/forum";
        if (u == null || post.getAuthorId() == null || !post.getAuthorId().equals(Long.valueOf(u.getId()))) {
            ra.addFlashAttribute("error", "Not authorized to edit this post.");
            return "redirect:/student/forum/post/" + postId;
        }
        post.setTitle(title);
        post.setContent(content);
        post.setCreatedAt(LocalDateTime.now());
        postDao.save(post);
        ra.addFlashAttribute("message", "Post updated.");
        return "redirect:/student/forum/post/" + postId;
    }
}
