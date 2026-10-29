# Plan

## The app: Forget It

A place to throw small thoughts, ideas, links, and news, which pops one back up at random so it isn't lost forever.
Later, AI looks for patterns across the basket.

The app stays small on purpose. The platform around it is the real project.
It is multi-tenant from day one: every request carries a tenant (a person or a team).

Rough shape as it grows:
- **Capture** `POST /items` → Kafka → consumer stores it (and later enriches links with title/summary)
- **Resurface** `GET /items/random` now, later a scheduled "here's something you forgot" notification
- **Patterns** later: AI clusters and summarizes the basket

### Scope (decided Oct 7)

Study hours (10:15–4:30) cover the Go backend and the platform around it only.
The phone and web client, and the product side (free app with paid AI features), are a separate project for now and stay outside study hours.
Nur may bring them into the plan later; until she does, don't schedule them.

## Restart — Tue Oct 27 afternoon (confirmed Oct 27)

Nur was sick Oct 15–26 and restarts slowly today, from about 2 PM. Small mechanical steps only; stop when tired.
The rest of Week 3 is decided at today's check-in. The proposed Week 3 table below is not the plan until she agrees to it.

| Step | What | Done when |
|---|---|---|
| 1 (15 min) | Install mise if needed, then in the repo root: `mise use go@1.25 terraform kubectl helm k3d k9s`. Pin Go to match `app/go.mod` (1.25), not the 1.23 in Giuseppe's example. If a tool isn't found, install it with Homebrew instead. | `mise.toml` exists and `mise ls` shows the tools |
| 1b (5 min) | Replace the personal email in `infra/envs/dev/example.tfvars` with a placeholder like `you@example.com` (the repo is public). The real value moves to fnox next week. | Pushed |
| 2 (15 min) | `k3d cluster create forget-it`, then `kubectl get nodes` | The node is `Ready` |
| 3 (30 min) | Open `k9s` and explore the empty cluster: `:pods` in `kube-system`, logs, describe. Note what k3s bundles (Traefik, CoreDNS, local-path storage, the service load balancer). | A few notes in PROGRESS.md |
| 4 | Commit `mise.toml` and push. `k3d cluster stop forget-it` when done (it's local, so it costs nothing either way). | Pushed |

Optional only with energy left: `/metrics` endpoint with `client_golang`.

## Session 01 with Giuseppe (Oct 20) — homework before session 02

Session notes are in Giuseppe's PDF and the shared Google Doc. Session 02 date: not set yet.
Session 02 plan: review the updated CV, walk through the Excalidraw design together, and one diagnostic Go problem.
Send each item to Giuseppe on Discord as soon as it's done, not all at the end.

**His eight items, in his order of impact**
1. CV: title, owned verbs, Kafka bullet first, GitHub link, summary that names the target role (no culture close).
2. LinkedIn: headline, About, Hootsuite end date Oct 2026, "Vanocuver" typo, owned verbs, skills order.
3. forget-it: k3d instead of kind.
4. forget-it: k9s in `mise.toml`, 30 minutes using it instead of kubectl.
5. forget-it: `/metrics` Prometheus endpoint, even a stub with one custom counter.
6. Go: one Exercism problem a day for two weeks (exercism.org/tracks/go, medium). Practical parsing and I/O, not algorithms. Solve without looking anything up, then read the idiomatic solution and rewrite.
7. System design: Excalidraw diagram of a familiar web app. Write the four scoping answers at the top first (who uses it, what's the hard problem, what's out of scope, how success is measured).
8. SRE book Ch 1–3 and Ch 13.

**His repo quick wins**
- GitHub description and topics (2 minutes).
- `mise.toml` pinning tools (done today if step 1 lands).
- Pre-commit hooks for Terraform: fmt, validate, tflint, trivy (antonbabenko/pre-commit-terraform).
- fnox: move the budget alert email out of files into `TF_VAR_budget_alert_emails`, mark the variable `sensitive`, no `.env` files.
- Every PIR ends with an interview hook: "I deliberately broke X to understand Y. I learned Z, and it changed how I now do W." (Added to `break-fix/TEMPLATE.md`.)
- `interview-stories.md`: each Friday, one line tagging the week's best moment to a competency.

**Questions he asked Nur to answer (send on Discord)**
- Which Grafana dashboards did you build? Did you write the PromQL?
- Any SLO, SLI or error budget work at Hootsuite, even informal?
- On-call scope: how many services? Any MTTR or P1 numbers?
- Full LinkedIn skills list.
- Is the API spec written anywhere, or straight to code?
- Plan for coding rounds; SRE book progress; any mock design done.

**Proposed for the rest of this week (gentle pace after illness, confirm at check-in)**

| Day | Morning | Afternoon |
|---|---|---|
| Tue Oct 27 | (sick until today) | mise, k3d, k9s, email placeholder (steps above) |
| Wed Oct 28 | CV five fixes. Needs the on-call numbers and the true verb for the Kafka work first. | Exercism #1; `/metrics` stub with one counter |
| Thu Oct 29 | LinkedIn six fixes | Exercism #2; GitHub metadata; pre-commit hooks |
| Fri Oct 30 | Exercism #3; SRE book Ch 1 | Excalidraw diagram, scoping answers first; first line of `interview-stories.md` |

**Fri Oct 30, proposed at the Oct 29 check-in (not agreed; no reply Oct 27–29):** a light catch-up day. Do whatever's easiest from the Oct 27 restart steps first (email placeholder, then `mise.toml`, then k3d). Then the weekly review at 4:00, which plans Week 4 from wherever things actually are. The first mock is proposed to move to Nov 6 or later; Nur decides.

Next week: SRE Ch 2, 3 and 13; fnox; back to `POST /items` and `GET /items/random`; daily Exercism continues.
Until session 02, the daily 10:15 design rotation in COACH.md is replaced by these homework items. The Week 3 table below is superseded.

## Week 3 (Mon Oct 26 – Fri Oct 30): proposed at the Oct 23 weekly review, superseded on Oct 27 by the session 01 homework above

Proposed before Nur replied. Coach sessions: confirm with Nur before treating this as the plan.
The Week 2 scorecard and the open questions to Nur are in `weekly/2026-W43.md` (draft).

Goal: get the service and the habits back on track, and put the first design answers and the first PIR in the repo. Kafka waits.
Rule: push the design file by 11:15 and everything else by 3:40, even if it's half-done.

### Mon Oct 26 — proposed; nothing pushed by the 4:00 check-in

No update from Nur yet. If it wasn't done, Monday's build and break-fix carry into Tue Oct 27 and the Tuesday plan gets cut down, not stacked. Decide at the check-in.

| Time | Block | Done when |
|---|---|---|
| 10:15–11:15 | **System design, classic #2: multi-tenant rate limiter for a public API.** Use `design/TEMPLATE.md`. Cover: per-tenant limits and tiers, token bucket vs. sliding window, where the counters live (local vs. Redis) and what happens when that store is slow or down, and how to stop one noisy tenant from hurting the others. Rough is fine; all 8 headings should have something under them. | `design/2026-10-26-rate-limiter.md` is pushed by 11:15, complete or not. |
| 11:15–12:30 | **Go service, local only.** `POST /items` (text or link) and `GET /items/random`, in-memory store guarded by `sync.Mutex`, keyed by tenant. A missing `X-Tenant-ID` returns 400. | Both endpoints work with `curl`. |
| 1:15–3:00 | Tests with `httptest`: happy path, missing tenant, empty basket on `/random`, and tenant isolation (tenant A never sees B's items). Then push. If there's time, start the multi-stage Dockerfile. | `go test ./...` passes and is on `main`. |
| 3:00–3:40 | **Break-fix: data race.** Remove the mutex, write a test that hits `POST` concurrently, run `go test -race`, read the report, put the fix back. | `break-fix/2026-10-26-data-race.md` follows the template. |
| 3:40–4:00 | If still open: billing access fix (sign in as root → Account → activate IAM user and role access to Billing) and read month-to-date spend. Write the 5-line interview note, commit, push. Nothing on AWS needs destroying today. | Everything is on `main` and the spend figure is in hand. |
| 4:00 | Check-in. The coach reviews the rate limiter answer with interviewer follow-ups. | |

### Rest of the week — proposed

| Day | Design 10:15–11:15 | Build | Break-fix 3:00–3:40 |
|---|---|---|---|
| Tue Oct 27 | Deep dive: Kubernetes requests vs. limits, OOMKilled vs. CPU throttling | Multi-stage Dockerfile, k3d cluster, Deployment with probes, k9s, `mise.toml` | CrashLoopBackOff on k3d, PIR |
| Wed Oct 28 | Classic #5: notification system | `/metrics` with `client_golang`, then Postgres on k3d behind a storage interface | Break the app→Postgres path (DNS or Service selector), debug from inside the pod, PIR |
| Thu Oct 29 | ADR-001: k3d over kind for local development | Tenant in every query, then GitHub Actions: test and build on PR | Terraform state lock (only S3), PIR |
| Fri Oct 30 | Untimed classic #16: URL shortener with analytics, follow-ups at the check-in. The first scored mock is proposed to move to Nov 6 or later; Nur decides | Catch-up morning, then the small Terraform fixes from the Oct 8 review | None |

Open for Nur: Giuseppe's Oct 20 feedback, days off or interviews next week, roadmap option A (slide two weeks) or B (slide one week and cut Mimir/Pyroscope, merge GitOps and security). The roadmap table below is unchanged until she decides.

## Restart — Tue Oct 20 (confirmed Oct 20)

Nur was sick Oct 15–19 and restarts today with the mentor session and the Forget It work.
Gentle restart, not a catch-up day. The rest of the week is planned after the session, using Giuseppe's feedback.

| Time | Block | Done when |
|---|---|---|
| 10:15–10:45 | **First move:** open `app/`, run `go run .` and `curl localhost:8080/healthz`, push whatever exists of `POST /items`. Then a quick look over the notes in Giuseppe's doc. | A commit on `main` before 10:45 |
| 10:45–11:30 | **1:1 with Giuseppe**: CV review, top questions, homework check-in | His feedback written into the shared doc |
| 1:15–3:00 | Finish `POST /items` and `GET /items/random` with an in-memory store, `sync.Mutex`, and tests (`httptest`) | `go test ./...` passes; a missing `X-Tenant-ID` returns 400 |
| 3:00–3:40 | Plan the rest of the week from his feedback, or start the Excalidraw diagram (60 min, rough is fine) | |
| 3:40 | Push, even if WIP | |

Homework items 1–4 (questions, Hootsuite stories, Rivian postmortem, five companies) were drafted early on Oct 20 and live in Giuseppe's Google Doc.

## Mentor homework — due Tue Oct 20, 10:45 (session with Giuseppe, 10:45–11:30)

Added Oct 16. Until the session, this section takes priority over the Week 1 tables below.
Giuseppe said not everything needs to be done; the order below is the order of value.
The Fri/Mon split is proposed; confirm or change it at today's check-in and weekly review.

Notes for Giuseppe (questions, stories, postmortem, targets, his feedback) live in a Google Doc Nur shares with him, not in this repo. The coach sessions can't read that doc, so the end-of-day update should say which items were added to it.

**Must have before the session**
1. Questions for Giuseppe, sent through async Q&A by end of Monday (one batched message). Draft list is in the Oct 16 chat; include: senior vs. other levels given 6.5 years at Intermediate 2, SRE vs. platform CV, how to start a blank design question, how to split a study week, when to start applying, and how he'd like async Q&A used (the plan says unlimited, he said within session time).
2. Proudest Hootsuite work, as notes for system design and behavioural stories.
3. Rivian postmortem: rounds reached, what came up, where it went wrong, what to do differently.
4. Five target companies: exact role link, level, interview rounds. Grafana, Elastic, and Wealthsimple postings are already known.
5. Excalidraw diagram of a web app you know well (WhatsApp, Netflix...), every component explainable. A rough version is fine; he will go through it in a session. This replaces the stalled 10M-users question for now.

**Should have**
6. SRE book Ch 1 and Ch 13 first, then Ch 2–3.
7. k3d (instead of kind, which was never set up), k9s, and a `mise.toml` with pinned tool versions; 30 minutes using k9s instead of kubectl.
8. `/metrics` Prometheus endpoint in the Go service (`client_golang`).

**Defer until after the session**
- fnox (no real secrets yet; AWS credentials are already short-lived).
- OpenSpec → OpenAPI (`design/api/openapi.yaml`, Redocly lint, oapi-codegen). Ask him how he uses it first.

**Proposed days**

| Day | 10:15–11:15 | 11:15–12:30 | 1:15–3:00 | 3:00–3:40 |
|---|---|---|---|---|
| Fri Oct 16 | Excalidraw diagram, 60 min, rough is fine | Hootsuite stories + Rivian postmortem | Finish `POST /items` and `GET /items/random` with tests (in progress since Wed) | `/metrics` endpoint |
| Mon Oct 19 | SRE book Ch 1 and Ch 13 | Five companies; finish and send the questions | Dockerfile, k3d cluster, healthz running on k3d, k9s, `mise.toml` | SRE Ch 2–3 skim, or diagram polish |
| Tue Oct 20 | 10:15–10:45 review notes; 10:45–11:30 session | | Act on his feedback; plan the rest of Week 2 | |

## Week 2 (Mon Oct 19 – Fri Oct 23) — past

Mon was a sick day; Tue was the restart around the mentor 1:1 (plan above). The Oct 16 draft plan was never confirmed.
Scorecard in `weekly/2026-W43.md`.

## Week 0 — Foundations (Wed Oct 7 – Fri Oct 9)

Goal: a safe AWS account, Terraform with remote state, and the first version of the app running on kind.

### Wed Oct 7 (Day 1) — done in part

Done: admin IAM user with MFA, Terraform skeleton for the S3 state bucket with state saved, a $5 budget with one alert.
Carried to Thursday: the system design question, the state-lock break-fix, and pushing the code.
Decided: one alert threshold on a $5 budget is enough for now. Raise the budget before the EKS week.

### Thu Oct 8 (Day 2) — done in part

Done: Day 1 leftovers. Account hardening finished, Terraform layout (`bootstrap`, `modules/budget`, `envs/dev`) merged to `main`, budget imported into Terraform, `terraform plan` clean.
Not done: the design question, the state-lock break-fix, the Go service.
Decided: the spending rule is $5 USD per month until the EKS week (see COACH.md).
Week 0's goal of running the app on kind moves to Week 1.

### Fri Oct 9 — day off

Nur took the day off (confirmed Oct 13). None of the plan below was done; it carries into Week 1.

Agreed with Nur on Oct 8: design gets more room, and the break-fix is left out of Friday to make that room.

| Time | Block | Done when |
|---|---|---|
| 10:15–12:30 | **System design, before opening Terraform.** Design Forget It as a product for 10 million users. Users capture short items (text or a link) from web and mobile, and the system resurfaces one random forgotten item per user per day. Cover requirements, estimates, API, data model, how "random but not recently shown" works at scale, and how the daily resurfacing job runs for 10M users. Untimed and unscored: this one is for learning the shape of an answer, not a mock. | `design/2026-10-09-forget-it-10m-users.md` is pushed with all 8 sections of `design/TEMPLATE.md` filled. |
| 1:15–3:00 | **Go service, local only.** `POST /items`, `GET /items/random`, `X-Tenant-ID` required, in-memory store, unit tests. No Docker and no kind. | `go test ./...` passes, and a request without the tenant header returns 400. |
| 3:00–3:40 | Fix billing access (sign in as root, Account settings, activate "IAM user and role access to Billing information"), read the month-to-date figure, write the 5-line interview explanation, commit, push. | Everything above is on `main` and the spend figure is in hand. |
| 3:45 | Check-in. The coach reviews the design answer with interviewer follow-ups. | |
| 4:00 | Weekly review and Week 1 plan. | |

No break-fix on Friday.

**Carried into Week 1 (Tue Oct 13 onward; Mon Oct 12 is a holiday). Order to be decided at Friday's weekly review:**
- State-lock break-fix with PIR. Use a throwaway folder with its own state key and a `time_sleep` resource so the apply is slow enough to collide and to kill; run two applies at once, kill one mid-run, find the `.tflock` object in S3, recover with `force-unlock`.
- Dockerfile, run the service on kind, and the CrashLoopBackOff break-fix.
- ADR-001 on how Terraform is organized (Thursday Oct 15 is the ADR day). Include where an account-wide budget belongs.
- No full mocks until around Fri Oct 30 (end of Week 3), decided with Nur on Oct 8. Until then Friday's design block is an untimed classic question with follow-ups at the check-in, no scores.
- Small Terraform fixes from the Oct 8 review (see PROGRESS.md).

## Week 1 (Tue Oct 13 – Fri Oct 16) — Tuesday confirmed, rest proposed

Proposed at the Oct 9 weekly review, before Nur replied. Nothing here is decided.
Coach sessions: confirm this with Nur before treating it as the plan, then replace the Week 0 section above with the agreed version.
The Week 0 scorecard is in `weekly/2026-W41.md` (draft).

Goal: the Go service runs on kind with Postgres, and the first design answers and the first PIRs are in the repo.

Two proposed changes to how the day runs:
- The design answer is pushed by 11:15, before any build work starts, whether or not it is complete.
- Build stops at 3:00 for the break-fix, even in the middle of a task.

### Tue Oct 13 (Day 3) — confirmed

Nur confirmed on Oct 13 that she starts today with this plan. Wed–Fri are still to be confirmed at today's check-in.

| Time | Block | Done when |
|---|---|---|
| 10:15–11:15 | **System design deep dive: Terraform state, locking, drift and blast radius.** What state is and why it is remote, how S3-native locking works and what a stale lock looks like, what drift is and how you find it, and how splitting state (bootstrap vs. envs) limits the damage of a bad apply. Use your own `infra/` as the example. | `design/2026-10-13-terraform-state.md` is pushed by 11:15, complete or not. |
| 11:15–12:30, 1:15–3:00 | **Go service, local only.** `POST /items`, `GET /items/random`, `X-Tenant-ID` required, in-memory store, unit tests. No Docker and no kind. If this was written on Friday, push it and start the Dockerfile instead. | `go test ./...` passes, and a request without the tenant header returns 400. |
| 3:00–3:40 | **Break-fix: state lock.** Throwaway folder with its own state key and a `time_sleep` resource; run two applies at once, kill one mid-run, find the `.tflock` object in S3, recover with `force-unlock`. | `break-fix/2026-10-13-terraform-state-lock.md` follows the template. |
| 3:40–4:00 | If still open: activate IAM access to billing (sign in as root, Account settings) and read month-to-date. Write the 5-line interview explanation, commit, push, destroy the throwaway resources. | Everything is on `main` and the spend figure is in hand. |
| 4:00 | Check-in. The coach reviews the deep dive with interviewer follow-ups. | |

### Rest of the week — superseded on Oct 16 by the mentor homework section above

| Day | System design | Build | Break-fix |
|---|---|---|---|
| Wed Oct 14 | Classic: Forget It for 10 million users. If written on Oct 9, #16 URL shortener with analytics. | Dockerfile, kind cluster, Deployment and Service with probes | CrashLoopBackOff, with PIR |
| Thu Oct 15 | ADR-001: how Terraform is organized, including where an account-wide budget belongs | Postgres on kind, storage behind an interface, tenant in every query | Networking: break the app's path to Postgres (DNS or Service selector), debug from inside the pod, with PIR |
| Fri Oct 16 | Untimed classic, no scores: #2 multi-tenant rate limiter, follow-ups at the check-in | Morning catch-up (including the small Terraform fixes from the Oct 8 review), then GitHub Actions running tests and build on a PR | None, or a missed PIR |

Proposed move: the Helm chart, pushing to GHCR, and `terraform plan` on PRs go from Week 1 to the start of Week 2, ahead of Kafka.
The roadmap table below is unchanged until Nur agrees. Whether the whole roadmap slides a week is a question for the Oct 16 review.

## Roadmap (rough, re-planned every Friday)

| Week | Dates | Focus |
|---|---|---|
| 0 | Oct 7–9 | Foundations: AWS hardening, budget, Terraform state, Go skeleton on kind |
| 1 | Oct 13–16 | Postgres, Helm chart, GitHub Actions (test, build, push to GHCR, `terraform plan` on PR), Linux/networking break-fix |
| 2 | Oct 19–23 | Kafka (Strimzi on kind): async capture, idempotent consumer, retries, dead-letter topic. Python tooling starts (AWS "janitor" script) |
| 3 | Oct 26–30 | Observability: OpenTelemetry in Go, Prometheus, Grafana, Loki, Tempo, Alloy |
| 4 | Nov 2–6 | SLOs: per-tenant SLIs, burn-rate alerts, runbooks, k6 load and noisy-neighbour tests, Mimir |
| 5 | Nov 9–13 | GitOps and security: Argo CD, Kyverno, External Secrets/Vault, image scanning |
| 6 | Nov 16–20 | EKS: Terraform module, IRSA, load balancer, autoscaling, Pyroscope. Created and destroyed daily |
| 7 | Nov 23–27 | AI: pattern-finding over the basket, alert-triage agent, PIR drafting, AI-assisted deploy steps |
| 8 | Nov 30–Dec 4 | Golden path capstone (one command creates a new service with chart, CI, Argo app, dashboards, SLOs), then mock interviews |

## Backlog (not scheduled)

- Jenkins (only if a posting asks for it)
- ECS
- Elastic stack via ECK (one day, if an Elastic interview gets scheduled)
- Jsonnet / Tanka (Grafana's house style)
- Ansible, Teleport
- Spoken system design sessions (in a few weeks, outside the library)
