# System design question bank

Skewed toward the target postings: observability, multi-tenant infrastructure, platform, streaming.
Mark a question with the date when it's used. Add new ones freely.

## Classic questions (Mon / Wed)

| # | Question | Why it matters | Used |
|---|---|---|---|
| 1 | Design Forget It for 10M users (capture + daily random resurfacing) | Warm-up; shapes our own app | 2026-10-07 |
| 2 | Multi-tenant rate limiter for a public API | Noisy neighbours, per-tenant limits (Grafana) | |
| 3 | Metrics ingestion pipeline (Prometheus remote-write at millions of samples/sec) | This is Mimir (Grafana) | |
| 4 | Log aggregation and search system | Loki vs. Elasticsearch tradeoffs (Grafana, Elastic) | |
| 5 | Notification system (email, push, in-app) with retries and preferences | Classic; also Forget It's resurfacing | |
| 6 | Distributed job scheduler (cron at scale) | Platform staple | |
| 7 | CI/CD platform for 500 engineers | Platform as a product (Wealthsimple) | |
| 8 | Alerting system that evaluates rules over metrics and pages on-call | SLO/alerting depth (Grafana, Elastic) | |
| 9 | Distributed tracing backend | Tempo; sampling, storage | |
| 10 | Feature flag service | Low latency reads, consistency, safe rollout | |
| 11 | Multi-region active-active key-value store | Replication, consistency, failover | |
| 12 | Uptime / synthetic monitoring service | Global probes, SLA measurement | |
| 13 | Internal developer platform: "create a new service" golden path | Wealthsimple, our capstone | |
| 14 | Secrets management service | Security mindset (Elastic) | |
| 15 | Event-driven pipeline with exactly-once-ish processing via Kafka | Streaming depth (Wealthsimple, our app) | |
| 16 | URL shortener with analytics | Classic warm-up; caching and hot keys | |

## Deep-dive topics (Tue)

Picked to match the week's build layer.

- Terraform state, locking, drift, and blast radius
- Kubernetes scheduling, requests vs. limits, OOMKilled vs. CPU throttling
- Linux: processes, file descriptors, memory, what happens on `curl` (DNS, TCP, TLS)
- Kafka: partitions, ordering, consumer groups, rebalancing, delivery guarantees
- Metrics cardinality: why it kills TSDBs and how to control it
- SLIs, SLOs, error budgets, multi-window burn-rate alerts
- Load testing: open vs. closed models, coordinated omission
- GitOps: reconciliation loops, drift, rollbacks
- IAM on Kubernetes: IRSA / pod identity, least privilege
- Consistent hashing and sharding (how Mimir and Loki distribute data)
- Caching strategies and cache stampedes
- Backpressure, retries, timeouts, circuit breakers

## Mock interviews (Fri)

Drawn from the classic list, played live with interruptions and changing requirements.
Scored with the rubric in `COACH.md`.

| Date | Question | Scores |
|---|---|---|
