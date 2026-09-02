/*
 * The Circlebook
 * Profile & Privacy Settings
 */

document.addEventListener("DOMContentLoaded", () => {
    initializeSettings();
});


function initializeSettings() {
    const currentUser = getCurrentUser();

    if (!currentUser) {
        window.location.href = "login.html";
        return;
    }

    const users = getUsers();
    const user = users.find(item => item.id === currentUser.id);

    if (!user) {
        localStorage.removeItem("circlebook_current_user");
        window.location.href = "login.html";
        return;
    }

    loadProfileSettings(user);
    loadPrivacySettings(user);

    initializeProfileForm(user);
    initializePrivacyForm(user);
}


/* =========================
   USERS
========================= */

function getUsers() {
    try {
        return JSON.parse(
            localStorage.getItem("circlebook_users")
        ) || [];
    } catch (error) {
        console.error("Unable to load users:", error);
        return [];
    }
}


function saveUsers(users) {
    localStorage.setItem(
        "circlebook_users",
        JSON.stringify(users)
    );
}


/* =========================
   PROFILE SETTINGS
========================= */

function loadProfileSettings(user) {
    setValue("settingsName", user.fullName || "");
    setValue("settingsLocation", user.location || "");
    setValue("settingsEducation", user.education || "");

    const interests = Array.isArray(user.interests)
        ? user.interests.join(", ")
        : "";

    setValue("settingsInterests", interests);
}


function initializeProfileForm(user) {
    const form = document.getElementById("profileSettingsForm");

    if (!form) {
        return;
    }

    form.addEventListener("submit", event => {
        event.preventDefault();

        const users = getUsers();
        const index = users.findIndex(
            item => item.id === user.id
        );

        if (index === -1) {
            showSettingsMessage(
                "Unable to update your profile.",
                "error"
            );
            return;
        }

        const fullName =
            document.getElementById("settingsName").value.trim();

        const location =
            document.getElementById("settingsLocation").value.trim();

        const education =
            document.getElementById("settingsEducation").value.trim();

        const interestsValue =
            document.getElementById("settingsInterests").value.trim();

        if (!fullName) {
            showSettingsMessage(
                "Please enter your full name.",
                "error"
            );
            return;
        }

        users[index].fullName = fullName;
        users[index].location = location;
        users[index].education = education;

        users[index].interests = interestsValue
            ? interestsValue
                .split(",")
                .map(item => item.trim())
                .filter(Boolean)
            : [];

        saveUsers(users);

        updateCurrentUser(users[index]);

        showSettingsMessage(
            "Profile information saved successfully.",
            "success"
        );
    });
}


/* =========================
   PRIVACY SETTINGS
========================= */

function loadPrivacySettings(user) {
    const privacy = user.privacy || {};

    setValue(
        "profileVisibility",
        privacy.profile || "friends"
    );

    setValue(
        "birthdayVisibility",
        privacy.birthday || "friends"
    );

    setValue(
        "emailVisibility",
        privacy.email || "private"
    );
}


function initializePrivacyForm(user) {
    const form = document.getElementById("privacyForm");

    if (!form) {
        return;
    }

    form.addEventListener("submit", event => {
        event.preventDefault();

        const users = getUsers();
        const index = users.findIndex(
            item => item.id === user.id
        );

        if (index === -1) {
            showSettingsMessage(
                "Unable to update privacy settings.",
                "error"
            );
            return;
        }

        const allowedVisibility = ["public", "friends", "private"];
        const profileVisibility = document.getElementById("profileVisibility").value;
        const birthdayVisibility = document.getElementById("birthdayVisibility").value;
        const emailVisibility = document.getElementById("emailVisibility").value;

        if (![profileVisibility, birthdayVisibility, emailVisibility]
            .every(value => allowedVisibility.includes(value))) {
            showSettingsMessage("Please choose valid privacy settings.", "error");
            return;
        }

        users[index].privacy = {
            profile:
                profileVisibility,

            birthday:
                birthdayVisibility,

            email:
                emailVisibility
        };

        saveUsers(users);

        updateCurrentUser(users[index]);

        showSettingsMessage(
            "Privacy settings saved successfully.",
            "success"
        );
    });
}


/* =========================
   CURRENT USER
========================= */

function updateCurrentUser(user) {
    // This prototype stores credentials locally; keep passwords out of the session snapshot.
    const sessionUser = { ...user };
    delete sessionUser.password;
    localStorage.setItem(
        "circlebook_current_user",
        JSON.stringify(sessionUser)
    );
}


/* =========================
   HELPERS
========================= */

function setValue(id, value) {
    const element = document.getElementById(id);

    if (element) {
        element.value = value;
    }
}


function showSettingsMessage(message, type = "info") {
    const messageBox =
        document.getElementById("settingsMessage");

    if (!messageBox) {
        return;
    }

    messageBox.textContent = message;
    messageBox.className = `auth-message ${type}`;
    messageBox.hidden = false;

    setTimeout(() => {
        messageBox.hidden = true;
    }, 3000);
}