/*
 * The Circlebook
 * Profile Page JavaScript
 */

document.addEventListener("DOMContentLoaded", () => {
    loadProfile();
});


/* =========================================
   LOAD PROFILE
========================================= */

function loadProfile() {
    const currentUser = getCurrentUser();

    if (!currentUser) {
        window.location.href = "login.html";
        return;
    }

    const users = getProfileUsers();
    const requestedId = new URLSearchParams(window.location.search).get("id");

    const user = users.find(
        (item) => item.id === (requestedId || currentUser.id)
    );

    if (!user) {
        showUnavailableProfile();
        return;
    }

    if (!canViewField(user, currentUser, users, "profile")) {
        showUnavailableProfile();
        return;
    }

    displayProfile(user, currentUser, users);
    initializePosts(user, currentUser);
}


/* =========================================
   GET USERS
========================================= */

function getProfileUsers() {

    const users = localStorage.getItem("circlebook_users");

    if (!users) {
        return [];
    }

    try {
        return JSON.parse(users);
    } catch (error) {
        console.error("Unable to load users:", error);
        return [];
    }
}


/* =========================================
   DISPLAY PROFILE
========================================= */

function displayProfile(user, viewer, users) {

    const name = user.fullName || "Unknown User";

    const location = canViewField(user, viewer, users, "profile")
        ? user.location || "Location not provided"
        : "Private";

    const education = canViewField(user, viewer, users, "profile")
        ? user.education || "Not provided"
        : "Private";

    const birthday = canViewField(user, viewer, users, "birthday") && user.birthday
            ? formatProfileDate(user.birthday)
            : canViewField(user, viewer, users, "birthday") ? "Not provided" : "Private";

    const gender =
        user.gender
            ? capitalize(user.gender)
            : "Not provided";


    /* Header */

    setText("profileName", name);
    setText("profileLocation", location);


    /* Initial */

    const initial =
        name.charAt(0).toUpperCase();

    setText("profileInitial", initial);


    /* Details */

    setText("detailName", name);
    setText("detailLocation", location);
    setText("detailEducation", education);
    setText("detailBirthday", birthday);
    setText("detailGender", gender);


    /* Interests */

    displayInterests(canViewField(user, viewer, users, "profile") ? user.interests : []);


    /* Friends */

    const friends =
        Array.isArray(user.friends)
            ? user.friends
            : [];

    setText(
        "friendCount",
        friends.length
    );
}

function initializePosts(user, viewer) {
    const form = document.getElementById("profilePostForm");
    const postsContainer = document.getElementById("profilePosts");

    if (!postsContainer) {
        return;
    }

    renderPosts(postsContainer, Array.isArray(user.posts) ? user.posts : []);

    if (!form || user.id !== viewer.id) {
        return;
    }

    form.hidden = false;
    form.addEventListener("submit", event => {
        event.preventDefault();

        const textElement = document.getElementById("profilePostText");
        const text = textElement ? textElement.value.trim() : "";
        if (!text) {
            return;
        }

        const users = getProfileUsers();
        const index = users.findIndex(item => item.id === user.id);
        if (index === -1) {
            return;
        }

        if (!Array.isArray(users[index].posts)) {
            users[index].posts = [];
        }

        users[index].posts.unshift({
            id: `post_${Date.now().toString(36)}`,
            text,
            createdAt: new Date().toISOString()
        });

        localStorage.setItem("circlebook_users", JSON.stringify(users));
        textElement.value = "";
        renderPosts(postsContainer, users[index].posts);
    });
}

function renderPosts(container, posts) {
    container.innerHTML = "";

    if (!posts.length) {
        const empty = document.createElement("p");
        empty.className = "empty-state";
        empty.textContent = "No posts yet.";
        container.appendChild(empty);
        return;
    }

    posts.forEach(post => {
        if (!post || !post.text) {
            return;
        }

        const article = document.createElement("article");
        article.className = "profile-post";

        const text = document.createElement("p");
        text.textContent = post.text;

        const date = document.createElement("time");
        date.dateTime = post.createdAt || "";
        date.textContent = post.createdAt ? formatProfileDate(post.createdAt) : "";

        article.appendChild(text);
        article.appendChild(date);
        container.appendChild(article);
    });
}


/* =========================================
   DISPLAY INTERESTS
========================================= */

function displayInterests(interests) {

    const container =
        document.getElementById("profileInterests");

    if (!container) {
        return;
    }

    container.innerHTML = "";


    if (!Array.isArray(interests) || interests.length === 0) {

        const empty =
            document.createElement("span");

        empty.className = "empty-state";
        empty.textContent =
            "No interests added yet.";

        container.appendChild(empty);

        return;
    }


    interests.forEach((interest) => {

        if (!interest) {
            return;
        }

        const tag =
            document.createElement("span");

        tag.className = "interest-tag";
        tag.textContent = interest;

        container.appendChild(tag);
    });
}


/* =========================================
   SET TEXT SAFELY
========================================= */

function setText(elementId, value) {

    const element =
        document.getElementById(elementId);

    if (element) {
        element.textContent = value;
    }
}


/* =========================================
   DATE FORMAT
========================================= */

function formatProfileDate(dateString) {

    const date = new Date(dateString);

    if (Number.isNaN(date.getTime())) {
        return "Not provided";
    }

    return date.toLocaleDateString("en-US", {
        year: "numeric",
        month: "long",
        day: "numeric"
    });
}


/* =========================================
   CAPITALIZE
========================================= */

function capitalize(value) {

    return value.charAt(0).toUpperCase() +
        value.slice(1);
}

function canViewField(user, viewer, users, field) {
    if (user.id === viewer.id) {
        return true;
    }

    const visibility = user.privacy && user.privacy[field] || "friends";
    if (visibility === "public") {
        return true;
    }
    if (visibility !== "friends") {
        return false;
    }

    const viewerRecord = users.find(item => item.id === viewer.id);
    return Array.isArray(user.friends) && user.friends.includes(viewer.id) &&
        Array.isArray(viewerRecord && viewerRecord.friends) && viewerRecord.friends.includes(user.id);
}

function showUnavailableProfile() {
    setText("profileName", "Profile unavailable");
    setText("profileLocation", "This profile is private or no longer available.");
    setText("profileInitial", "?");
    const content = document.querySelector(".profile-grid");
    if (content) {
        content.hidden = true;
    }
    document.querySelectorAll(".profile-actions").forEach(element => element.hidden = true);
}