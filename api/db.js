// GET /api/db?q=profile|skills|hobbies|movies|courses|enquiries|queries
// Reads the real portfolio.db with Node's built-in node:sqlite.
// If node:sqlite is unavailable in the Vercel runtime, it falls back to
// data.json, a snapshot exported from the same database at deploy time.
// Writes are NOT attempted here: Vercel serverless functions run on a
// read-only / ephemeral filesystem, so an INSERT would not persist.
// The site's contact form uses mailto instead, and enquiry rows are
// added to portfolio.db locally, then redeployed.
const fs = require('fs');
const path = require('path');

function findDb() {
  const candidates = [
    path.join(__dirname, 'portfolio.db'),
    path.join(process.cwd(), 'portfolio.db'),
    path.join(process.cwd(), 'api', 'portfolio.db'),
  ];
  for (const p of candidates) {
    try { if (fs.existsSync(p)) return p; } catch (_) {}
  }
  return null;
}

function readViaSqlite() {
  const { DatabaseSync } = require('node:sqlite');
  const dbPath = findDb();
  if (!dbPath) throw new Error('portfolio.db not found');
  const db = new DatabaseSync(dbPath, { readOnly: true });
  const all = (sql, params = []) => db.prepare(sql).all(...params);
  const result = {
    source: 'sqlite:portfolio.db',
    profile: all('SELECT * FROM profile'),
    skills: all('SELECT * FROM skill ORDER BY skill_id'),
    hobbies: all('SELECT * FROM hobby ORDER BY hobby_id'),
    movies: all('SELECT * FROM movie ORDER BY my_rank'),
    courses: all('SELECT * FROM course ORDER BY course_id'),
    enquiries: all('SELECT * FROM enquiry ORDER BY enquiry_id'),
    queries: {
      movies_ranked: all('SELECT title, release_year FROM movie ORDER BY my_rank'),
      movies_after_2010: all('SELECT title FROM movie WHERE release_year > 2010'),
      profile_with_hobbies: all('SELECT profile.full_name, hobby.hobby_name FROM profile JOIN hobby ON hobby.profile_id = profile.profile_id'),
      skill_count: all('SELECT COUNT(*) AS skill_count FROM skill')[0],
    },
  };
  db.close();
  return result;
}

function readViaJson() {
  const candidates = [
    path.join(process.cwd(), 'data.json'),
    path.join(__dirname, '..', 'data.json'),
  ];
  for (const p of candidates) {
    try {
      if (fs.existsSync(p)) {
        const d = JSON.parse(fs.readFileSync(p, 'utf8'));
        return {
          source: 'data.json snapshot of portfolio.db',
          profile: d.profile, skills: d.skill, hobbies: d.hobby,
          movies: d.movie, courses: d.course, enquiries: d.enquiry,
          queries: d.queries,
        };
      }
    } catch (_) {}
  }
  throw new Error('no database source available');
}

module.exports = (req, res) => {
  res.setHeader('Content-Type', 'application/json');
  res.setHeader('Cache-Control', 'no-store');
  if (req.method === 'POST') {
    res.statusCode = 501;
    res.end(JSON.stringify({ ok: false, error: 'Writes do not persist on Vercel serverless (read-only filesystem). Add enquiry rows to portfolio.db locally and redeploy, or use the mailto contact form on the site.' }));
    return;
  }
  let data;
  try { data = readViaSqlite(); }
  catch (e) { try { data = readViaJson(); } catch (_) { res.statusCode = 500; res.end(JSON.stringify({ ok: false, error: String(e && e.message || e) })); return; } }
  const q = (req.query && req.query.q) || '';
  const map = { profile: 'profile', skills: 'skills', hobbies: 'hobbies', movies: 'movies', courses: 'courses', enquiries: 'enquiries', queries: 'queries' };
  if (q && map[q]) {
    res.end(JSON.stringify({ ok: true, source: data.source, q, data: data[map[q]] }));
  } else {
    res.end(JSON.stringify({ ok: true, source: data.source, data }));
  }
};
