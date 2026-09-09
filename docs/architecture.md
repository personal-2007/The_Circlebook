# The Circlebook — System Architecture Specification

## 1. Executive Overview
The Circlebook is a community directory and social platform designed with a 1940s–1960s vintage aesthetic combined with modern reactive web applications, AI semantic recommendations, and privacy controls.

## 2. Core Layers
- **Presentation Layer**: Responsive HTML5, CSS Grid/Flexbox with 4 curated aesthetic themes, modular CSS.
- **Client State Layer**: Local state store (`CirclebookStore`) backed by `localStorage`.
- **Router Layer**: Hash & history-based sub-tab navigation system (`CirclebookRouter`).
- **AI & Recommendation Layer**: Semantic vector match algorithms & Circle AI prompt assistant.
- **Admin & Safety Layer**: Role-based access control (RBAC), moderation queue, system metrics monitor.

## 3. Data Flow Architecture
```
User Action ──> Router/Component ──> State Store ──> Re-render View
                                        │
                                  localStorage
```
