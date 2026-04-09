package com.secj3303.controller.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.secj3303.dao.ContentDao;
import com.secj3303.dao.ForumPostDao;
import com.secj3303.dao.ModerationItemDao;
import com.secj3303.dao.StudentReportDao;
import com.secj3303.dao.UserDao;
import com.secj3303.model.Content.Content;
import com.secj3303.model.User;

@Controller
@RequestMapping("/admin")
public class ModerationController {

    private final ContentDao contentDao; 
    private final UserDao userDao;
    private final ModerationItemDao moderationItemDao;
    private final ForumPostDao forumPostDao;
    private final com.secj3303.dao.ForumReplyDao forumReplyDao;
    private final StudentReportDao studentReportDao;

    @Autowired
    public ModerationController(ContentDao contentDao, UserDao userDao, ModerationItemDao moderationItemDao, ForumPostDao forumPostDao, com.secj3303.dao.ForumReplyDao forumReplyDao, StudentReportDao studentReportDao) {
        this.contentDao = contentDao;
        this.userDao = userDao;
        this.moderationItemDao = moderationItemDao;
        this.forumPostDao = forumPostDao;
        this.forumReplyDao = forumReplyDao;
        this.studentReportDao = studentReportDao;
    }


    @GetMapping("/moderation-queue") 
    public String showModerationQueue(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/auth/login";

        model.addAttribute("moderationItems", contentDao.findByStatus("Pending"));
        model.addAttribute("user", loggedInUser);
        
        return "/admin/moderation-queue"; 
    }

    @GetMapping("/forum-moderation-queue")
    public String showForumModerationQueue(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/auth/login";

        java.util.List<com.secj3303.model.Content.ModerationItem> items = new java.util.ArrayList<>();
        java.util.List<com.secj3303.model.Content.ModerationItem> persisted = moderationItemDao.findPendingItems();
        if (persisted != null) items.addAll(persisted);

        java.util.List<com.secj3303.model.Report.StudentReport> reports = studentReportDao.findPendingReports();
        java.util.Map<Integer, com.secj3303.model.Report.StudentReport> studentReportsMap = new java.util.HashMap<>();
        java.util.Map<Integer, String> studentReporters = new java.util.HashMap<>();
        if (reports != null) {
            for (com.secj3303.model.Report.StudentReport sr : reports) {
                if (sr == null) continue;
                com.secj3303.model.Content.ModerationItem mi;
                if (sr.getReplyId() != null) {
                    mi = new com.secj3303.model.Content.ModerationItem("Comment", "medium", "reply:" + sr.getReplyId(), null, sr.getReason());
                } else {
                    mi = new com.secj3303.model.Content.ModerationItem("Forum Post", "medium", "post:" + (sr.getPostId() == null ? "0" : sr.getPostId()), null, sr.getReason());
                }
                mi.setStatus(sr.getStatus() == null ? "PENDING" : sr.getStatus());
                int nid = sr.getId() == null ? 0 : -sr.getId();
                mi.setId(nid);
                items.add(mi);
                studentReportsMap.put(nid, sr);

                String reporterName = "Unknown";
                try {
                    if (sr.getReporterId() != null) {
                        com.secj3303.model.User ruser = userDao.findById(sr.getReporterId());
                        if (ruser != null) {
                            if (ruser.getFullName() != null && !ruser.getFullName().isEmpty()) reporterName = ruser.getFullName();
                            else if (ruser.getUsername() != null && !ruser.getUsername().isEmpty()) reporterName = ruser.getUsername();
                        }
                    }
                } catch (Exception e) {
                    // ignore
                }
                studentReporters.put(nid, reporterName);
            }
        }

        model.addAttribute("moderationItems", items == null ? java.util.Collections.emptyList() : items);
        model.addAttribute("user", loggedInUser);

        java.util.Map<Integer, Object> reportedPosts = new java.util.HashMap<>();
        java.util.Map<Integer, String> reportedPostExcerpts = new java.util.HashMap<>();
        java.util.Map<Integer, Object> reportedReplies = new java.util.HashMap<>();
        java.util.Map<Integer, String> reportedReplyExcerpts = new java.util.HashMap<>();
        java.util.Map<Integer, com.secj3303.model.ForumPost> reportedParentPosts = new java.util.HashMap<>();

        if (items != null) {
            for (com.secj3303.model.Content.ModerationItem mi : items) {
                if (mi == null) continue;
                String title = mi.getTitle();
                if (title != null && title.startsWith("post:")) {
                    try {
                        Long postId = Long.valueOf(title.substring(5));
                        com.secj3303.model.ForumPost p = forumPostDao.findById(postId);
                        if (p != null) {
                            reportedPosts.put(mi.getId(), p);
                            String content = p.getContent() == null ? "" : p.getContent();
                            String excerpt = content.length() > 300 ? content.substring(0, 300) + "…" : content;
                            reportedPostExcerpts.put(mi.getId(), excerpt);
                        }
                    } catch (Exception ex) {
                        // ignore 
                    }
                } else if (title != null && title.startsWith("reply:")) {
                    try {
                        Long replyId = Long.valueOf(title.substring(6));
                        com.secj3303.model.ForumReply rep = forumReplyDao.findById(replyId);
                        if (rep != null) {
                            reportedReplies.put(mi.getId(), rep);
                            String content = rep.getContent() == null ? "" : rep.getContent();
                            String excerpt = content.length() > 300 ? content.substring(0, 300) + "…" : content;
                            reportedReplyExcerpts.put(mi.getId(), excerpt);
                            // also resolve parent post for this reply so the JSP can show it
                            try {
                                Long parentPostId = rep.getPostId();
                                if (parentPostId != null) {
                                    com.secj3303.model.ForumPost parent = forumPostDao.findById(parentPostId);
                                    if (parent != null) reportedParentPosts.put(mi.getId(), parent);
                                }
                            } catch (Exception ex) {
                                // ignore
                            }
                        }
                    } catch (Exception ex) {
                        // ignore
                    }
                }
            }
        }

        model.addAttribute("reportedPosts", reportedPosts);
        model.addAttribute("reportedPostExcerpts", reportedPostExcerpts);
        model.addAttribute("reportedReplies", reportedReplies);
        model.addAttribute("reportedReplyExcerpts", reportedReplyExcerpts);
        model.addAttribute("reportedParentPosts", reportedParentPosts);
        model.addAttribute("studentReports", studentReportsMap);
        model.addAttribute("studentReporters", studentReporters);

        return "/admin/forum-moderation-queue";
    }

    @PostMapping("/moderation/flag") 
    public String flagContent(@RequestParam("contentId") int contentId, 
                              @RequestParam("reason") String reason,
                              RedirectAttributes redirectAttributes) {
        
        Content content = contentDao.findById(contentId);
        if (content != null) {
            content.setStatus("Flagged");
            content.setFlagReason(reason);
            contentDao.save(content);
            redirectAttributes.addFlashAttribute("message", "Content flagged successfully.");
        }
        
        return "redirect:/admin/moderation-queue";
    }

    @GetMapping("/moderation/approve/{id}") 
    public String approveContent(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        Content content = contentDao.findById(id);
        if (content != null) {
            content.setStatus("Published");
            contentDao.save(content);
            redirectAttributes.addFlashAttribute("message", "Content approved.");
        }
        return "redirect:/admin/moderation-queue";
    }

    @GetMapping("/moderation/dismiss/{id}")
    public String dismissReport(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        if (id < 0) {
            int rid = -id;
            com.secj3303.model.Report.StudentReport sr = studentReportDao.findById(rid);
            if (sr != null) {
                sr.setStatus("DISMISSED");
                studentReportDao.save(sr);
                redirectAttributes.addFlashAttribute("message", "Student report dismissed.");
            }
        } else {
            com.secj3303.model.Content.ModerationItem mi = moderationItemDao.findById(id);
            if (mi != null) {
                mi.setStatus("DISMISSED");
                moderationItemDao.save(mi);
                redirectAttributes.addFlashAttribute("message", "Report dismissed.");
            }
        }
        return "redirect:/admin/forum-moderation-queue";
    }

    @GetMapping("/moderation/removePost/{id}")
    public String removePostFromReport(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        if (id < 0) {
            int rid = -id;
            com.secj3303.model.Report.StudentReport sr = studentReportDao.findById(rid);
            if (sr != null) {
                Long postId = sr.getPostId();
                if (postId != null) {
                    try { forumPostDao.delete(postId); } catch (Exception e) { }
                }
                studentReportDao.delete(rid);
                redirectAttributes.addFlashAttribute("message", "Post removed and student report cleared.");
            }
        } else {
            com.secj3303.model.Content.ModerationItem mi = moderationItemDao.findById(id);
            if (mi != null) {
                String title = mi.getTitle();
                if (title != null && title.startsWith("post:")) {
                    try {
                        Long postId = Long.valueOf(title.substring(5));
                        forumPostDao.delete(postId);
                    } catch (Exception ex) {
                        // ignore 
                    }
                }
                moderationItemDao.delete(id);
                redirectAttributes.addFlashAttribute("message", "Post removed and report cleared.");
            }
        }
        return "redirect:/admin/forum-moderation-queue";
    }

    @GetMapping("/moderation/removeReply/{id}")
    public String removeReplyFromReport(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        if (id < 0) {
            int rid = -id;
            com.secj3303.model.Report.StudentReport sr = studentReportDao.findById(rid);
            if (sr != null) {
                Long replyId = sr.getReplyId();
                if (replyId != null) {
                    try { forumReplyDao.delete(replyId); } catch (Exception e) { }
                }
                studentReportDao.delete(rid);
                redirectAttributes.addFlashAttribute("message", "Comment removed and student report cleared.");
            }
        } else {
            com.secj3303.model.Content.ModerationItem mi = moderationItemDao.findById(id);
            if (mi != null) {
                String title = mi.getTitle();
                if (title != null && title.startsWith("reply:")) {
                    try {
                        Long replyId = Long.valueOf(title.substring(6));
                        try { forumReplyDao.delete(replyId); } catch (Exception e) { }
                    } catch (Exception ex) {
                        // ignore 
                    }
                }
                moderationItemDao.delete(id);
                redirectAttributes.addFlashAttribute("message", "Comment removed and report cleared.");
            }
        }
        return "redirect:/admin/forum-moderation-queue";
    }

    @GetMapping("/moderation/remove/{id}") 
    public String removeContent(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        contentDao.delete(id);
        redirectAttributes.addFlashAttribute("error", "Content removed.");
        return "redirect:/admin/moderation-queue";
    }
}