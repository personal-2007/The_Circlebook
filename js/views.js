/* =========================================================
   THE CIRCLEBOOK - MASTER VIEWS RENDERER
   ========================================================= */

const CirclebookViews = {
    // ---------------------------------------------------------
    // 1. 🚀 ENTRY MODULE
    // ---------------------------------------------------------
    entry(subTab = "welcome") {
        if (subTab === "splash") {
            return `
                <div class="circle-card" style="text-align: center; padding: 4rem 2rem; max-width: 540px; margin: 2rem auto;">
                    <div class="loading-logo" style="width: 100px; height: 100px; margin: 0 auto 1.25rem;">
                        <img src="assets/images/circlebook-logo.png" alt="The Circlebook Logo" style="width: 100%; height: 100%; object-fit: contain; border-radius: 50%; border: 3px solid var(--saffron);" />
                    </div>
                    <h1 style="font-family: Georgia, serif; font-size: 2.2rem; color: var(--ashoka-blue, #000080); margin-bottom: 0.25rem;">The Circlebook</h1>
                    <p style="color: var(--saffron-dark); font-weight: 600; font-size: 1.05rem; margin-bottom: 1.5rem;">Know your people. Build your circle.</p>
                    <div class="loading-spinner" style="margin: 0 auto 1.25rem;"></div>
                    <p style="font-size: 0.88rem; color: var(--text-muted);">Initializing directory & network connections...</p>
                </div>
            `;
        }
        if (subTab === "welcome") {
            return `
                <div class="circle-card" style="padding: 3rem; background: linear-gradient(to right, var(--surface), var(--surface-soft));">
                    <div class="grid-2" style="align-items: center;">
                        <div>
                            <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1rem;">
                                <img src="assets/images/circlebook-logo.png" style="width: 48px; height: 48px; object-fit: contain; border-radius: 50%; border: 2px solid var(--saffron);" alt="Logo" />
                                <span class="tag-badge" style="background: var(--saffron-soft); color: var(--saffron-dark); font-weight: 700;">RELATIONSHIP & KNOWLEDGE NETWORK</span>
                            </div>
                            <h1 style="font-family: Georgia, serif; font-size: 2.5rem; margin: 0.75rem 0; color: var(--text);">Know Your People. Build Your Circle.</h1>
                            <p style="font-size: 1.05rem; color: var(--text-secondary); line-height: 1.6; margin-bottom: 1.5rem;">
                                Welcome to The Circlebook — an editorial, human-first social platform inspired by simple community roots, built for meaningful relationships, knowledge sharing, and career opportunities.
                            </p>
                            <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                                <button class="btn-primary" onclick="CirclebookRouter.navigate('auth', 'register')">Create Account & Join Circle →</button>
                                <button class="btn-secondary" onclick="CirclebookRouter.navigate('home', 'feed')">Explore Directory Feed</button>
                            </div>
                        </div>
                        <div style="text-align: center;">
                            <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=600&q=80" style="width: 100%; border-radius: var(--radius-soft); border: 2px solid var(--border);" alt="Community Group" />
                        </div>
                    </div>
                </div>
            `;
        }
        if (subTab.startsWith("onboarding")) {
            const step = subTab === "onboarding1" ? 1 : subTab === "onboarding2" ? 2 : 3;
            return `
                <div class="circle-card" style="max-width: 680px; margin: 0 auto; padding: 2rem;">
                    <div class="onboarding-steps-bar">
                        <div class="step-indicator ${step >= 1 ? 'active' : ''}"></div>
                        <div class="step-indicator ${step >= 2 ? 'active' : ''}"></div>
                        <div class="step-indicator ${step >= 3 ? 'active' : ''}"></div>
                    </div>
                    <h2 style="font-family: Georgia, serif; margin-bottom: 0.5rem;">Profile Setup — Step ${step} of 3</h2>
                    <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">
                        ${step === 1 ? 'Personal Identity & Basic Information' : step === 2 ? 'Select Skills, Interests & Career Intentions' : 'Circle Connections & Recommended Communities'}
                    </p>
                    
                    ${step === 1 ? `
                        <div class="form-group"><label>Display Name</label><input type="text" id="obName" class="form-control" value="${CirclebookStore.currentUser.name}"></div>
                        <div class="form-group"><label>Headline / Short Bio</label><input type="text" id="obHeadline" class="form-control" value="${CirclebookStore.currentUser.headline}"></div>
                        <div class="form-group"><label>Location</label><input type="text" id="obLocation" class="form-control" value="${CirclebookStore.currentUser.location}"></div>
                        <div class="form-group"><label>College / Alma Mater</label><input type="text" id="obCollege" class="form-control" value="${CirclebookStore.currentUser.college}"></div>
                        <button class="btn-primary" onclick="CirclebookApp.saveOnboardingStep1()">Next: Skills & Interests →</button>
                    ` : step === 2 ? `
                        <div class="form-group">
                            <label>Popular Skills Tags (Click to select)</label>
                            <div style="display: flex; gap: 0.5rem; flex-wrap: wrap; margin-top: 0.5rem;">
                                <span class="tag-badge" style="background: var(--saffron-soft); color: var(--saffron-dark); font-weight: 700;">✓ JavaScript</span>
                                <span class="tag-badge" style="background: var(--saffron-soft); color: var(--saffron-dark); font-weight: 700;">✓ React</span>
                                <span class="tag-badge">Python</span>
                                <span class="tag-badge">UI/UX Design</span>
                                <span class="tag-badge">System Design</span>
                                <span class="tag-badge">DevOps</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Networking Intents</label>
                            <select class="form-control">
                                <option>Make Friends & Networking</option>
                                <option>Find Career Opportunities</option>
                                <option>Build Projects & Collaborations</option>
                                <option>Find Tech Mentors</option>
                            </select>
                        </div>
                        <button class="btn-primary" onclick="CirclebookRouter.navigate('entry', 'onboarding3')">Next: Communities →</button>
                    ` : `
                        <div class="form-group">
                            <label>Recommended Communities to Join</label>
                            <div style="margin-top: 0.5rem;">
                                <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.75rem; border: 1px solid var(--border); border-radius: var(--radius-soft); margin-bottom: 0.5rem;">
                                    <div><strong>Frontend Guild</strong> • 1.4k members</div>
                                    <button class="btn-secondary" style="padding: 0.3rem 0.75rem;">Joined ✓</button>
                                </div>
                                <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.75rem; border: 1px solid var(--border); border-radius: var(--radius-soft);">
                                    <div><strong>Vintage Typography & UI</strong> • 890 members</div>
                                    <button class="btn-primary" style="padding: 0.3rem 0.75rem;">Join</button>
                                </div>
                            </div>
                        </div>
                        <button class="btn-primary" onclick="CirclebookApp.completeOnboarding()">Complete Setup & Launch Feed 🚀</button>
                    `}
                </div>
            `;
        }
        return this.entry("welcome");
    },

    // ---------------------------------------------------------
    // 2. 🔐 AUTH MODULE
    // ---------------------------------------------------------
    auth(subTab = "login") {
        return `
            <div class="circle-card" style="max-width: 480px; margin: 2rem auto; padding: 2.25rem;">
                <div style="text-align: center; margin-bottom: 1.5rem;">
                    <img src="assets/images/circlebook-logo.png" style="width: 64px; height: 64px; object-fit: contain; border-radius: 50%; border: 3px solid var(--saffron); margin-bottom: 0.5rem;" alt="Circlebook Logo" />
                    <h2 style="font-family: Georgia, serif; margin-bottom: 0.25rem; color: var(--ashoka-blue, #000080);">The Circlebook</h2>
                    <p style="color: var(--text-secondary); font-size: 0.9rem;">Know your people. Build your circle.</p>
                </div>

                ${subTab === "login" ? `
                    <div class="form-group"><label>Email Address</label><input type="email" id="loginEmail" class="form-control" value="${CirclebookStore.currentUser.email}"></div>
                    <div class="form-group"><label>Password</label><input type="password" id="loginPass" class="form-control" value="••••••••••••"></div>
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                        <label style="font-size: 0.85rem;"><input type="checkbox" checked> Remember me</label>
                        <a href="javascript:void(0)" onclick="CirclebookRouter.navigate('auth', 'forgot')" style="color: var(--saffron-dark); text-decoration: none; font-size: 0.88rem; font-weight: 600;">Forgot Password?</a>
                    </div>
                    <button class="btn-primary" style="width: 100%;" onclick="CirclebookApp.handleLoginSubmit()">Sign In to The Circlebook</button>
                    
                    <div style="margin-top: 1.25rem; text-align: center; font-size: 0.88rem; color: var(--text-secondary);">
                        Don't have an account? <a href="javascript:void(0)" onclick="CirclebookRouter.navigate('auth', 'register')" style="color: var(--saffron-dark); font-weight: 700;">Sign Up</a>
                    </div>

                    <div style="margin-top: 1.5rem; padding-top: 1rem; border-top: 1px solid var(--border); text-align: center;">
                        <p style="font-size: 0.82rem; color: var(--text-secondary);">Quick Demo Context Switcher:</p>
                        <div style="display: flex; gap: 0.5rem; justify-content: center; margin-top: 0.5rem;">
                            <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.3rem 0.6rem;" onclick="CirclebookApp.switchDemoUser('usr_001')">User (Aarav)</button>
                            <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.3rem 0.6rem;" onclick="CirclebookApp.switchDemoUser('usr_004')">Admin (Ananya)</button>
                        </div>
                    </div>
                ` : subTab === "register" ? `
                    <div class="form-group"><label>Full Name</label><input type="text" id="regName" class="form-control" placeholder="Jane Doe"></div>
                    <div class="form-group"><label>Email Address</label><input type="email" id="regEmail" class="form-control" placeholder="jane@example.com"></div>
                    <div class="form-group"><label>Password</label><input type="password" id="regPass" class="form-control" placeholder="Create strong password"></div>
                    <button class="btn-primary" style="width: 100%; margin-top: 0.5rem;" onclick="CirclebookApp.handleRegisterSubmit()">Create Account & Get OTP →</button>
                    
                    <div style="margin-top: 1.25rem; text-align: center; font-size: 0.88rem; color: var(--text-secondary);">
                        Already registered? <a href="javascript:void(0)" onclick="CirclebookRouter.navigate('auth', 'login')" style="color: var(--saffron-dark); font-weight: 700;">Sign In</a>
                    </div>
                ` : subTab === "otp" ? `
                    <div style="text-align: center;">
                        <h3 style="font-family: Georgia, serif; margin-bottom: 0.5rem;">Security Verification (OTP)</h3>
                        <p style="font-size: 0.88rem; color: var(--text-secondary);">Enter the 6-digit code sent to your registered email/phone.</p>
                        
                        <div class="otp-input-group">
                            <input type="text" maxlength="1" class="otp-digit" value="4" />
                            <input type="text" maxlength="1" class="otp-digit" value="8" />
                            <input type="text" maxlength="1" class="otp-digit" value="2" />
                            <input type="text" maxlength="1" class="otp-digit" value="9" />
                            <input type="text" maxlength="1" class="otp-digit" value="1" />
                            <input type="text" maxlength="1" class="otp-digit" value="5" />
                        </div>
                        
                        <button class="btn-primary" style="width: 100%;" onclick="CirclebookApp.handleOTPSubmit()">Verify OTP & Setup Profile ✓</button>
                        <p style="margin-top: 1rem; font-size: 0.82rem; color: var(--text-muted);">Resend code in 24 seconds...</p>
                    </div>
                ` : `
                    <div class="form-group"><label>Enter your registered Email</label><input type="email" class="form-control" value="${CirclebookStore.currentUser.email}"></div>
                    <button class="btn-primary" style="width: 100%;" onclick="CirclebookApp.toast('Password reset code sent to email!'); CirclebookRouter.navigate('auth', 'otp');">Send Reset Code</button>
                `}
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 3. 🏠 HOME MODULE
    // ---------------------------------------------------------
    home(subTab = "feed") {
        const posts = CirclebookStore.posts;
        return `
            <div class="grid-3">
                <div style="grid-column: span 2;">
                    <!-- Create Post Box -->
                    <div class="circle-card">
                        <div style="display: flex; gap: 0.75rem; align-items: center; margin-bottom: 0.75rem;">
                            <img src="${CirclebookStore.currentUser.avatar}" class="post-avatar" alt="Avatar" />
                            <input type="text" id="newPostInput" class="form-control" style="border-radius: var(--radius-pill);" placeholder="Share an update, paper, or vintage typography thought with your circle..." />
                        </div>
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div style="display: flex; gap: 0.5rem;">
                                <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.7rem;">📷 Media</button>
                                <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.7rem;">📊 Poll</button>
                                <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.7rem;">🏷️ Tag</button>
                            </div>
                            <button class="btn-primary" style="padding: 0.4rem 1rem;" onclick="CirclebookApp.handleCreatePost()">Publish Post</button>
                        </div>
                    </div>

                    <!-- Feed Items -->
                    ${posts.length ? posts.map(p => `
                        <div class="circle-card">
                            <div class="post-header" style="justify-content: space-between;">
                                <div style="display: flex; align-items: center; gap: 0.75rem;">
                                    <img src="${p.authorAvatar}" class="post-avatar" alt="${p.authorName}" />
                                    <div>
                                        <div class="post-author-name">${p.authorName} <span class="tag-badge">${p.category}</span></div>
                                        <div class="post-author-handle">${p.authorHandle} • ${p.timestamp}</div>
                                    </div>
                                </div>
                                ${p.authorId === CirclebookStore.currentUser.id ? `
                                    <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.25rem 0.5rem; color: var(--danger);" title="Delete Post" onclick="CirclebookApp.confirmDeletePost('${p.id}')">🗑️ Delete</button>
                                ` : ''}
                            </div>
                            <div class="post-content">${p.content}</div>
                            ${p.image ? `<img src="${p.image}" class="post-media" alt="Post Media" />` : ''}
                            <div style="margin-bottom: 0.75rem;">
                                ${p.tags.map(t => `<span class="tag-badge">${t}</span>`).join('')}
                            </div>
                            <div class="post-actions">
                                <button class="post-action-btn ${p.isLiked ? 'active' : ''}" onclick="CirclebookStore.toggleLikePost('${p.id}'); CirclebookRouter.render();">
                                    ❤️ ${p.likes} Likes
                                </button>
                                <button class="post-action-btn" onclick="const txt = prompt('Add comment:'); if(txt){ CirclebookStore.addComment('${p.id}', txt); CirclebookRouter.render(); }">
                                    💬 ${p.comments.length} Comments
                                </button>
                                <button class="post-action-btn ${p.isBookmarked ? 'active' : ''}" onclick="CirclebookStore.toggleBookmarkPost('${p.id}'); CirclebookRouter.render();">
                                    📌 Bookmark
                                </button>
                            </div>
                            ${p.comments.length ? `
                                <div style="margin-top: 0.85rem; padding-top: 0.75rem; border-top: 1px dashed var(--border); font-size: 0.88rem;">
                                    ${p.comments.map(c => `
                                        <div style="display: flex; gap: 0.5rem; margin-bottom: 0.5rem;">
                                            <strong style="color: var(--text);">${c.author}:</strong>
                                            <span style="color: var(--text-secondary);">${c.text}</span>
                                        </div>
                                    `).join('')}
                                </div>
                            ` : ''}
                        </div>
                    `).join('') : `
                        <div class="empty-state-box">
                            <span class="empty-state-icon">📜</span>
                            <div class="empty-state-title">Your Feed is Empty</div>
                            <div class="empty-state-desc">Share your first update or connect with people in your circle to see updates here.</div>
                            <button class="btn-primary" onclick="CirclebookApp.openCreatePostModal()">+ Create First Post</button>
                        </div>
                    `}
                </div>

                <!-- Right Sidebar Widgets -->
                <div class="right-sidebar-panel sticky-right-panel">
                    <div class="circle-card">
                        <div class="circle-card-title">🔥 Trending Topics</div>
                        <div style="margin-top: 0.75rem;">
                            <div style="margin-bottom: 0.6rem;"><strong>#CirclebookMaster</strong><br><small style="color: var(--text-secondary);">1.2k posts today</small></div>
                            <div style="margin-bottom: 0.6rem;"><strong>#VintageDesign</strong><br><small style="color: var(--text-secondary);">840 posts</small></div>
                            <div style="margin-bottom: 0.6rem;"><strong>#AgenticAI</strong><br><small style="color: var(--text-secondary);">620 posts</small></div>
                        </div>
                    </div>

                    <div class="circle-card">
                        <div class="circle-card-title">⚡ What's Happening</div>
                        <div style="font-size: 0.88rem; color: var(--text-secondary); margin-top: 0.5rem; line-height: 1.5;">
                            • <strong>Tech Summit 2026</strong> RSVP registration is open.<br>
                            • 3 new communities created in your region.
                        </div>
                    </div>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 4. 🔎 DISCOVER MODULE
    // ---------------------------------------------------------
    discover(subTab = "people") {
        const users = CirclebookStore.users;
        return `
            <div class="circle-card">
                <div class="circle-card-header">
                    <div class="circle-card-title">🔎 Discover People & Connections</div>
                    <button class="btn-secondary" style="font-size: 0.8rem;" onclick="CirclebookRouter.navigate('ai', 'people_finder')">🤖 AI Smart Match</button>
                </div>
                <div class="global-search-bar" style="width: 100%; margin-bottom: 1.5rem;">
                    <span class="search-icon">🔍</span>
                    <input type="text" placeholder="Search people by name, skill (e.g. React, Python), location, or college..." oninput="CirclebookApp.filterDiscoverPeople(this.value)">
                </div>

                <div class="grid-3" id="discoverGrid">
                    ${users.map(u => `
                        <div class="circle-card" style="text-align: center; margin-bottom: 0;">
                            <img src="${u.avatar}" style="width: 76px; height: 76px; border-radius: 50%; object-fit: cover; margin-bottom: 0.5rem; border: 2px solid var(--border);" alt="${u.name}" />
                            <h3 style="font-size: 1.05rem; font-weight: 700; margin-bottom: 0.2rem;">${u.name}</h3>
                            <p style="font-size: 0.82rem; color: var(--text-secondary); margin-bottom: 0.4rem; min-height: 2.4em;">${u.headline}</p>
                            <p style="font-size: 0.78rem; color: var(--text-muted); margin-bottom: 0.75rem;">📍 ${u.location} • 🎓 ${u.college}</p>
                            <div style="margin-bottom: 0.85rem; min-height: 28px;">
                                ${u.skills.slice(0, 3).map(s => `<span class="tag-badge">${s}</span>`).join('')}
                            </div>
                            <div style="display: flex; gap: 0.5rem; justify-content: center;">
                                ${u.connectionStatus === 'connected' ? `
                                    <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.75rem; color: var(--india-green);" disabled>✓ Connected</button>
                                ` : u.connectionStatus === 'pending_sent' ? `
                                    <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;" onclick="CirclebookStore.cancelCircleRequest('${u.id}'); CirclebookApp.toast('Request cancelled'); CirclebookRouter.render();">⏳ Sent</button>
                                ` : `
                                    <button class="btn-primary" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;" onclick="CirclebookStore.sendCircleRequest('${u.id}'); CirclebookApp.toast('Circle request sent to ${u.name}'); CirclebookRouter.render();">+ Circle</button>
                                `}
                                <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;" onclick="CirclebookRouter.navigate('profile', 'overview')">Profile</button>
                            </div>
                        </div>
                    `).join('')}
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 5. 👥 MY CIRCLE MODULE
    // ---------------------------------------------------------
    mycircle(subTab = "all") {
        let users = CirclebookStore.users;
        if (subTab === "requests") {
            users = users.filter(u => u.connectionStatus === "pending_received" || u.connectionStatus === "pending_sent");
        } else if (subTab === "inner") {
            users = users.filter(u => CirclebookStore.currentUser.innerCircleIds.includes(u.id));
        } else if (subTab === "friends") {
            users = users.filter(u => u.circleType === "Friends");
        } else if (subTab === "work") {
            users = users.filter(u => u.circleType === "Work");
        } else {
            users = users.filter(u => u.connectionStatus === "connected");
        }

        return `
            <div class="circle-card">
                <div class="circle-card-header">
                    <div class="circle-card-title">👥 My Circle Network (${CirclebookStore.currentUser.circleCount} Members)</div>
                    <button class="btn-primary" style="font-size: 0.85rem;" onclick="const cName = prompt('Create Custom Circle Name:'); if(cName) CirclebookApp.toast('Circle created: ' + cName);">+ Create Custom Circle</button>
                </div>
                
                ${users.length ? `
                    <div class="grid-2">
                        ${users.map(u => `
                            <div style="display: flex; gap: 1rem; align-items: center; padding: 0.85rem; border: 1px solid var(--border); border-radius: var(--radius-soft); background: var(--surface);">
                                <img src="${u.avatar}" style="width: 54px; height: 54px; border-radius: 50%; object-fit: cover;" alt="${u.name}" />
                                <div style="flex: 1;">
                                    <div style="font-weight: 700;">${u.name} <span class="tag-badge" style="background: var(--saffron-soft); color: var(--saffron-dark); font-size: 0.72rem;">${u.circleType || 'Circle'}</span></div>
                                    <div style="font-size: 0.82rem; color: var(--text-secondary);">${u.headline}</div>
                                </div>
                                <div style="display: flex; gap: 0.4rem;">
                                    ${u.connectionStatus === 'pending_received' ? `
                                        <button class="btn-primary" style="font-size: 0.78rem; padding: 0.3rem 0.6rem;" onclick="CirclebookStore.acceptConnectionRequest('${u.id}'); CirclebookApp.toast('Accepted request from ${u.name}'); CirclebookRouter.render();">Accept</button>
                                        <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.3rem 0.6rem;" onclick="CirclebookStore.declineConnectionRequest('${u.id}'); CirclebookApp.toast('Declined request'); CirclebookRouter.render();">Decline</button>
                                    ` : u.connectionStatus === 'pending_sent' ? `
                                        <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.3rem 0.6rem;" onclick="CirclebookStore.cancelCircleRequest('${u.id}'); CirclebookApp.toast('Cancelled request'); CirclebookRouter.render();">Cancel</button>
                                    ` : `
                                        <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.3rem 0.6rem;" onclick="CirclebookRouter.navigate('communication', 'chat')">Message</button>
                                    `}
                                </div>
                            </div>
                        `).join('')}
                    </div>
                ` : `
                    <div class="empty-state-box">
                        <span class="empty-state-icon">👥</span>
                        <div class="empty-state-title">No Connections Found</div>
                        <div class="empty-state-desc">There are currently no members in this sub-circle. Search the directory to add people to your circle.</div>
                        <button class="btn-primary" onclick="CirclebookRouter.navigate('discover', 'people')">Find People →</button>
                    </div>
                `}
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 6. 👤 PROFILE MODULE
    // ---------------------------------------------------------
    profile(subTab = "overview") {
        const u = CirclebookStore.currentUser;
        return `
            <div class="circle-card" style="padding: 0; overflow: hidden;">
                <img src="${u.banner}" style="width: 100%; height: 180px; object-fit: cover;" alt="Banner" />
                <div style="padding: 1.5rem; position: relative;">
                    <img src="${u.avatar}" style="width: 90px; height: 90px; border-radius: 50%; border: 4px solid var(--surface); position: absolute; top: -45px; left: 1.5rem; object-fit: cover;" alt="${u.name}" />
                    <div class="profile-info-row" style="margin-left: 110px; display: flex; justify-content: space-between; align-items: flex-start;">
                        <div>
                            <h2 style="font-family: Georgia, serif; font-size: 1.5rem;">${u.name}</h2>
                            <p style="color: var(--text-secondary); font-size: 0.95rem;">${u.headline}</p>
                            <p style="color: var(--text-muted); font-size: 0.85rem; margin-top: 0.25rem;">📍 ${u.location} • 🎓 ${u.college}</p>
                        </div>
                        <button class="btn-secondary" onclick="CirclebookApp.openEditProfileModal()">✏️ Edit Profile</button>
                    </div>
                </div>
            </div>

            <div class="circle-card">
                <div class="circle-card-title" style="margin-bottom: 0.75rem;">About & Bio</div>
                <p style="line-height: 1.6; color: var(--text);">${u.about}</p>
                <div style="margin-top: 1rem;">
                    <strong>Skills & Endorsements:</strong><br>
                    <div style="margin-top: 0.5rem;">
                        ${u.skills.map(s => `<span class="tag-badge" style="padding: 0.3rem 0.6rem; font-size: 0.85rem;">${s} 👍</span>`).join('')}
                    </div>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 7. 💬 COMMUNICATION MODULE
    // ---------------------------------------------------------
    communication(subTab = "chat") {
        const chats = CirclebookStore.chats;
        const activeChat = chats[0];
        return `
            <div class="chat-container">
                <div class="chat-sidebar">
                    <div style="padding: 1rem; border-bottom: 1px solid var(--border); font-weight: 700; font-family: Georgia, serif;">💬 Circle Messages</div>
                    ${chats.map(c => `
                        <div class="chat-thread-item ${c.id === activeChat.id ? 'active' : ''}">
                            <div style="font-weight: 600; font-size: 0.9rem;">${c.participant ? c.participant.name : c.name}</div>
                            <div style="font-size: 0.78rem; color: var(--text-secondary); white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${c.lastMessage}</div>
                        </div>
                    `).join('')}
                </div>
                <div class="chat-main">
                    <div class="chat-header">
                        <div>${activeChat.participant ? activeChat.participant.name : activeChat.name}</div>
                        <span style="font-size: 0.78rem; color: var(--india-green, green);">● Active now</span>
                    </div>
                    <div class="chat-messages-body" id="chatMessagesBody">
                        ${activeChat.messages.map(m => `
                            <div class="chat-bubble ${m.sender === CirclebookStore.currentUser.id ? 'sent' : 'received'}">
                                <div>${m.text}</div>
                                <div style="font-size: 0.7rem; opacity: 0.8; text-align: right; margin-top: 0.2rem;">${m.timestamp}</div>
                            </div>
                        `).join('')}
                    </div>
                    <div class="chat-input-area">
                        <input type="text" id="chatInput" placeholder="Type a message to Priya..." onkeypress="if(event.key==='Enter') CirclebookApp.handleSendChatMessage('${activeChat.id}')">
                        <button class="btn-primary" onclick="CirclebookApp.handleSendChatMessage('${activeChat.id}')">Send</button>
                    </div>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 8. 🔔 NOTIFICATIONS MODULE
    // ---------------------------------------------------------
    notifications(subTab = "all") {
        const notifs = CirclebookStore.notifications;
        return `
            <div class="circle-card">
                <div class="circle-card-header">
                    <div class="circle-card-title">🔔 Notifications Center</div>
                    <button class="btn-secondary" style="font-size: 0.8rem;" onclick="CirclebookApp.toast('All marked as read');">Mark all as read</button>
                </div>
                ${notifs.map(n => `
                    <div style="display: flex; gap: 1rem; align-items: center; padding: 0.85rem; border-bottom: 1px solid var(--border);">
                        <div style="font-size: 1.5rem;">${n.avatar.startsWith('http') ? `<img src="${n.avatar}" style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;" />` : n.avatar}</div>
                        <div style="flex: 1;">
                            <div style="font-size: 0.92rem; color: var(--text);">${n.title}</div>
                            <div style="font-size: 0.78rem; color: var(--text-secondary);">${n.timestamp}</div>
                        </div>
                        ${n.actionable ? `<button class="btn-primary" style="font-size: 0.78rem; padding: 0.3rem 0.65rem;" onclick="CirclebookStore.acceptConnectionRequest('${n.requestId}'); CirclebookRouter.render();">Accept</button>` : ''}
                    </div>
                `).join('')}
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 9. 🌐 COMMUNITIES MODULE
    // ---------------------------------------------------------
    communities(subTab = "discover") {
        const comms = CirclebookStore.communities;
        return `
            <div class="circle-card">
                <div class="circle-card-header">
                    <div class="circle-card-title">🌐 Communities & Interest Hubs</div>
                    <button class="btn-primary" style="font-size: 0.85rem;" onclick="const name = prompt('Community Name:'); if(name) CirclebookApp.toast('Community requested for review!');">+ Start Community</button>
                </div>
                <div class="grid-3">
                    ${comms.map(c => `
                        <div class="circle-card" style="margin-bottom: 0; padding: 0; overflow: hidden;">
                            <img src="${c.banner}" style="width: 100%; height: 110px; object-fit: cover;" alt="${c.name}" />
                            <div style="padding: 1rem;">
                                <h3 style="font-size: 1.05rem; font-weight: 700; margin-bottom: 0.3rem;">${c.name}</h3>
                                <p style="font-size: 0.82rem; color: var(--text-secondary); line-height: 1.4; margin-bottom: 0.75rem;">${c.description}</p>
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <span style="font-size: 0.78rem; color: var(--text-muted);">👥 ${c.membersCount} members</span>
                                    <button class="${c.isJoined ? 'btn-secondary' : 'btn-primary'}" style="font-size: 0.78rem; padding: 0.3rem 0.7rem;" onclick="CirclebookStore.toggleCommunityJoin('${c.id}'); CirclebookRouter.render();">
                                        ${c.isJoined ? 'Joined ✓' : '+ Join'}
                                    </button>
                                </div>
                            </div>
                        </div>
                    `).join('')}
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 10. 📅 EVENTS MODULE
    // ---------------------------------------------------------
    events(subTab = "discover") {
        const evts = CirclebookStore.events;
        return `
            <div class="circle-card">
                <div class="circle-card-header">
                    <div class="circle-card-title">📅 Community Events & Summits</div>
                    <button class="btn-primary" style="font-size: 0.85rem;" onclick="CirclebookApp.toast('Event creation modal opened');">+ Host Event</button>
                </div>
                <div class="grid-2">
                    ${evts.map(e => `
                        <div class="circle-card" style="margin-bottom: 0; padding: 0; overflow: hidden;">
                            <img src="${e.banner}" style="width: 100%; height: 130px; object-fit: cover;" alt="${e.title}" />
                            <div style="padding: 1.25rem;">
                                <span class="tag-badge" style="background: var(--saffron-soft); color: var(--saffron-dark); font-weight: 700;">${e.type}</span>
                                <h3 style="font-size: 1.1rem; font-weight: 700; margin: 0.4rem 0;">${e.title}</h3>
                                <p style="font-size: 0.85rem; color: var(--text-secondary); margin-bottom: 0.75rem;">📆 ${e.date} • 🕒 ${e.time}</p>
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <span style="font-size: 0.8rem; color: var(--text-muted);">🎟️ ${e.attendingCount} attending</span>
                                    <button class="${e.isRSVPed ? 'btn-secondary' : 'btn-primary'}" style="font-size: 0.8rem; padding: 0.35rem 0.8rem;" onclick="CirclebookStore.toggleEventRSVP('${e.id}'); CirclebookRouter.render();">
                                        ${e.isRSVPed ? 'RSVPed ✓' : 'RSVP Now'}
                                    </button>
                                </div>
                            </div>
                        </div>
                    `).join('')}
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 11. 💼 CAREER HUB MODULE
    // ---------------------------------------------------------
    career(subTab = "dashboard") {
        const jobs = CirclebookStore.jobs;
        return `
            <div class="circle-card">
                <div class="circle-card-header">
                    <div class="circle-card-title">💼 Career Hub & Opportunities</div>
                </div>
                <div class="grid-3" style="margin-bottom: 1.5rem;">
                    <div class="metric-card">
                        <div class="metric-label">Profile Strength</div>
                        <div class="metric-value" style="color: var(--india-green, green);">94%</div>
                        <div style="font-size: 0.78rem; color: var(--text-secondary);">Ready for recruiter outreach</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-label">Job Applications</div>
                        <div class="metric-value">1</div>
                        <div style="font-size: 0.78rem; color: var(--text-secondary);">Active application status</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-label">Matched Positions</div>
                        <div class="metric-value" style="color: var(--saffron-dark);">12</div>
                        <div style="font-size: 0.78rem; color: var(--text-secondary);">Based on JavaScript & CSS</div>
                    </div>
                </div>

                <div class="grid-2">
                    ${jobs.map(j => `
                        <div class="circle-card" style="margin-bottom: 0;">
                            <div style="display: flex; gap: 0.75rem; align-items: flex-start; margin-bottom: 0.5rem;">
                                <div style="font-size: 2rem;">${j.logo}</div>
                                <div style="flex: 1;">
                                    <h3 style="font-size: 1.05rem; font-weight: 700;">${j.title}</h3>
                                    <div style="font-size: 0.85rem; color: var(--text-secondary);">${j.company} • 📍 ${j.location}</div>
                                </div>
                            </div>
                            <p style="font-size: 0.85rem; color: var(--text); line-height: 1.5; margin-bottom: 0.75rem;">${j.description}</p>
                            <div style="margin-bottom: 0.85rem;">
                                ${j.skills.map(s => `<span class="tag-badge">${s}</span>`).join('')}
                            </div>
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <strong style="font-size: 0.88rem; color: var(--saffron-dark);">${j.salary}</strong>
                                <button class="${j.isApplied ? 'btn-secondary' : 'btn-primary'}" style="font-size: 0.8rem; padding: 0.35rem 0.85rem;" onclick="CirclebookStore.applyForJob('${j.id}'); CirclebookRouter.render();">
                                    ${j.isApplied ? 'Applied ✓' : 'Easy Apply'}
                                </button>
                            </div>
                        </div>
                    `).join('')}
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 12. 🤖 CIRCLE AI MODULE
    // ---------------------------------------------------------
    ai(subTab = "home") {
        return `
            <div class="circle-card">
                <div class="circle-card-header">
                    <div class="circle-card-title">🤖 Circle AI Assistant & Search Engine</div>
                </div>
                <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">
                    Ask Circle AI to find people with specific skills, draft posts, summarize community discussions, or suggest career milestones.
                </p>

                <div class="grid-2" style="margin-bottom: 1.5rem;">
                    <div style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-soft); cursor: pointer;" onclick="CirclebookApp.triggerAIPrompt('Find senior UI designers in Bangalore with 3+ years experience')">
                        <strong>🔍 Semantic People Finder</strong>
                        <p style="font-size: 0.82rem; color: var(--text-secondary); margin-top: 0.25rem;">"Find senior UI designers in Bangalore with 3+ years experience"</p>
                    </div>
                    <div style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-soft); cursor: pointer;" onclick="CirclebookApp.triggerAIPrompt('Draft an engaging post about vintage CSS grid layouts')">
                        <strong>✍️ Post Draft Assistant</strong>
                        <p style="font-size: 0.82rem; color: var(--text-secondary); margin-top: 0.25rem;">"Draft an engaging post about vintage CSS grid layouts"</p>
                    </div>
                </div>

                <div style="background: var(--surface-soft); border: 1px solid var(--border); border-radius: var(--radius-soft); padding: 1.25rem;">
                    <div style="font-weight: 700; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.5rem;">
                        <span style="font-size: 1.2rem;">✨</span> Circle AI Prompt Output
                    </div>
                    <div id="aiPromptResult" style="font-size: 0.92rem; line-height: 1.6; color: var(--text);">
                        Ready! Click any prompt above or type a query below to interact with Circle AI.
                    </div>
                    <div style="display: flex; gap: 0.5rem; margin-top: 1rem;">
                        <input type="text" id="customAIPrompt" class="form-control" placeholder="Ask Circle AI anything about your network or career..." />
                        <button class="btn-primary" onclick="CirclebookApp.triggerAIPrompt(document.getElementById('customAIPrompt').value)">Generate</button>
                    </div>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 13. ⚙️ SETTINGS MODULE
    // ---------------------------------------------------------
    settings(subTab = "appearance") {
        const u = CirclebookStore.currentUser;
        const theme = u.appearance.theme;
        return `
            <div class="circle-card">
                <div class="circle-card-header">
                    <div class="circle-card-title">⚙️ Settings & Account Preferences</div>
                    <button class="btn-primary" style="font-size: 0.85rem;" onclick="CirclebookApp.openEditProfileModal()">✏️ Edit Profile</button>
                </div>
                
                <div class="form-group">
                    <label>Select Application Theme & Palette</label>
                    <div class="grid-4" style="margin-top: 0.5rem;">
                        <button class="btn-secondary" style="${theme === 'vintage-gold' ? 'border-color: var(--saffron); font-weight: 700; background: var(--saffron-soft);' : ''}" onclick="CirclebookStore.applyTheme('vintage-gold'); CirclebookRouter.render();">📜 Vintage Gold</button>
                        <button class="btn-secondary" style="${theme === 'vintage-dark' ? 'border-color: var(--saffron); font-weight: 700; background: var(--saffron-soft);' : ''}" onclick="CirclebookStore.applyTheme('vintage-dark'); CirclebookRouter.render();">🌙 Vintage Dark</button>
                        <button class="btn-secondary" style="${theme === 'modern-navy' ? 'border-color: var(--saffron); font-weight: 700; background: var(--saffron-soft);' : ''}" onclick="CirclebookStore.applyTheme('modern-navy'); CirclebookRouter.render();">🌊 Modern Navy</button>
                        <button class="btn-secondary" style="${theme === 'emerald-clean' ? 'border-color: var(--saffron); font-weight: 700; background: var(--saffron-soft);' : ''}" onclick="CirclebookStore.applyTheme('emerald-clean'); CirclebookRouter.render();">🌿 Emerald Clean</button>
                    </div>
                </div>

                <div style="margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid var(--border);">
                    <h3 style="font-size: 1.1rem; font-weight: 700; margin-bottom: 1rem;">🔒 Account & Privacy Controls</h3>
                    <div class="grid-2">
                        <div class="form-group">
                            <label>Profile Visibility</label>
                            <select class="form-control" onchange="CirclebookApp.toast('Privacy setting updated')">
                                <option ${u.privacy.profile === 'Everyone' ? 'selected' : ''}>Everyone</option>
                                <option ${u.privacy.profile === 'My Circle' ? 'selected' : ''}>My Circle Only</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Email Visibility</label>
                            <select class="form-control" onchange="CirclebookApp.toast('Privacy setting updated')">
                                <option ${u.privacy.email === 'My Circle' ? 'selected' : ''}>My Circle</option>
                                <option ${u.privacy.email === 'Only Me' ? 'selected' : ''}>Only Me</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div style="margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <strong style="color: var(--text);">Signed in as ${u.name}</strong> (${u.email})
                        <div style="font-size: 0.82rem; color: var(--text-secondary);">Session active on current device</div>
                    </div>
                    <button class="btn-danger" style="font-size: 0.88rem;" onclick="CirclebookApp.confirmLogout()">🚪 Sign Out</button>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 14. 🛡️ SAFETY MODULE
    // ---------------------------------------------------------
    safety(subTab = "center") {
        return `
            <div class="circle-card">
                <div class="circle-card-header">
                    <div class="circle-card-title">🛡️ Safety Center & Community Standards</div>
                </div>
                <p style="color: var(--text-secondary); margin-bottom: 1.25rem;">
                    The Circlebook strictly enforces respectful community interaction, zero tolerance for harassment, and data privacy rights.
                </p>
                <div class="grid-2">
                    <div style="padding: 1.25rem; border: 1px solid var(--border); border-radius: var(--radius-soft);">
                        <h4 style="font-size: 1rem; margin-bottom: 0.5rem;">🚩 Report Content or User</h4>
                        <p style="font-size: 0.85rem; color: var(--text-secondary); margin-bottom: 0.75rem;">Submit a confidential report to our 24/7 moderation team.</p>
                        <button class="btn-secondary" onclick="const reason = prompt('Reason for report:'); if(reason) CirclebookApp.toast('Report submitted for review');">Submit Report</button>
                    </div>
                    <div style="padding: 1.25rem; border: 1px solid var(--border); border-radius: var(--radius-soft);">
                        <h4 style="font-size: 1rem; margin-bottom: 0.5rem;">🔒 Account Security Health</h4>
                        <p style="font-size: 0.85rem; color: var(--text-secondary); margin-bottom: 0.75rem;">Status: <strong style="color: var(--india-green, green);">Secure (2FA Active)</strong></p>
                        <button class="btn-secondary" onclick="CirclebookApp.toast('Security Scan Completed: 0 issues found');">Run Security Scan</button>
                    </div>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 15. 🧑💼 ADMIN MODULE
    // ---------------------------------------------------------
    admin(subTab = "dashboard") {
        const metrics = CirclebookStore.adminData.systemMetrics;
        const reports = CirclebookStore.adminData.pendingReports;
        const logs = CirclebookStore.adminData.auditLogs;
        return `
            <div class="circle-card">
                <div class="circle-card-header">
                    <div class="circle-card-title">🧑💼 Admin Command & Moderation Suite</div>
                    <span class="tag-badge" style="background: var(--saffron-soft); color: var(--saffron-dark); font-weight: 700;">Role: System Admin</span>
                </div>

                <div class="grid-4" style="margin-bottom: 1.5rem;">
                    <div class="metric-card">
                        <div class="metric-label">Total Users</div>
                        <div class="metric-value">${metrics.totalUsers}</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-label">Active Today</div>
                        <div class="metric-value" style="color: var(--saffron-dark);">${metrics.activeToday}</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-label">Pending Reports</div>
                        <div class="metric-value" style="color: red;">${reports.length}</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-label">Server Uptime</div>
                        <div class="metric-value" style="color: var(--india-green, green);">${metrics.serverUptime}</div>
                    </div>
                </div>

                <h3>Pending Moderation Reports Queue</h3>
                <table class="circle-table">
                    <thead>
                        <tr>
                            <th>Reporter</th>
                            <th>Target Content</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${reports.map(r => `
                            <tr>
                                <td>${r.reporter}</td>
                                <td>${r.target}</td>
                                <td>${r.reason}</td>
                                <td><span class="tag-badge" style="color: orange;">${r.status}</span></td>
                                <td>
                                    <button class="btn-primary" style="font-size: 0.75rem; padding: 0.2rem 0.5rem;" onclick="CirclebookApp.toast('Report Resolved');">Resolve</button>
                                </td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            </div>
        `;
    }
};
