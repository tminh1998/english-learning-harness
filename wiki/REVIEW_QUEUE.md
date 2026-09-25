# REVIEW_QUEUE — Lịch ôn (spaced repetition)

> Bậc → khoảng cách ôn: **1** = +1 ngày · **2** = +3 · **3** = +7 · **4** = +16 · **5** = +35
> Đúng khi ôn → lên bậc kế, tính lại `next_review`. Sai → tụt về bậc 1, `next_review` = mai, `sai` +1.
> Từ đạt bậc 5 và đúng → coi như đã thuộc, chuyển xuống mục **Đã thuộc** ở cuối file.

**⚠️ Tới hạn / quá hạn tính tới 2026-09-25: 170 từ** — toàn bộ vốn từ trừ lô học hôm nay:

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
- hạn 2026-08-27 — spin up · truncate · touch base · accommodate · drop by
- hạn 2026-08-28 — deadlock · throughput · milestone · buy-in · chip in
- hạn 2026-08-29 — backpressure · cold start · pain point · takeaway · hassle
- hạn 2026-08-30 — granular · sanity check · circle back · feasible · drag on
- hạn 2026-09-01 — immutable · overhead · wrap up · leeway · sleep in
- hạn 2026-09-02 — failover · graceful degradation · nail down · outstanding · spare
- hạn 2026-09-03 — culprit · spike · defer · ramp up · worn out
- hạn 2026-09-04 — backport · smoke test · iron out · action item · grab a bite
- hạn 2026-09-05 — canary release · downstream · recap · bear with · under the weather
- hạn 2026-09-06 — latency · stub · onboarding · pencil in · run errands
- hạn 2026-09-08 — propagate · resilient · weigh in · discrepancy · doze off
- hạn 2026-09-09 — provision · bump · run by · short notice · put up with
- hạn 2026-09-10 — dry run · snapshot · narrow down · lead time · hit it off
- hạn 2026-09-11 — drift · purge · hand over · chase up · stay up
- hạn 2026-09-12 — backoff · blast radius · sticking point · pitch · swamped
- hạn 2026-09-16 — heartbeat · dangling · quote · off the table · night owl
- hạn 2026-09-17 — ingest · quarantine · hash out · manage expectations · rain check
- hạn 2026-09-18 — single point of failure · load shedding · loose ends · on the same page · commute
- hạn 2026-09-19 — postmortem · runbook · due diligence · buffer · rush hour
- hạn 2026-09-22 — drain · fan-out · carve out · ground rules · settle in
- hạn 2026-09-23 — shard · contention · contingency · scale back · show up
- hạn 2026-09-24 — saturation · skew · on the fence · waive · binge-watch
- hạn 2026-09-25 — eviction · cardinality · concession · draw the line · splurge

_Ghi chú 2026-09-25 (buổi #35): phần A hỏi lại 5 từ của buổi 24/09 (eviction · cardinality · concession · draw the line · splurge), phần B bốc ngẫu nhiên bằng lệnh trúng outstanding · provision · sleep in · dangling · drag on · sanity check · run out of · ingest · propagate · onboarding · downstream · under the weather · circle back · accommodate · hash out · feature flag · sticking point · sort out · catch up · discrepancy — chạm cả lô cũ nhất (13/08) lẫn lô 23/09. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **170/175 từ**, toàn bộ ở bậc 1._

_Ghi chú 2026-09-24 (buổi #34): phần A hỏi lại 5 từ của buổi 23/09 (saturation · skew · on the fence · waive · binge-watch), phần B bốc ngẫu nhiên bằng lệnh trúng quote · fed up · resilient · put off · purge · breaking change · manage expectations · culprit · stateless · graceful degradation · off the table · downstream · dangling · immutable · contention · buffer · on track · backpressure · turnaround · hash out — chạm cả lô cũ nhất (13/08) lẫn lô 22/09. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **165/170 từ**, toàn bộ ở bậc 1._

_Ghi chú 2026-09-23 (buổi #33): phần A hỏi lại 5 từ của buổi 22/09 (shard · contention · contingency · scale back · show up), phần B bốc ngẫu nhiên bằng lệnh trúng spike · drag on · pain point · run errands · escalate · verbose · deliverable · drain · pencil in · hand over · backport · boilerplate · sign off · leeway · stay up · follow up · rush hour · commute · recap · hash out — chạm cả lô cũ nhất (13/08) lẫn lô 21/09. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **160/165 từ**, toàn bộ ở bậc 1._

_Ghi chú 2026-09-22 (buổi #32): phần A hỏi lại 5 từ của buổi 21/09 (drain · fan-out · carve out · ground rules · settle in), phần B bốc ngẫu nhiên bằng lệnh trúng bottleneck · scope creep · immutable · align · stateless · verbose · backport · sticking point · bandwidth · put up with · rain check · feasible · technical debt · iron out · purge · feature flag · dry run · deliverable · heartbeat · bump — chạm cả lô cũ nhất (14/08) lẫn lô 16/09. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **155/160 từ**, toàn bộ ở bậc 1. `contention` được dạy lại trong buổi này — nó nằm trong 5 từ của bài 19/09 đã xoá hẳn hôm 21/09, đã trả khỏi `VOCAB_INDEX.md` nên hard gate R1 sạch (cùng tiền lệ với `off the table`)._

_Ghi chú 2026-09-21 (buổi #31): phần A hỏi lại 5 từ của buổi 18/09 (postmortem · runbook · due diligence · buffer · rush hour), phần B bốc ngẫu nhiên bằng lệnh trúng purge · drag on · outstanding · stakeholder · discrepancy · stub · brittle · cold start · heartbeat · spare · rain check · get the hang of · worn out · stay up · align · fed up · edge case · bandwidth · pitch · hand over — chạm cả lô cũ nhất (14/08) lẫn lô 18/09. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **150/155 từ**, toàn bộ ở bậc 1._

_Ghi chú 2026-09-21 (xoá bài 19/09): người học báo thứ Bảy 19/09 không học — gỡ 5 từ contention · telemetry · reservations · red tape · tag along khỏi vốn từ và lịch ôn; bài 21/09 lùi thành buổi #31, phần A đổi sang 5 từ của 18/09, `runbook` ở phần B bốc lại thành `fed up`._

_Ghi chú 2026-09-18 (buổi #30): phần A hỏi lại 5 từ của buổi 17/09 (single point of failure · load shedding · loose ends · on the same page · commute), phần B bốc ngẫu nhiên bằng lệnh trúng throttle · truncate · verbose · heads-up · deprecate · nail down · lead time · catch up · spin up · manage expectations · sign off · outstanding · run errands · action item · stateless · spare · backport · immutable · pencil in · under the weather — chạm cả lô cũ nhất (13/08) lẫn lô 16/09. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **145/150 từ**, toàn bộ ở bậc 1._

_Ghi chú 2026-09-17 (buổi #29): phần A hỏi lại 5 từ của buổi 16/09 (ingest · quarantine · hash out · manage expectations · rain check), phần B bốc ngẫu nhiên bằng lệnh trúng flaky · bottleneck · latency · chip in · graceful degradation · touch base · regression · backoff · bump · stateless · catch up · under the weather · fallback · milestone · worn out · throughput · ballpark · cold start · resilient · out of the blue — chạm cả lô cũ nhất (13/08) lẫn lô 11/09. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **140/145 từ**, toàn bộ ở bậc 1._

_Ghi chú 2026-09-17 (sửa cùng ngày): người học báo đã biết sẵn `stack trace`, `memory leak`, `kick off` → **không** vào lịch ôn, chuyển sang bảng **Đã biết sẵn** cuối `VOCAB_INDEX.md` (R1.b). Ba dòng lịch ôn thay bằng `single point of failure`, `load shedding`, `loose ends`._

_Ghi chú 2026-09-16 (buổi #28): phần A hỏi lại 5 từ của buổi 15/09 (heartbeat · dangling · quote · off the table · night owl), phần B bốc ngẫu nhiên bằng lệnh trúng backoff · feature flag · deprecate · provision · brittle · bottleneck · onboarding · cutover · takeaway · run by · pitch · stateless · bandwidth · pain point · bear with · catch up · run out of · spin up · sticking point · align — chạm cả lô cũ nhất (13/08) lẫn lô 11/09. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **135/140 từ**, toàn bộ ở bậc 1._

_Ghi chú 2026-09-15 (buổi #27): phần A hỏi lại 5 từ của buổi 11/09 (backoff · blast radius · sticking point · pitch · swamped) — buổi thật liền trước sau khi xoá hai bài 12/09 và 14/09; phần B bốc ngẫu nhiên bằng lệnh trúng leeway · wrap up · grab a bite · dry run · scope creep · edge case · chip in · truncate · feature flag · backfill · stay up · bear with · sleep in · outstanding · escalate · loop in · throughput · clarify · downstream · defer. **Hai bài đã xoá hẳn** theo yêu cầu người học vì bận chưa học: Thứ Bảy 12/09 (cascade · flush · firm up · off the table · call it a day) và Thứ Hai 14/09 (shard · observability · blocker · bottom line · take it easy) — 10 từ đó trả lại, sau này được phép dạy lại (`off the table` đã được dạy lại ngay buổi 15/09). Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **130/135 từ**, toàn bộ ở bậc 1._

_Ghi chú 2026-09-11 (buổi #26): phần A hỏi lại 5 từ của buổi 10/09 (drift · purge · hand over · chase up · stay up), phần B bốc ngẫu nhiên bằng lệnh trúng onboarding · idempotent · buy-in · lead time · prioritize · immutable · failover · bandwidth · follow up · short notice · sign off · sort out · narrow down · align · action item · graceful degradation · spare · recap · backpressure · drop by — chạm cả lô cũ nhất (13/08) lẫn lô 09/09. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **125/130 từ**, toàn bộ ở bậc 1._

_Ghi chú 2026-09-10 (buổi #25): phần A hỏi lại 5 từ của buổi 09/09 (dry run · snapshot · narrow down · lead time · hit it off), phần B bốc ngẫu nhiên bằng lệnh trúng cold start · graceful degradation · verbose · technical debt · ballpark · pain point · feasible · awkward · bottleneck · push back · sort out · stub · prioritize · touch base · get the hang of · backward compatible · breaking change · wrap up · chip in · takeaway — chạm cả lô cũ nhất (13/08) lẫn lô 05/09. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc**. Nợ ôn tập nay là **120/125 từ**, toàn bộ ở bậc 1._

_Lý do đọng lại: `/on-tap` và `/kiem-tra` cần user trả lời mới chấm và lên/xuống bậc được — routine tự động chạy 7h sáng không làm thay được. Khối "Ôn nhanh đầu giờ" trên trang bài học **không** đổi bậc ở đây (hỏi-tự-trả-lời), nó chỉ giữ cho từ khỏi rơi khỏi tầm ngắm. Muốn thật sự xoá nợ thì phải gõ tay `/on-tap`, ưu tiên lô cũ nhất trước._

**⚙️ Đổi luật 2026-09-04 — khối "Ôn nhanh đầu giờ" của `/hoc`:** phần bốc ngẫu nhiên **10 → 20 từ** (tổng **25 từ**/buổi: 5 từ buổi liền trước + 20 bốc ngẫu). Vốn từ đã qua 90 từ nên bốc 10 thì mỗi từ chỉ quay lại sau ~9 buổi; bốc 20 rút xuống ~4-5 buổi. Đổi lại trang dài gấp đôi, nên kèm hai thay đổi giao diện: **cả cụm ôn nhanh gập lại được và mặc định ĐANG ẨN** (vào trang thấy 5 từ mới trước, bấm mới mở phần ôn), và **đáp án đi theo từng câu** — mỗi câu một thẻ có số riêng + nút `👁 đáp án` ở cuối dòng, thay cho khối đáp án gộp ở cuối trước đây. Vẫn là hỏi-tự-trả-lời nên **không đổi bậc** ở bảng này. Luật đầy đủ: R9 trong `AGENTS.md`. Áp dụng từ bài học kế tiếp (bài 2026-09-03 giữ nguyên 15 từ).

**⚙️ Đổi luật 2026-08-26 — khối "Ôn nhanh đầu giờ" của `/hoc`:** từ **8 từ / lô hạn cũ nhất** → **15 từ**, chia cố định: **5 từ của buổi liền trước** + **10 từ bốc ngẫu nhiên** trong toàn bộ `VOCAB_INDEX.md` (bốc bằng lệnh `awk+rand`, không bốc bằng mắt). Quét theo lô làm lô cũ bị hỏi lặp còn lô vừa học xong cả tuần không được đụng tới; bốc ngẫu nhiên thì mọi từ đều có cơ hội quay lại. Luật đầy đủ: R9 trong `AGENTS.md`. Harness cũng **bỏ hẳn phần ngữ pháp** kể từ ngày này.

**Tới hạn hôm nay (2026-09-01): 80 từ** — toàn bộ vốn từ cũ, lô cũ nhất là 2026-08-14 (deprecate · workaround · clarify · follow up · come across)

**Tới hạn ngày mai (2026-09-01): 5 từ** — immutable · overhead · wrap up · leeway · sleep in

_Ghi chú 2026-08-28 (buổi #14): khối "Ôn nhanh đầu giờ" theo đúng R9 — phần A là 5 từ của buổi 27/08 (deadlock · throughput · milestone · buy-in · chip in), phần B là 10 từ bốc ngẫu nhiên bằng lệnh `awk+rand` trong cả 60 từ cũ (verbose · come across · flaky · backfill · technical debt · prioritize · walk through · push back · heads-up · clarify) — chạm cả lô cũ nhất 13/08 lẫn lô 24/08. Vẫn là hỏi-tự-trả-lời trên trang nên **không từ nào lên bậc** — muốn đổi bậc phải gõ `/on-tap`. Nợ ôn tập nay là **65/70 từ**, toàn bộ ở bậc 1._

_Ghi chú 2026-08-27 (buổi #13): phần A là 5 từ của buổi 26/08 (spin up · truncate · touch base · accommodate · drop by), phần B bốc trúng clarify · technical debt · scope creep · sign off · bandwidth · escalate · throttle · put off · turnaround · stale. Nợ ôn tập khi đó: 60/65 từ._

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
| deadlock | 1 | 2026-08-28 | 0 | 0 | 2026-08-27 |
| throughput | 1 | 2026-08-28 | 0 | 0 | 2026-08-27 |
| milestone | 1 | 2026-08-28 | 0 | 0 | 2026-08-27 |
| buy-in | 1 | 2026-08-28 | 0 | 0 | 2026-08-27 |
| chip in | 1 | 2026-08-28 | 0 | 0 | 2026-08-27 |
| backpressure | 1 | 2026-08-29 | 0 | 0 | 2026-08-28 |
| cold start | 1 | 2026-08-29 | 0 | 0 | 2026-08-28 |
| pain point | 1 | 2026-08-29 | 0 | 0 | 2026-08-28 |
| takeaway | 1 | 2026-08-29 | 0 | 0 | 2026-08-28 |
| hassle | 1 | 2026-08-29 | 0 | 0 | 2026-08-28 |
| granular | 1 | 2026-08-30 | 0 | 0 | 2026-08-29 |
| sanity check | 1 | 2026-08-30 | 0 | 0 | 2026-08-29 |
| circle back | 1 | 2026-08-30 | 0 | 0 | 2026-08-29 |
| feasible | 1 | 2026-08-30 | 0 | 0 | 2026-08-29 |
| drag on | 1 | 2026-08-30 | 0 | 0 | 2026-08-29 |
| immutable | 1 | 2026-09-01 | 0 | 0 | 2026-08-31 |
| overhead | 1 | 2026-09-01 | 0 | 0 | 2026-08-31 |
| wrap up | 1 | 2026-09-01 | 0 | 0 | 2026-08-31 |
| leeway | 1 | 2026-09-01 | 0 | 0 | 2026-08-31 |
| sleep in | 1 | 2026-09-01 | 0 | 0 | 2026-08-31 |
| failover | 1 | 2026-09-02 | 0 | 0 | 2026-09-01 |
| graceful degradation | 1 | 2026-09-02 | 0 | 0 | 2026-09-01 |
| nail down | 1 | 2026-09-02 | 0 | 0 | 2026-09-01 |
| outstanding | 1 | 2026-09-02 | 0 | 0 | 2026-09-01 |
| spare | 1 | 2026-09-02 | 0 | 0 | 2026-09-01 |
| culprit | 1 | 2026-09-03 | 0 | 0 | 2026-09-02 |
| spike | 1 | 2026-09-03 | 0 | 0 | 2026-09-02 |
| defer | 1 | 2026-09-03 | 0 | 0 | 2026-09-02 |
| ramp up | 1 | 2026-09-03 | 0 | 0 | 2026-09-02 |
| worn out | 1 | 2026-09-03 | 0 | 0 | 2026-09-02 |
| backport | 1 | 2026-09-04 | 0 | 0 | 2026-09-03 |
| smoke test | 1 | 2026-09-04 | 0 | 0 | 2026-09-03 |
| iron out | 1 | 2026-09-04 | 0 | 0 | 2026-09-03 |
| action item | 1 | 2026-09-04 | 0 | 0 | 2026-09-03 |
| grab a bite | 1 | 2026-09-04 | 0 | 0 | 2026-09-03 |
| canary release | 1 | 2026-09-05 | 0 | 0 | 2026-09-04 |
| downstream | 1 | 2026-09-05 | 0 | 0 | 2026-09-04 |
| recap | 1 | 2026-09-05 | 0 | 0 | 2026-09-04 |
| bear with | 1 | 2026-09-05 | 0 | 0 | 2026-09-04 |
| under the weather | 1 | 2026-09-05 | 0 | 0 | 2026-09-04 |
| latency | 1 | 2026-09-06 | 0 | 0 | 2026-09-05 |
| stub | 1 | 2026-09-06 | 0 | 0 | 2026-09-05 |
| onboarding | 1 | 2026-09-06 | 0 | 0 | 2026-09-05 |
| pencil in | 1 | 2026-09-06 | 0 | 0 | 2026-09-05 |
| run errands | 1 | 2026-09-06 | 0 | 0 | 2026-09-05 |
| propagate | 1 | 2026-09-08 | 0 | 0 | 2026-09-07 |
| resilient | 1 | 2026-09-08 | 0 | 0 | 2026-09-07 |
| weigh in | 1 | 2026-09-08 | 0 | 0 | 2026-09-07 |
| discrepancy | 1 | 2026-09-08 | 0 | 0 | 2026-09-07 |
| doze off | 1 | 2026-09-08 | 0 | 0 | 2026-09-07 |
| provision | 1 | 2026-09-09 | 0 | 0 | 2026-09-08 |
| bump | 1 | 2026-09-09 | 0 | 0 | 2026-09-08 |
| run by | 1 | 2026-09-09 | 0 | 0 | 2026-09-08 |
| short notice | 1 | 2026-09-09 | 0 | 0 | 2026-09-08 |
| put up with | 1 | 2026-09-09 | 0 | 0 | 2026-09-08 |
| dry run | 1 | 2026-09-10 | 0 | 0 | 2026-09-09 |
| snapshot | 1 | 2026-09-10 | 0 | 0 | 2026-09-09 |
| narrow down | 1 | 2026-09-10 | 0 | 0 | 2026-09-09 |
| lead time | 1 | 2026-09-10 | 0 | 0 | 2026-09-09 |
| hit it off | 1 | 2026-09-10 | 0 | 0 | 2026-09-09 |
| drift | 1 | 2026-09-11 | 0 | 0 | 2026-09-10 |
| purge | 1 | 2026-09-11 | 0 | 0 | 2026-09-10 |
| hand over | 1 | 2026-09-11 | 0 | 0 | 2026-09-10 |
| chase up | 1 | 2026-09-11 | 0 | 0 | 2026-09-10 |
| stay up | 1 | 2026-09-11 | 0 | 0 | 2026-09-10 |
| backoff | 1 | 2026-09-12 | 0 | 0 | 2026-09-11 |
| blast radius | 1 | 2026-09-12 | 0 | 0 | 2026-09-11 |
| sticking point | 1 | 2026-09-12 | 0 | 0 | 2026-09-11 |
| pitch | 1 | 2026-09-12 | 0 | 0 | 2026-09-11 |
| swamped | 1 | 2026-09-12 | 0 | 0 | 2026-09-11 |
| heartbeat | 1 | 2026-09-16 | 0 | 0 | 2026-09-15 |
| dangling | 1 | 2026-09-16 | 0 | 0 | 2026-09-15 |
| quote | 1 | 2026-09-16 | 0 | 0 | 2026-09-15 |
| off the table | 1 | 2026-09-16 | 0 | 0 | 2026-09-15 |
| night owl | 1 | 2026-09-16 | 0 | 0 | 2026-09-15 |
| ingest | 1 | 2026-09-17 | 0 | 0 | 2026-09-16 |
| quarantine | 1 | 2026-09-17 | 0 | 0 | 2026-09-16 |
| hash out | 1 | 2026-09-17 | 0 | 0 | 2026-09-16 |
| manage expectations | 1 | 2026-09-17 | 0 | 0 | 2026-09-16 |
| rain check | 1 | 2026-09-17 | 0 | 0 | 2026-09-16 |
| single point of failure | 1 | 2026-09-18 | 0 | 0 | 2026-09-17 |
| load shedding | 1 | 2026-09-18 | 0 | 0 | 2026-09-17 |
| loose ends | 1 | 2026-09-18 | 0 | 0 | 2026-09-17 |
| on the same page | 1 | 2026-09-18 | 0 | 0 | 2026-09-17 |
| commute | 1 | 2026-09-18 | 0 | 0 | 2026-09-17 |
| postmortem | 1 | 2026-09-19 | 0 | 0 | 2026-09-18 |
| runbook | 1 | 2026-09-19 | 0 | 0 | 2026-09-18 |
| due diligence | 1 | 2026-09-19 | 0 | 0 | 2026-09-18 |
| buffer | 1 | 2026-09-19 | 0 | 0 | 2026-09-18 |
| rush hour | 1 | 2026-09-19 | 0 | 0 | 2026-09-18 |
| drain | 1 | 2026-09-22 | 0 | 0 | 2026-09-21 |
| fan-out | 1 | 2026-09-22 | 0 | 0 | 2026-09-21 |
| carve out | 1 | 2026-09-22 | 0 | 0 | 2026-09-21 |
| ground rules | 1 | 2026-09-22 | 0 | 0 | 2026-09-21 |
| settle in | 1 | 2026-09-22 | 0 | 0 | 2026-09-21 |
| shard | 1 | 2026-09-23 | 0 | 0 | 2026-09-22 |
| contention | 1 | 2026-09-23 | 0 | 0 | 2026-09-22 |
| contingency | 1 | 2026-09-23 | 0 | 0 | 2026-09-22 |
| scale back | 1 | 2026-09-23 | 0 | 0 | 2026-09-22 |
| show up | 1 | 2026-09-23 | 0 | 0 | 2026-09-22 |
| saturation | 1 | 2026-09-24 | 0 | 0 | 2026-09-23 |
| skew | 1 | 2026-09-24 | 0 | 0 | 2026-09-23 |
| on the fence | 1 | 2026-09-24 | 0 | 0 | 2026-09-23 |
| waive | 1 | 2026-09-24 | 0 | 0 | 2026-09-23 |
| binge-watch | 1 | 2026-09-24 | 0 | 0 | 2026-09-23 |
| eviction | 1 | 2026-09-25 | 0 | 0 | 2026-09-24 |
| cardinality | 1 | 2026-09-25 | 0 | 0 | 2026-09-24 |
| concession | 1 | 2026-09-25 | 0 | 0 | 2026-09-24 |
| draw the line | 1 | 2026-09-25 | 0 | 0 | 2026-09-24 |
| splurge | 1 | 2026-09-25 | 0 | 0 | 2026-09-24 |
| flush | 1 | 2026-09-26 | 0 | 0 | 2026-09-25 |
| idle | 1 | 2026-09-26 | 0 | 0 | 2026-09-25 |
| call out | 1 | 2026-09-26 | 0 | 0 | 2026-09-25 |
| de-risk | 1 | 2026-09-26 | 0 | 0 | 2026-09-25 |
| chill out | 1 | 2026-09-26 | 0 | 0 | 2026-09-25 |

## Đã thuộc (bậc 5, đúng)

_(chưa có)_
