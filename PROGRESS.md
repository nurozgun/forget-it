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
  - Pushed on branch `FI-1` and merged to `main` through PR #1.
- Not done: everything planned for Thursday in PLAN.md (the 10M-users design question, the state-lock break-fix with its PIR, starting the Go service). Two study days in, there is no design answer and no PIR yet.
- Blocked: the billing console shows "Access denied" for month-to-date cost when signed in as `nur-admin`. Fix on Friday: sign in as root, Account settings, activate "IAM user and role access to Billing information".
- Decisions:
  - IAM user instead of IAM Identity Center, because creating an AWS Organization ends the Free Plan and expires the credits. Revisit when moving to the paid plan.
  - The spending rule is $5 USD per month until the EKS week (the account bills in USD). COACH.md is updated; it said 80 CAD before.
  - No full mock interviews until around the end of Week 3 (Fri Oct 30). Until then Friday's design block is an untimed question with follow-ups and no scores.
- Learned: `aws login` sessions are not read by the Terraform AWS provider, so export credentials first with `eval "$(aws configure export-credentials --profile admin --format env)"`. Backend vs state, why bootstrap is a separate folder, module versioning, SCPs vs permission boundaries.
- Break-fix: none yet.
- AWS spend month-to-date: not known (billing access denied, see Blocked). Nur reports that everything running is free: only the state bucket and the budget exist.
- Coach review of `infra/` (read only, not run). Good: bootstrap split, bucket settings and `prevent_destroy`, lock files committed, tfvars ignored with an example, branch and PR. To revisit, none urgent:
  - Budget alerts are `ACTUAL` only; add a `FORECASTED` alert at 100%.
  - `bucket_key_enabled = true` has no effect with AES256 (bucket keys are for SSE-KMS). Be ready to explain SSE-S3 vs KMS.
  - The budget is account-wide but lives in `envs/dev` with an `Environment = dev` tag. Material for ADR-001.
  - The budget module wraps one resource. Have an answer for "why is this a module?"
  - Smaller: no bucket policy denying non-TLS access, no lifecycle rule for old state versions, tags repeated by hand instead of provider `default_tags`.
- Tomorrow: a long design block (the 10M-users question, 10:15–12:30, untimed), then the Go service running locally with tests. The state-lock break-fix moves to Week 1 so design gets the room. See PLAN.md.

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
