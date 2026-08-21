# REVIEW_QUEUE — Lịch ôn (spaced repetition)

> Bậc → khoảng cách ôn: **1** = +1 ngày · **2** = +3 · **3** = +7 · **4** = +16 · **5** = +35
> Đúng khi ôn → lên bậc kế, tính lại `next_review`. Sai → tụt về bậc 1, `next_review` = mai, `sai` +1.
> Từ đạt bậc 5 và đúng → coi như đã thuộc, chuyển xuống mục **Đã thuộc** ở cuối file.

**⚠️ Tới hạn / quá hạn tính tới 2026-08-21: 35 từ** — toàn bộ vốn từ trừ lô học hôm nay:

- hạn 2026-08-14 — deprecate · workaround · clarify · follow up · come across
- hạn 2026-08-15 — edge case · bottleneck · escalate · deliverable · run out of
- hạn 2026-08-16 — rollback · flaky · reach out · scope creep · get the hang of
- hạn 2026-08-18 — throttle · regression · heads-up · ballpark · keep an eye on
- hạn 2026-08-19 — boilerplate · stale · walk through · sign off · end up
- hạn 2026-08-20 — race condition · idempotent · push back · caveat · awkward
- hạn 2026-08-21 — technical debt · backward compatible · loop in · bandwidth · catch up

_Lý do đọng lại: `/on-tap` và `/kiem-tra` cần user trả lời mới chấm và lên/xuống bậc được — routine tự động chạy 7h sáng không làm thay được. Các lô 08-16, 08-18, 08-19 và 08-20 đã được ôn nhanh ở đầu buổi #4 / #5 / #6 / #7 nhưng chưa chấm nên vẫn giữ bậc 1. Số từ đọng đã gấp rưỡi `review.maxPerSession` (15) — gõ `/on-tap` sớm, ưu tiên lô cũ nhất trước._

**Tới hạn hôm nay (2026-08-21): 5 từ** — technical debt · backward compatible · loop in · bandwidth · catch up (đã ôn nhanh đầu buổi #8, chưa chấm nên vẫn bậc 1)

**Tới hạn ngày mai (2026-08-22): 5 từ** — feature flag · breaking change · stakeholder · align · out of the blue

| Word | Bậc | next_review | Số lần đúng | Số lần sai | Học từ |
| ---- | --- | ----------- | ----------- | ---------- | ------ |
| deprecate | 1 | 2026-08-14 | 0 | 0 | 2026-08-13 |
| workaround | 1 | 2026-08-14 | 0 | 0 | 2026-08-13 |
| clarify | 1 | 2026-08-14 | 0 | 0 | 2026-08-13 |
| follow up | 1 | 2026-08-14 | 0 | 0 | 2026-08-13 |
| come across | 1 | 2026-08-14 | 0 | 0 | 2026-08-13 |
| edge case | 1 | 2026-08-15 | 0 | 0 | 2026-08-14 |
| bottleneck | 1 | 2026-08-15 | 0 | 0 | 2026-08-14 |
| escalate | 1 | 2026-08-15 | 0 | 0 | 2026-08-14 |
| deliverable | 1 | 2026-08-15 | 0 | 0 | 2026-08-14 |
| run out of | 1 | 2026-08-15 | 0 | 0 | 2026-08-14 |
| rollback | 1 | 2026-08-16 | 0 | 0 | 2026-08-15 |
| flaky | 1 | 2026-08-16 | 0 | 0 | 2026-08-15 |
| reach out | 1 | 2026-08-16 | 0 | 0 | 2026-08-15 |
| scope creep | 1 | 2026-08-16 | 0 | 0 | 2026-08-15 |
| get the hang of | 1 | 2026-08-16 | 0 | 0 | 2026-08-15 |
| throttle | 1 | 2026-08-18 | 0 | 0 | 2026-08-17 |
| regression | 1 | 2026-08-18 | 0 | 0 | 2026-08-17 |
| heads-up | 1 | 2026-08-18 | 0 | 0 | 2026-08-17 |
| ballpark | 1 | 2026-08-18 | 0 | 0 | 2026-08-17 |
| keep an eye on | 1 | 2026-08-18 | 0 | 0 | 2026-08-17 |
| boilerplate | 1 | 2026-08-19 | 0 | 0 | 2026-08-18 |
| stale | 1 | 2026-08-19 | 0 | 0 | 2026-08-18 |
| walk through | 1 | 2026-08-19 | 0 | 0 | 2026-08-18 |
| sign off | 1 | 2026-08-19 | 0 | 0 | 2026-08-18 |
| end up | 1 | 2026-08-19 | 0 | 0 | 2026-08-18 |
| race condition | 1 | 2026-08-20 | 0 | 0 | 2026-08-19 |
| idempotent | 1 | 2026-08-20 | 0 | 0 | 2026-08-19 |
| push back | 1 | 2026-08-20 | 0 | 0 | 2026-08-19 |
| caveat | 1 | 2026-08-20 | 0 | 0 | 2026-08-19 |
| awkward | 1 | 2026-08-20 | 0 | 0 | 2026-08-19 |
| technical debt | 1 | 2026-08-21 | 0 | 0 | 2026-08-20 |
| backward compatible | 1 | 2026-08-21 | 0 | 0 | 2026-08-20 |
| loop in | 1 | 2026-08-21 | 0 | 0 | 2026-08-20 |
| bandwidth | 1 | 2026-08-21 | 0 | 0 | 2026-08-20 |
| catch up | 1 | 2026-08-21 | 0 | 0 | 2026-08-20 |
| feature flag | 1 | 2026-08-22 | 0 | 0 | 2026-08-21 |
| breaking change | 1 | 2026-08-22 | 0 | 0 | 2026-08-21 |
| stakeholder | 1 | 2026-08-22 | 0 | 0 | 2026-08-21 |
| align | 1 | 2026-08-22 | 0 | 0 | 2026-08-21 |
| out of the blue | 1 | 2026-08-22 | 0 | 0 | 2026-08-21 |

## Đã thuộc (bậc 5, đúng)

_(chưa có)_
