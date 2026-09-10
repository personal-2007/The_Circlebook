/* =========================================================
   THE CIRCLEBOOK - MASTER VIEWS RENDERER
   ========================================================= */

const CirclebookViews = {
    // ---------------------------------------------------------
    // 1. ENTRY MODULE
    // ---------------------------------------------------------
    entry(subTab = "welcome") {
        if (subTab === "splash") {
            return `
                <div class="circle-card" style="text-align: center; padding: 4rem 2rem; max-width: 480px; margin: 4rem auto;">
                    <div class="loading-logo" style="width: 80px; height: 80px; margin: 0 auto 1.25rem;">
                        <img src="assets/images/circlebook-logo.png" alt="The Circlebook Logo" style="width: 100%; height: 100%; object-fit: contain; border-radius: 50%; border: 2px solid var(--primary-blue);" />
                    </div>
                    <h1 style="font-size: 2rem; font-weight: 800; color: var(--text-primary); margin-bottom: 0.25rem;">The Circlebook</h1>
                    <p style="color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 1.5rem;">Know your people. Build your circle.</p>
                    <div class="loading-spinner" style="margin: 0 auto 1.25rem;"></div>
                    <p style="font-size: 0.85rem; color: var(--text-muted);">Loading network directory...</p>
                </div>
            `;
        }
        if (subTab === "welcome") {
            return `
                <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 2rem; background: var(--background);">
                    <div class="circle-card" style="max-width: 860px; width: 100%; padding: 3rem;">
                        <div class="grid-2" style="align-items: center; gap: 2.5rem;">
                            <div>
                                <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1.25rem;">
                                    <img src="assets/images/circlebook-logo.png" style="width: 44px; height: 44px; object-fit: contain; border-radius: 50%;" alt="Logo" />
                                    <span class="tag-badge" style="background: rgba(37, 99, 235, 0.1); color: var(--primary-blue); font-weight: 700;">COMMUNITY & PROFESSIONAL NETWORK</span>
                                </div>
                                <h1 style="font-size: 2.4rem; font-weight: 800; margin: 0.5rem 0 1rem; color: var(--text-primary); line-height: 1.2;">Know Your People.<br>Build Your Circle.</h1>
                                <p style="font-size: 1rem; color: var(--text-secondary); line-height: 1.6; margin-bottom: 2rem;">
                                    Welcome to The Circlebook — a classical social networking platform built for authentic relationships, knowledge exchange, and career progression.
                                </p>
                                <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                                    <button class="btn-primary" onclick="CirclebookRouter.navigate('auth', 'register')">Get Started</button>
                                    <button class="btn-secondary" onclick="CirclebookRouter.navigate('auth', 'login')">Sign In</button>
                                </div>
                            </div>
                            <div style="text-align: center;">
                                <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=600&q=80" style="width: 100%; border-radius: var(--radius-md); border: 1px solid var(--border);" alt="Community Group" />
                            </div>
                        </div>
                    </div>
                </div>
            `;
        }
        if (subTab.startsWith("onboarding")) {
            const step = subTab === "onboarding1" ? 1 : subTab === "onboarding2" ? 2 : 3;
            return `
                <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 2rem; background: var(--background);">
                    <div class="circle-card" style="max-width: 620px; width: 100%; padding: 2.5rem;">
                        <div class="onboarding-steps-bar" style="display: flex; gap: 0.5rem; margin-bottom: 1.5rem;">
                            <div style="flex: 1; height: 4px; border-radius: 2px; background: ${step >= 1 ? 'var(--primary-blue)' : 'var(--border)'}"></div>
                            <div style="flex: 1; height: 4px; border-radius: 2px; background: ${step >= 2 ? 'var(--primary-blue)' : 'var(--border)'}"></div>
                            <div style="flex: 1; height: 4px; border-radius: 2px; background: ${step >= 3 ? 'var(--primary-blue)' : 'var(--border)'}"></div>
                        </div>
                        <h2 style="font-size: 1.5rem; font-weight: 700; margin-bottom: 0.35rem;">Profile Setup — Step ${step} of 3</h2>
                        <p style="color: var(--text-secondary); font-size: 0.9rem; margin-bottom: 1.75rem;">
                            ${step === 1 ? 'Basic Information & Headline' : step === 2 ? 'Skills & Professional Interests' : 'Circle Connections & Recommended Communities'}
                        </p>
                        
                        ${step === 1 ? `
                            <div class="form-group"><label>Full Name</label><input type="text" id="obName" class="form-control" value="${CirclebookStore.currentUser.name}"></div>
                            <div class="form-group"><label>Headline / Professional Title</label><input type="text" id="obHeadline" class="form-control" value="${CirclebookStore.currentUser.headline}"></div>
                            <div class="form-group"><label>Location</label><input type="text" id="obLocation" class="form-control" value="${CirclebookStore.currentUser.location}"></div>
                            <div class="form-group"><label>Education / University</label><input type="text" id="obCollege" class="form-control" value="${CirclebookStore.currentUser.college}"></div>
                            <button class="btn-primary" style="width: 100%; margin-top: 1rem;" onclick="CirclebookApp.saveOnboardingStep1()">Continue</button>
                        ` : step === 2 ? `
                            <div class="form-group">
                                <label>Select Primary Skills</label>
                                <div style="display: flex; gap: 0.5rem; flex-wrap: wrap; margin-top: 0.5rem;">
                                    <span class="tag-badge" style="background: rgba(37, 99, 235, 0.1); color: var(--primary-blue); font-weight: 600;">JavaScript</span>
                                    <span class="tag-badge" style="background: rgba(37, 99, 235, 0.1); color: var(--primary-blue); font-weight: 600;">React</span>
                                    <span class="tag-badge">Python</span>
                                    <span class="tag-badge">UI/UX Design</span>
                                    <span class="tag-badge">System Design</span>
                                    <span class="tag-badge">DevOps</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Networking Goal</label>
                                <select class="form-control">
                                    <option>Professional Networking & Peer Connections</option>
                                    <option>Discover Career Opportunities</option>
                                    <option>Collaborate on Projects</option>
                                    <option>Mentorship & Guidance</option>
                                </select>
                            </div>
                            <button class="btn-primary" style="width: 100%; margin-top: 1rem;" onclick="CirclebookRouter.navigate('entry', 'onboarding3')">Continue</button>
                        ` : `
                            <div class="form-group">
                                <label>Recommended Communities</label>
                                <div style="margin-top: 0.75rem;">
                                    <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.85rem; border: 1px solid var(--border); border-radius: var(--radius-sm); margin-bottom: 0.5rem;">
                                        <div><strong>Frontend Engineering Guild</strong> • 1.4k members</div>
                                        <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.3rem 0.75rem;">Joined</button>
                                    </div>
                                    <div style="display: flex; align-items: center; justify-content: space-between; padding: 0.85rem; border: 1px solid var(--border); border-radius: var(--radius-sm);">
                                        <div><strong>Design Systems & UI UX</strong> • 890 members</div>
                                        <button class="btn-primary" style="font-size: 0.8rem; padding: 0.3rem 0.75rem;">Join</button>
                                    </div>
                                </div>
                            </div>
                            <button class="btn-primary" style="width: 100%; margin-top: 1rem;" onclick="CirclebookApp.completeOnboarding()">Complete Setup & Go to Feed</button>
                        `}
                    </div>
                </div>
            `;
        }
        return this.entry("welcome");
    },

    // ---------------------------------------------------------
    // 2. AUTH MODULE
    // ---------------------------------------------------------
    auth(subTab = "login") {
        return `
            <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 2rem; background: var(--background);">
                <div class="circle-card" style="max-width: 440px; width: 100%; padding: 2.5rem;">
                    <div style="text-align: center; margin-bottom: 1.75rem;">
                        <img src="assets/images/circlebook-logo.png" style="width: 56px; height: 56px; object-fit: contain; border-radius: 50%; margin-bottom: 0.75rem;" alt="Circlebook Logo" />
                        <h2 style="font-size: 1.5rem; font-weight: 800; color: var(--text-primary); margin-bottom: 0.25rem;">The Circlebook</h2>
                        <p style="color: var(--text-secondary); font-size: 0.88rem;">Know your people. Build your circle.</p>
                    </div>

                    ${subTab === "login" ? `
                        <div class="form-group"><label>Email Address</label><input type="email" id="loginEmail" class="form-control" value="${CirclebookStore.currentUser.email}"></div>
                        <div class="form-group"><label>Password</label><input type="password" id="loginPass" class="form-control" value="••••••••••••"></div>
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                            <label style="font-size: 0.85rem; color: var(--text-secondary); cursor: pointer;"><input type="checkbox" checked style="margin-right: 0.35rem;"> Remember me</label>
                            <a href="javascript:void(0)" onclick="CirclebookRouter.navigate('auth', 'forgot')" style="color: var(--primary-blue); text-decoration: none; font-size: 0.85rem; font-weight: 600;">Forgot password?</a>
                        </div>
                        <button class="btn-primary" style="width: 100%;" onclick="CirclebookApp.handleLoginSubmit()">Sign In</button>
                        
                        <div style="margin-top: 1.5rem; text-align: center; font-size: 0.88rem; color: var(--text-secondary);">
                            Don't have an account? <a href="javascript:void(0)" onclick="CirclebookRouter.navigate('auth', 'register')" style="color: var(--primary-blue); font-weight: 600;">Create Account</a>
                        </div>

                        <div style="margin-top: 1.5rem; padding-top: 1rem; border-top: 1px solid var(--border); text-align: center;">
                            <p style="font-size: 0.8rem; color: var(--text-secondary); margin-bottom: 0.5rem;">Quick Context Switcher:</p>
                            <div style="display: flex; gap: 0.5rem; justify-content: center;">
                                <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.3rem 0.65rem;" onclick="CirclebookApp.switchDemoUser('usr_001')">Member (Aarav)</button>
                                <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.3rem 0.65rem;" onclick="CirclebookApp.switchDemoUser('usr_004')">Admin (Ananya)</button>
                            </div>
                        </div>
                    ` : subTab === "register" ? `
                        <div class="form-group"><label>Full Name</label><input type="text" id="regName" class="form-control" placeholder="Jane Doe"></div>
                        <div class="form-group"><label>Email Address</label><input type="email" id="regEmail" class="form-control" placeholder="jane@example.com"></div>
                        <div class="form-group"><label>Password</label><input type="password" id="regPass" class="form-control" placeholder="Create password"></div>
                        <button class="btn-primary" style="width: 100%; margin-top: 0.5rem;" onclick="CirclebookApp.handleRegisterSubmit()">Create Account</button>
                        
                        <div style="margin-top: 1.5rem; text-align: center; font-size: 0.88rem; color: var(--text-secondary);">
                            Already registered? <a href="javascript:void(0)" onclick="CirclebookRouter.navigate('auth', 'login')" style="color: var(--primary-blue); font-weight: 600;">Sign In</a>
                        </div>
                    ` : subTab === "otp" ? `
                        <div style="text-align: center;">
                            <h3 style="font-size: 1.25rem; font-weight: 700; margin-bottom: 0.5rem;">Security Verification</h3>
                            <p style="font-size: 0.88rem; color: var(--text-secondary); margin-bottom: 1.25rem;">Enter the verification code sent to your email.</p>
                            
                            <div class="otp-input-group" style="display: flex; gap: 0.5rem; justify-content: center; margin-bottom: 1.5rem;">
                                <input type="text" maxlength="1" class="form-control" style="width: 44px; text-align: center; font-size: 1.2rem; font-weight: 700;" value="4" />
                                <input type="text" maxlength="1" class="form-control" style="width: 44px; text-align: center; font-size: 1.2rem; font-weight: 700;" value="8" />
                                <input type="text" maxlength="1" class="form-control" style="width: 44px; text-align: center; font-size: 1.2rem; font-weight: 700;" value="2" />
                                <input type="text" maxlength="1" class="form-control" style="width: 44px; text-align: center; font-size: 1.2rem; font-weight: 700;" value="9" />
                                <input type="text" maxlength="1" class="form-control" style="width: 44px; text-align: center; font-size: 1.2rem; font-weight: 700;" value="1" />
                                <input type="text" maxlength="1" class="form-control" style="width: 44px; text-align: center; font-size: 1.2rem; font-weight: 700;" value="5" />
                            </div>
                            
                            <button class="btn-primary" style="width: 100%;" onclick="CirclebookApp.handleOTPSubmit()">Verify Code</button>
                            <p style="margin-top: 1rem; font-size: 0.82rem; color: var(--text-muted);">Resend code in 24s</p>
                        </div>
                    ` : `
                        <div class="form-group"><label>Registered Email Address</label><input type="email" class="form-control" value="${CirclebookStore.currentUser.email}"></div>
                        <button class="btn-primary" style="width: 100%;" onclick="CirclebookApp.toast('Password reset instructions sent'); CirclebookRouter.navigate('auth', 'otp');">Send Reset Instructions</button>
                        <div style="margin-top: 1.25rem; text-align: center;">
                            <a href="javascript:void(0)" onclick="CirclebookRouter.navigate('auth', 'login')" style="color: var(--primary-blue); font-size: 0.88rem; font-weight: 600;">Back to Sign In</a>
                        </div>
                    `}
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 3. HOME MODULE
    // ---------------------------------------------------------
    home(subTab = "feed") {
        const posts = CirclebookStore.posts;
        const currentUser = CirclebookStore.currentUser;

        return `
            <div class="grid-3">
                <div style="grid-column: span 2;">
                    <!-- Create Post Box -->
                    <div class="circle-card">
                        <div style="display: flex; gap: 0.75rem; align-items: flex-start; margin-bottom: 0.85rem;">
                            <img src="${currentUser.avatar}" class="post-avatar" alt="Avatar" style="width: 42px; height: 42px; border-radius: 50%; object-fit: cover;" />
                            <textarea id="newPostInput" class="form-control" rows="2" style="border-radius: var(--radius-sm); resize: none;" placeholder="Share an update, paper, or insight with your circle..."></textarea>
                        </div>
                        <div style="display: flex; justify-content: space-between; align-items: center; border-top: 1px solid var(--border); padding-top: 0.75rem;">
                            <div style="display: flex; gap: 0.4rem;">
                                <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.65rem; display: flex; align-items: center; gap: 0.35rem;" onclick="CirclebookApp.openCreatePostModal()">
                                    ${CirclebookIcons.get('image', '', 15)} Media
                                </button>
                                <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.65rem; display: flex; align-items: center; gap: 0.35rem;" onclick="CirclebookApp.openCreatePostModal()">
                                    ${CirclebookIcons.get('poll', '', 15)} Poll
                                </button>
                                <button class="btn-secondary" style="font-size: 0.8rem; padding: 0.35rem 0.65rem; display: flex; align-items: center; gap: 0.35rem;" onclick="CirclebookApp.openCreatePostModal()">
                                    ${CirclebookIcons.get('tag', '', 15)} Tag
                                </button>
                            </div>
                            <button class="btn-primary" style="padding: 0.4rem 1.1rem; font-size: 0.88rem;" onclick="CirclebookApp.handleCreatePost()">Publish</button>
                        </div>
                    </div>

                    <!-- Feed Items -->
                    ${posts.length ? posts.map(p => {
                        const isOwn = p.authorId === currentUser.id;
                        return `
                            <div class="circle-card" style="position: relative;">
                                <div class="post-header" style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.85rem;">
                                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                                        <img src="${p.authorAvatar}" class="post-avatar" style="width: 44px; height: 44px; border-radius: 50%; object-fit: cover;" alt="${p.authorName}" />
                                        <div>
                                            <div class="post-author-name" style="font-weight: 700; font-size: 0.95rem; display: flex; align-items: center; gap: 0.5rem;">
                                                ${p.authorName} 
                                                <span class="tag-badge" style="font-weight: 500; font-size: 0.72rem;">${p.category}</span>
                                            </div>
                                            <div class="post-author-handle" style="font-size: 0.78rem; color: var(--text-secondary);">${p.authorHandle} • ${p.timestamp}</div>
                                        </div>
                                    </div>
                                    
                                    <!-- CONTEXTUAL THREE-DOT MORE MENU -->
                                    <div style="position: relative;">
                                        <button class="post-more-btn" aria-label="More options" onclick="CirclebookApp.togglePostMenu(event, '${p.id}')">
                                            ${CirclebookIcons.get('more-vertical', '', 18)}
                                        </button>
                                        <div class="cb-dropdown-menu" id="postMenu_${p.id}" style="display: none;">
                                            ${isOwn ? `
                                                <button class="cb-dropdown-item" onclick="CirclebookApp.editPost('${p.id}')">
                                                    ${CirclebookIcons.get('edit', '', 16)} Edit Post
                                                </button>
                                                <button class="cb-dropdown-item" onclick="CirclebookApp.copyLink('${window.location.origin}/#home')">
                                                    ${CirclebookIcons.get('link', '', 16)} Copy Link
                                                </button>
                                                <button class="cb-dropdown-item" onclick="CirclebookApp.mutePostNotifications('${p.id}')">
                                                    ${CirclebookIcons.get('bell-off', '', 16)} Turn Off Notifications
                                                </button>
                                                <div class="cb-dropdown-divider"></div>
                                                <button class="cb-dropdown-item danger" onclick="CirclebookApp.confirmDeletePost('${p.id}')">
                                                    ${CirclebookIcons.get('trash', '', 16)} Delete Post
                                                </button>
                                            ` : `
                                                <button class="cb-dropdown-item" onclick="CirclebookStore.toggleBookmarkPost('${p.id}'); CirclebookApp.toast('Post saved'); CirclebookRouter.render();">
                                                    ${CirclebookIcons.get(p.isBookmarked ? 'bookmark-filled' : 'bookmark', '', 16)} ${p.isBookmarked ? 'Unsave Post' : 'Save Post'}
                                                </button>
                                                <button class="cb-dropdown-item" onclick="CirclebookApp.copyLink('${window.location.origin}/#home')">
                                                    ${CirclebookIcons.get('link', '', 16)} Copy Link
                                                </button>
                                                <button class="cb-dropdown-item" onclick="CirclebookApp.mutePostNotifications('${p.id}')">
                                                    ${CirclebookIcons.get('bell-off', '', 16)} Mute Post Notifications
                                                </button>
                                                <div class="cb-dropdown-divider"></div>
                                                <button class="cb-dropdown-item" onclick="CirclebookApp.hidePost('${p.id}')">
                                                    ${CirclebookIcons.get('eye-off', '', 16)} Hide Post
                                                </button>
                                                <button class="cb-dropdown-item danger" onclick="CirclebookApp.reportPost('${p.id}')">
                                                    ${CirclebookIcons.get('flag', '', 16)} Report Post
                                                </button>
                                            `}
                                        </div>
                                    </div>
                                </div>

                                <div class="post-content" style="font-size: 0.95rem; line-height: 1.55; color: var(--text-primary); margin-bottom: 0.85rem;">
                                    ${p.content}
                                </div>
                                
                                ${p.image ? `<img src="${p.image}" class="post-media" style="width: 100%; border-radius: var(--radius-sm); margin-bottom: 0.85rem; max-height: 380px; object-fit: cover;" alt="Post Media" />` : ''}
                                
                                <div style="margin-bottom: 0.85rem; display: flex; gap: 0.35rem; flex-wrap: wrap;">
                                    ${p.tags.map(t => `<span class="tag-badge" style="font-size: 0.75rem;">${t}</span>`).join('')}
                                </div>

                                <!-- PRIMARY ESSENTIAL POST ACTIONS -->
                                <div class="post-actions" style="display: flex; gap: 0.5rem; border-top: 1px solid var(--border); padding-top: 0.65rem;">
                                    <button class="btn-secondary ${p.isLiked ? 'active' : ''}" style="font-size: 0.82rem; padding: 0.35rem 0.8rem; display: flex; align-items: center; gap: 0.4rem;" onclick="CirclebookStore.toggleLikePost('${p.id}'); CirclebookRouter.render();">
                                        ${CirclebookIcons.get(p.isLiked ? 'heart-filled' : 'heart', '', 16)} ${p.likes}
                                    </button>
                                    <button class="btn-secondary" style="font-size: 0.82rem; padding: 0.35rem 0.8rem; display: flex; align-items: center; gap: 0.4rem;" onclick="const txt = prompt('Add comment:'); if(txt){ CirclebookStore.addComment('${p.id}', txt); CirclebookRouter.render(); }">
                                        ${CirclebookIcons.get('comment', '', 16)} ${p.comments.length}
                                    </button>
                                    <button class="btn-secondary" style="font-size: 0.82rem; padding: 0.35rem 0.8rem; display: flex; align-items: center; gap: 0.4rem;" onclick="CirclebookApp.copyLink('${window.location.origin}/#home')">
                                        ${CirclebookIcons.get('share', '', 16)} Share
                                    </button>
                                </div>

                                ${p.comments.length ? `
                                    <div style="margin-top: 0.85rem; padding-top: 0.75rem; border-top: 1px dashed var(--border); font-size: 0.85rem;">
                                        ${p.comments.map(c => `
                                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
                                                <div>
                                                    <strong style="color: var(--text-primary);">${c.author}:</strong>
                                                    <span style="color: var(--text-secondary); margin-left: 0.35rem;">${c.text}</span>
                                                </div>
                                            </div>
                                        `).join('')}
                                    </div>
                                ` : ''}
                            </div>
                        `;
                    }).join('') : `
                        <div class="empty-state-box" style="text-align: center; padding: 3rem 1rem;">
                            <div class="empty-state-icon" style="margin-bottom: 0.75rem; color: var(--text-muted);">${CirclebookIcons.get('home', '', 40)}</div>
                            <div class="empty-state-title" style="font-weight: 700; font-size: 1.1rem; margin-bottom: 0.25rem;">No posts yet</div>
                            <div class="empty-state-desc" style="color: var(--text-secondary); font-size: 0.88rem; margin-bottom: 1.25rem;">Share an update or connect with people to populate your feed.</div>
                            <button class="btn-primary" onclick="CirclebookApp.openCreatePostModal()">Create Post</button>
                        </div>
                    `}
                </div>

                <!-- Right Sidebar Widgets -->
                <div class="right-sidebar-panel">
                    <div class="circle-card">
                        <div class="circle-card-title" style="font-weight: 700; font-size: 0.95rem; margin-bottom: 0.85rem;">Trending Topics</div>
                        <div>
                            <div style="margin-bottom: 0.75rem;">
                                <strong style="font-size: 0.88rem; color: var(--text-primary);">#Circlebook</strong>
                                <div style="font-size: 0.78rem; color: var(--text-secondary);">1.2k posts</div>
                            </div>
                            <div style="margin-bottom: 0.75rem;">
                                <strong style="font-size: 0.88rem; color: var(--text-primary);">#DesignSystems</strong>
                                <div style="font-size: 0.78rem; color: var(--text-secondary);">840 posts</div>
                            </div>
                            <div style="margin-bottom: 0.75rem;">
                                <strong style="font-size: 0.88rem; color: var(--text-primary);">#Engineering</strong>
                                <div style="font-size: 0.78rem; color: var(--text-secondary);">620 posts</div>
                            </div>
                        </div>
                    </div>

                    <div class="circle-card">
                        <div class="circle-card-title" style="font-weight: 700; font-size: 0.95rem; margin-bottom: 0.85rem;">Notice Board</div>
                        <div style="font-size: 0.85rem; color: var(--text-secondary); line-height: 1.5;">
                            • Tech Summit registration is open.<br>
                            • 3 new communities joined in your domain.
                        </div>
                    </div>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 4. DISCOVER MODULE
    // ---------------------------------------------------------
    discover(subTab = "people") {
        const users = CirclebookStore.users;
        return `
            <div class="circle-card">
                <div class="circle-card-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <div class="circle-card-title" style="font-weight: 700; font-size: 1.1rem;">Discover Directory & People</div>
                    <button class="btn-secondary" style="font-size: 0.8rem; display: flex; align-items: center; gap: 0.35rem;" onclick="CirclebookRouter.navigate('ai', 'people_finder')">
                        ${CirclebookIcons.get('sparkles', '', 14)} Semantic Search
                    </button>
                </div>
                
                <div class="global-search-bar" style="width: 100%; margin-bottom: 1.5rem; display: flex; align-items: center; border: 1px solid var(--border); border-radius: var(--radius-sm); padding: 0.5rem 0.85rem; background: var(--surface);">
                    <span style="color: var(--text-muted); margin-right: 0.5rem; display: flex;">${CirclebookIcons.get('search', '', 16)}</span>
                    <input type="text" placeholder="Search people by name, skill (e.g., React, Python), location, or university..." style="border: none; outline: none; width: 100%; font-size: 0.9rem;" oninput="CirclebookApp.filterDiscoverPeople(this.value)">
                </div>

                <div class="grid-3" id="discoverGrid">
                    ${users.map(u => `
                        <div class="circle-card" style="text-align: center; margin-bottom: 0; position: relative;">
                            <img src="${u.avatar}" style="width: 72px; height: 72px; border-radius: 50%; object-fit: cover; margin-bottom: 0.6rem; border: 2px solid var(--border);" alt="${u.name}" />
                            <h3 style="font-size: 1rem; font-weight: 700; margin-bottom: 0.2rem;">${u.name}</h3>
                            <p style="font-size: 0.82rem; color: var(--text-secondary); margin-bottom: 0.4rem; min-height: 2.4em; line-height: 1.4;">${u.headline}</p>
                            <p style="font-size: 0.78rem; color: var(--text-muted); margin-bottom: 0.75rem;">${u.location} • ${u.college}</p>
                            
                            <div style="margin-bottom: 0.85rem; min-height: 28px; display: flex; gap: 0.3rem; justify-content: center; flex-wrap: wrap;">
                                ${u.skills.slice(0, 3).map(s => `<span class="tag-badge" style="font-size: 0.72rem;">${s}</span>`).join('')}
                            </div>
                            
                            <div style="display: flex; gap: 0.4rem; justify-content: center; align-items: center;">
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
                    `).join('')}
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 5. MY CIRCLE MODULE
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
                <div class="circle-card-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <div class="circle-card-title" style="font-weight: 700; font-size: 1.1rem;">My Circle Connections (${CirclebookStore.currentUser.circleCount})</div>
                    <button class="btn-primary" style="font-size: 0.85rem;" onclick="const cName = prompt('Enter Group Name:'); if(cName) CirclebookApp.toast('Group created: ' + cName);">Create Group</button>
                </div>
                
                ${users.length ? `
                    <div class="grid-2">
                        ${users.map(u => `
                            <div style="display: flex; gap: 1rem; align-items: center; padding: 0.85rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--surface);">
                                <img src="${u.avatar}" style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover;" alt="${u.name}" />
                                <div style="flex: 1;">
                                    <div style="font-weight: 700; font-size: 0.92rem;">${u.name} <span class="tag-badge" style="font-size: 0.72rem; font-weight: 500;">${u.circleType || 'Circle'}</span></div>
                                    <div style="font-size: 0.82rem; color: var(--text-secondary);">${u.headline}</div>
                                </div>
                                <div style="display: flex; gap: 0.4rem; align-items: center;">
                                    ${u.connectionStatus === 'pending_received' ? `
                                        <button class="btn-primary" style="font-size: 0.78rem; padding: 0.3rem 0.65rem;" onclick="CirclebookStore.acceptConnectionRequest('${u.id}'); CirclebookApp.toast('Accepted request from ${u.name}'); CirclebookRouter.render();">Accept</button>
                                        <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.3rem 0.65rem;" onclick="CirclebookStore.declineConnectionRequest('${u.id}'); CirclebookApp.toast('Declined request'); CirclebookRouter.render();">Decline</button>
                                    ` : u.connectionStatus === 'pending_sent' ? `
                                        <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.3rem 0.65rem;" onclick="CirclebookStore.cancelCircleRequest('${u.id}'); CirclebookApp.toast('Cancelled request'); CirclebookRouter.render();">Cancel</button>
                                    ` : `
                                        <button class="btn-secondary" style="font-size: 0.78rem; padding: 0.3rem 0.65rem;" onclick="CirclebookRouter.navigate('communication', 'chat')">Message</button>
                                    `}
                                </div>
                            </div>
                        `).join('')}
                    </div>
                ` : `
                    <div class="empty-state-box" style="text-align: center; padding: 3rem 1rem;">
                        <div class="empty-state-icon" style="margin-bottom: 0.75rem; color: var(--text-muted);">${CirclebookIcons.get('users', '', 40)}</div>
                        <div class="empty-state-title" style="font-weight: 700; font-size: 1.1rem; margin-bottom: 0.25rem;">No connections found</div>
                        <div class="empty-state-desc" style="color: var(--text-secondary); font-size: 0.88rem; margin-bottom: 1.25rem;">There are no members in this group view yet.</div>
                        <button class="btn-primary" onclick="CirclebookRouter.navigate('discover', 'people')">Search Directory</button>
                    </div>
                `}
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 6. PROFILE MODULE
    // ---------------------------------------------------------
    profile(subTab = "overview") {
        const u = CirclebookStore.currentUser;
        return `
            <div class="circle-card" style="padding: 0; overflow: hidden; margin-bottom: 1.25rem;">
                <img src="${u.banner}" style="width: 100%; height: 180px; object-fit: cover;" alt="Banner" />
                <div style="padding: 1.5rem; position: relative;">
                    <img src="${u.avatar}" style="width: 88px; height: 88px; border-radius: 50%; border: 4px solid var(--surface); position: absolute; top: -44px; left: 1.5rem; object-fit: cover;" alt="${u.name}" />
                    
                    <div style="margin-left: 106px; display: flex; justify-content: space-between; align-items: flex-start;">
                        <div>
                            <h2 style="font-size: 1.4rem; font-weight: 800; color: var(--text-primary); margin-bottom: 0.2rem;">${u.name}</h2>
                            <p style="color: var(--text-secondary); font-size: 0.92rem;">${u.headline}</p>
                            <p style="color: var(--text-muted); font-size: 0.82rem; margin-top: 0.25rem;">${u.location} • ${u.college}</p>
                        </div>
                        
                        <div style="display: flex; gap: 0.5rem; align-items: center; position: relative;">
                            <button class="btn-secondary" style="font-size: 0.85rem; display: flex; align-items: center; gap: 0.4rem;" onclick="CirclebookApp.openEditProfileModal()">
                                ${CirclebookIcons.get('edit', '', 15)} Edit Profile
                            </button>
                            <button class="post-more-btn" aria-label="Profile options" onclick="CirclebookApp.toggleUserMenu(event, '${u.id}')">
                                ${CirclebookIcons.get('more-vertical', '', 18)}
                            </button>
                            
                            <div class="cb-dropdown-menu" id="userMenu_${u.id}" style="display: none;">
                                <button class="cb-dropdown-item" onclick="CirclebookApp.shareProfile('${u.id}')">
                                    ${CirclebookIcons.get('share', '', 16)} Share Profile
                                </button>
                                <button class="cb-dropdown-item" onclick="CirclebookApp.copyLink('${window.location.origin}/#profile')">
                                    ${CirclebookIcons.get('link', '', 16)} Copy Profile Link
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="circle-card">
                <div class="circle-card-title" style="font-weight: 700; font-size: 1rem; margin-bottom: 0.75rem;">About</div>
                <p style="line-height: 1.6; color: var(--text-primary); font-size: 0.92rem;">${u.about}</p>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 7. COMMUNICATION MODULE
    // ---------------------------------------------------------
    communication(subTab = "chat") {
        const chats = CirclebookStore.chats;
        const activeChat = chats[0];
        return `
            <div class="chat-container circle-card" style="padding: 0; overflow: hidden; display: flex; height: 560px;">
                <div class="chat-sidebar" style="width: 280px; border-right: 1px solid var(--border); background: var(--background);">
                    <div style="padding: 1rem; border-bottom: 1px solid var(--border); font-weight: 700; font-size: 0.95rem;">Messages</div>
                    ${chats.map(c => `
                        <div class="chat-thread-item ${c.id === activeChat.id ? 'active' : ''}" style="padding: 0.85rem; border-bottom: 1px solid var(--border); cursor: pointer; ${c.id === activeChat.id ? 'background: var(--surface); border-left: 3px solid var(--primary-blue);' : ''}">
                            <div style="font-weight: 600; font-size: 0.88rem;">${c.participant ? c.participant.name : c.name}</div>
                            <div style="font-size: 0.78rem; color: var(--text-secondary); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; margin-top: 0.15rem;">${c.lastMessage}</div>
                        </div>
                    `).join('')}
                </div>
                
                <div class="chat-main" style="flex: 1; display: flex; flex-direction: column;">
                    <div class="chat-header" style="padding: 1rem; border-bottom: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; background: var(--surface);">
                        <div style="font-weight: 700; font-size: 0.95rem;">${activeChat.participant ? activeChat.participant.name : activeChat.name}</div>
                        <span style="font-size: 0.78rem; color: var(--success);">Online</span>
                    </div>
                    
                    <div class="chat-messages-body" id="chatMessagesBody" style="flex: 1; padding: 1rem; overflow-y: auto; display: flex; flex-direction: column; gap: 0.75rem;">
                        ${activeChat.messages.map(m => `
                            <div class="chat-bubble ${m.sender === CirclebookStore.currentUser.id ? 'sent' : 'received'}" style="max-width: 70%; padding: 0.65rem 0.9rem; border-radius: var(--radius-md); font-size: 0.88rem; ${m.sender === CirclebookStore.currentUser.id ? 'align-self: flex-end; background: var(--primary-blue); color: #fff;' : 'align-self: flex-start; background: var(--background); border: 1px solid var(--border); color: var(--text-primary);'}">
                                <div>${m.text}</div>
                                <div style="font-size: 0.68rem; opacity: 0.75; text-align: right; margin-top: 0.25rem;">${m.timestamp}</div>
                            </div>
                        `).join('')}
                    </div>
                    
                    <div class="chat-input-area" style="padding: 0.85rem; border-top: 1px solid var(--border); display: flex; gap: 0.5rem; background: var(--surface);">
                        <input type="text" id="chatInput" class="form-control" placeholder="Write a message..." style="flex: 1;" onkeypress="if(event.key==='Enter') CirclebookApp.handleSendChatMessage('${activeChat.id}')">
                        <button class="btn-primary" style="padding: 0.4rem 1rem; display: flex; align-items: center; gap: 0.35rem;" onclick="CirclebookApp.handleSendChatMessage('${activeChat.id}')">
                            ${CirclebookIcons.get('send', '', 15)} Send
                        </button>
                    </div>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 8. NOTIFICATIONS MODULE
    // ---------------------------------------------------------
    notifications(subTab = "all") {
        const notifs = CirclebookStore.notifications;
        return `
            <div class="circle-card">
                <div class="circle-card-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <div class="circle-card-title" style="font-weight: 700; font-size: 1.1rem;">Notifications</div>
                    <button class="btn-secondary" style="font-size: 0.8rem;" onclick="CirclebookApp.toast('All notifications marked as read');">Mark all read</button>
                </div>
                
                ${notifs.length ? notifs.map(n => `
                    <div style="display: flex; gap: 0.85rem; align-items: center; padding: 0.85rem 0; border-bottom: 1px solid var(--border);">
                        <div style="width: 36px; height: 36px; border-radius: 50%; background: var(--background); display: flex; align-items: center; justify-content: center; color: var(--primary-blue);">
                            ${n.avatar.startsWith('http') ? `<img src="${n.avatar}" style="width: 36px; height: 36px; border-radius: 50%; object-fit: cover;" />` : CirclebookIcons.get(n.avatar === 'briefcase' ? 'briefcase' : n.avatar === 'globe' ? 'globe' : 'bell', '', 18)}
                        </div>
                        <div style="flex: 1;">
                            <div style="font-size: 0.88rem; color: var(--text-primary); font-weight: 500;">${n.title}</div>
                            <div style="font-size: 0.78rem; color: var(--text-secondary);">${n.timestamp}</div>
                        </div>
                        ${n.actionable ? `<button class="btn-primary" style="font-size: 0.78rem; padding: 0.3rem 0.65rem;" onclick="CirclebookStore.acceptConnectionRequest('${n.requestId}'); CirclebookRouter.render();">Accept</button>` : ''}
                    </div>
                `).join('') : `
                    <div class="empty-state-box" style="text-align: center; padding: 3rem 1rem;">
                        <div class="empty-state-icon" style="margin-bottom: 0.75rem; color: var(--text-muted);">${CirclebookIcons.get('bell-off', '', 40)}</div>
                        <div class="empty-state-title" style="font-weight: 700; font-size: 1.1rem; margin-bottom: 0.25rem;">No notifications yet</div>
                        <div class="empty-state-desc" style="color: var(--text-secondary); font-size: 0.88rem;">New notifications will appear here.</div>
                    </div>
                `}
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 9. COMMUNITIES MODULE
    // ---------------------------------------------------------
    communities(subTab = "discover") {
        const comms = CirclebookStore.communities;
        return `
            <div class="circle-card">
                <div class="circle-card-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <div class="circle-card-title" style="font-weight: 700; font-size: 1.1rem;">Communities & Discussion Hubs</div>
                    <button class="btn-primary" style="font-size: 0.85rem;" onclick="const name = prompt('Community Name:'); if(name) CirclebookApp.toast('Community request submitted');">Create Community</button>
                </div>
                
                <div class="grid-3">
                    ${comms.map(c => `
                        <div class="circle-card" style="margin-bottom: 0; padding: 0; overflow: hidden;">
                            <img src="${c.banner}" style="width: 100%; height: 110px; object-fit: cover;" alt="${c.name}" />
                            <div style="padding: 1rem;">
                                <h3 style="font-size: 1rem; font-weight: 700; margin-bottom: 0.3rem;">${c.name}</h3>
                                <p style="font-size: 0.82rem; color: var(--text-secondary); line-height: 1.4; margin-bottom: 0.85rem; min-height: 2.8em;">${c.description}</p>
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <span style="font-size: 0.78rem; color: var(--text-muted); display: flex; align-items: center; gap: 0.3rem;">
                                        ${CirclebookIcons.get('users', '', 14)} ${c.membersCount} members
                                    </span>
                                    <button class="${c.isJoined ? 'btn-secondary' : 'btn-primary'}" style="font-size: 0.78rem; padding: 0.3rem 0.75rem;" onclick="CirclebookStore.toggleCommunityJoin('${c.id}'); CirclebookRouter.render();">
                                        ${c.isJoined ? 'Joined' : 'Join'}
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
    // 10. EVENTS MODULE
    // ---------------------------------------------------------
    events(subTab = "discover") {
        const evts = CirclebookStore.events;
        return `
            <div class="circle-card">
                <div class="circle-card-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <div class="circle-card-title" style="font-weight: 700; font-size: 1.1rem;">Events & Industry Summits</div>
                    <button class="btn-primary" style="font-size: 0.85rem;" onclick="CirclebookApp.toast('Event creation modal opened');">Host Event</button>
                </div>
                
                <div class="grid-2">
                    ${evts.map(e => `
                        <div class="circle-card" style="margin-bottom: 0; padding: 0; overflow: hidden;">
                            <img src="${e.banner}" style="width: 100%; height: 130px; object-fit: cover;" alt="${e.title}" />
                            <div style="padding: 1.15rem;">
                                <span class="tag-badge" style="font-weight: 600; font-size: 0.72rem;">${e.type}</span>
                                <h3 style="font-size: 1.05rem; font-weight: 700; margin: 0.4rem 0 0.3rem;">${e.title}</h3>
                                <p style="font-size: 0.82rem; color: var(--text-secondary); margin-bottom: 0.85rem; display: flex; align-items: center; gap: 0.35rem;">
                                    ${CirclebookIcons.get('calendar', '', 14)} ${e.date} • ${e.time}
                                </p>
                                <div style="display: flex; justify-content: space-between; align-items: center;">
                                    <span style="font-size: 0.78rem; color: var(--text-muted);">${e.attendingCount} attending</span>
                                    <button class="${e.isRSVPed ? 'btn-secondary' : 'btn-primary'}" style="font-size: 0.78rem; padding: 0.35rem 0.8rem;" onclick="CirclebookStore.toggleEventRSVP('${e.id}'); CirclebookRouter.render();">
                                        ${e.isRSVPed ? 'RSVPed' : 'RSVP Now'}
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
    // 11. CAREER HUB MODULE
    // ---------------------------------------------------------
    career(subTab = "dashboard") {
        const jobs = CirclebookStore.jobs;
        return `
            <div class="circle-card">
                <div class="circle-card-header" style="margin-bottom: 1.25rem;">
                    <div class="circle-card-title" style="font-weight: 700; font-size: 1.1rem;">Career Opportunities</div>
                </div>
                
                <div class="grid-3" style="margin-bottom: 1.5rem;">
                    <div class="metric-card" style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--surface);">
                        <div class="metric-label" style="font-size: 0.78rem; color: var(--text-secondary);">Profile Strength</div>
                        <div class="metric-value" style="font-size: 1.5rem; font-weight: 800; color: var(--success); margin: 0.2rem 0;">94%</div>
                        <div style="font-size: 0.78rem; color: var(--text-muted);">Recruiter outreach active</div>
                    </div>
                    <div class="metric-card" style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--surface);">
                        <div class="metric-label" style="font-size: 0.78rem; color: var(--text-secondary);">Active Applications</div>
                        <div class="metric-value" style="font-size: 1.5rem; font-weight: 800; color: var(--text-primary); margin: 0.2rem 0;">1</div>
                        <div style="font-size: 0.78rem; color: var(--text-muted);">Application under review</div>
                    </div>
                    <div class="metric-card" style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--surface);">
                        <div class="metric-label" style="font-size: 0.78rem; color: var(--text-secondary);">Job Matches</div>
                        <div class="metric-value" style="font-size: 1.5rem; font-weight: 800; color: var(--primary-blue); margin: 0.2rem 0;">12</div>
                        <div style="font-size: 0.78rem; color: var(--text-muted);">Based on skills profile</div>
                    </div>
                </div>

                <div class="grid-2">
                    ${jobs.map(j => `
                        <div class="circle-card" style="margin-bottom: 0;">
                            <div style="display: flex; gap: 0.75rem; align-items: flex-start; margin-bottom: 0.5rem;">
                                <div style="width: 36px; height: 36px; border-radius: var(--radius-sm); background: var(--background); display: flex; align-items: center; justify-content: center; color: var(--primary-blue);">
                                    ${CirclebookIcons.get(j.logo || 'briefcase', '', 20)}
                                </div>
                                <div style="flex: 1;">
                                    <h3 style="font-size: 1rem; font-weight: 700;">${j.title}</h3>
                                    <div style="font-size: 0.82rem; color: var(--text-secondary);">${j.company} • ${j.location}</div>
                                </div>
                            </div>
                            <p style="font-size: 0.85rem; color: var(--text-primary); line-height: 1.5; margin-bottom: 0.75rem;">${j.description}</p>
                            <div style="margin-bottom: 0.85rem; display: flex; gap: 0.3rem; flex-wrap: wrap;">
                                ${j.skills.map(s => `<span class="tag-badge" style="font-size: 0.72rem;">${s}</span>`).join('')}
                            </div>
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <strong style="font-size: 0.88rem; color: var(--primary-blue);">${j.salary}</strong>
                                <button class="${j.isApplied ? 'btn-secondary' : 'btn-primary'}" style="font-size: 0.78rem; padding: 0.35rem 0.85rem;" onclick="CirclebookStore.applyForJob('${j.id}'); CirclebookRouter.render();">
                                    ${j.isApplied ? 'Applied' : 'Easy Apply'}
                                </button>
                            </div>
                        </div>
                    `).join('')}
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 12. CIRCLE AI MODULE
    // ---------------------------------------------------------
    ai(subTab = "home") {
        return `
            <div class="circle-card">
                <div class="circle-card-header" style="margin-bottom: 1rem;">
                    <div class="circle-card-title" style="font-weight: 700; font-size: 1.1rem; display: flex; align-items: center; gap: 0.5rem;">
                        ${CirclebookIcons.get('sparkles', '', 20)} Circle AI Search & Tools
                    </div>
                </div>
                <p style="color: var(--text-secondary); font-size: 0.9rem; margin-bottom: 1.5rem; line-height: 1.5;">
                    Use semantic queries to search for members by specific experience, draft updates, or summarize community discussions.
                </p>

                <div class="grid-2" style="margin-bottom: 1.5rem;">
                    <div style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm); cursor: pointer; background: var(--surface);" onclick="CirclebookApp.triggerAIPrompt('Find senior UI designers in Mumbai with 3+ years experience')">
                        <strong style="font-size: 0.9rem; display: flex; align-items: center; gap: 0.4rem;">${CirclebookIcons.get('search', '', 16)} Semantic Member Search</strong>
                        <p style="font-size: 0.82rem; color: var(--text-secondary); margin-top: 0.25rem;">"Find senior UI designers in Mumbai with 3+ years experience"</p>
                    </div>
                    <div style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm); cursor: pointer; background: var(--surface);" onclick="CirclebookApp.triggerAIPrompt('Draft an engaging post about modern CSS grid layouts')">
                        <strong style="font-size: 0.9rem; display: flex; align-items: center; gap: 0.4rem;">${CirclebookIcons.get('edit', '', 16)} Post Draft Assistant</strong>
                        <p style="font-size: 0.82rem; color: var(--text-secondary); margin-top: 0.25rem;">"Draft an engaging post about modern CSS grid layouts"</p>
                    </div>
                </div>

                <div style="background: var(--background); border: 1px solid var(--border); border-radius: var(--radius-sm); padding: 1.25rem;">
                    <div style="font-weight: 600; font-size: 0.9rem; margin-bottom: 0.5rem; color: var(--text-primary);">
                        Query Output
                    </div>
                    <div id="aiPromptResult" style="font-size: 0.88rem; line-height: 1.6; color: var(--text-secondary);">
                        Click a quick query above or type a search prompt below.
                    </div>
                    <div style="display: flex; gap: 0.5rem; margin-top: 1rem;">
                        <input type="text" id="customAIPrompt" class="form-control" placeholder="Ask Circle AI anything about your network or career..." style="flex: 1;" />
                        <button class="btn-primary" style="padding: 0.4rem 1rem;" onclick="CirclebookApp.triggerAIPrompt(document.getElementById('customAIPrompt').value)">Search</button>
                    </div>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 13. SETTINGS MODULE
    // ---------------------------------------------------------
    settings(subTab = "appearance") {
        const u = CirclebookStore.currentUser;
        const theme = u.appearance.theme;
        return `
            <div class="circle-card">
                <div class="circle-card-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <div class="circle-card-title" style="font-weight: 700; font-size: 1.1rem;">Settings & Preferences</div>
                    <button class="btn-primary" style="font-size: 0.85rem;" onclick="CirclebookApp.openEditProfileModal()">Edit Profile</button>
                </div>
                
                <div class="form-group">
                    <label>Application Theme</label>
                    <div class="grid-4" style="margin-top: 0.5rem;">
                        <button class="btn-secondary" style="${theme === 'glass-light' ? 'border-color: var(--primary-blue); font-weight: 700; background: rgba(37, 99, 235, 0.08);' : ''}" onclick="CirclebookStore.applyTheme('glass-light'); CirclebookRouter.render();">Glass Light</button>
                        <button class="btn-secondary" style="${theme === 'glass-dark' ? 'border-color: var(--primary-blue); font-weight: 700; background: rgba(37, 99, 235, 0.08);' : ''}" onclick="CirclebookStore.applyTheme('glass-dark'); CirclebookRouter.render();">Glass Dark</button>
                        <button class="btn-secondary" style="${theme === 'modern-blue' ? 'border-color: var(--primary-blue); font-weight: 700; background: rgba(37, 99, 235, 0.08);' : ''}" onclick="CirclebookStore.applyTheme('modern-blue'); CirclebookRouter.render();">Modern Blue</button>
                        <button class="btn-secondary" style="${theme === 'purple-luxe' ? 'border-color: var(--premium-purple); font-weight: 700; background: rgba(124, 58, 237, 0.1);' : ''}" onclick="CirclebookStore.applyTheme('purple-luxe'); CirclebookRouter.render();">Purple Luxe</button>
                    </div>
                </div>

                <div style="margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid var(--border);">
                    <h3 style="font-size: 1rem; font-weight: 700; margin-bottom: 1rem;">Privacy & Visibility</h3>
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
                        <strong style="color: var(--text-primary); font-size: 0.92rem;">Signed in as ${u.name}</strong> (${u.email})
                        <div style="font-size: 0.8rem; color: var(--text-secondary);">Session active on this browser</div>
                    </div>
                    <button class="btn-danger" style="font-size: 0.85rem;" onclick="CirclebookApp.confirmLogout()">Log out</button>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 14. SAFETY MODULE
    // ---------------------------------------------------------
    safety(subTab = "center") {
        return `
            <div class="circle-card">
                <div class="circle-card-header" style="margin-bottom: 1rem;">
                    <div class="circle-card-title" style="font-weight: 700; font-size: 1.1rem; display: flex; align-items: center; gap: 0.5rem;">
                        ${CirclebookIcons.get('shield', '', 20)} Safety Center & Community Standards
                    </div>
                </div>
                <p style="color: var(--text-secondary); font-size: 0.9rem; margin-bottom: 1.5rem; line-height: 1.5;">
                    The Circlebook enforces respectful community behavior, data privacy, and prompt moderation of reported content.
                </p>
                <div class="grid-2">
                    <div style="padding: 1.25rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--surface);">
                        <h4 style="font-size: 0.95rem; font-weight: 700; margin-bottom: 0.4rem; display: flex; align-items: center; gap: 0.4rem;">
                            ${CirclebookIcons.get('flag', '', 16)} Report Content
                        </h4>
                        <p style="font-size: 0.82rem; color: var(--text-secondary); margin-bottom: 0.85rem;">Submit a confidential report to our moderation team.</p>
                        <button class="btn-secondary" style="font-size: 0.8rem;" onclick="const reason = prompt('Reason for report:'); if(reason) CirclebookApp.toast('Report submitted');">Submit Report</button>
                    </div>
                    <div style="padding: 1.25rem; border: 1px solid var(--border); border-radius: var(--radius-sm); background: var(--surface);">
                        <h4 style="font-size: 0.95rem; font-weight: 700; margin-bottom: 0.4rem; display: flex; align-items: center; gap: 0.4rem;">
                            ${CirclebookIcons.get('lock', '', 16)} Account Security
                        </h4>
                        <p style="font-size: 0.82rem; color: var(--text-secondary); margin-bottom: 0.85rem;">Status: <strong style="color: var(--success);">Secure</strong></p>
                        <button class="btn-secondary" style="font-size: 0.8rem;" onclick="CirclebookApp.toast('Security check completed');">Run Security Scan</button>
                    </div>
                </div>
            </div>
        `;
    },

    // ---------------------------------------------------------
    // 15. ADMIN MODULE
    // ---------------------------------------------------------
    admin(subTab = "dashboard") {
        const metrics = CirclebookStore.adminData.systemMetrics;
        const reports = CirclebookStore.adminData.pendingReports;
        return `
            <div class="circle-card">
                <div class="circle-card-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.25rem;">
                    <div class="circle-card-title" style="font-weight: 700; font-size: 1.1rem; display: flex; align-items: center; gap: 0.5rem;">
                        ${CirclebookIcons.get('lock', '', 20)} Admin Moderation Suite
                    </div>
                    <span class="tag-badge" style="font-weight: 600;">System Admin</span>
                </div>

                <div class="grid-4" style="margin-bottom: 1.5rem;">
                    <div class="metric-card" style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm);">
                        <div class="metric-label" style="font-size: 0.78rem; color: var(--text-secondary);">Total Users</div>
                        <div class="metric-value" style="font-size: 1.4rem; font-weight: 800;">${metrics.totalUsers}</div>
                    </div>
                    <div class="metric-card" style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm);">
                        <div class="metric-label" style="font-size: 0.78rem; color: var(--text-secondary);">Active Today</div>
                        <div class="metric-value" style="font-size: 1.4rem; font-weight: 800; color: var(--primary-blue);">${metrics.activeToday}</div>
                    </div>
                    <div class="metric-card" style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm);">
                        <div class="metric-label" style="font-size: 0.78rem; color: var(--text-secondary);">Pending Reports</div>
                        <div class="metric-value" style="font-size: 1.4rem; font-weight: 800; color: var(--danger);">${reports.length}</div>
                    </div>
                    <div class="metric-card" style="padding: 1rem; border: 1px solid var(--border); border-radius: var(--radius-sm);">
                        <div class="metric-label" style="font-size: 0.78rem; color: var(--text-secondary);">Server Uptime</div>
                        <div class="metric-value" style="font-size: 1.4rem; font-weight: 800; color: var(--success);">${metrics.serverUptime}</div>
                    </div>
                </div>

                <h3 style="font-size: 0.95rem; font-weight: 700; margin-bottom: 0.75rem;">Pending Moderation Queue</h3>
                <table class="circle-table" style="width: 100%; border-collapse: collapse; font-size: 0.85rem;">
                    <thead>
                        <tr style="border-bottom: 1px solid var(--border); text-align: left;">
                            <th style="padding: 0.6rem;">Reporter</th>
                            <th style="padding: 0.6rem;">Target</th>
                            <th style="padding: 0.6rem;">Reason</th>
                            <th style="padding: 0.6rem;">Status</th>
                            <th style="padding: 0.6rem;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${reports.map(r => `
                            <tr style="border-bottom: 1px solid var(--border);">
                                <td style="padding: 0.6rem;">${r.reporter}</td>
                                <td style="padding: 0.6rem;">${r.target}</td>
                                <td style="padding: 0.6rem;">${r.reason}</td>
                                <td style="padding: 0.6rem;"><span class="tag-badge">${r.status}</span></td>
                                <td style="padding: 0.6rem;">
                                    <button class="btn-primary" style="font-size: 0.75rem; padding: 0.25rem 0.5rem;" onclick="CirclebookApp.toast('Report resolved');">Resolve</button>
                                </td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            </div>
        `;
    }
};
