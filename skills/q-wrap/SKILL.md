---
name: q-wrap
description: "Evening wrap. 10-minute end-of-day health check. Use when the user says 'wrap', 'end of day', 'done for today', or 'q-wrap'."
user-invocable: true
---

# Evening Wrap

Quick end-of-day system check:

1. **Effort log**: What was accomplished today? Count actions taken (emails sent, comments posted, DMs sent, meetings had).
2. **Missed debriefs**: Any conversations today that weren't debriefed? If so, offer to run `/q-debrief` now.
3. **Open loops**: Check `q-system/my-project/progress.md` for any items started but not completed.
4. **Canonical drift**: Were any canonical files updated today? Quick consistency check.
5. **Tomorrow preview**: Check calendar for tomorrow's meetings. Flag any that need prep.
6. **Handoff note**: Write a brief context note to `q-system/memory/last-handoff.md` so the next session picks up cleanly.

Track effort not outcomes. Present what was done, not what wasn't.
