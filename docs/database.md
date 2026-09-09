# The Circlebook — Database Schema Specification

## Collections / Tables

### Users Collection (`users`)
- `id` (String, Primary Key)
- `name`, `handle`, `email`
- `role` ("user", "moderator", "admin")
- `skills` (Array of Strings)
- `interests` (Array of Strings)
- `circleCount` (Integer)
- `privacy` (Embedded Object)

### Posts Collection (`posts`)
- `id` (String)
- `authorId` (String, FK to Users)
- `content` (Text)
- `likes` (Integer)
- `comments` (Array of Comment Objects)

### Communities Collection (`communities`)
- `id`, `name`, `membersCount`, `rules`
