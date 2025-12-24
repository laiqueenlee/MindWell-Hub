package com.secj3303.controller;

import com.secj3303.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Combined ForumController
 * - GET  /student/forum        -> list view (student/peer.jsp) with "posts"
 * - GET  /forum/post?id={id}   -> single post view (student/post.jsp) with "post" and "replies"
 * - GET  /forum/post/{id}      -> same as above (path variable)
 * - POST /forum/submit-post    -> add a new post (in-memory)
 */
@Controller
public class ForumController {

    // 1. STATIC LIST: in-memory posts store for the running app
    private static List<Map<String, String>> posts = new ArrayList<>();

    // 2. STATIC BLOCK: initialize sample data once
    static {
        posts.add(makePost("1", "Managing exam stress - what works for you?", "Anonymous", "Stress",
                "Finals are coming up and I'm feeling overwhelmed. What strategies have helped you cope with academic pressure?",
                "A", "Moderated", "24", "18", "2 hours ago"));

        posts.add(makePost("2", "How to deal with imposter syndrome", "Anonymous", "Anxiety",
                "Sometimes I feel like I don't belong here and everyone is better than me. Can anyone relate?",
                "A", "Moderated", "43", "31", "1 day ago"));

        posts.add(makePost("3", "Small wins: share one thing you accomplished today", "StudentUser", "Wellness",
                "I finished a short workout and it really lifted my mood — what about you?",
                "S", "Moderated", "12", "6", "3 hours ago"));
    }

    // --- PAGE ROUTES ---

    @GetMapping("/student/forum")
    public String forumIndex(Model model) {
        model.addAttribute("posts", posts);
        return "student/peer";
    }

    @GetMapping("/student/new-post")
    public String showCreatePostPage() {
        return "student/new-post";
    }

    // --- ACTION ROUTES ---

    @PostMapping("/forum/submit-post")
    public String submitPost(
            @RequestParam("postTitle") String title,
            @RequestParam("postContent") String content,
            @RequestParam("category") String category,
            @RequestParam(value = "postAnonymously", required = false) String anonymous,
            Model model,
            HttpSession session
    ) {
        int maxId = posts.stream()
                .mapToInt(p -> Integer.parseInt(p.get("id")))
                .max()
                .orElse(0);
        String newId = String.valueOf(maxId + 1);

        String author = "Current User";
        String avatar = "U";

        if (anonymous != null) {
            author = "Anonymous";
            avatar = "A";
        } else {
            Object logged = session.getAttribute("loggedInUser");
            if (logged instanceof User) {
                User u = (User) logged;
                if (u.getFullName() != null && !u.getFullName().isEmpty()) {
                    author = u.getFullName();
                } else if (u.getUsername() != null && !u.getUsername().isEmpty()) {
                    author = u.getUsername();
                }
                if (author != null && !author.isEmpty()) {
                    avatar = author.substring(0, 1).toUpperCase();
                }
            }
        }

        Map<String, String> newPost = makePost(
                newId,
                title,
                author,
                category, 
                content,
                avatar,
                "",
                "0",
                "0",
                "Just now"
        );

        posts.add(0, newPost);
        model.addAttribute("replies", Collections.emptyList());
        model.addAttribute("newPost", newPost);
        model.addAttribute("posts", posts);
        return "student/new-post";
    }

    // --- VIEW SINGLE POST (both param and path variants) ---

    @GetMapping("/forum/post")
    public String viewPostByParam(@RequestParam(name = "id", required = false, defaultValue = "1") String id,
                                  Model model) {
        return viewPostById(id, model);
    }

    @GetMapping("/forum/post/{id}")
    public String viewPostByPath(@PathVariable String id, Model model) {
        return viewPostById(id, model);
    }

    private String viewPostById(String id, Model model) {
        Map<String, String> foundPost = posts.stream()
                .filter(p -> p.get("id").equals(id))
                .findFirst()
                .orElse(null);

        if (foundPost != null) {
            model.addAttribute("post", foundPost);

            // Limit replies to the post's replyCount (safety check)
            List<Map<String, String>> allReplies = sampleReplies();
            int targetCount = 0;
            try {
                targetCount = Integer.parseInt(foundPost.getOrDefault("replyCount", "0"));
            } catch (NumberFormatException e) {
                targetCount = Math.min(allReplies.size(), 5);
            }
            if (targetCount > allReplies.size()) {
                targetCount = allReplies.size();
            }
            List<Map<String, String>> limitedReplies = allReplies.subList(0, targetCount);
            model.addAttribute("replies", limitedReplies);
            return "student/post";
        } else {
            return "redirect:/student/forum";
        }
    }

    // --- HELPERS ---

    private static Map<String, String> makePost(String id, String title, String author, String category, String content,
                                                String avatar, String badge, String likes, String replyCount, String time) {
        Map<String, String> p = new HashMap<>();
        p.put("id", id);
        p.put("title", title);
        p.put("author", author);
        p.put("category", category);
        p.put("excerpt", content);
        p.put("content", content);
        p.put("avatar", avatar);
        p.put("badge", badge);
        p.put("likes", likes);
        p.put("replyCount", replyCount);
        p.put("time", time);
        return p;
    }

    private List<Map<String,String>> sampleReplies() {
        List<Map<String,String>> replies = new ArrayList<>();
        replies.add(makeReply("Relax_Bro", "Ali • 1 hour ago", "Take deep breaths and remember that exams don't define you. You've got this!", "R"));
        replies.add(makeReply("Sam", "45 minutes ago", "Breaking study time into short sessions, getting enough sleep and quick breaks really helps.", "S"));
        replies.add(makeReply("Daniel", "12 minutes ago", "I find that taking regular breaks, staying positive, and getting enough rest helps me manage exam stress better.", "D"));
        replies.add(makeReply("Maya", "8 minutes ago", "Exercise has been a game-changer for me. Even a 15-minute walk helps clear my mind and reduce anxiety.", "M"));
        replies.add(makeReply("Jordan", "5 minutes ago", "Making a realistic study schedule has helped me feel more in control. I break down what I need to study by day and it feels less overwhelming.", "J"));
        replies.add(makeReply("Lisa", "3 minutes ago", "Meditation apps like Headspace or Calm have really helped me. Just 10 minutes a day makes a difference.", "L"));
        replies.add(makeReply("Chris", "2 minutes ago", "Study groups help me stay accountable and motivated. Plus, explaining concepts to others really reinforces my own understanding.", "C"));
        replies.add(makeReply("Emma", "1 minute ago", "I keep healthy snacks nearby while studying. Proper nutrition really affects my concentration and mood.", "E"));
        replies.add(makeReply("Tyler", "Just now", "Limiting caffeine has surprisingly helped me. I was drinking too much coffee which made my anxiety worse.", "T"));
        replies.add(makeReply("Nina", "Just now", "Talk to your professors if you're struggling! Most are really understanding and can offer guidance or extensions if needed.", "N"));
        replies.add(makeReply("Alex", "Just now", "I use the Pomodoro technique - 25 minutes of focused study, then a 5-minute break. It keeps me from burning out.", "A"));
        replies.add(makeReply("Kate", "Just now", "Remember to reach out to campus counseling services if you need extra support. They're there to help!", "K"));
        replies.add(makeReply("Relax_Bro", "Ali • 1 hour ago", "Take deep breaths and remember that exams don't define you. You've got this!", "R"));
        replies.add(makeReply("Sam", "45 minutes ago", "Breaking study time into short sessions, getting enough sleep and quick breaks really helps.", "S"));
        replies.add(makeReply("Daniel", "12 minutes ago", "I find that taking regular breaks, staying positive, and getting enough rest helps me manage exam stress better.", "D"));
        replies.add(makeReply("Maya", "8 minutes ago", "Exercise has been a game-changer for me. Even a 15-minute walk helps clear my mind and reduce anxiety.", "M"));
        replies.add(makeReply("Jordan", "5 minutes ago", "Making a realistic study schedule has helped me feel more in control. I break down what I need to study by day and it feels less overwhelming.", "J"));
        replies.add(makeReply("Lisa", "3 minutes ago", "Meditation apps like Headspace or Calm have really helped me. Just 10 minutes a day makes a difference.", "L"));
        replies.add(makeReply("Chris", "2 minutes ago", "Study groups help me stay accountable and motivated. Plus, explaining concepts to others really reinforces my own understanding.", "C"));
        replies.add(makeReply("Emma", "1 minute ago", "I keep healthy snacks nearby while studying. Proper nutrition really affects my concentration and mood.", "E"));
        replies.add(makeReply("Tyler", "Just now", "Limiting caffeine has surprisingly helped me. I was drinking too much coffee which made my anxiety worse.", "T"));
        replies.add(makeReply("Nina", "Just now", "Talk to your professors if you're struggling! Most are really understanding and can offer guidance or extensions if needed.", "N"));
        replies.add(makeReply("Alex", "Just now", "I use the Pomodoro technique - 25 minutes of focused study, then a 5-minute break. It keeps me from burning out.", "A"));
        replies.add(makeReply("Kate", "Just now", "Remember to reach out to campus counseling services if you need extra support. They're there to help!", "K"));
        return replies;
    }

    private Map<String,String> makeReply(String author, String time, String content, String avatar) {
        Map<String,String> r = new HashMap<>();
        r.put("author", author);
        r.put("time", time);
        r.put("content", content);
        r.put("avatar", avatar);
        return r;
    }

    @PostMapping("/forum/addReply")
    public String addReply(
            @RequestParam("postId") String postId,
            @RequestParam("content") String content,
            Model model,
            HttpSession session
    ) {
        // Find post
        Map<String, String> foundPost = posts.stream()
                .filter(p -> p.get("id").equals(postId))
                .findFirst()
                .orElse(null);

        if (foundPost == null) {
            return "redirect:/student/forum";
        }

        // Determine author from session (loggedInUser), fallback to "Current User"
        String author = "Current User";
        Object logged = session.getAttribute("loggedInUser");
        if (logged instanceof com.secj3303.model.User) {
            com.secj3303.model.User u = (com.secj3303.model.User) logged;
            if (u.getFullName() != null && !u.getFullName().isEmpty()) {
                author = u.getFullName();
            } else if (u.getUsername() != null && !u.getUsername().isEmpty()) {
                author = u.getUsername();
            }
        }

        // Create new reply with resolved author
        Map<String, String> newReply = new HashMap<>();
        newReply.put("author", author);
        newReply.put("time", "Just now");
        newReply.put("content", content);
        newReply.put("avatar", "U");

        // Update the post's replyCount first (safety)
        int newCount = 1;
        try {
            int rc = Integer.parseInt(foundPost.getOrDefault("replyCount", "0"));
            newCount = rc + 1;
        } catch (NumberFormatException ignored) {
            newCount = 1;
        }
        foundPost.put("replyCount", String.valueOf(newCount));

        // Build a replies list: prepend the new reply to the sample replies
        List<Map<String, String>> allReplies = new ArrayList<>(sampleReplies());
        allReplies.add(0, newReply);

        // Limit the replies list to the post's replyCount (safety check)
        int targetCount = newCount;
        if (targetCount > allReplies.size()) {
            targetCount = allReplies.size();
        }
        List<Map<String, String>> limitedReplies = new ArrayList<>(allReplies.subList(0, targetCount));

        model.addAttribute("post", foundPost);
        model.addAttribute("replies", limitedReplies);

        // Render the newreply view which shows the post with updated replies
        return "student/newreply";
    }
}
