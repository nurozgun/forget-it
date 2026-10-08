# Progress

Newest entry first. One entry per study day, written at the end-of-day check-in.

Format:

```
## YYYY-MM-DD (Day N)
- Done:
- Blocked:
- Learned:
- Break-fix:
- AWS spend month-to-date:
- Tomorrow:
```

<!-- entries below -->

## 2026-10-08 (Day 2)
- Done (all of it Day 1 leftovers):
  - Account hardening finished: root MFA on, no root access keys, admin IAM user `nur-admin` with MFA, CLI profile `admin` via `aws login` (short-lived credentials). The old `terraform-local` access key is deleted.
  - Terraform layout: `infra/bootstrap/`, `infra/modules/budget/`, `infra/envs/dev/`.
  - State bucket `nurozgun-forget-it-tfstate` (versioning, AES256 encryption, public access blocked) with S3-native locking (`use_lockfile`). Bootstrap and dev state both live in it.
  - Budget `nur-budget` ($5 USD/month) is now in Terraform (imported, alerts added at 50%, 80% and 100%). `terraform plan` is clean.
  - Pushed to branch `FI-1`.
- Not done: everything planned for Day 2 (ADR-001 on Terraform organization, Go service skeleton on kind, CrashLoopBackOff break-fix). Also still open from Day 1: the system design question and the state-lock break-fix with its PIR (the break-fix is planned for Friday).
- Blocked: nothing.
- Decisions: IAM user instead of IAM Identity Center, because creating an AWS Organization ends the Free Plan and expires the credits. Revisit when moving to the paid plan. Budget limit is $5 USD (the account bills in USD), not the 80 CAD in PLAN.md.
- Learned: `aws login` sessions are not read by the Terraform AWS provider, so export credentials first with `eval "$(aws configure export-credentials --profile admin --format env)"`. Backend vs state, why bootstrap is a separate folder, module versioning, SCPs vs permission boundaries.
- Break-fix: none yet.
- AWS spend month-to-date: not reported.
- Tomorrow: state-lock break-fix with PIR, then the Day 1 design question, then the Day 2 items that slipped (ADR-001, Go skeleton on kind). The Day 2 plan did not start, so Friday's catch-up window is full and PLAN.md should be re-planned at the weekly review.

## 2026-10-07 (Day 1)
- Done: Admin IAM user with MFA. Terraform skeleton for the S3 state bucket, with state saved. AWS budget of $5 with one alert (kept at one threshold for now).
- Not done: system design question (Forget It for 10M users) and the Terraform state-lock break-fix with its PIR. Both carried to Thursday.
- Not pushed yet: Terraform code. Nur plans to push it tonight.
- Blocked: nothing.
- Note: part of the day went to thinking about the app as a product (monetization, naming, domains, competitors), which is outside study scope.
- Still open: root account MFA and access keys, bucket settings, whether the budget is in Terraform.
- AWS spend month-to-date: not reported.
- Tomorrow: Day 1 design question, finish Day 1 leftovers, state-lock break-fix, start the Go service. See PLAN.md.

## 2026-10-06 (Day 0)
- Done: Agreed the plan, the app (Forget It), the schedule, and the repo layout.
- Tomorrow: Day 1 as written in PLAN.md.
