-- portfolio.sql
-- ICS 2216 Lab 2, Part B (Week 6): portfolio database for Tracy Anita Adhiambo
-- BSc Applied Biology, JKUAT, 2025-2029 (Expected)
-- Contact on the site is email only: anita.tracy856@gmail.com
-- No phone numbers or referee contacts are stored in this database.
--
-- Provenance, read this before submitting:
-- * profile, skills and courses come from Anita's CV / coursework.
-- * hobbies (3) and movies/shows (5) are ANITA'S OWN LISTS, supplied by
--   Richie on 25 Nov 2026 and confirmed in Anita's own reflection the
--   same evening: Skating, Riding a Bicycle, Watching Movies;
--   Euphoria, A Different World, Nemesis, Never Have I Ever, Bridgerton.
--   They match exactly what the portfolio site currently shows, in her
--   own order (my_rank 1-5). The why_i_love_it lines were rewritten
--   25 Nov 2026 in Anita's own voice (first person), at Richie's request.
-- * 'Bridgeston' as supplied is spelled Bridgerton on the site and here
--   (Netflix series, 2020-PRESENT). Nemesis CONFIRMED 25 Nov 2026
--   (Richie) as the 2021 British crime thriller film.
-- * The movie table holds 1 film (Nemesis, 2021) and 4 TV series:
--   Euphoria (2019-PRESENT), A Different World (1987-1993),
--   Never Have I Ever (2020-2023) and Bridgerton (2020-PRESENT).
--   movie.release_year stores the START year only.
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

-- Hobbies: 3, Anita's own list, matching the site exactly.
INSERT INTO hobby (profile_id, hobby_name, description) VALUES
(1, 'Skating', 'Gliding outdoors on skates - balancing, turning and picking up speed. It is fun, it keeps me fit, and it is a good way to clear my head after classes.'),
(1, 'Riding a Bicycle', 'Cycling on open roads and around the neighbourhood - fresh air, exercise and a simple way to get around while enjoying the ride.'),
(1, 'Watching Movies', 'Settling in with popcorn to watch a film or a series, from crime thrillers to comedies. A relaxing way to unwind and enjoy a good story.');

-- Movies / shows: 5, Anita's own Top 5, ranked in her order, matching the site exactly.
-- Stored in the Lab movie table (release_year = start year, see header).
INSERT INTO movie (profile_id, title, release_year, my_rank, why_i_love_it) VALUES
(1, 'Euphoria', 2019, 1, 'I love Euphoria because it tells the truth about being young, about friendship, mistakes and trying to find yourself. The characters feel real, and the way it is filmed makes every episode stay with me long after it ends.'),
(1, 'A Different World', 1987, 2, 'As a university student myself, I love watching life at Hillman College, the friendships, the laughter and the lessons about growing up away from home. Whitley and Dwayne''s story is my favourite part, it feels close to real student life.'),
(1, 'Nemesis', 2021, 3, 'Nemesis keeps me guessing from the start, with old scores, family feuds and betrayal catching up fast. I enjoy crime stories where you have to think along, and the tension and the London setting make me want to watch it again.'),
(1, 'Never Have I Ever', 2020, 4, 'Never Have I Ever makes me laugh and feel at the same time. Devi is funny, stubborn and trying her best, and the show reminds me that growing up is messy for everyone.'),
(1, 'Bridgerton', 2020, 5, 'Bridgerton is pure enjoyment, the dresses, the music, the balls and the romance of Regency London. It is the show I watch when I want to relax and escape into a beautiful world.');

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
