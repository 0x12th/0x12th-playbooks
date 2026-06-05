# Example: Focused Review

Prompt:

```text
Review the worker queue architecture for reliability, observability, and performance bottlenecks. Keep the review focused.
```

Example output:

```md
## Scope and evidence

Scope: worker queue path — producers, worker loop, retry handling, queue configuration, deployment settings, and tests.

## Local architecture model

Requests enqueue jobs through the API layer. Workers consume jobs in batches, call an external dependency, update local state, and retry failed jobs. Queue ownership is not explicit from the available evidence.

## Findings

### 1. Retries are not clearly bounded

Severity: High

Problem: Failed jobs can be retried without a visible max-attempt policy or dead-letter handling.

Impact: A persistent dependency failure can create retry storms, queue growth, and delayed processing for healthy jobs.

Root cause: Retry behavior is embedded in worker control flow rather than defined as an explicit reliability policy.

Proposed solution: Add max attempts, exponential backoff with jitter, dead-letter routing, and metrics for retry count and dead-letter volume.

Complexity: Medium
Risk: Medium
Expected benefit: Lower blast radius during dependency incidents and faster diagnosis.
Evolution cost: Small operational increase for new metrics and alerts; lower long-term maintenance cost because failure behavior becomes explicit.

### 2. Queue capacity limits are not documented

Severity: Medium

Problem: Worker concurrency, queue depth limits, and dependency rate limits are not tied together.

Impact: Scaling workers may increase dependency failures or database contention instead of improving throughput.

Root cause: Capacity planning is implicit in configuration rather than modeled as part of the queue architecture.

Proposed solution: Document throughput assumptions, add queue-age metrics, and run a small load test before increasing concurrency.

Complexity: Small
Risk: Low
Expected benefit: Safer scaling decisions and fewer performance regressions.
Evolution cost: Low; mostly documentation, metrics, and validation.
```
