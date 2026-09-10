/* =========================================================
   THE CIRCLEBOOK - MASTER ROUTER & APPLICATION CONTROLLER
   ========================================================= */

const CirclebookRouter = {
    currentModule: "home",
    currentSubTab: "feed",

    // Taxonomy Tree Mapping with Titles & Sub-Tabs
    taxonomy: {
        entry: {
            title: "ENTRY",
            subTabs: [
                { id: "welcome", label: "Welcome" },
                { id: "splash", label: "Splash" },
                { id: "onboarding1", label: "Onboarding — Identity" },
                { id: "onboarding2", label: "Onboarding — Skills" },
                { id: "onboarding3", label: "Onboarding — Circle" }
            ]
        },
        auth: {
            title: "AUTH",
            subTabs: [
                { id: "login", label: "Sign In" },
                { id: "register", label: "Create Account" },
                { id: "forgot", label: "Password Reset" }
            ]
        },
        home: {
            title: "HOME",
            subTabs: [
                { id: "feed", label: "Feed" },
                { id: "trending", label: "Trending" },
                { id: "recommended", label: "Recommended" }
            ]
        },
        discover: {
            title: "DISCOVER",
            subTabs: [
                { id: "people", label: "People Search" },
                { id: "communities", label: "Communities" },
                { id: "events", label: "Events" },
                { id: "opportunities", label: "Opportunities" }
            ]
        },
        mycircle: {
            title: "MY CIRCLE",
            subTabs: [
                { id: "all", label: "All Connections" },
                { id: "inner", label: "Inner Circle" },
                { id: "friends", label: "Friends" },
                { id: "work", label: "Work" },
                { id: "requests", label: "Requests" }
            ]
        },
        profile: {
            title: "PROFILE",
            subTabs: [
                { id: "overview", label: "Overview" },
                { id: "posts", label: "Posts" },
                { id: "about", label: "About" },
                { id: "skills", label: "Skills" }
            ]
        },
        communication: {
            title: "MESSAGES",
            subTabs: [
                { id: "chat", label: "Direct Messages" },
                { id: "group", label: "Groups" },
                { id: "requests", label: "Message Requests" }
            ]
        },
        notifications: {
            title: "NOTIFICATIONS",
            subTabs: [
                { id: "all", label: "All Notifications" },
                { id: "social", label: "Social" },
                { id: "messages", label: "Messages" }
            ]
        },
        communities: {
            title: "COMMUNITIES",
            subTabs: [
                { id: "discover", label: "Discover Communities" },
                { id: "details", label: "Community Feed" }
            ]
        },
        events: {
            title: "EVENTS",
            subTabs: [
                { id: "discover", label: "Discover Events" },
                { id: "my_events", label: "My Events" }
            ]
        },
        career: {
            title: "CAREER HUB",
            subTabs: [
                { id: "dashboard", label: "Career Dashboard" },
                { id: "jobs", label: "Job Postings" }
            ]
        },
        ai: {
            title: "CIRCLE AI",
            subTabs: [
                { id: "home", label: "AI Search & Tools" },
                { id: "people_finder", label: "Semantic Search" }
            ]
        },
        settings: {
            title: "SETTINGS",
            subTabs: [
                { id: "appearance", label: "Appearance" },
                { id: "privacy", label: "Privacy & Security" }
            ]
        },
        safety: {
            title: "SAFETY",
            subTabs: [
                { id: "center", label: "Safety Center" },
                { id: "report", label: "Report Center" }
            ]
        },
        admin: {
            title: "ADMIN",
            subTabs: [
                { id: "dashboard", label: "Admin Dashboard" },
                { id: "reports", label: "Moderation Queue" }
            ]
        }
    },

    init() {
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
        const appShell = document.getElementById("appShell");
        if (!viewport) return;

        // Close any open dropdown menus
        CirclebookApp.closeDropdowns();

        // 1. ENTRY & AUTH LAYOUT ISOLATION
        if (this.currentModule === "entry" || this.currentModule === "auth") {
            if (appShell) appShell.classList.add("auth-layout");
        } else {
            if (appShell) appShell.classList.remove("auth-layout");
        }

        // Apply theme from store
        if (CirclebookStore.currentUser && CirclebookStore.currentUser.appearance) {
            document.documentElement.setAttribute("data-theme", CirclebookStore.currentUser.appearance.theme || "glass-light");
        }

        // Sync Topbar User Display
        const topbarUsername = document.getElementById("topbarUsername");
        const topbarAvatar = document.getElementById("topbarAvatar");
        const dropdownUserName = document.getElementById("dropdownUserName");
        const dropdownUserHandle = document.getElementById("dropdownUserHandle");

        if (CirclebookStore.currentUser) {
            if (topbarUsername) topbarUsername.textContent = CirclebookStore.currentUser.name;
            if (topbarAvatar) topbarAvatar.src = CirclebookStore.currentUser.avatar;
            if (dropdownUserName) dropdownUserName.textContent = CirclebookStore.currentUser.name;
            if (dropdownUserHandle) dropdownUserHandle.textContent = `@${CirclebookStore.currentUser.name.toLowerCase().replace(/\s+/g, '_')}`;
        }

        // Sync Admin Link visibility
        const sidebarAdminBtn = document.getElementById("sidebarAdminBtn");
        if (sidebarAdminBtn) {
            sidebarAdminBtn.style.display = (CirclebookStore.currentUser && CirclebookStore.currentUser.role === 'admin') ? 'flex' : 'none';
        }

        // Sync Sidebar Circle & Notif Badges
        const sidebarCircleBadge = document.getElementById("sidebarCircleBadge");
        if (sidebarCircleBadge && CirclebookStore.currentUser) {
            sidebarCircleBadge.textContent = CirclebookStore.currentUser.circleCount;
        }

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

        // Highlight Active Mobile Bottom Nav Link
        document.querySelectorAll(".mobile-nav-item").forEach(el => {
            el.classList.remove("active");
        });

        // Render View HTML
        const renderFunc = CirclebookViews[this.currentModule];
        if (renderFunc) {
            viewport.innerHTML = renderFunc.call(CirclebookViews, this.currentSubTab);
        } else {
            viewport.innerHTML = `<div class="circle-card">Module view updating...</div>`;
        }
    }
};

const CirclebookApp = {
    toast(message) {
        let box = document.querySelector(".app-toast");
        if (!box) {
            box = document.createElement("div");
            box.className = "app-toast";
            box.style.cssText = "position: fixed; bottom: 5rem; left: 50%; transform: translateX(-50%); background: var(--deep-navy, #0F172A); color: #fff; padding: 0.75rem 1.5rem; border-radius: var(--radius-pill, 9999px); font-size: 0.88rem; font-weight: 600; z-index: 600; box-shadow: var(--shadow-md); opacity: 0; transition: opacity 0.3s;";
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

    // ---------------------------------------------------------
    // DROPDOWN MENU CONTROLLER
    // ---------------------------------------------------------
    toggleProfileMenu(e) {
        if (e) e.stopPropagation();
        const menu = document.getElementById("topbarProfileMenu");
        if (!menu) return;
        const isVisible = menu.style.display === "block";
        this.closeDropdowns();
        if (!isVisible) {
            menu.style.display = "block";
        }
    },

    togglePostMenu(e, postId) {
        if (e) e.stopPropagation();
        const menu = document.getElementById(`postMenu_${postId}`);
        if (!menu) return;
        const isVisible = menu.style.display === "block";
        this.closeDropdowns();
        if (!isVisible) {
            menu.style.display = "block";
        }
    },

    toggleUserMenu(e, userId) {
        if (e) e.stopPropagation();
        const menu = document.getElementById(`userMenu_${userId}`);
        if (!menu) return;
        const isVisible = menu.style.display === "block";
        this.closeDropdowns();
        if (!isVisible) {
            menu.style.display = "block";
        }
    },

    closeDropdowns() {
        document.querySelectorAll(".cb-dropdown-menu").forEach(menu => {
            menu.style.display = "none";
        });
    },

    // ---------------------------------------------------------
    // CONTEXTUAL ACTIONS
    // ---------------------------------------------------------
    copyLink(urlOrText = window.location.href) {
        navigator.clipboard.writeText(urlOrText).then(() => {
            this.toast("Link copied to clipboard");
        }).catch(() => {
            this.toast("Link copied");
        });
        this.closeDropdowns();
    },

    editPost(postId) {
        this.closeDropdowns();
        const post = CirclebookStore.posts.find(p => p.id === postId);
        if (!post) return;
        this.openModal(
            "Edit Post",
            `
                <div class="form-group">
                    <label>Post Content</label>
                    <textarea id="editPostText" class="form-control" rows="4">${post.content}</textarea>
                </div>
            `,
            `
                <button class="btn-secondary" onclick="CirclebookApp.closeModal()">Cancel</button>
                <button class="btn-primary" onclick="CirclebookApp.savePostEdit('${postId}')">Save Changes</button>
            `
        );
    },

    savePostEdit(postId) {
        const text = document.getElementById("editPostText") ? document.getElementById("editPostText").value : "";
        if (text.trim()) {
            const post = CirclebookStore.posts.find(p => p.id === postId);
            if (post) {
                post.content = text.trim();
                CirclebookStore.saveState();
                this.closeModal();
                this.toast("Post updated");
                CirclebookRouter.render();
            }
        }
    },

    mutePostNotifications(postId) {
        this.closeDropdowns();
        this.toast("Notifications muted for this post");
    },

    hidePost(postId) {
        this.closeDropdowns();
        this.toast("Post hidden from your feed");
    },

    reportPost(postId) {
        this.closeDropdowns();
        const reason = prompt("Please specify reason for reporting this post (e.g., spam, harassment):");
        if (reason) {
            this.toast("Post reported. Thank you for keeping the circle safe.");
        }
    },

    shareProfile(userId) {
        this.closeDropdowns();
        this.copyLink(`${window.location.origin}/#profile`);
    },

    blockUser(userId) {
        this.closeDropdowns();
        const user = CirclebookStore.users.find(u => u.id === userId);
        const name = user ? user.name : "user";
        this.openModal(
            "Block User",
            `<p style="color: var(--text-secondary); line-height: 1.5;">Are you sure you want to block ${name}? They will no longer be able to message you or see your circle updates.</p>`,
            `
                <button class="btn-secondary" onclick="CirclebookApp.closeModal()">Cancel</button>
                <button class="btn-danger" onclick="CirclebookApp.confirmBlockUser('${userId}')">Block ${name}</button>
            `
        );
    },

    confirmBlockUser(userId) {
        this.closeModal();
        this.toast("User blocked");
    },

    reportUser(userId) {
        this.closeDropdowns();
        const reason = prompt("Please specify reason for reporting this profile:");
        if (reason) {
            this.toast("User reported for moderation review");
        }
    },

    toggleNextTheme() {
        const themes = ['glass-light', 'glass-dark', 'modern-blue', 'purple-luxe'];
        const current = CirclebookStore.currentUser.appearance.theme || 'glass-light';
        const nextIndex = (themes.indexOf(current) + 1) % themes.length;
        const next = themes[nextIndex < 0 ? 0 : nextIndex];
        CirclebookStore.applyTheme(next);
        this.toast(`Applied theme: ${next.replace('-', ' ').toUpperCase()}`);
        CirclebookRouter.render();
    },

    switchDemoUser(userId) {
        const target = CirclebookStore.users.find(u => u.id === userId) || CirclebookStore.currentUser;
        CirclebookStore.currentUser = { ...CirclebookStore.currentUser, ...target };
        CirclebookStore.saveState();
        this.toast(`Switched context to ${target.name} (${target.role})`);
        CirclebookRouter.render();
    },

    openModal(title, bodyHTML, footerHTML = '') {
        const backdrop = document.getElementById("globalModalBackdrop");
        const box = document.getElementById("globalModalBox");
        if (!backdrop || !box) return;

        box.innerHTML = `
            <div class="circle-modal-header">
                <h3 class="circle-modal-title">${title}</h3>
                <button class="circle-modal-close" onclick="CirclebookApp.closeModal()">✕</button>
            </div>
            <div class="circle-modal-body">${bodyHTML}</div>
            ${footerHTML ? `<div class="circle-modal-footer">${footerHTML}</div>` : ''}
        `;
        backdrop.classList.add("active");
    },

    closeModal() {
        const backdrop = document.getElementById("globalModalBackdrop");
        if (backdrop) {
            backdrop.classList.remove("active");
        }
    },

    openCreatePostModal() {
        this.openModal(
            "Create Post",
            `
                <div class="form-group">
                    <label>Post Category</label>
                    <select id="modalPostCat" class="form-control">
                        <option>General</option>
                        <option>Design</option>
                        <option>Engineering</option>
                        <option>Career & Jobs</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>What's on your mind?</label>
                    <textarea id="modalPostText" class="form-control" rows="4" placeholder="Share an update, paper, or insight with your circle..."></textarea>
                </div>
                <div class="form-group">
                    <label>Optional Image URL</label>
                    <input type="text" id="modalPostImg" class="form-control" placeholder="https://images.unsplash.com/..." />
                </div>
            `,
            `
                <button class="btn-secondary" onclick="CirclebookApp.closeModal()">Cancel</button>
                <button class="btn-primary" onclick="CirclebookApp.submitCreatePostModal()">Publish Post</button>
            `
        );
    },

    submitCreatePostModal() {
        const cat = document.getElementById("modalPostCat") ? document.getElementById("modalPostCat").value : "General";
        const text = document.getElementById("modalPostText") ? document.getElementById("modalPostText").value : "";
        const img = document.getElementById("modalPostImg") ? document.getElementById("modalPostImg").value : null;

        if (text.trim()) {
            CirclebookStore.addPost(text.trim(), cat, img ? img.trim() : null);
            this.closeModal();
            this.toast("Post published");
            CirclebookRouter.navigate("home", "feed");
        } else {
            this.toast("Please enter content for your post.");
        }
    },

    confirmDeletePost(postId) {
        this.closeDropdowns();
        this.openModal(
            "Confirm Post Deletion",
            `<p style="color: var(--text-secondary); line-height: 1.5;">Are you sure you want to remove this post? This action cannot be undone.</p>`,
            `
                <button class="btn-secondary" onclick="CirclebookApp.closeModal()">Cancel</button>
                <button class="btn-danger" onclick="CirclebookStore.deletePost('${postId}'); CirclebookApp.closeModal(); CirclebookApp.toast('Post deleted'); CirclebookRouter.render();">Delete Post</button>
            `
        );
    },

    openEditProfileModal() {
        const u = CirclebookStore.currentUser;
        this.openModal(
            "Edit Profile Information",
            `
                <div class="form-group"><label>Full Name</label><input type="text" id="editName" class="form-control" value="${u.name}"></div>
                <div class="form-group"><label>Headline / Title</label><input type="text" id="editHeadline" class="form-control" value="${u.headline}"></div>
                <div class="form-group"><label>Location</label><input type="text" id="editLocation" class="form-control" value="${u.location}"></div>
                <div class="form-group"><label>College / Education</label><input type="text" id="editCollege" class="form-control" value="${u.college}"></div>
                <div class="form-group"><label>Bio / About</label><textarea id="editAbout" class="form-control" rows="3">${u.about}</textarea></div>
            `,
            `
                <button class="btn-secondary" onclick="CirclebookApp.closeModal()">Cancel</button>
                <button class="btn-primary" onclick="CirclebookApp.saveProfileEdit()">Save Profile Changes</button>
            `
        );
    },

    saveProfileEdit() {
        const name = document.getElementById("editName").value;
        const headline = document.getElementById("editHeadline").value;
        const location = document.getElementById("editLocation").value;
        const college = document.getElementById("editCollege").value;
        const about = document.getElementById("editAbout").value;

        CirclebookStore.updateUserProfile({ name, headline, location, college, about });
        this.closeModal();
        this.toast("Profile updated");
        CirclebookRouter.render();
    },

    confirmLogout() {
        this.openModal(
            "Log out?",
            `<p style="color: var(--text-secondary); line-height: 1.5;">Are you sure you want to log out of The Circlebook?</p>`,
            `
                <button class="btn-secondary" onclick="CirclebookApp.closeModal()">Cancel</button>
                <button class="btn-danger" onclick="CirclebookApp.executeLogout()">Log out</button>
            `
        );
    },

    executeLogout() {
        localStorage.removeItem("circlebook_current_user");
        sessionStorage.removeItem("circlebook_splash_seen");
        this.closeModal();
        this.toast("Logged out");
        CirclebookRouter.navigate("auth", "login");
    },

    handleCreatePost() {
        const input = document.getElementById("newPostInput");
        if (input && input.value.trim()) {
            CirclebookStore.addPost(input.value.trim());
            input.value = "";
            this.toast("Post published to circle feed");
            CirclebookRouter.render();
        }
    },

    handleSendChatMessage(chatId) {
        const input = document.getElementById("chatInput");
        if (input && input.value.trim()) {
            CirclebookStore.sendChatMessage(chatId, input.value.trim());
            input.value = "";
            CirclebookRouter.render();
            setTimeout(() => {
                CirclebookStore.sendChatMessage(chatId, "Received your message!");
                CirclebookRouter.render();
            }, 1200);
        }
    },

    handleLoginSubmit() {
        const email = document.getElementById("loginEmail") ? document.getElementById("loginEmail").value : "";
        if (email) {
            this.toast("Signed in successfully");
            CirclebookRouter.navigate("home", "feed");
        }
    },

    handleRegisterSubmit() {
        const name = document.getElementById("regName") ? document.getElementById("regName").value : "Jane Doe";
        const email = document.getElementById("regEmail") ? document.getElementById("regEmail").value : "jane@example.com";
        const pass = document.getElementById("regPass") ? document.getElementById("regPass").value : "password";

        CirclebookStore.registerUser(name, email, pass);
        this.toast("Verification code sent to your email");
        CirclebookRouter.navigate("auth", "otp");
    },

    handleOTPSubmit() {
        this.toast("Account verified");
        CirclebookRouter.navigate("entry", "onboarding1");
    },

    saveOnboardingStep1() {
        const name = document.getElementById("obName") ? document.getElementById("obName").value : CirclebookStore.currentUser.name;
        const headline = document.getElementById("obHeadline") ? document.getElementById("obHeadline").value : CirclebookStore.currentUser.headline;
        const location = document.getElementById("obLocation") ? document.getElementById("obLocation").value : CirclebookStore.currentUser.location;
        const college = document.getElementById("obCollege") ? document.getElementById("obCollege").value : CirclebookStore.currentUser.college;

        CirclebookStore.updateUserProfile({ name, headline, location, college });
        CirclebookRouter.navigate("entry", "onboarding2");
    },

    completeOnboarding() {
        CirclebookStore.updateUserProfile({ isOnboarded: true });
        this.toast("Setup complete");
        CirclebookRouter.navigate("home", "feed");
    },

    triggerAIPrompt(promptText) {
        if (!promptText) return;
        const target = document.getElementById("aiPromptResult");
        if (target) {
            target.innerHTML = `<em>Processing query: "${promptText}"...</em>`;
            setTimeout(() => {
                if (promptText.toLowerCase().includes("designer") || promptText.toLowerCase().includes("find")) {
                    target.innerHTML = `
                        <strong>Search Results:</strong><br>
                        • <strong>Priya Nair</strong> (@priya_nair) — Product Designer in Mumbai (98% Match). Skills: UI/UX, Typography.<br>
                        • <strong>Kavya Iyer</strong> (@kavya_iyer) — Growth Marketer (85% Match).
                    `;
                } else if (promptText.toLowerCase().includes("post") || promptText.toLowerCase().includes("draft")) {
                    target.innerHTML = `
                        <strong>Suggested Post Draft:</strong><br>
                        <em>"Exploring modern community directory design patterns. Clean serif headlines and structured card grids provide a great foundation. What interface style do you prefer?"</em>
                    `;
                } else {
                    target.innerHTML = `<strong>Search Result:</strong> Evaluated query "${promptText}". Found 4 circle connections and 2 upcoming community events matching your criteria.`;
                }
            }, 500);
        }
    },

    _searchDebounceTimer: null,
    filterDiscoverPeople(query) {
        clearTimeout(this._searchDebounceTimer);
        this._searchDebounceTimer = setTimeout(() => {
            const grid = document.getElementById("discoverGrid");
            if (!grid) return;
            const filtered = CirclebookStore.users.filter(u => 
                u.name.toLowerCase().includes(query.toLowerCase()) || 
                u.headline.toLowerCase().includes(query.toLowerCase()) ||
                u.skills.some(s => s.toLowerCase().includes(query.toLowerCase()))
            );
            if (!filtered.length) {
                grid.innerHTML = `
                    <div style="grid-column: 1 / -1;" class="empty-state-box">
                        <div class="empty-state-icon">${CirclebookIcons.get('search', '', 48)}</div>
                        <div class="empty-state-title">No People Found</div>
                        <div class="empty-state-desc">No circle members match "${query}". Try searching by skills such as "React", "Python", or "Design".</div>
                    </div>
                `;
                return;
            }
            grid.innerHTML = filtered.map(u => `
                <div class="circle-card" style="text-align: center; margin-bottom: 0; position: relative;">
                    <img src="${u.avatar}" style="width: 76px; height: 76px; border-radius: 50%; object-fit: cover; margin-bottom: 0.5rem; border: 2px solid var(--border);" alt="${u.name}" />
                    <h3 style="font-size: 1.05rem; font-weight: 700; margin-bottom: 0.2rem;">${u.name}</h3>
                    <p style="font-size: 0.82rem; color: var(--text-secondary); margin-bottom: 0.4rem; min-height: 2.4em;">${u.headline}</p>
                    <p style="font-size: 0.78rem; color: var(--text-muted); margin-bottom: 0.75rem;">${u.location} • ${u.college}</p>
                    <div style="margin-bottom: 0.85rem; min-height: 28px;">
                        ${u.skills.slice(0, 3).map(s => `<span class="tag-badge">${s}</span>`).join('')}
                    </div>
                    <div style="display: flex; gap: 0.5rem; justify-content: center; align-items: center;">
                        ${u.connectionStatus === 'connected' ? `
                            <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.75rem; color: var(--success);" disabled>Connected</button>
                        ` : u.connectionStatus === 'pending_sent' ? `
                            <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;" onclick="CirclebookStore.cancelCircleRequest('${u.id}'); CirclebookApp.toast('Request cancelled'); CirclebookRouter.render();">Sent</button>
                        ` : `
                            <button class="btn-primary" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;" onclick="CirclebookStore.sendCircleRequest('${u.id}'); CirclebookApp.toast('Request sent to ${u.name}'); CirclebookRouter.render();">Add Friend</button>
                        `}
                        <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;" onclick="CirclebookRouter.navigate('profile', 'overview')">Profile</button>
                    </div>
                </div>
            `).join('');
        }, 150);
    }
};

// Global Click listener to close dropdowns when clicking outside
document.addEventListener("click", (e) => {
    if (!e.target.closest(".cb-dropdown-menu") && !e.target.closest(".topbar-user") && !e.target.closest(".post-more-btn")) {
        CirclebookApp.closeDropdowns();
    }
});

// Initialize Application on DOM Ready
document.addEventListener("DOMContentLoaded", () => {
    CirclebookRouter.init();
});