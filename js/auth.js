/*
 * The Circlebook
 * Authentication JavaScript
 *
 * Version 1:
 * - Registration
 * - Local browser storage
 * - Password validation
 * - Login support
 */

document.addEventListener("DOMContentLoaded", () => {
    initializeRegistration();
    initializeLogin();
});


/* =========================================
   STORAGE HELPERS
========================================= */

function getUsers() {
    const users = localStorage.getItem("circlebook_users");

    if (!users) {
        return [];
    }

    try {
        return JSON.parse(users);
    } catch (error) {
        console.error("Unable to read users:", error);
        return [];
    }
}


function saveUsers(users) {
    localStorage.setItem(
        "circlebook_users",
        JSON.stringify(users)
    );
}


/* =========================================
   REGISTRATION
========================================= */

function initializeRegistration() {

    const form = document.getElementById("registerForm");

    if (!form) {
        return;
    }

    form.addEventListener("submit", (event) => {

        event.preventDefault();

        const fullName =
            document.getElementById("fullName").value.trim();

        const email =
            document.getElementById("email").value.trim().toLowerCase();

        const birthday =
            document.getElementById("birthday").value;

        const gender =
            document.getElementById("gender").value;

        const location =
            document.getElementById("location").value.trim();

        const education =
            document.getElementById("education").value.trim();

        const interests =
            document.getElementById("interests").value.trim();

        const password =
            document.getElementById("password").value;

        const confirmPassword =
            document.getElementById("confirmPassword").value;


        /* Validate name */

        if (fullName.length < 2) {
            showAuthMessage(
                "Please enter your full name.",
                "error"
            );

            return;
        }


        /* Validate email */

        if (!isValidEmail(email)) {
            showAuthMessage(
                "Please enter a valid email address.",
                "error"
            );

            return;
        }


        /* Validate password */

        if (password.length < 6) {
            showAuthMessage(
                "Password must contain at least 6 characters.",
                "error"
            );

            return;
        }


        /* Confirm password */

        if (password !== confirmPassword) {
            showAuthMessage(
                "Passwords do not match.",
                "error"
            );

            return;
        }


        /* Get existing users */

        const users = getUsers();


        /* Check duplicate email */

        const existingUser = users.find(
            (user) => user.email === email
        );

        if (existingUser) {
            showAuthMessage(
                "An account with this email already exists.",
                "error"
            );

            return;
        }


        /* Create user */

        // Production authentication requires a backend, secure password hashing, and sessions.
        const newUser = {
            id: generateUserId(),
            fullName,
            email,
            birthday,
            gender,
            location,
            education,
            interests: interests
                ? interests
                    .split(",")
                    .map(item => item.trim())
                    .filter(Boolean)
                : [],
            password,
            profilePhoto: "",
            friends: [],
            friendRequests: [],
            posts: [],
            privacy: {
                profile: "friends",
                birthday: "friends",
                email: "private"
            },
            createdAt: new Date().toISOString()
        };


        /* Save user */

        users.push(newUser);

        saveUsers(users);


        /* Automatically log in */

        const currentUser = {
            id: newUser.id,
            fullName: newUser.fullName,
            email: newUser.email
        };

        localStorage.setItem(
            "circlebook_current_user",
            JSON.stringify(currentUser)
        );


        showAuthMessage(
            "Your Circlebook profile has been created.",
            "success"
        );


        /* Redirect */

        setTimeout(() => {
            window.location.href = "profile.html";
        }, 1000);
    });
}


/* =========================================
   LOGIN
========================================= */

function initializeLogin() {

    const form = document.getElementById("loginForm");

    if (!form) {
        return;
    }

    form.addEventListener("submit", (event) => {

        event.preventDefault();

        const email =
            document.getElementById("email")
                .value
                .trim()
                .toLowerCase();

        const password =
            document.getElementById("password").value;


        if (!email || !password) {
            showAuthMessage(
                "Please enter your email and password.",
                "error"
            );

            return;
        }


        const users = getUsers();


        const user = users.find(
            (item) =>
                item.email === email &&
                item.password === password
        );


        if (!user) {
            showAuthMessage(
                "Incorrect email or password.",
                "error"
            );

            return;
        }


        /* Store logged-in user */

        const currentUser = {
            id: user.id,
            fullName: user.fullName,
            email: user.email
        };

        localStorage.setItem(
            "circlebook_current_user",
            JSON.stringify(currentUser)
        );


        showAuthMessage(
            `Welcome back, ${user.fullName}.`,
            "success"
        );


        setTimeout(() => {
            window.location.href = "profile.html";
        }, 800);
    });
}


/* =========================================
   EMAIL VALIDATION
========================================= */

function isValidEmail(email) {

    const emailPattern =
        /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    return emailPattern.test(email);
}


/* =========================================
   USER ID
========================================= */

function generateUserId() {

    return (
        "user_" +
        Date.now().toString(36) +
        "_" +
        Math.random()
            .toString(36)
            .substring(2, 8)
    );
}


/* =========================================
   AUTH MESSAGE
========================================= */

function showAuthMessage(message, type = "info") {

    const form = document.querySelector(
        "#registerForm, #loginForm"
    );

    if (!form) {
        return;
    }


    const existingMessage =
        document.querySelector(".auth-message");

    if (existingMessage) {
        existingMessage.remove();
    }


    const messageElement =
        document.createElement("div");

    messageElement.className =
        `auth-message ${type}`;

    messageElement.textContent = message;

    form.parentNode.insertBefore(
        messageElement,
        form
    );
}