/*
 * The Circlebook
 * Profile Wall JavaScript
 */

document.addEventListener("DOMContentLoaded", () => {
    loadPosts();
});


function loadPosts() {
    const viewer = getCurrentUser();
    const postsContainer = document.getElementById("profilePosts");

    if (!viewer || !postsContainer) {
        return;
    }

    const users = normalizeUsers(getProfileUsers());
    const requestedId = new URLSearchParams(window.location.search).get("id");
    const profileUser = users.find(user => user.id === (requestedId || viewer.id));

    if (!profileUser || !canViewField(profileUser, viewer, users, "profile")) {
        return;
    }

    renderPosts(postsContainer, profileUser.posts, profileUser, viewer);

    const form = document.getElementById("profilePostForm");
    if (!form || profileUser.id !== viewer.id) {
        return;
    }

    form.hidden = false;
    form.addEventListener("submit", event => {
        event.preventDefault();
        createPost(profileUser.id);
    });
}


function normalizeUsers(users) {
    if (!Array.isArray(users)) {
        return [];
    }

    let changed = false;
    const normalizedUsers = users.map(user => {
        if (!user || typeof user !== "object") {
            return user;
        }

        if (!Array.isArray(user.posts)) {
            user.posts = [];
            changed = true;
        }

        user.posts = user.posts
            .filter(post => post && typeof post === "object")
            .map(post => {
                const content = typeof post.content === "string"
                    ? post.content
                    : typeof post.text === "string" ? post.text : "";
                const normalizedPost = {
                    id: post.id || `post_${Date.now().toString(36)}`,
                    authorId: post.authorId || user.id,
                    content,
                    createdAt: post.createdAt || new Date().toISOString(),
                    reactions: post.reactions && typeof post.reactions === "object"
                        ? post.reactions
                        : {},
                    comments: normalizeComments(post.comments)
                };

                if (
                    post.id !== normalizedPost.id ||
                    post.authorId !== normalizedPost.authorId ||
                    post.content !== normalizedPost.content ||
                    post.createdAt !== normalizedPost.createdAt ||
                    post.reactions !== normalizedPost.reactions ||
                    post.comments !== normalizedPost.comments ||
                    Object.prototype.hasOwnProperty.call(post, "text")
                ) {
                    changed = true;
                }

                return normalizedPost;
            });

        return user;
    });

    if (changed) {
        localStorage.setItem("circlebook_users", JSON.stringify(normalizedUsers));
    }

    return normalizedUsers;
}


function normalizeComments(comments) {
    if (!Array.isArray(comments)) {
        return [];
    }

    return comments
        .filter(comment => comment && typeof comment === "object")
        .map(comment => ({
            id: comment.id || `comment_${Date.now().toString(36)}`,
            authorId: comment.authorId || "",
            content: typeof comment.content === "string"
                ? comment.content
                : typeof comment.text === "string" ? comment.text : "",
            createdAt: comment.createdAt || new Date().toISOString(),
            replies: normalizeComments(comment.replies)
        }));
}


function renderPosts(container, posts, profileUser, viewer) {
    container.innerHTML = "";

    const visiblePosts = Array.isArray(posts)
        ? posts.filter(post => post && post.content)
        : [];

    if (!visiblePosts.length) {
        const empty = document.createElement("p");
        empty.className = "empty-state";
        empty.textContent = "No posts yet.";
        container.appendChild(empty);
        return;
    }

    visiblePosts.forEach(post => {
        const article = document.createElement("article");
        article.className = "profile-post";

        const content = document.createElement("p");
        content.textContent = post.content;

        const postActions = document.createElement("div");
        postActions.className = "wall-post-actions";

        const reactionButton = document.createElement("button");
        reactionButton.type = "button";
        reactionButton.className = "wall-action-button";
        updateReactionButton(reactionButton, post, viewer.id);
        reactionButton.addEventListener("click", () => toggleReaction(profileUser.id, post.id));
        postActions.appendChild(reactionButton);

        const reactionCount = document.createElement("span");
        reactionCount.className = "wall-reaction-count";
        reactionCount.textContent = getReactionCount(post);
        postActions.appendChild(reactionCount);

        article.appendChild(content);
        article.appendChild(postActions);

        const commentsSection = document.createElement("div");
        commentsSection.className = "wall-comments";
        renderComments(commentsSection, post, profileUser, viewer);
        article.appendChild(commentsSection);

        const postFooter = document.createElement("div");
        postFooter.className = "profile-post-footer";

        const date = document.createElement("time");
        date.dateTime = post.createdAt || "";
        date.textContent = formatPostDate(post.createdAt);
        postFooter.appendChild(date);

        if (post.authorId === viewer.id && post.authorId === profileUser.id) {
            const deleteButton = document.createElement("button");
            deleteButton.type = "button";
            deleteButton.className = "wall-delete-button";
            deleteButton.textContent = "Delete";
            deleteButton.addEventListener("click", () => deletePost(profileUser.id, post.id));
            postFooter.appendChild(deleteButton);
        }

        article.appendChild(postFooter);
        container.appendChild(article);
    });
}


function updateReactionButton(button, post, viewerId) {
    const reacted = Boolean(post.reactions && post.reactions[viewerId]);
    button.textContent = reacted ? "Reacted" : "React";
    button.classList.toggle("is-active", reacted);
    button.setAttribute("aria-pressed", String(reacted));
}


function getReactionCount(post) {
    return Object.keys(post.reactions || {}).length;
}


function renderComments(container, post, profileUser, viewer) {
    const comments = Array.isArray(post.comments) ? post.comments : [];

    if (comments.length) {
        const list = document.createElement("div");
        list.className = "wall-comment-list";
        comments.forEach(comment => renderComment(list, comment, post, profileUser, viewer));
        container.appendChild(list);
    }

    const form = document.createElement("form");
    form.className = "wall-comment-form";
    form.innerHTML = '<input type="text" maxlength="300" placeholder="Write a comment..." aria-label="Write a comment"><button type="submit" class="wall-action-button">Comment</button>';
    form.addEventListener("submit", event => {
        event.preventDefault();
        const input = form.querySelector("input");
        addComment(profileUser.id, post.id, input.value);
    });
    container.appendChild(form);
}


function renderComment(container, comment, post, profileUser, viewer) {
    const item = document.createElement("div");
    item.className = "wall-comment";

    const text = document.createElement("p");
    text.textContent = comment.content;
    item.appendChild(text);

    const meta = document.createElement("time");
    meta.dateTime = comment.createdAt || "";
    meta.textContent = formatPostDate(comment.createdAt);
    item.appendChild(meta);

    const replyButton = document.createElement("button");
    replyButton.type = "button";
    replyButton.className = "wall-action-button wall-reply-button";
    replyButton.textContent = "Reply";
    item.appendChild(replyButton);

    const replies = document.createElement("div");
    replies.className = "wall-replies";
    (comment.replies || []).forEach(reply => renderComment(replies, reply, post, profileUser, viewer));
    item.appendChild(replies);

    const replyForm = document.createElement("form");
    replyForm.className = "wall-comment-form wall-reply-form";
    replyForm.hidden = true;
    replyForm.innerHTML = '<input type="text" maxlength="300" placeholder="Write a reply..." aria-label="Write a reply"><button type="submit" class="wall-action-button">Reply</button>';
    replyButton.addEventListener("click", () => {
        replyForm.hidden = !replyForm.hidden;
    });
    replyForm.addEventListener("submit", event => {
        event.preventDefault();
        const input = replyForm.querySelector("input");
        addReply(profileUser.id, post.id, comment.id, input.value);
    });
    item.appendChild(replyForm);
    container.appendChild(item);
}


function toggleReaction(profileUserId, postId) {
    const viewer = getCurrentUser();
    const users = normalizeUsers(getProfileUsers());
    const profileUser = users.find(user => user.id === profileUserId);
    const post = profileUser && profileUser.posts.find(item => item.id === postId);

    if (!viewer || !profileUser || !post) {
        return;
    }

    if (!post.reactions || typeof post.reactions !== "object") {
        post.reactions = {};
    }

    if (post.reactions[viewer.id]) {
        delete post.reactions[viewer.id];
    } else {
        post.reactions[viewer.id] = "like";
    }

    saveWallUsers(users);
    rerenderWall(profileUser, viewer);
}


function addComment(profileUserId, postId, value) {
    const content = value.trim();
    if (!content) {
        showWallMessage("Please write a comment first.", "error");
        return;
    }

    const viewer = getCurrentUser();
    const users = normalizeUsers(getProfileUsers());
    const profileUser = users.find(user => user.id === profileUserId);
    const post = profileUser && profileUser.posts.find(item => item.id === postId);

    if (!viewer || !profileUser || !post) {
        return;
    }

    post.comments.push(createComment(viewer.id, content));
    saveWallUsers(users);
    rerenderWall(profileUser, viewer);
}


function addReply(profileUserId, postId, commentId, value) {
    const content = value.trim();
    if (!content) {
        showWallMessage("Please write a reply first.", "error");
        return;
    }

    const viewer = getCurrentUser();
    const users = normalizeUsers(getProfileUsers());
    const profileUser = users.find(user => user.id === profileUserId);
    const post = profileUser && profileUser.posts.find(item => item.id === postId);
    const comment = post && findComment(post.comments, commentId);

    if (!viewer || !profileUser || !comment) {
        return;
    }

    comment.replies.push(createComment(viewer.id, content));
    saveWallUsers(users);
    rerenderWall(profileUser, viewer);
}


function createComment(authorId, content) {
    return {
        id: `comment_${Date.now().toString(36)}_${Math.random().toString(36).slice(2, 7)}`,
        authorId,
        content,
        createdAt: new Date().toISOString(),
        replies: []
    };
}


function findComment(comments, commentId) {
    for (const comment of comments || []) {
        if (comment.id === commentId) {
            return comment;
        }
        const nested = findComment(comment.replies, commentId);
        if (nested) {
            return nested;
        }
    }
    return null;
}


function saveWallUsers(users) {
    localStorage.setItem("circlebook_users", JSON.stringify(users));
}


function rerenderWall(profileUser, viewer) {
    renderPosts(document.getElementById("profilePosts"), profileUser.posts, profileUser, viewer);
}


function validatePost(value) {
    const content = typeof value === "string" ? value.trim() : "";

    if (!content) {
        return "Please write something before posting.";
    }

    if (content.length > 500) {
        return "Posts must be 500 characters or fewer.";
    }

    return "";
}


function createPost(profileUserId) {
    const textElement = document.getElementById("profilePostText");
    const content = textElement ? textElement.value.trim() : "";
    const validationMessage = validatePost(content);

    if (validationMessage) {
        showWallMessage(validationMessage, "error");
        return;
    }

    const viewer = getCurrentUser();
    const users = normalizeUsers(getProfileUsers());
    const userIndex = users.findIndex(user => user.id === profileUserId);

    if (!viewer || viewer.id !== profileUserId || userIndex === -1) {
        showWallMessage("Only the profile owner can create a post.", "error");
        return;
    }

    users[userIndex].posts.unshift({
        id: `post_${Date.now().toString(36)}_${Math.random().toString(36).slice(2, 7)}`,
        authorId: viewer.id,
        content,
        createdAt: new Date().toISOString(),
        reactions: {},
        comments: []
    });

    localStorage.setItem("circlebook_users", JSON.stringify(users));
    textElement.value = "";
    renderPosts(
        document.getElementById("profilePosts"),
        users[userIndex].posts,
        users[userIndex],
        viewer
    );
    showWallMessage("Your post was added to the wall.", "success");
}


function deletePost(profileUserId, postId) {
    if (!window.confirm("Delete this post?")) {
        return;
    }

    const viewer = getCurrentUser();
    const users = normalizeUsers(getProfileUsers());
    const userIndex = users.findIndex(user => user.id === profileUserId);
    const profileUser = users[userIndex];

    if (!viewer || !profileUser || viewer.id !== profileUser.id) {
        showWallMessage("Only the post owner can delete it.", "error");
        return;
    }

    const post = profileUser.posts.find(item => item.id === postId);
    if (!post || post.authorId !== viewer.id) {
        showWallMessage("Only the post owner can delete it.", "error");
        return;
    }

    profileUser.posts = profileUser.posts.filter(item => item.id !== postId);
    localStorage.setItem("circlebook_users", JSON.stringify(users));
    renderPosts(
        document.getElementById("profilePosts"),
        profileUser.posts,
        profileUser,
        viewer
    );
    showWallMessage("Your post was deleted.", "success");
}


function formatPostDate(dateString) {
    const date = new Date(dateString);
    if (Number.isNaN(date.getTime())) {
        return "";
    }

    const now = new Date();
    const elapsedSeconds = Math.max(0, Math.floor((now - date) / 1000));

    if (elapsedSeconds < 60) {
        return "Just now";
    }

    if (elapsedSeconds < 60 * 60) {
        const minutes = Math.floor(elapsedSeconds / 60);
        return `${minutes} minute${minutes === 1 ? "" : "s"} ago`;
    }

    if (elapsedSeconds < 24 * 60 * 60) {
        const hours = Math.floor(elapsedSeconds / (60 * 60));
        return `${hours} hour${hours === 1 ? "" : "s"} ago`;
    }

    const yesterday = new Date(now);
    yesterday.setDate(now.getDate() - 1);
    if (date.toDateString() === yesterday.toDateString()) {
        return "Yesterday";
    }

    return date.toLocaleDateString("en-US", {
        year: "numeric",
        month: "long",
        day: "numeric"
    });
}


function showWallMessage(message, type) {
    const messageElement = document.getElementById("profilePostMessage");
    if (!messageElement) {
        return;
    }

    messageElement.textContent = message;
    messageElement.className = `wall-message ${type}`;
    messageElement.hidden = false;
}
