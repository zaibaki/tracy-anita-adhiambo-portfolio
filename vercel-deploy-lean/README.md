# Tracy Anita Adhiambo — Portfolio (ICS 2216 Lab 2)

BSc Applied Biology, JKUAT, 2025–2029. Contact on the site is email only:
anita.tracy856@gmail.com. No phone numbers or referee contacts are published.

## What is in here

- `index.html` — the portfolio site (exported, self-contained, 8.9 MB with photos/posters inlined)
- `db.html` — a live database viewer, reads `/api/db`
- `portfolio.db` — SQLite database, Lab 2 Part B (profile, skill, hobby, movie, enquiry, plus an extra `course` table)
- `portfolio.sql` — the full CREATE + INSERT script. Rebuild with: `sqlite3 portfolio.db < portfolio.sql`
- `query-results.txt` — output of the 5 Lab SQL queries
- `api/db.js` — Vercel serverless function, reads `portfolio.db` with Node's built-in `node:sqlite`, falls back to `data.json` if that is unavailable
- `data.json` — snapshot exported from `portfolio.db` at deploy time, used only as a fallback
- `vercel.json` — bundles `portfolio.db` into the API function

## The shows

The Movies & Shows page now has only two TV shows, with their actual banners:
1. A Different World (1987–1993, SITCOM / DRAMA)
2. Euphoria (2019–PRESENT, DRAMA)

In the database `movie.release_year` stores the start year only (1987 / 2019).
Hobbies (6) and the two shows are training placeholders — swap them for Anita's
real lists before submission. Skill levels are training self-assessments.

## How the SQLite DB works on Vercel

- Reads work live: `GET /api/db`, `GET /api/db?q=movies`, `?q=profile`, `?q=skills`, `?q=hobbies`, `?q=courses`, `?q=enquiries`, `?q=queries`
- Writes do NOT persist on Vercel: serverless functions run on a read-only,
  ephemeral filesystem. `POST /api/db` returns 501 with that explanation.
  Add enquiry rows to `portfolio.db` locally and redeploy.

## Deploy

```sh
vercel --prod
# or, from the Vercel dashboard, import this folder as a new project
```

## Run locally

```sh
# site
python3 -m http.server 8000
# database
sqlite3 portfolio.db "SELECT title, release_year FROM movie ORDER BY my_rank;"
# API (Node 24)
node -e "const {DatabaseSync}=require('node:sqlite'); const db=new DatabaseSync('portfolio.db',{readOnly:true}); console.log(db.prepare('SELECT * FROM profile').all());"
```
