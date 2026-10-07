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

### Thu Oct 8 (Day 2) — confirmed

**System design (10:15–11:15), classic question (carried from Day 1):**
Design Forget It as a product for 10 million users.
Users capture short items (text or a link) from web and mobile, and the system resurfaces one random forgotten item per user per day.
Cover: requirements, estimates, API, data model, how "random but not recently shown" works at scale, and how the daily resurfacing job runs for 10M users.
Write it in `design/2026-10-08-forget-it-10m-users.md` using `design/TEMPLATE.md`.

**Morning build — finish Day 1:**
1. Confirm the Terraform code is in the repo (Nur planned to push it Wednesday night). If it isn't, push it first.
2. Quick checks, fix anything missing: root account has MFA and no access keys; the state bucket has versioning, encryption, and public access blocked; `infra/bootstrap/` holds the state bucket and `infra/envs/dev/` is ready for what comes next.
3. If the budget was made in the console, bring it into Terraform.

**Break it and fix it (do it right after the morning build, while Terraform is fresh):**
Run two `terraform apply` commands at once and watch the lock. Then simulate a stale lock (kill an apply mid-run) and recover safely. Write the PIR in `break-fix/`.

**Afternoon build — start the Go service:**
`POST /items`, `GET /items/random`, `X-Tenant-ID` required, in-memory store, unit tests.

**Done when:** the design file, the Terraform code, and the PIR are pushed; `terraform plan` is clean; the Go service runs locally with passing tests; nothing billable is left running.

### Fri Oct 9 — tentative

- Morning catch-up: Dockerfile, run the service on kind, and the CrashLoopBackOff break-fix.
- Design: ADR-001 on how Terraform is organized (moved from Thursday), or the first mock interview (multi-tenant rate limiter). Decide at Thursday's check-in.
- 3:45 check-in, 4:00 weekly review and plan Week 1.

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
