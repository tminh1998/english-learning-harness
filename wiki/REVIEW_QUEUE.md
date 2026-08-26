# REVIEW_QUEUE — Lịch ôn (spaced repetition)

> Bậc → khoảng cách ôn: **1** = +1 ngày · **2** = +3 · **3** = +7 · **4** = +16 · **5** = +35
> Đúng khi ôn → lên bậc kế, tính lại `next_review`. Sai → tụt về bậc 1, `next_review` = mai, `sai` +1.
> Từ đạt bậc 5 và đúng → coi như đã thuộc, chuyển xuống mục **Đã thuộc** ở cuối file.

**⚠️ Tới hạn / quá hạn tính tới 2026-08-26: 55 từ** — toàn bộ vốn từ trừ lô học hôm nay:

- hạn 2026-08-14 — deprecate · workaround · clarify · follow up · come across
- hạn 2026-08-15 — edge case · bottleneck · escalate · deliverable · run out of
- hạn 2026-08-16 — rollback · flaky · reach out · scope creep · get the hang of
- hạn 2026-08-18 — throttle · regression · heads-up · ballpark · keep an eye on
- hạn 2026-08-19 — boilerplate · stale · walk through · sign off · end up
- hạn 2026-08-20 — race condition · idempotent · push back · caveat · awkward
- hạn 2026-08-21 — technical debt · backward compatible · loop in · bandwidth · catch up
- hạn 2026-08-22 — feature flag · breaking change · stakeholder · align · out of the blue
- hạn 2026-08-23 — fallback · brittle · bring up · turnaround · sort out
- hạn 2026-08-25 — cutover · backfill · prioritize · trade-off · put off
- hạn 2026-08-26 — stateless · verbose · on track · tentative · fed up

_Lý do đọng lại: `/on-tap` và `/kiem-tra` cần user trả lời mới chấm và lên/xuống bậc được — routine tự động chạy 7h sáng không làm thay được. Khối "Ôn nhanh đầu giờ" trên trang bài học **không** đổi bậc ở đây (hỏi-tự-trả-lời), nó chỉ giữ cho từ khỏi rơi khỏi tầm ngắm. Muốn thật sự xoá nợ thì phải gõ tay `/on-tap`, ưu tiên lô cũ nhất trước._

**⚙️ Đổi luật 2026-08-26 — khối "Ôn nhanh đầu giờ" của `/hoc`:** từ **8 từ / lô hạn cũ nhất** → **15 từ**, chia cố định: **5 từ của buổi liền trước** + **10 từ bốc ngẫu nhiên** trong toàn bộ `VOCAB_INDEX.md` (bốc bằng lệnh `awk+rand`, không bốc bằng mắt). Quét theo lô làm lô cũ bị hỏi lặp còn lô vừa học xong cả tuần không được đụng tới; bốc ngẫu nhiên thì mọi từ đều có cơ hội quay lại. Luật đầy đủ: R9 trong `AGENTS.md`. Harness cũng **bỏ hẳn phần ngữ pháp** kể từ ngày này.

**Tới hạn hôm nay (2026-08-26): 5 từ** — stateless · verbose · on track · tentative · fed up

**Tới hạn ngày mai (2026-08-27): 5 từ** — spin up · truncate · touch base · accommodate · drop by

_Ghi chú 2026-08-26: bài buổi #12 đã được **soạn lại theo luật R9 mới** — khối "Ôn nhanh đầu giờ" giờ là **15 từ**: phần A là 5 từ của buổi 25/08 (stateless · verbose · on track · tentative · fed up), phần B là 10 từ bốc ngẫu nhiên bằng lệnh trong cả 60 từ (bring up · caveat · brittle · prioritize · regression · sign off · stakeholder · clarify · trade-off · keep an eye on). Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc** — muốn đổi bậc phải gõ `/on-tap`._

_Ghi chú 2026-08-25: buổi #11 hỏi 8 từ ở khối "Ôn nhanh đầu giờ", **đi tiếp** lô cũ nhất còn nợ thay vì hỏi lại đúng 8 từ của buổi #10 (deliverable · run out of · rollback · flaky · reach out · scope creep · get the hang of · throttle). Lý do: routine tự động không chấm được nên không từ nào lên bậc — cứ hỏi lại y hệt một lô thì 42 từ còn lại không bao giờ được đụng tới. Sau buổi này khối ôn nhanh đã quét hết lô 14/08, 15/08, 16/08 và chạm lô 18/08._

_Ghi chú 2026-08-24: người học báo đã biết sẵn `hotfix`, `overwrite`, `cherry-pick` → ba từ đó **không** vào lịch ôn, chuyển sang bảng **Đã biết sẵn** cuối `VOCAB_INDEX.md` (luật R1.b chặn vĩnh viễn). Hai suất IT của buổi thay bằng `cutover` và `backfill`._

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
| fallback | 1 | 2026-08-23 | 0 | 0 | 2026-08-22 |
| brittle | 1 | 2026-08-23 | 0 | 0 | 2026-08-22 |
| bring up | 1 | 2026-08-23 | 0 | 0 | 2026-08-22 |
| turnaround | 1 | 2026-08-23 | 0 | 0 | 2026-08-22 |
| sort out | 1 | 2026-08-23 | 0 | 0 | 2026-08-22 |
| cutover | 1 | 2026-08-25 | 0 | 0 | 2026-08-24 |
| backfill | 1 | 2026-08-25 | 0 | 0 | 2026-08-24 |
| prioritize | 1 | 2026-08-25 | 0 | 0 | 2026-08-24 |
| trade-off | 1 | 2026-08-25 | 0 | 0 | 2026-08-24 |
| put off | 1 | 2026-08-25 | 0 | 0 | 2026-08-24 |
| stateless | 1 | 2026-08-26 | 0 | 0 | 2026-08-25 |
| verbose | 1 | 2026-08-26 | 0 | 0 | 2026-08-25 |
| on track | 1 | 2026-08-26 | 0 | 0 | 2026-08-25 |
| tentative | 1 | 2026-08-26 | 0 | 0 | 2026-08-25 |
| fed up | 1 | 2026-08-26 | 0 | 0 | 2026-08-25 |
| spin up | 1 | 2026-08-27 | 0 | 0 | 2026-08-26 |
| truncate | 1 | 2026-08-27 | 0 | 0 | 2026-08-26 |
| touch base | 1 | 2026-08-27 | 0 | 0 | 2026-08-26 |
| accommodate | 1 | 2026-08-27 | 0 | 0 | 2026-08-26 |
| drop by | 1 | 2026-08-27 | 0 | 0 | 2026-08-26 |

## Đã thuộc (bậc 5, đúng)

_(chưa có)_
