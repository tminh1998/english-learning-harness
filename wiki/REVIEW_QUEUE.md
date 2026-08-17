# REVIEW_QUEUE — Lịch ôn (spaced repetition)

> Bậc → khoảng cách ôn: **1** = +1 ngày · **2** = +3 · **3** = +7 · **4** = +16 · **5** = +35
> Đúng khi ôn → lên bậc kế, tính lại `next_review`. Sai → tụt về bậc 1, `next_review` = mai, `sai` +1.
> Từ đạt bậc 5 và đúng → coi như đã thuộc, chuyển xuống mục **Đã thuộc** ở cuối file.

**⚠️ Quá hạn tính tới 2026-08-17: 15 từ** — toàn bộ vốn từ của tuần W33, cả ba lô:

- hạn 2026-08-14 — deprecate · workaround · clarify · follow up · come across
- hạn 2026-08-15 — edge case · bottleneck · escalate · deliverable · run out of
- hạn 2026-08-16 — rollback · flaky · reach out · scope creep · get the hang of

_Lý do đọng lại: `/on-tap` và `/kiem-tra` cần user trả lời mới chấm và lên/xuống bậc được — routine tự động chạy 7h sáng không làm thay được. Lô 08-16 đã được ôn nhanh ở đầu buổi #4 nhưng chưa chấm nên vẫn giữ bậc 1. Gõ `/on-tap` để giải quyết cả 15 từ (config `review.maxPerSession` = 15, vừa đủ một buổi)._

**Tới hạn ngày mai (2026-08-18): 5 từ** — throttle · regression · heads-up · ballpark · keep an eye on

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

## Đã thuộc (bậc 5, đúng)

_(chưa có)_
