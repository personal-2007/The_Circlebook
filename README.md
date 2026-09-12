# The Circlebook

> **Know your people. Build your circle.**

The Circlebook is a vintage-inspired community directory and social-network website built around the simplicity of early social networking platforms.

Instead of focusing on modern social-media features, The Circlebook focuses on **people, profiles, discovery, connections, invitations, and privacy**.

---

## About The Project

The Circlebook combines the concept of an early online community directory with a **1940s–1960s-inspired visual identity**.

The interface uses classic typography, paper-like surfaces, structured directory layouts, thin borders, and a restrained color palette to create a timeless community experience.

### Core Concept

**Discover people → View profiles → Send requests → Build your circle**

---

## Design Direction

| Category       | Direction                           |
| -------------- | ----------------------------------- |
| Visual Era     | 1940s–1960s                         |
| Design Style   | Vintage Community Directory         |
| Primary Colors | Navy Blue, Warm Gold                |
| Background     | Cream / Paper                       |
| Typography     | Classic Serif + Clean Sans Serif    |
| Layout         | Directory / Newspaper Inspired      |
| Borders        | Thin and Structured                 |
| Animation      | Minimal                             |
| UI Philosophy  | Simple, readable, information-first |

### Design Principles

* Classic rather than futuristic
* Simple rather than overloaded
* Information-first layouts
* Strong typography hierarchy
* Clear navigation
* Minimal animation
* Responsive across devices
* Consistent spacing and borders
* Real interface icons instead of decorative AI-generated symbols

---

# Features

## 1. Registration

Users can create an account using:

* Full Name
* Email
* Birthday
* Gender
* Location
* College / School
* Interests
* Password

---

## 2. Login

Registered members can sign in using:

* Email
* Password

The current prototype uses browser `localStorage` for authentication.

> **Note:** `localStorage` authentication is intended only for the prototype. A production version should use a secure backend authentication system.

---

## 3. Member Profile

Each member has a structured profile containing:

* Name
* Profile information
* Location
* College / School
* Birthday
* Gender
* Interests
* Circle count
* Privacy settings

---

## 4. Find People

Members can discover people through the community directory.

Search by:

* Name
* Location
* Education
* Interests

Each result provides access to the member profile and an option to send a circle request.

---

## 5. Circle Requests

Members can:

* Send circle requests
* Receive requests
* Accept requests
* Decline requests

When a request is accepted, both members are added to each other's circle.

---

## 6. Invitations

Members can invite people who are not currently part of the community.

Invitation information includes:

* Name
* Email
* Personal message

The current prototype stores invitation information locally.

> No real email is sent in the current prototype.

---

## 7. Privacy Controls

Members can control who can see selected profile information.

### Privacy Options

| Setting   | Description                                   |
| --------- | --------------------------------------------- |
| Everyone  | Information is visible to all members         |
| My Circle | Information is visible only to circle members |
| Only Me   | Information remains private                   |

### Protected Information

* Profile information
* Birthday
* Email address

---

# Application Flow

```text
Application Launch
        |
        v
     Login
        |
        +------> Register
        |
        v
     Profile
        |
        v
   Find People
        |
        v
 Circle Request
        |
        +------> Accept
        |          |
        |          v
        |      Build Circle
        |
        +------> Decline
        |
        v
   Invitations
        |
        v
 Privacy Settings
```

---

# Project Screens

The current prototype contains the following primary screens:

```text
Loading / Entry
       |
       v
Login
       |
       +----> Register
       |
       v
Profile
       |
       +----> Find People
       |
       +----> Circle Requests
       |
       +----> Invitations
       |
       +----> Settings / Privacy
```

---

# Project Structure

```text
the-circlebook/
│
├── index.html
├── README.md
│
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
│
├── css/
│   ├── style.css
│   ├── auth.css
│   ├── profile.css
│   └── responsive.css
│
├── js/
│   ├── app.js
│   ├── auth.js
│   ├── profile.js
│   ├── people.js
│   ├── requests.js
│   └── privacy.js
│
├── pages/
│   ├── login.html
│   ├── register.html
│   ├── profile.html
│   ├── people.html
│   ├── requests.html
│   ├── invite.html
│   └── settings.html
│
└── data/
    └── users.json
```

---

# Technology

The current prototype is intentionally lightweight.

### Frontend

* HTML5
* CSS3
* JavaScript
* Responsive CSS

### Prototype Storage

* Browser `localStorage`
* Local JSON data

### Planned Production Stack

```text
Frontend
HTML
CSS
JavaScript
        |
        v
Backend API
        |
        v
Authentication
        |
        v
Database
        |
        v
Cloud Deployment
```

---

# Icon System

The Circlebook should use **real interface icons** rather than decorative emoji or AI-generated symbols.

Recommended icon approach:

```text
Search       → Search icon
Profile      → User icon
Circle       → Users / User Plus icon
Requests     → User Check icon
Invitation   → Mail icon
Settings     → Settings icon
Privacy      → Lock icon
Location     → Map Pin icon
Education    → Graduation Cap icon
Birthday     → Calendar icon
Email        → Mail icon
Logout       → Log Out icon
Back         → Arrow Left icon
```

Icons should remain:

* Simple
* Monochrome
* Consistent in stroke weight
* Small and functional
* Visually compatible with the vintage interface

Avoid:

* AI-style glowing icons
* Excessive gradients
* 3D icons
* Random emoji
* Decorative icons without a functional purpose

---

# Color Palette

### Primary Palette

```text
Navy Blue
#172A46

Warm Gold
#B08A3E

Cream
#F4EBDD

Paper
#FBF7EF

Dark Text
#202020

Muted Text
#6B6257

Border
#C9BDA9
```

### Example

```css
:root {
    --navy: #172A46;
    --gold: #B08A3E;
    --cream: #F4EBDD;
    --paper: #FBF7EF;
    --text: #202020;
    --muted: #6B6257;
    --border: #C9BDA9;
}
```

---

# Typography

The typography should reinforce the historical directory aesthetic.

### Recommended Structure

```text
Headings
→ Classic Serif

Body
→ Clean Sans Serif

Labels
→ Small uppercase / structured typography

Navigation
→ Clean, readable typography
```

The typography should prioritize readability over decorative styling.

---

# Responsive Design

The Circlebook should work across:

```text
Desktop
   |
Tablet
   |
Mobile
```

The interface should preserve the directory structure while adapting:

* Navigation
* Profile cards
* Search results
* Forms
* Request lists
* Settings
* Invitations

for smaller screens.

---

# Current Prototype Limitations

The current version is a frontend prototype.

### Authentication

```text
Browser localStorage
```

### Database

```text
Not connected
```

### Email

```text
No real email delivery
```

### Backend

```text
Not implemented
```

### Security

```text
Not production-ready
```

The prototype is intended to validate the **interface, navigation, profile system, discovery experience, circle workflow, invitations, and privacy controls** before introducing a production backend.

---

# Future Development

Possible future improvements include:

### Backend

* Node.js
* Express
* REST API
* Secure authentication
* Session management
* Password hashing

### Database

* MongoDB
* PostgreSQL

### Social Features

* Circle activity
* Mutual circles
* Member recommendations
* Profile verification
* Community groups
* Member directories
* Connection history

### Communication

* Direct messaging
* Email invitations
* Notifications

### Security

* Secure authentication
* Rate limiting
* Input validation
* Access control
* Privacy enforcement
* Secure password storage

---

# Development Roadmap

## Phase 1 — Foundation

* [x] Project structure
* [x] Landing / entry page
* [x] Registration
* [x] Login
* [x] Profile
* [x] Find People
* [x] Circle Requests
* [x] Invitations
* [x] Privacy Settings

## Phase 2 — Interface Refinement

* [ ] Complete responsive layouts
* [ ] Improve typography
* [ ] Standardize icons
* [ ] Improve accessibility
* [ ] Improve form validation
* [ ] Improve navigation
* [ ] Add empty states
* [ ] Add loading states
* [ ] Add error states

## Phase 3 — Backend

* [ ] Backend API
* [ ] Database
* [ ] Secure authentication
* [ ] User management
* [ ] Circle relationship system
* [ ] Request management
* [ ] Privacy enforcement

## Phase 4 — Production

* [ ] Email service
* [ ] Notifications
* [ ] Deployment
* [ ] Security testing
* [ ] Performance optimization
* [ ] Production monitoring

---

# Getting Started

## 1. Clone the Repository

```bash
git clone https://github.com/personal-2007/The_Circlebook.git
```

## 2. Open the Project

```bash
cd The_Circlebook
```

## 3. Run the Prototype

Because the current version is a frontend prototype, it can be opened using a local development server.

For example, with VS Code:

```text
Install Live Server
        ↓
Open index.html
        ↓
Run with Live Server
```

---

# Repository Structure Philosophy

The project separates responsibilities into clear areas:

```text
HTML
  ↓
Page Structure

CSS
  ↓
Visual Design

JavaScript
  ↓
Application Logic

Data
  ↓
Prototype User Data

Assets
  ↓
Images / Icons / Fonts
```

This structure is intended to make the project easy to expand into a full-stack application later.

---

# Project Goals

The Circlebook is built around a simple idea:

> **A social network does not need to be complicated to help people connect.**

The project aims to create a calmer alternative to modern social-media interfaces by emphasizing:

* People
* Profiles
* Discovery
* Connections
* Privacy
* Community

---

# License

This project is currently developed as a personal software project.

License information will be added when the project is prepared for public distribution.

---

# Author

**Selvakumar S**

The Circlebook
**Know your people. Build your circle.**
