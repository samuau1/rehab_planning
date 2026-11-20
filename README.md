# Rehab Tracker

A small, phone-first PWA for your physio exercises: log sets (reps + weight), auto-start a rest timer, see history and progress.
Static files only, so it hosts on GitHub Pages. Data lives in Supabase (or in the browser if you skip Supabase).

## Setup (≈10 minutes)

1. **Supabase**: create a project (or reuse one), open *SQL Editor*, paste `schema.sql`, run it.
   Then *Authentication → Providers → Email*: keep it enabled. Optional: turn off "Confirm email" for faster sign-up.
2. **Keys**: put *Project URL* and *anon public key* (Project Settings → API) in `config.js`.
   The anon key is meant to be public; the Row Level Security policies in `schema.sql` keep your rows private.
3. **GitHub Pages**: push this folder to a repo → Settings → Pages → deploy from `main` / root.
4. **Create your account** in the app (email + password). After that, in Supabase turn off *Allow new users to sign up*
   so nobody else can register on your public URL.
5. **On your phone**: open the Pages URL → Share → *Add to Home Screen* (iOS) or *Install app* (Android).

The first time you sign in, your 5 exercises from the physio's sheet are created automatically; edit them in Settings.

## Features
- Today: tap an exercise, set reps/weight (pre-filled from last time), "Log set" → rest timer starts
- Rest timer survives screen lock, beeps + vibrates, ±15 s, per-exercise rest times, screen stays awake
- Progression hint when you hit the top of the rep range on every set
- Backfill any past day (‹ › arrows or History calendar); edit/delete logged sets; extra sets with +
- How-it-felt rating + note per session (handy for the next physio visit)
- Progress: sessions per week, weight / total reps trend per exercise
- Export to CSV; edit, reorder, hide exercises

Without keys in `config.js` it runs in local-only mode (good for trying it out).
