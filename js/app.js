/* =========================================================
   THE CIRCLEBOOK - MASTER ROUTER & APPLICATION CONTROLLER
   ========================================================= */

const CirclebookRouter = {
    currentModule: "home",
    currentSubTab: "feed",

    // Taxonomy Tree Mapping with Titles & Sub-Tabs
    taxonomy: {
        entry: {
            title: "🚀 ENTRY",
            subTabs: [
                { id: "welcome", label: "Welcome Screen" },
                { id: "splash", label: "Splash / Loading" },
                { id: "onboarding1", label: "Onboarding — Step 1" },
                { id: "onboarding2", label: "Onboarding — Step 2" },
                { id: "onboarding3", label: "Onboarding — Step 3" }
            ]
        },
        auth: {
            title: "🔐 AUTH",
            subTabs: [
                { id: "login", label: "Login" },
                { id: "register", label: "Register" },
                { id: "forgot", label: "Forgot Password" }
            ]
        },
        home: {
            title: "🏠 HOME",
            subTabs: [
                { id: "feed", label: "Home Feed" },
                { id: "trending", label: "Trending" },
                { id: "recommended", label: "Recommended For You" },
                { id: "happening", label: "What's Happening" }
            ]
        },
        discover: {
            title: "🔎 DISCOVER",
            subTabs: [
                { id: "home", label: "Discover Home" },
                { id: "people", label: "People Search" },
                { id: "smart_search", label: "Smart Connection Search" },
                { id: "communities", label: "Communities" },
                { id: "events", label: "Events" },
                { id: "opportunities", label: "Opportunities" }
            ]
        },
        mycircle: {
            title: "👥 MY CIRCLE",
            subTabs: [
                { id: "all", label: "All Connections" },
                { id: "inner", label: "Inner Circle" },
                { id: "friends", label: "Friends" },
                { id: "work", label: "Work" },
                { id: "requests", label: "Requests" }
            ]
        },
        profile: {
            title: "👤 PROFILE",
            subTabs: [
                { id: "overview", label: "Overview" },
                { id: "posts", label: "Posts" },
                { id: "about", label: "About" },
                { id: "skills", label: "Skills" },
                { id: "career", label: "Career Profile" }
            ]
        },
        communication: {
            title: "💬 COMMUNICATION",
            subTabs: [
                { id: "chat", label: "Chat Threads" },
                { id: "group", label: "Group Chat" },
                { id: "requests", label: "Message Requests" }
            ]
        },
        notifications: {
            title: "🔔 NOTIFICATIONS",
            subTabs: [
                { id: "all", label: "All Notifications" },
                { id: "social", label: "Social" },
                { id: "messages", label: "Messages" },
                { id: "opportunities", label: "Opportunities" }
            ]
        },
        communities: {
            title: "🌐 COMMUNITIES",
            subTabs: [
                { id: "discover", label: "Community Discover" },
                { id: "details", label: "Community Feed" }
            ]
        },
        events: {
            title: "📅 EVENTS",
            subTabs: [
                { id: "discover", label: "Event Discover" },
                { id: "my_events", label: "My Events" }
            ]
        },
        career: {
            title: "💼 CAREER HUB",
            subTabs: [
                { id: "dashboard", label: "Career Dashboard" },
                { id: "jobs", label: "Job Postings" },
                { id: "recommendations", label: "AI Career Match" }
            ]
        },
        ai: {
            title: "🤖 CIRCLE AI",
            subTabs: [
                { id: "home", label: "AI Home" },
                { id: "people_finder", label: "AI People Finder" },
                { id: "post_assistant", label: "Post Assistant" }
            ]
        },
        settings: {
            title: "⚙️ SETTINGS",
            subTabs: [
                { id: "appearance", label: "Appearance & Themes" },
                { id: "privacy", label: "Privacy" },
                { id: "security", label: "Security" }
            ]
        },
        safety: {
            title: "🛡️ SAFETY",
            subTabs: [
                { id: "center", label: "Safety Center" },
                { id: "report", label: "Report Center" }
            ]
        },
        admin: {
            title: "🧑💼 ADMIN",
            subTabs: [
                { id: "dashboard", label: "Admin Dashboard" },
                { id: "users", label: "User Management" },
                { id: "reports", label: "Moderation Queue" }
            ]
        }
    },

    init() {
        // Parse hash if available e.g. #discover/people
        const hash = window.location.hash.replace("#", "");
        if (hash) {
            const parts = hash.split("/");
            if (this.taxonomy[parts[0]]) {
                this.currentModule = parts[0];
                if (parts[1]) this.currentSubTab = parts[1];
            }
        }
        this.render();
    },

    navigate(moduleKey, subTabKey = null) {
        if (!this.taxonomy[moduleKey]) return;
        this.currentModule = moduleKey;
        if (subTabKey) {
            this.currentSubTab = subTabKey;
        } else {
            this.currentSubTab = this.taxonomy[moduleKey].subTabs[0].id;
        }
        window.location.hash = `${this.currentModule}/${this.currentSubTab}`;
        this.render();
    },

    render() {
        const viewport = document.getElementById("moduleViewport");
        const subNav = document.getElementById("subHeaderNav");
        if (!viewport) return;

        // Render Sub Header Tabs
        const moduleConfig = this.taxonomy[this.currentModule];
        if (subNav && moduleConfig) {
            subNav.innerHTML = moduleConfig.subTabs.map(tab => `
                <button class="sub-nav-btn ${tab.id === this.currentSubTab ? 'active' : ''}" onclick="CirclebookRouter.navigate('${this.currentModule}', '${tab.id}')">
                    ${tab.label}
                </button>
            `).join('');
        }

        // Highlight Active Sidebar Link
        document.querySelectorAll(".sidebar-link").forEach(el => {
            el.classList.remove("active");
            if (el.dataset.module === this.currentModule) {
                el.classList.add("active");
            }
        });

        // Render View HTML
        const renderFunc = CirclebookViews[this.currentModule];
        if (renderFunc) {
            viewport.innerHTML = renderFunc.call(CirclebookViews, this.currentSubTab);
        } else {
            viewport.innerHTML = `<div class="circle-card">Module view building...</div>`;
        }
    }
};

const CirclebookApp = {
    toast(message) {
        let box = document.querySelector(".app-toast");
        if (!box) {
            box = document.createElement("div");
            box.className = "app-toast";
            box.style.cssText = "position: fixed; bottom: 2rem; left: 50%; transform: translateX(-50%); background: var(--vintage-ink); color: #fff; padding: 0.75rem 1.5rem; border-radius: var(--radius-pill); font-size: 0.9rem; font-weight: 600; z-index: 300; box-shadow: var(--shadow-card); opacity: 0; transition: opacity 0.3s;";
            document.body.appendChild(box);
        }
        box.textContent = message;
        box.style.opacity = "1";
        setTimeout(() => {
            box.style.opacity = "0";
        }, 2500);
    },

    toggleMobileSidebar() {
        const sidebar = document.querySelector(".app-sidebar");
        if (sidebar) {
            sidebar.classList.toggle("open");
        }
    },

    switchDemoUser(userId) {
        const target = CirclebookStore.users.find(u => u.id === userId) || CirclebookStore.currentUser;
        CirclebookStore.currentUser = { ...CirclebookStore.currentUser, ...target };
        CirclebookStore.saveState();
        this.toast(`Switched context to ${target.name} (${target.role})`);
        CirclebookRouter.render();
    },

    handleCreatePost() {
        const input = document.getElementById("newPostInput");
        if (input && input.value.trim()) {
            CirclebookStore.addPost(input.value.trim());
            input.value = "";
            this.toast("Post published to circle feed!");
            CirclebookRouter.render();
        }
    },

    handleSendChatMessage(chatId) {
        const input = document.getElementById("chatInput");
        if (input && input.value.trim()) {
            CirclebookStore.sendChatMessage(chatId, input.value.trim());
            input.value = "";
            CirclebookRouter.render();
            // Simulate reply from connection
            setTimeout(() => {
                CirclebookStore.sendChatMessage(chatId, "Received your message! Loving this vintage-modern Circlebook interface.");
                CirclebookRouter.render();
            }, 1200);
        }
    },

    triggerAIPrompt(promptText) {
        if (!promptText) return;
        const target = document.getElementById("aiPromptResult");
        if (target) {
            target.innerHTML = `<em>Circle AI processing: "${promptText}"...</em>`;
            setTimeout(() => {
                if (promptText.toLowerCase().includes("designer") || promptText.toLowerCase().includes("find")) {
                    target.innerHTML = `
                        <strong>AI Connection Match Result:</strong><br>
                        • <strong>Priya Nair</strong> (@priya_nair) — Product Designer in Mumbai (98% Match). Shared interests: Vintage Typography.<br>
                        • <strong>Kavya Iyer</strong> (@kavya_iyer) — Growth Marketer (85% Match).
                    `;
                } else if (promptText.toLowerCase().includes("post") || promptText.toLowerCase().includes("draft")) {
                    target.innerHTML = `
                        <strong>AI Draft Post Suggestion:</strong><br>
                        <em>"Exploring retro community directory design patterns. There's something deeply satisfying about clean serif headlines and structured card grids. What retro aesthetic do you miss most?"</em>
                    `;
                } else {
                    target.innerHTML = `<strong>Circle AI Insight:</strong> Evaluated query "${promptText}". Found 4 relevant circle connections and 2 upcoming community events matching your profile.`;
                }
            }, 700);
        }
    },

    filterDiscoverPeople(query) {
        const grid = document.getElementById("discoverGrid");
        if (!grid) return;
        const filtered = CirclebookStore.users.filter(u => 
            u.name.toLowerCase().includes(query.toLowerCase()) || 
            u.headline.toLowerCase().includes(query.toLowerCase()) ||
            u.skills.some(s => s.toLowerCase().includes(query.toLowerCase()))
        );
        grid.innerHTML = filtered.map(u => `
            <div class="circle-card" style="text-align: center; margin-bottom: 0;">
                <img src="${u.avatar}" style="width: 72px; height: 72px; border-radius: 50%; object-fit: cover; margin-bottom: 0.5rem;" alt="${u.name}" />
                <h3 style="font-size: 1.05rem; font-weight: 700; margin-bottom: 0.2rem;">${u.name}</h3>
                <p style="font-size: 0.82rem; color: var(--text-secondary); margin-bottom: 0.5rem;">${u.headline}</p>
                <p style="font-size: 0.78rem; color: var(--text-muted); margin-bottom: 0.75rem;">📍 ${u.location} • 🎓 ${u.college}</p>
                <div style="margin-bottom: 0.75rem;">
                    ${u.skills.slice(0, 3).map(s => `<span class="tag-badge">${s}</span>`).join('')}
                </div>
                <div style="display: flex; gap: 0.5rem; justify-content: center;">
                    <button class="btn-primary" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;" onclick="CirclebookApp.toast('Circle request sent to ${u.name}')">+ Circle</button>
                    <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;" onclick="CirclebookRouter.navigate('profile', 'overview')">Profile</button>
                </div>
            </div>
        `).join('');
    }
};

// Initialize Application on DOM Ready
document.addEventListener("DOMContentLoaded", () => {
    CirclebookRouter.init();
});