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

    const currentUserData =
        localStorage.getItem("circlebook_current_user");

    if (!currentUserData) {
        window.location.href = "login.html";
        return;
    }

    let currentUser;

    try {
        currentUser = JSON.parse(currentUserData);
    } catch (error) {
        console.error("Invalid current user:", error);
        window.location.href = "login.html";
        return;
    }


    const users = getProfileUsers();

    const user = users.find(
        (item) => item.id === currentUser.id
    );

    if (!user) {
        window.location.href = "login.html";
        return;
    }


    displayProfile(user);
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

function displayProfile(user) {

    const name = user.fullName || "Unknown User";

    const location =
        user.location || "Location not provided";

    const education =
        user.education || "Not provided";

    const birthday =
        user.birthday
            ? formatProfileDate(user.birthday)
            : "Not provided";

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

    displayInterests(user.interests);


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