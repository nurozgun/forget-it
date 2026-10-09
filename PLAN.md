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

### Fri Oct 9 (Day 3) — confirmed

Agreed with Nur on Oct 8: design gets more room, and the break-fix is left out of Friday to make that room.

| Time | Block | Done when |
|---|---|---|
| 10:15–12:30 | **System design, before opening Terraform.** Design Forget It as a product for 10 million users. Users capture short items (text or a link) from web and mobile, and the system resurfaces one random forgotten item per user per day. Cover requirements, estimates, API, data model, how "random but not recently shown" works at scale, and how the daily resurfacing job runs for 10M users. Untimed: this one is for learning the shape of an answer, not a mock. | `design/2026-10-09-forget-it-10m-users.md` is pushed with all 8 sections of `design/TEMPLATE.md` filled. |
| 1:15–3:00 | **Go service, local only.** `POST /items`, `GET /items/random`, `X-Tenant-ID` required, in-memory store, unit tests. No Docker and no kind. | `go test ./...` passes, and a request without the tenant header returns 400. |
| 3:00–3:40 | Fix billing access (sign in as root, Account settings, activate "IAM user and role access to Billing information"), read the month-to-date figure, write the 5-line interview explanation, commit, push. | Everything above is on `main` and the spend figure is in hand. |
| 3:45 | Check-in. The coach reviews the design answer with interviewer follow-ups. | |
| 4:00 | Weekly review and Week 1 plan. | |

No break-fix on Friday.

**Carried into Week 1 (Tue Oct 13 onward; Mon Oct 12 is a holiday). Order to be decided at Friday's weekly review:**
- State-lock break-fix with PIR. Use a throwaway folder with its own state key and a `time_sleep` resource so the apply is slow enough to collide and to kill; run two applies at once, kill one mid-run, find the `.tflock` object in S3, recover with `force-unlock`.
- Dockerfile, run the service on kind, and the CrashLoopBackOff break-fix.
- ADR-001 on how Terraform is organized (Thursday Oct 15 is the ADR day). Include where an account-wide budget belongs.
- First timed mock interview (multi-tenant rate limiter), Friday Oct 16.
- Small Terraform fixes from the Oct 8 review (see PROGRESS.md).

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
