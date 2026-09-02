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
    const nav = document.querySelector(".main-nav");
    if (!nav) {
        return;
    }

    nav.id = "main-navigation";

    let menuButton = document.querySelector(".menu-toggle");
    if (!menuButton) {
        menuButton = document.createElement("button");
        menuButton.type = "button";
        menuButton.className = "menu-toggle";
        menuButton.setAttribute("aria-controls", "main-navigation");
        menuButton.setAttribute("aria-expanded", "false");
        menuButton.setAttribute("aria-label", "Open navigation menu");
        menuButton.innerHTML = "<span></span><span></span><span></span>";
        nav.parentElement.insertBefore(menuButton, nav);

        menuButton.addEventListener("click", () => {
            const isOpen = nav.classList.toggle("is-open");
            menuButton.setAttribute("aria-expanded", String(isOpen));
            menuButton.setAttribute(
                "aria-label",
                isOpen ? "Close navigation menu" : "Open navigation menu"
            );
        });
    }

    const inPagesDirectory = window.location.pathname.includes("/pages/");
    const path = inPagesDirectory ? "" : "pages/";
    const homePath = inPagesDirectory ? "../index.html" : "index.html";
    const currentPage = window.location.pathname.split("/").pop() || "index.html";
    const links = [
        { label: "Home", href: homePath, page: "index.html" },
        { label: "People", href: `${path}people.html`, page: "people.html" }
    ];

    if (isLoggedIn()) {
        links.push(
            { label: "My Profile", href: `${path}profile.html`, page: "profile.html" },
            { label: "Requests", href: `${path}requests.html`, page: "requests.html" },
            { label: "Invite", href: `${path}invite.html`, page: "invite.html" },
            { label: "Settings", href: `${path}settings.html`, page: "settings.html" }
        );
    } else {
        links.push(
            { label: "Login", href: `${path}login.html`, page: "login.html" },
            { label: "Join", href: `${path}register.html`, page: "register.html", className: "nav-button" }
        );
    }

    nav.innerHTML = links.map((link) => {
        const classes = [link.className, link.page === currentPage ? "active" : ""]
            .filter(Boolean)
            .join(" ");
        return `<a href="${link.href}"${classes ? ` class="${classes}"` : ""}>${link.label}</a>`;
    }).join("");

    if (isLoggedIn()) {
        nav.insertAdjacentHTML("beforeend", '<button type="button" class="nav-link" data-action="logout">Sign Out</button>');
    }

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
            window.location.href = window.location.pathname.includes("/pages/")
                ? "login.html"
                : "pages/login.html";
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