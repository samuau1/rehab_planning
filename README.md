# Rehab Tracker

A small, phone-first PWA for your physio exercises: log sets (reps + weight), auto-start a rest timer, see history and progress.
Static files only, so it hosts on GitHub Pages. Data lives in Supabase (or in the browser if you skip Supabase).

## Setup (≈10 minutes)

1. **Supabase**: create a project (or reuse an existing one: the tables are prefixed `rehab_` so they won't clash with other apps; leave "Allow new users to sign up" on if other apps share the project), open *SQL Editor*, paste `schema.sql`, run it.
   Then *Authentication → Providers → Email*: keep it enabled. Optional: turn off "Confirm email" for faster sign-up.
2. **Keys**: put *Project URL* and *anon public key* (Project Settings → API) in `config.js`.
   The anon key is meant to be public; the Row Level Security policies in `schema.sql` keep your rows private.
3. **GitHub Pages**: push this folder to a repo → Settings → Pages → deploy from `main` / root.
4. **Create your account** in the app (email + password), or sign in with an existing account from the same Supabase project.
   If this project is dedicated to this app, you can then turn off *Allow new users to sign up*.
5. **On your phone**: open the Pages URL → Share → *Add to Home Screen* (iOS) or *Install app* (Android).

The first time you sign in, your 5 exercises from the physio's sheet are created automatically; edit them in Settings.

## Features
- **Focus mode**: tap an exercise for a full-screen view with the physio's illustration, instructions, big set circles, reps/weight steppers and the rest timer
- **Rest timer** survives screen lock, beeps and vibrates, ±15 s, per-exercise rest times, screen stays awake
- **Mini calendar** on the home screen: filled = full session, light = partial; tap a day to view or backfill it
- **Gamification** (no streak guilt): XP and levels (10 XP per set, 50 per finished session), a weekly-goal streak so rest days never break it,
  12 badges, "new personal best" alerts and a confetti celebration when you finish a session
- Progression hint when you hit the top of the rep range on every set
- How-it-felt rating + note per session (handy for the next physio visit)
- Progress: sessions per week, weight / total reps trend per exercise
- Export to CSV; edit, reorder, hide exercises; light and dark mode

XP, levels and badges are calculated from your logged sets, so they need no extra tables.
The weekly goal and default rest time are stored on the device.
Without keys in `config.js` it runs in local-only mode (good for trying it out).

> Updating from the first version? Re-run `schema.sql` once: it adds the `image` column (safe to run again).
