/* =========================================================
   THE CIRCLEBOOK - NAVIGATION CONTROLLER
   ========================================================= */

document.addEventListener("DOMContentLoaded", () => {
    CirclebookNavigation.init();
});

const CirclebookNavigation = {
    init() {
        this.highlightActiveLinks();
        this.bindEvents();
    },

    highlightActiveLinks() {
        const currentPath = window.location.pathname;
        const currentHash = window.location.hash;

        document.querySelectorAll("a[href], button[data-href]").forEach(el => {
            const href = el.getAttribute("href") || el.dataset.href;
            if (href && (currentPath.includes(href) || currentHash === href)) {
                el.classList.add("active");
            }
        });
    },

    bindEvents() {
        const toggleBtn = document.querySelector(".mobile-toggle");
        const sidebar = document.querySelector(".app-sidebar");
        if (toggleBtn && sidebar) {
            toggleBtn.addEventListener("click", () => {
                sidebar.classList.toggle("open");
            });
        }
    }
};
