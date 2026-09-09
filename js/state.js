/* =========================================================
   THE CIRCLEBOOK - CENTRAL STATE & STORE LAYER
   ========================================================= */

const CirclebookStore = {
    // Current Active User State
    currentUser: {
        id: "usr_001",
        name: "Aarav Sharma",
        handle: "@aarav_sharma",
        email: "aarav.sharma@circlebook.org",
        role: "user", // "user", "moderator", "admin"
        avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=250&q=80",
        banner: "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=1200&q=80",
        headline: "Senior Frontend Engineer & Open Source Advocate",
        location: "Bengaluru, India",
        college: "IIT Bombay • Computer Science ('21)",
        gender: "Male",
        birthday: "1998-11-14",
        about: "Passionate about web performance, vintage design systems, and building collaborative communities. Always eager to help fellow builders in the circle.",
        circleCount: 42,
        innerCircleIds: ["usr_002", "usr_004"],
        customCircles: [
            { id: "circ_1", name: "Tech Mentors", memberIds: ["usr_002", "usr_003"] },
            { id: "circ_2", name: "Design Club", memberIds: ["usr_004", "usr_005"] }
        ],
        skills: ["JavaScript", "React", "CSS Architecture", "TypeScript", "System Design"],
        intents: ["Networking", "Open Source", "Mentorship"],
        interests: ["Retro Computing", "Vintage Typography", "UI/UX Design", "Coffee Brewing"],
        career: {
            currentTitle: "Lead UI Architect",
            company: "Apex Tech Labs",
            openToWork: true,
            desiredRole: "Principal Frontend Engineer",
            preferredLocation: "Remote / Hybrid",
            expectedSalary: "$120,000 - $140,000"
        },
        privacy: {
            profile: "Everyone",
            email: "My Circle",
            birthday: "Only Me"
        },
        appearance: {
            theme: "vintage-gold", // "vintage-gold", "vintage-dark", "modern-navy", "emerald-clean"
            compact: false,
            fontSize: "medium"
        },
        isOnboarded: true
    },

    // All Users Directory
    users: [
        {
            id: "usr_002",
            name: "Priya Nair",
            handle: "@priya_nair",
            email: "priya.nair@circlebook.org",
            role: "user",
            avatar: "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=250&q=80",
            headline: "Product Designer & Visual Strategist",
            location: "Mumbai, India",
            college: "NID Ahmedabad • Industrial Design ('20)",
            gender: "Female",
            birthday: "1997-04-22",
            about: "Designing thoughtful digital experiences with nostalgia and crisp typography.",
            circleCount: 88,
            skills: ["UI/UX Design", "Figma", "Design Systems", "User Research"],
            interests: ["Vintage Typography", "Print Media", "Photography"],
            intents: ["Collaborations", "Mentorship"],
            connectionStatus: "connected", // "connected", "pending_sent", "pending_received", "none"
            circleType: "Friends"
        },
        {
            id: "usr_003",
            name: "Rohan Varma",
            handle: "@rohan_v",
            email: "rohan.v@circlebook.org",
            role: "user",
            avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=250&q=80",
            headline: "AI Engineer & Machine Learning Specialist",
            location: "Hyderabad, India",
            college: "IIIT Hyderabad • Artificial Intelligence ('19)",
            gender: "Male",
            birthday: "1996-08-10",
            about: "Building next-generation generative AI assistants and recommendation algorithms.",
            circleCount: 120,
            skills: ["Python", "PyTorch", "LLMs", "NLP", "FastAPI"],
            interests: ["Artificial Intelligence", "Algorithmic Trading", "Chess"],
            intents: ["Co-founder Search", "Research"],
            connectionStatus: "connected",
            circleType: "Work"
        },
        {
            id: "usr_004",
            name: "Ananya Roy",
            handle: "@ananya_roy",
            email: "ananya.roy@circlebook.org",
            role: "admin",
            avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=250&q=80",
            headline: "Community Lead & Tech Organizer @ The Circlebook",
            location: "Bengaluru, India",
            college: "St. Xavier's Kolkata • Mass Comm ('18)",
            gender: "Female",
            birthday: "1996-01-15",
            about: "Managing community safety, global outreach, and circle events.",
            circleCount: 310,
            skills: ["Community Management", "Event Planning", "Public Relations"],
            interests: ["Networking", "Podcasting", "Literature"],
            intents: ["Networking", "Event Hosting"],
            connectionStatus: "connected",
            circleType: "Inner Circle"
        },
        {
            id: "usr_005",
            name: "Vikram Sengupta",
            handle: "@vikram_s",
            email: "vikram.s@circlebook.org",
            role: "user",
            avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=250&q=80",
            headline: "Full Stack Engineer & Cloud Architect",
            location: "Delhi NCR, India",
            college: "DTU • Software Engineering ('22)",
            gender: "Male",
            birthday: "2000-03-05",
            about: "Cloud infrastructure lover and Kubernetes builder. Always ready to debug code.",
            circleCount: 65,
            skills: ["Go", "Node.js", "AWS", "Docker", "Kubernetes"],
            interests: ["DevOps", "Cybersecurity", "Gaming"],
            intents: ["Job Search", "Mentorship"],
            connectionStatus: "pending_received",
            circleType: "College"
        },
        {
            id: "usr_006",
            name: "Kavya Iyer",
            handle: "@kavya_iyer",
            email: "kavya.iyer@circlebook.org",
            role: "user",
            avatar: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=250&q=80",
            headline: "Growth Marketer & Content Strategist",
            location: "Chennai, India",
            college: "Anna University • Management ('21)",
            gender: "Female",
            birthday: "1999-12-01",
            about: "Scaling organic community growth and crafting storytelling campaigns.",
            circleCount: 154,
            skills: ["SEO", "Content Marketing", "Social Media", "Analytics"],
            interests: ["Writing", "Blogging", "Branding"],
            intents: ["Networking"],
            connectionStatus: "none",
            circleType: "Suggestions"
        }
    ],

    // Posts Store
    posts: [
        {
            id: "post_101",
            authorId: "usr_004",
            authorName: "Ananya Roy",
            authorHandle: "@ananya_roy",
            authorAvatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=250&q=80",
            timestamp: "2 hours ago",
            category: "General",
            content: "✦ Welcome to the newly upgraded **Circlebook Master Platform**! We've brought together vintage community aesthetic with modern AI recommendations, career opportunities, and direct circle messaging. How are you liking the new Circle AI assistant?",
            likes: 42,
            comments: [
                { id: "c_1", author: "Aarav Sharma", avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=250&q=80", text: "The Smart People Search and AI Career Assistant look incredible! 🚀", timestamp: "1 hour ago" },
                { id: "c_2", author: "Priya Nair", avatar: "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=250&q=80", text: "The vintage cream theme is so soothing for reading directory entries.", timestamp: "30 mins ago" }
            ],
            shares: 12,
            isLiked: true,
            isBookmarked: false,
            tags: ["#Circlebook", "#Community", "#Update"]
        },
        {
            id: "post_102",
            authorId: "usr_002",
            authorName: "Priya Nair",
            authorHandle: "@priya_nair",
            authorAvatar: "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=250&q=80",
            timestamp: "5 hours ago",
            category: "Design",
            content: "Exploring vintage newspaper layouts from the 1950s to create clean, human-first digital interfaces. Minimal noise, rich typography, and meaningful connections.",
            image: "https://images.unsplash.com/photo-1507679799987-c73779587ccf?auto=format&fit=crop&w=800&q=80",
            likes: 29,
            comments: [],
            shares: 5,
            isLiked: false,
            isBookmarked: true,
            tags: ["#DesignSystems", "#Typography", "#VintageUI"]
        },
        {
            id: "post_103",
            authorId: "usr_003",
            authorName: "Rohan Varma",
            authorHandle: "@rohan_v",
            authorAvatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=250&q=80",
            timestamp: "1 day ago",
            category: "Artificial Intelligence",
            content: "Just published a benchmark comparing lightweight local embedding models for community directory searches. Semantic vector match yields 40% better connection suggestions than pure keyword match!",
            likes: 56,
            comments: [
                { id: "c_3", author: "Vikram Sengupta", avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=250&q=80", text: "Are you deploying this via WebAssembly or cloud API?", timestamp: "18 hours ago" }
            ],
            shares: 18,
            isLiked: false,
            isBookmarked: false,
            tags: ["#AI", "#MachineLearning", "#VectorSearch"]
        }
    ],

    // Communities Store
    communities: [
        {
            id: "comm_1",
            name: "Frontend Guild & UI Design",
            slug: "frontend-guild",
            banner: "https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=800&q=80",
            category: "Technology",
            description: "A hub for Web Developers, CSS Craftsmen, and UX Engineers to discuss design systems and web performance.",
            membersCount: 1420,
            isJoined: true,
            discussionsCount: 184,
            rules: [
                "Be respectful to all members.",
                "Share working code or Figma references when asking for feedback.",
                "No promotional spam."
            ],
            moderators: ["Aarav Sharma", "Priya Nair"],
            recentDiscussions: [
                { id: "disc_1", title: "Should we use CSS Container Queries or Subgrid for complex card layouts?", author: "Priya Nair", replies: 14, isAnswered: true },
                { id: "disc_2", title: "Best practices for micro-animations without causing layout shifts?", author: "Aarav Sharma", replies: 8, isAnswered: false }
            ]
        },
        {
            id: "comm_2",
            name: "Vintage Typography & Print Society",
            slug: "vintage-typography",
            banner: "https://images.unsplash.com/photo-1516962215378-7fa2e137ae93?auto=format&fit=crop&w=800&q=80",
            category: "Design & Arts",
            description: "Celebrating mid-century editorial design, woodblock printing, serif fonts, and classical typesetting.",
            membersCount: 890,
            isJoined: false,
            discussionsCount: 92,
            rules: ["High-res typography photos preferred.", "Attribute original font foundries."],
            moderators: ["Priya Nair"],
            recentDiscussions: [
                { id: "disc_3", title: "Archive showcase: 1940s community directory fonts", author: "Priya Nair", replies: 21, isAnswered: true }
            ]
        },
        {
            id: "comm_3",
            name: "AI & Machine Learning Innovators",
            slug: "ai-innovators",
            banner: "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=800&q=80",
            category: "Artificial Intelligence",
            description: "Building open source LLM tools, agentic assistants, and vector embeddings.",
            membersCount: 2310,
            isJoined: true,
            discussionsCount: 412,
            rules: ["Cite research papers when discussing benchmarks."],
            moderators: ["Rohan Varma"],
            recentDiscussions: [
                { id: "disc_4", title: "How to reduce hallucination in structured RAG pipelines?", author: "Rohan Varma", replies: 32, isAnswered: true }
            ]
        }
    ],

    // Events Store
    events: [
        {
            id: "evt_1",
            title: "Circlebook Tech Summit 2026: Building Human-Centric Social Software",
            date: "Sep 25, 2026",
            time: "10:00 AM - 4:00 PM IST",
            type: "Virtual Webinar",
            banner: "https://images.unsplash.com/photo-1540575467063-178a50c2df87?auto=format&fit=crop&w=800&q=80",
            host: "The Circlebook Team",
            description: "Join developers, designers, and AI researchers to explore how vintage simplicity meets next-generation social networking.",
            attendingCount: 340,
            isRSVPed: true,
            agenda: [
                "10:00 AM: Keynote - The Return of Directory Communities",
                "11:30 AM: Panel - Designing for Nostalgia and Speed",
                "02:00 PM: Hands-on Workshop - Building AI Circle Assistants"
            ]
        },
        {
            id: "evt_2",
            title: "Bengaluru Web Developers & Designers Meetup",
            date: "Oct 05, 2026",
            time: "05:30 PM IST",
            type: "In-Person",
            venue: "Indiranagar Tech Hub, Bengaluru",
            banner: "https://images.unsplash.com/photo-1511578314322-379afb476865?auto=format&fit=crop&w=800&q=80",
            host: "Aarav Sharma & Priya Nair",
            description: "Casual networking, code demos, lightning talks, and vintage print design show & tell.",
            attendingCount: 85,
            isRSVPed: false,
            agenda: ["05:30 PM: Welcome Coffee", "06:15 PM: Lightning Talks", "07:30 PM: Networking"]
        }
    ],

    // Career Jobs & Opportunities Store
    jobs: [
        {
            id: "job_101",
            title: "Senior Frontend Architect",
            company: "Pulse Systems",
            logo: "⚡",
            location: "Remote / Bengaluru",
            type: "Full-Time",
            salary: "$110,000 - $135,000 / year",
            skills: ["JavaScript", "React", "CSS", "Performance"],
            description: "Seeking a frontend specialist to architect high-speed web apps with clean CSS and custom component design systems.",
            posted: "3 days ago",
            applicantsCount: 42,
            isApplied: false
        },
        {
            id: "job_102",
            title: "AI Research Engineer (LLM & Agents)",
            company: "Cognitive Labs",
            logo: "🤖",
            location: "Hyderabad, India (Hybrid)",
            type: "Full-Time",
            salary: "$120,000 - $150,000 / year",
            skills: ["Python", "PyTorch", "LLMs", "FastAPI"],
            description: "Build autonomous agent workstreams and recommendation algorithms for global community networks.",
            posted: "1 day ago",
            applicantsCount: 68,
            isApplied: true
        },
        {
            id: "job_103",
            title: "Lead UI/UX Designer",
            company: "Vintage Studio",
            logo: "🎨",
            location: "Remote",
            type: "Contract / Project",
            salary: "$60 - $85 / hr",
            skills: ["Figma", "Design Systems", "Typography"],
            description: "Craft editorial digital magazines and vintage-style web designs for international client brands.",
            posted: "Just now",
            applicantsCount: 15,
            isApplied: false
        }
    ],

    // Direct Messages & Group Chat Store
    chats: [
        {
            id: "chat_1",
            type: "direct", // "direct", "group"
            participant: {
                id: "usr_002",
                name: "Priya Nair",
                avatar: "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=250&q=80",
                status: "online"
            },
            lastMessage: "I loved the vintage CSS tokens! Are we adding dark mode toggle today?",
            lastTimestamp: "10:42 AM",
            unreadCount: 1,
            messages: [
                { id: "m1", sender: "usr_002", text: "Hey Aarav! Have you checked out the new Circle AI post assistant?", timestamp: "10:38 AM" },
                { id: "m2", sender: "usr_001", text: "Yes Priya! It generates post drafts with tone customization. Super slick.", timestamp: "10:40 AM" },
                { id: "m3", sender: "usr_002", text: "I loved the vintage CSS tokens! Are we adding dark mode toggle today?", timestamp: "10:42 AM" }
            ]
        },
        {
            id: "chat_2",
            type: "direct",
            participant: {
                id: "usr_003",
                name: "Rohan Varma",
                avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=250&q=80",
                status: "offline"
            },
            lastMessage: "Let's review the semantic circle recommendation matching score tomorrow.",
            lastTimestamp: "Yesterday",
            unreadCount: 0,
            messages: [
                { id: "m4", sender: "usr_003", text: "Let's review the semantic circle recommendation matching score tomorrow.", timestamp: "Yesterday" }
            ]
        },
        {
            id: "chat_3",
            type: "group",
            name: "Frontend Guild Core Team",
            avatar: "🌐",
            membersCount: 4,
            lastMessage: "Ananya Roy added 2 new event announcements.",
            lastTimestamp: "09:15 AM",
            unreadCount: 2,
            messages: [
                { id: "m5", sender: "usr_004", text: "Ananya Roy added 2 new event announcements.", timestamp: "09:15 AM" }
            ]
        }
    ],

    // Notifications Store
    notifications: [
        {
            id: "notif_1",
            category: "social", // "social", "messages", "communities", "opportunities"
            avatar: "https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=250&q=80",
            title: "Priya Nair liked your post in Frontend Guild",
            timestamp: "15 mins ago",
            isRead: false,
            link: "#home-feed"
        },
        {
            id: "notif_2",
            category: "social",
            avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=250&q=80",
            title: "Vikram Sengupta sent you a Circle Connection Request",
            timestamp: "1 hour ago",
            isRead: false,
            actionable: true,
            requestId: "usr_005"
        },
        {
            id: "notif_3",
            category: "opportunities",
            avatar: "💼",
            title: "Job Recommendation: Senior Frontend Architect @ Pulse Systems",
            timestamp: "3 hours ago",
            isRead: true,
            link: "#career-jobs"
        },
        {
            id: "notif_4",
            category: "communities",
            avatar: "🌐",
            title: "New Discussion in Vintage Typography: 'Archive showcase 1940s fonts'",
            timestamp: "5 hours ago",
            isRead: true,
            link: "#community-details"
        }
    ],

    // Admin & System Moderation Store
    adminData: {
        systemMetrics: {
            totalUsers: 14850,
            activeToday: 3240,
            pendingReports: 3,
            serverUptime: "99.98%",
            avgResponseTime: "42ms",
            dbPoolStatus: "Healthy (12/50 connections)"
        },
        pendingReports: [
            {
                id: "rep_101",
                reporter: "Kavya Iyer",
                target: "Post #post_99 (Unrelated Spam)",
                reason: "Commercial Spam & Excessive Links",
                timestamp: "2 hours ago",
                status: "Pending"
            },
            {
                id: "rep_102",
                reporter: "Rohan Varma",
                target: "User @bot_account_99",
                reason: "Automated Bot Behavior",
                timestamp: "4 hours ago",
                status: "Pending"
            }
        ],
        auditLogs: [
            { id: "log_1", action: "User Elevated to Admin", target: "@ananya_roy", admin: "System Admin", time: "2026-09-08 14:20" },
            { id: "log_2", action: "Community Approved", target: "Vintage Typography & Print", admin: "Aarav Sharma", time: "2026-09-07 09:12" },
            { id: "log_3", action: "Security Policy Updated", target: "2FA Requirement Policy", admin: "System Admin", time: "2026-09-06 18:45" }
        ]
    },

    /* =========================================
       STORE METHODS
    ========================================= */
    init() {
        // Load persistent settings or state from localStorage if available
        const savedState = localStorage.getItem("circlebook_master_store");
        if (savedState) {
            try {
                const parsed = JSON.parse(savedState);
                if (parsed.currentUser) this.currentUser = { ...this.currentUser, ...parsed.currentUser };
                if (parsed.posts) this.posts = parsed.posts;
                if (parsed.users) this.users = parsed.users;
                if (parsed.notifications) this.notifications = parsed.notifications;
                if (parsed.chats) this.chats = parsed.chats;
            } catch (e) {
                console.warn("Could not load stored state, using defaults.", e);
            }
        }
        this.saveState();
        this.applyTheme(this.currentUser.appearance.theme);
    },

    saveState() {
        try {
            localStorage.setItem("circlebook_master_store", JSON.stringify({
                currentUser: this.currentUser,
                posts: this.posts,
                users: this.users,
                notifications: this.notifications,
                chats: this.chats
            }));
        } catch (e) {
            console.error("Failed saving store to localStorage", e);
        }
    },

    applyTheme(themeName) {
        document.documentElement.setAttribute("data-theme", themeName);
        this.currentUser.appearance.theme = themeName;
        this.saveState();
    },

    // Helper methods for actions
    addPost(content, category = "General", image = null, tags = []) {
        const newPost = {
            id: `post_${Date.now()}`,
            authorId: this.currentUser.id,
            authorName: this.currentUser.name,
            authorHandle: this.currentUser.handle,
            authorAvatar: this.currentUser.avatar,
            timestamp: "Just now",
            category: category,
            content: content,
            image: image,
            likes: 0,
            comments: [],
            shares: 0,
            isLiked: false,
            isBookmarked: false,
            tags: tags.length ? tags : ["#Circlebook"]
        };
        this.posts.unshift(newPost);
        this.saveState();
        return newPost;
    },

    toggleLikePost(postId) {
        const post = this.posts.find(p => p.id === postId);
        if (post) {
            post.isLiked = !post.isLiked;
            post.likes += post.isLiked ? 1 : -1;
            this.saveState();
        }
    },

    toggleBookmarkPost(postId) {
        const post = this.posts.find(p => p.id === postId);
        if (post) {
            post.isBookmarked = !post.isBookmarked;
            this.saveState();
        }
    },

    addComment(postId, text) {
        const post = this.posts.find(p => p.id === postId);
        if (post && text.trim()) {
            post.comments.push({
                id: `c_${Date.now()}`,
                author: this.currentUser.name,
                avatar: this.currentUser.avatar,
                text: text.trim(),
                timestamp: "Just now"
            });
            this.saveState();
        }
    },

    sendChatMessage(chatId, text) {
        const chat = this.chats.find(c => c.id === chatId);
        if (chat && text.trim()) {
            const msg = {
                id: `m_${Date.now()}`,
                sender: this.currentUser.id,
                text: text.trim(),
                timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
            };
            chat.messages.push(msg);
            chat.lastMessage = text.trim();
            chat.lastTimestamp = "Just now";
            this.saveState();
            return msg;
        }
    },

    acceptConnectionRequest(userId) {
        const user = this.users.find(u => u.id === userId);
        if (user) {
            user.connectionStatus = "connected";
            this.currentUser.circleCount += 1;
            this.saveState();
        }
    },

    declineConnectionRequest(userId) {
        const user = this.users.find(u => u.id === userId);
        if (user) {
            user.connectionStatus = "none";
            this.saveState();
        }
    },

    toggleCommunityJoin(commId) {
        const comm = this.communities.find(c => c.id === commId);
        if (comm) {
            comm.isJoined = !comm.isJoined;
            comm.membersCount += comm.isJoined ? 1 : -1;
            this.saveState();
        }
    },

    toggleEventRSVP(eventId) {
        const evt = this.events.find(e => e.id === eventId);
        if (evt) {
            evt.isRSVPed = !evt.isRSVPed;
            evt.attendingCount += evt.isRSVPed ? 1 : -1;
            this.saveState();
        }
    },

    applyForJob(jobId) {
        const job = this.jobs.find(j => j.id === jobId);
        if (job) {
            job.isApplied = true;
            job.applicantsCount += 1;
            this.saveState();
        }
    }
};

// Initialize store on script load
CirclebookStore.init();
