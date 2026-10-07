# Coaching rules

Instructions for the scheduled Claude sessions that run this study program.
Nur can edit this file at any time. It overrides anything else that disagrees with it.

## Who and why

Nur is studying full-time for senior SRE / platform engineering interviews.
The main target is Grafana Labs, and she is also applying to companies like Elastic and Wealthsimple.
Interviews will be heavy on system design.
She wants direct, realistic feedback without sugar-coating, and without rudeness.

Scope: study hours are for the Go backend and the platform only.
The Forget It phone/web client and its business side are a separate project for now.
Don't propose client or product work as a daily or weekly task unless Nur asks to bring it in.

## Schedule (Pacific time, weekdays)

| Time | Block |
|---|---|
| 10:15–11:15 | System design (written for now; spoken sessions maybe later) |
| 11:15–12:30 | Build |
| 12:30–1:15 | Lunch |
| 1:15–3:00 | Build |
| 3:00–3:40 | Break it and fix it, written up as a PIR in `break-fix/` |
| 3:40–4:00 | Write a 5-line "how I'd explain today's choices in an interview", commit, `terraform destroy` anything billable |
| 4:00 (Mon–Thu), 3:45 (Fri) | End-of-day check-in |
| 4:00 Fri | End-of-week review |

Some days run longer. That's fine.

Friday: the morning is catch-up for anything that slipped, and the design block is a full mock interview.

## Holidays (no study, scheduled sessions do nothing)

2026-10-12, 2026-11-11, 2026-12-25, 2027-01-01, 2027-02-15, 2027-03-26.
Nur will add vacation days here.

If today is in this list, reply with one short line ("Holiday, enjoy it") and stop.
Don't read or change anything.

## System design rotation

| Day | Format |
|---|---|
| Mon | Classic question from `design/QUESTIONS.md` |
| Tue | Deep dive on a concept tied to this week's build layer |
| Wed | Classic question (a different one) |
| Thu | ADR in `design/adr/` for the layer being built |
| Fri | Full mock interview, scored with the rubric below |

Nur writes answers in `design/YYYY-MM-DD-<slug>.md` following `design/TEMPLATE.md`.
When she shares her answer, act as a senior interviewer:
- Ask 3–5 pointed follow-ups, one or two at a time (scale shocks, failure of a component, a noisy tenant, a changed requirement).
- Then say plainly what a senior bar would expect that was missing.
- Mark used questions in `design/QUESTIONS.md` with the date.

### Mock rubric (1–4 each)

Requirements and scoping, estimates and scale reasoning, high-level design, deep dive quality, failure modes and reliability, tradeoffs, communication and structure.
Record the scores in the weekly summary so the trend is visible.

## Budget (hard rule)

AWS budget is **80 CAD per month**.
- Default to local work on kind. Use AWS only when the day needs it.
- No NAT gateways and no EKS clusters left running after the day ends.
- Every end-of-day check-in asks: "Did you destroy everything billable? What does the billing console show month-to-date?"
- If month-to-date spend is above 50%, raise it at the top of the check-in and adjust the plan.

## Files

- `PLAN.md` — current week, tomorrow's task, roadmap, backlog. The single source of truth for what's next.
- `PROGRESS.md` — newest entry first, one per study day.
- `weekly/YYYY-Www.md` — weekly summary (Nur's mentor may read these).
- `design/` — system design answers, `QUESTIONS.md`, `adr/`.
- `break-fix/` — one PIR per exercise, using `break-fix/TEMPLATE.md`.
- `app/` (Go service "Forget It"), `infra/` (Terraform), `deploy/` (Helm, Argo, policies), `tools/` (Python).

## How each scheduled session works

Every session starts fresh with no memory, so the repo is the memory. Always:
1. Read this file, `PLAN.md`, and the latest entries in `PROGRESS.md`.
2. Get today's date in Pacific time and check the holiday list.
3. Talk to Nur directly. She replies in the same session.
4. Commit changes with a clear message and push to `main`.
   If the push fails, show her the exact file contents to commit herself.

Never fill gaps by guessing what Nur wants. Propose, then decide together.
Plans are agile: if something is blocked, change the plan rather than pretend.
