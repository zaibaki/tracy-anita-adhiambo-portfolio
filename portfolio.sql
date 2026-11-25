-- portfolio.sql
-- ICS 2216 Lab 2, Part B (Week 6): portfolio database for Tracy Anita Adhiambo
-- BSc Applied Biology, JKUAT, 2025-2029 (Expected)
-- Contact on the site is email only: anita.tracy856@gmail.com
-- No phone numbers or referee contacts are stored in this database.
--
-- Provenance, read this before submitting:
-- * profile, skills and courses come from Anita's CV / coursework.
-- * hobbies (6) and shows (2) are TRAINING PLACEHOLDERS, filled in at
--   Richie's instruction because Anita's real lists were not supplied.
--   They match exactly what the portfolio site currently shows.
--   Swap those two tables for her real lists before submission.
-- * The two shows are TV series, not films: A Different World
--   (1987-1993, SITCOM / DRAMA) and Euphoria (2019-PRESENT, DRAMA).
--   movie.release_year stores the START year only (1987 / 2019).
--   Do not invent an end year for Euphoria.
-- * skill levels are training self-assessments, not grades from the CV.
-- * enquiry is intentionally empty: no real message has been received yet.
--   Do not invent a fake sender. The contact form will add real rows.
--
-- Run with: sqlite3 portfolio.db < portfolio.sql
-- (or open portfolio.db in DB Browser for SQLite and run this file)

PRAGMA foreign_keys = ON;

-- Step 14: Create the tables (Lab 2 schema, verbatim)

CREATE TABLE profile (
  profile_id INTEGER PRIMARY KEY,
  full_name TEXT NOT NULL,
  programme TEXT,
  bio TEXT
);

CREATE TABLE skill (
  skill_id INTEGER PRIMARY KEY,
  profile_id INTEGER NOT NULL,
  skill_name TEXT NOT NULL,
  level TEXT,
  FOREIGN KEY (profile_id) REFERENCES profile(profile_id)
);

CREATE TABLE hobby (
  hobby_id INTEGER PRIMARY KEY,
  profile_id INTEGER NOT NULL,
  hobby_name TEXT NOT NULL,
  description TEXT,
  FOREIGN KEY (profile_id) REFERENCES profile(profile_id)
);

CREATE TABLE movie (
  movie_id INTEGER PRIMARY KEY,
  profile_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  release_year INTEGER,
  my_rank INTEGER,
  why_i_love_it TEXT,
  FOREIGN KEY (profile_id) REFERENCES profile(profile_id)
);

CREATE TABLE enquiry (
  enquiry_id INTEGER PRIMARY KEY,
  profile_id INTEGER NOT NULL,
  sender_name TEXT NOT NULL,
  sender_email TEXT NOT NULL,
  message TEXT NOT NULL,
  sent_at TEXT DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (profile_id) REFERENCES profile(profile_id)
);

-- Extra table, not in Lab 2 Step 14, to match the site's Courses section.
-- Education (BSc / KCSE) is NOT stored here as a course.
CREATE TABLE course (
  course_id INTEGER PRIMARY KEY,
  profile_id INTEGER NOT NULL,
  year_label TEXT,
  code TEXT,
  title TEXT NOT NULL,
  description TEXT,
  tags TEXT,
  FOREIGN KEY (profile_id) REFERENCES profile(profile_id)
);

-- Step 15: Enter the records (profile_id = 1 throughout)

INSERT INTO profile (profile_id, full_name, programme, bio)
VALUES (1, 'Tracy Anita Adhiambo', 'BSc Applied Biology',
'A motivated and enthusiastic student with a strong academic background and an interest in practical learning. Possesses good communication, teamwork, and organizational skills, and gains valuable professional experience');

-- Skills: 10 core skills from the CV (5 practical/personal + 5 computer)
INSERT INTO skill (profile_id, skill_name, level) VALUES
(1, 'Communication skills', 'Strong'),
(1, 'Teamwork and collaboration', 'Strong'),
(1, 'Time management', 'Strong'),
(1, 'Problem-solving', 'Strong'),
(1, 'Attention to detail', 'Strong'),
(1, 'Microsoft Word', 'Advanced'),
(1, 'Microsoft Excel', 'Intermediate'),
(1, 'PowerPoint', 'Advanced'),
(1, 'Data entry', 'Intermediate'),
(1, 'Report writing', 'Advanced');

-- Hobbies: 6, matching the site exactly. TRAINING PLACEHOLDERS - see header.
INSERT INTO hobby (profile_id, hobby_name, description) VALUES
(1, 'Nature Walks & Field Observation', 'Walking outdoors and observing plants, insects and birds in their natural environment - the hobby that made Applied Biology feel like the right course for me.'),
(1, 'Listening to Music', 'Music keeps me focused during study sessions and relaxed after long laboratory days. It is the soundtrack to most of my revision.'),
(1, 'Photography', 'Taking photos of people, places and nature - including the two portraits on this website. I enjoy capturing colour and light on an ordinary day.'),
(1, 'Reading Science & Biology Books', 'Reading beyond the coursework - books and articles about the human body, plants and the environment that deepen what we cover in class.'),
(1, 'Team Activities & Group Study', 'Working with classmates on group assignments and practicals. Teamwork is one of my core skills, and group study makes difficult topics easier.'),
(1, 'Gardening & Plant Care', 'Looking after plants at home and watching them grow - a small, everyday way of practising the observation skills I use in biology practicals.');

-- Shows: 2, ranked, matching the site exactly. TRAINING PLACEHOLDERS - see header.
-- Stored in the Lab movie table (release_year = start year, see header).
INSERT INTO movie (profile_id, title, release_year, my_rank, why_i_love_it) VALUES
(1, 'A Different World', 1987, 1, 'Life at Hillman College, a fictional historically Black university — friendships, ambition, love and growing up away from home. As a university student myself, the campus stories, the humour and Whitley and Dwayne''s journey feel close to real student life.'),
(1, 'Euphoria', 2019, 2, 'Zendaya stars as Rue in HBO''s raw, emotional drama about youth, identity, addiction and friendship. The storytelling is honest and hard-hitting, and the visuals are striking — a show that stays with you long after each episode ends.');

-- Courses: 3, matching the site's Academic Journey cards exactly.
INSERT INTO course (profile_id, year_label, code, title, description, tags) VALUES
(1, '2025', 'ICS 2216 · Lab 1', 'Professional CV in Microsoft Word', 'Professional document formatting, structuring a CV, and presenting skills and education clearly.', 'Microsoft Word, Document Design'),
(1, '2026', 'ICS 2216 · Lab 2', '“All About Me” Portfolio Website', 'HTML structure, CSS styling, hyperlinks and navigation, images with alt text, and responsive, accessible design - this site.', 'HTML, CSS, Web Design'),
(1, '2025 – Present', 'Applied Biology', 'Laboratory Practical Exercises', 'Following procedures accurately, observing carefully, and documenting findings in academic reports.', 'Lab Skills, Report Writing');

-- enquiry: intentionally no rows yet. See header.

-- Step 16: SQL queries (run these separately; results are in query-results.txt)
-- 1. Show my full profile
--    SELECT * FROM profile;
-- 2. My movies in rank order (sorting)
--    SELECT title, release_year FROM movie ORDER BY my_rank;
-- 3. Only movies released after 2010 (filtering)
--    SELECT title FROM movie WHERE release_year > 2010;
-- 4. Combine tables: my name with each of my hobbies (relationship)
--    SELECT profile.full_name, hobby.hobby_name FROM profile JOIN hobby ON hobby.profile_id = profile.profile_id;
-- 5. How many skills do I list?
--    SELECT COUNT(*) FROM skill;
