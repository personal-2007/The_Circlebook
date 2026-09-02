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