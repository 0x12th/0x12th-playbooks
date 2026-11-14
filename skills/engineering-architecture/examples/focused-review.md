# Example: Focused Review

Prompt:

```text
Review the worker queue architecture for reliability, observability, and performance bottlenecks. Keep the review focused.
```

Example output:

```md
## Verdict

Keep the current worker architecture while checking its effective retry and capacity policies. Readiness for higher load is not established by the supplied code and documentation alone.

## Scope and evidence

Scope: worker queue path — producers, worker loop, retry handling, queue configuration, deployment settings, and tests.

## Local architecture model

Requests enqueue jobs through the API layer. Workers consume jobs in batches, call an external dependency, update local state, and retry failed jobs. Queue ownership is not explicit from the available evidence.

## Findings

### 1. Effective retry limits are unverified

Severity: High
Confidence: Low; queue and broker policy were not supplied.

Evidence gap: The provided worker code does not establish the effective retry limit or failure routing. These may be configured by the queue or broker.

Conditional impact: If a retry path is unbounded, a persistent dependency failure can create retry storms, queue growth, and delayed processing for healthy jobs.

Minimal action: Inspect the effective worker and broker policies. Propose changes only for confirmed gaps, preserving the operation's accepted retry and failure contract.

Validation signal: A controlled failure check demonstrates the configured attempt limit and terminal failure handling.

Disposition: Defer pending evidence.

Expected benefit: Establish whether a reliability change is needed before adding duplicate retry or dead-letter mechanisms.

### 2. Queue capacity limits are not documented

Severity: Medium
Confidence: Low; effective limits and workload have not been verified.

Evidence gap: The available documentation does not relate worker concurrency, queue depth limits, and dependency rate limits; their effective values remain unknown.

Conditional impact: If those limits are mismatched, scaling workers may increase dependency failures or database contention instead of improving throughput.

Minimal action: Compare effective limits with the expected workload and existing queue-age signals. Recommend a bounded load check only if this leaves a material uncertainty before increasing concurrency.

Validation signal: The planned concurrency fits verified dependency limits and the observed or safely tested queue-age target.

Disposition: Next safe step.

Expected benefit: Safer scaling decisions and fewer performance regressions.
Evolution cost: Assess after confirming the gap; existing configuration or monitoring may already suffice.
```
