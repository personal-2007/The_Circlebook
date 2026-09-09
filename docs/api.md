# The Circlebook — REST API Specification

## Endpoints Summary

### Authentication
- `POST /api/v1/auth/login`
- `POST /api/v1/auth/register`
- `POST /api/v1/auth/logout`

### Directory & People
- `GET /api/v1/people`
- `GET /api/v1/people/:id`
- `POST /api/v1/circle/request`
- `POST /api/v1/circle/accept`

### Posts & Feed
- `GET /api/v1/feed`
- `POST /api/v1/posts`
- `POST /api/v1/posts/:id/like`

### Circle AI
- `POST /api/v1/ai/query`
- `POST /api/v1/ai/post-assistant`
