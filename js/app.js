/*
 * The Circlebook
 * Main application JavaScript
 */

document.addEventListener("DOMContentLoaded", () => {
    initializeNavigation();
    initializeYear();
    initializeButtons();
});

/*
 * Navigation
 */
function initializeNavigation() {
    const currentPage = window.location.pathname.split("/").pop() || "index.html";

    document.querySelectorAll("nav a").forEach((link) => {
        const linkPage = link.getAttribute("href");

        if (linkPage === currentPage) {
            link.classList.add("active");
        }
    });
}

/*
 * Automatically update copyright year
 */
function initializeYear() {
    const yearElements = document.querySelectorAll("[data-year]");

    yearElements.forEach((element) => {
        element.textContent = new Date().getFullYear();
    });
}

/*
 * Button interactions
 */
function initializeButtons() {
    document.querySelectorAll("[data-action='back']").forEach((button) => {
        button.addEventListener("click", () => {
            window.history.back();
        });
    });

    document.querySelectorAll("[data-action='logout']").forEach((button) => {
        button.addEventListener("click", () => {
            localStorage.removeItem("circlebook_current_user");
            window.location.href = "pages/login.html";
        });
    });
}

/*
 * Save current logged-in user
 */
function setCurrentUser(user) {
    localStorage.setItem(
        "circlebook_current_user",
        JSON.stringify(user)
    );
}

/*
 * Get current logged-in user
 */
function getCurrentUser() {
    const user = localStorage.getItem("circlebook_current_user");

    if (!user) {
        return null;
    }

    try {
        return JSON.parse(user);
    } catch (error) {
        console.error("Invalid user data:", error);
        return null;
    }
}

/*
 * Check whether a user is logged in
 */
function isLoggedIn() {
    return getCurrentUser() !== null;
}

/*
 * Redirect user to login page
 */
function requireLogin() {
    if (!isLoggedIn()) {
        window.location.href = "login.html";
    }
}

/*
 * Format date for display
 */
function formatDate(dateString) {
    if (!dateString) {
        return "";
    }

    const date = new Date(dateString);

    return date.toLocaleDateString("en-US", {
        year: "numeric",
        month: "long",
        day: "numeric"
    });
}

/*
 * Show a simple notification
 */
function showMessage(message, type = "info") {
    const existingMessage = document.querySelector(".app-message");

    if (existingMessage) {
        existingMessage.remove();
    }

    const messageBox = document.createElement("div");

    messageBox.className = `app-message ${type}`;
    messageBox.textContent = message;

    document.body.appendChild(messageBox);

    setTimeout(() => {
        messageBox.remove();
    }, 3000);
}