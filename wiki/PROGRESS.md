# PROGRESS — Tiến độ học

**Cập nhật:** 2026-09-05 (buổi #21)

| Chỉ số               | Giá trị                                                                                 |
| -------------------- | --------------------------------------------------------------------------------------- |
| Tổng số từ đã học    | 105 · **đã biết sẵn** 5 (hotfix · overwrite · cherry-pick · debounce · payload — bảng cuối VOCAB_INDEX, không dạy lại) |
| Phân bố              | IT 42 · Business 42 · Life 21                                                           |
| Số buổi học          | 21                                                                                      |
| Streak hiện tại      | 21 buổi (Chủ nhật 2026-08-16, 2026-08-23 và 2026-08-30 là ngày nghỉ theo lịch — không tính đứt) |
| Streak dài nhất      | 21 buổi                                                                                 |
| Buổi gần nhất        | 2026-09-05 (Thứ Bảy) — buổi #21                                                         |
| Số quiz đã làm       | 0                                                                                       |
| Điểm quiz trung bình | —                                                                                       |
| Level                | B1+ reading / A2-B1 active (tự đánh giá — **chưa chốt**, chờ bài xếp loại ở lesson đầu) |

## Nhật ký buổi học

| Ngày | Tuần | Buổi | Từ đã học |
| ---- | ---- | ---- | --------- |
| 2026-08-13 | 2026-W33 | #1 | deprecate · workaround · clarify · follow up · come across |
| 2026-08-14 | 2026-W33 | #2 | edge case · bottleneck · escalate · deliverable · run out of |
| 2026-08-15 | 2026-W33 | #3 | rollback · flaky · reach out · scope creep · get the hang of |
| 2026-08-17 | 2026-W34 | #4 | throttle · regression · heads-up · ballpark · keep an eye on |
| 2026-08-18 | 2026-W34 | #5 | boilerplate · stale · walk through · sign off · end up |
| 2026-08-19 | 2026-W34 | #6 | race condition · idempotent · push back · caveat · awkward |
| 2026-08-20 | 2026-W34 | #7 | technical debt · backward compatible · loop in · bandwidth · catch up |
| 2026-08-21 | 2026-W34 | #8 | feature flag · breaking change · stakeholder · align · out of the blue |
| 2026-08-22 | 2026-W34 | #9 | fallback · brittle · bring up · turnaround · sort out |
| 2026-08-24 | 2026-W35 | #10 | cutover · backfill · prioritize · trade-off · put off |
| 2026-08-25 | 2026-W35 | #11 | stateless · verbose · on track · tentative · fed up |
| 2026-08-26 | 2026-W35 | #12 | spin up · truncate · touch base · accommodate · drop by |
| 2026-08-27 | 2026-W35 | #13 | deadlock · throughput · milestone · buy-in · chip in |
| 2026-08-28 | 2026-W35 | #14 | backpressure · cold start · pain point · takeaway · hassle |
| 2026-08-29 | 2026-W35 | #15 | granular · sanity check · circle back · feasible · drag on |
| 2026-08-31 | 2026-W36 | #16 | immutable · overhead · wrap up · leeway · sleep in |
| 2026-09-01 | 2026-W36 | #17 | failover · graceful degradation · nail down · outstanding · spare |
| 2026-09-02 | 2026-W36 | #18 | culprit · spike · defer · ramp up · worn out |
| 2026-09-03 | 2026-W36 | #19 | backport · smoke test · iron out · action item · grab a bite |
| 2026-09-04 | 2026-W36 | #20 | canary release · downstream · recap · bear with · under the weather |
| 2026-09-05 | 2026-W36 | #21 | latency · stub · onboarding · pencil in · run errands |

## Kết quả quiz tuần

| Tuần     | Ngày làm                    | Điểm | Kết quả | Từ sai |
| -------- | --------------------------- | ---- | ------- | ------ |
| 2026-W33 | _(chưa làm — Chủ nhật 2026-08-16 routine chỉ sinh bảng ôn `recap/2026-W33`; `/kiem-tra` cần user trả lời nên phải gõ tay)_ | —    | —       | —      |

## Đổi luật 2026-09-04 — ôn nhanh lên 25 từ, cả cụm ẩn mặc định

Người học chốt: phần **bốc ngẫu nhiên** của khối "Ôn nhanh đầu giờ" nâng **10 → 20 từ**
(tổng **25 từ**/buổi, phần A vẫn đúng 5 từ của buổi liền trước). Vốn từ đã qua 90 từ,
bốc 10 mỗi buổi thì một từ chỉ quay lại sau khoảng 9 buổi — quá thưa. Bốc 20 rút còn
4-5 buổi.

Cái giá là trang bài học dài gấp đôi trước khi tới 5 từ mới, nên đi kèm hai thay đổi
giao diện:

1. **Cả cụm ôn nhanh bọc trong `<details class="warm-toggle">`, mặc định ĐANG ĐÓNG** —
   vào trang thấy bài mới trước, ôn tập là cái người học chủ động bấm mở.
2. **Đáp án đi theo từng câu**, không gộp một khối ở cuối nữa. Mỗi câu là một thẻ có
   số thứ tự riêng, nút `👁 đáp án` ở cuối dòng; bấm thì đáp án hiện ngay trong thẻ
   đó (nền accent, vạch màu bên trái, viền thẻ đổi sang accent). Trước đây 25 câu mà
   đáp án dồn xuống cuối thì phải cuộn đi cuộn lại và đếm ngược xem câu 14 ứng với
   dòng nào — sai dòng là học sai từ.

Cả hai đều dùng `<details>` gốc của trình duyệt, không JS, để không hỏng khi mở bằng
`file://`. Duyệt mẫu ngày 2026-09-03 (thư mục `demo/`, đã xoá sau khi chốt).

Áp dụng **từ bài học kế tiếp**; bài 2026-09-03 và các bài cũ giữ nguyên 15 từ, hiện sẵn.
Luật đầy đủ: R9 trong `AGENTS.md`.

## Đổi luật 2026-08-26 — bỏ ngữ pháp, ôn nhanh lên 15 từ

Người học chốt: harness **không dạy ngữ pháp nữa**. Bỏ hẳn khối "Ngữ pháp hôm nay",
khối "Tự viết", thư mục `wiki/grammar/`, phần ngữ pháp trong quiz và bảng ôn tuần —
kể cả trong ba bài đã sinh (24, 25, 26/08). Buổi học quay về đúng một việc: **từ vựng**.

| Khối | Trước | Từ 2026-08-26 |
| --- | --- | --- |
| Ôn nhanh đầu giờ | 8 từ, luôn lấy lô hạn cũ nhất | **15 từ** = 5 từ buổi trước + **10 từ bốc ngẫu nhiên** trong cả vốn từ |
| Ngữ pháp hôm nay | 1 điểm/buổi, 8 mục | ❌ bỏ |
| 5 từ mới | giữ | giữ (ví dụ vẫn phải mượn từ cũ — R8) |
| Mẩu đọc | giữ | giữ |
| Tự viết | 3 câu, không đáp án | ❌ bỏ |
| Bài tập | 3 câu từ vựng + 2 câu ngữ pháp | 5 câu, toàn bộ về từ vựng |

Vì sao đổi cách ôn nhanh: quét theo lô hạn cũ nhất làm lô cũ bị hỏi lặp còn lô vừa
học xong thì cả tuần không được đụng tới. Bốc ngẫu nhiên trên **toàn bộ** vốn từ thì
mọi từ đều có cơ hội quay lại, và 5 từ của buổi trước luôn được ôn đúng lúc trí nhớ
sắp phai. Luật đầy đủ: R9 trong [AGENTS.md](../AGENTS.md).

## Đang yếu

_(chưa có dữ liệu về từ yếu — cần ít nhất 1 lượt ôn hoặc 1 bài quiz)_

🔁 **Sửa lại 2026-09-01 (cùng ngày, sau khi user xem bài):** user báo đã biết sẵn `debounce` và `payload` — hai suất IT của buổi #17. Theo R1.b: hai từ chuyển xuống bảng **Đã biết sẵn** ở cuối `VOCAB_INDEX.md` (không tính vào tổng, không vào `REVIEW_QUEUE.md`), và được thay bằng `failover` + `graceful degradation` — cùng nhóm IT, đã qua lại hard gate R1. Bài `.md` và `.html` đã viết lại toàn bộ: khối từ, ví dụ (R8 vẫn đúng), mẩu đọc, bài tập, đáp án, ghi chú. Tổng số từ vẫn là 85 vì thay 2 ăn 2; số từ "đã biết sẵn" lên 5. Đây là lần thứ hai user loại từ vì đã biết (lần đầu 2026-08-24 với `hotfix` · `overwrite` · `cherry-pick`) — cả 5 từ bị loại đều thuộc nhóm "lệnh/khái niệm gặp hằng ngày", đúng cảnh báo trong `memory/tu-da-biet-khong-day-lai.md`.

⚠️ **Cập nhật 2026-09-05:** vốn từ lên **105 từ**, nợ ôn tập lên **100/105 từ quá hạn**, vẫn toàn bộ ở bậc 1. Buổi #21 chạy luật R9 bản 25 từ: phần A hỏi lại 5 từ của buổi 04/09, phần B bốc ngẫu nhiên bằng lệnh trúng run out of · edge case · throttle · sign off · come across · takeaway · cutover · graceful degradation · stateless · idempotent · circle back · prioritize · sanity check · leeway · fallback · keep an eye on · truncate · accommodate · walk through · deliverable — chạm cả lô cũ nhất (13/08) lẫn lô 02/09. Nhưng khối này vẫn là hỏi-tự-trả-lời trên trang nên **không có từ nào lên bậc**. Hôm nay là Thứ Bảy và tuần 2026-W36 đã đủ **30 từ** (31/08 → 05/09) — mai Chủ nhật routine sẽ tự sinh bảng ôn `/on-tap-tuan`, nhưng muốn có **điểm quiz đầu tiên** thì vẫn phải gõ tay `/kiem-tra`, và muốn nợ giảm thật thì phải gõ `/on-tap` (lô cũ nhất 14/08 → 16/08).

⚠️ **Cập nhật 2026-09-04:** cột mốc **100 từ** — nợ ôn tập lên **95/100 từ quá hạn**, vẫn toàn bộ ở bậc 1. Buổi #20 là buổi ĐẦU TIÊN chạy luật R9 bản mới: ôn nhanh **25 từ** (5 từ buổi 03/09 + **20 từ** bốc ngẫu nhiên bằng lệnh — trúng worn out · push back · graceful degradation · stateless · drag on · spare · granular · escalate · keep an eye on · cold start · run out of · pain point · end up · bandwidth · on track · takeaway · follow up · workaround · overhead · chip in, chạm cả lô cũ nhất 13/08 lẫn lô 02/09), cả cụm bọc `<details class="warm-toggle">` mặc định ĐÓNG và đáp án đi theo từng câu. Nhưng khối này vẫn là hỏi-tự-trả-lời trên trang nên **không có từ nào lên bậc**. Tuần 2026-W36 đã có 25 từ (31/08 → 04/09); W35 vẫn chưa có điểm quiz. Muốn nợ giảm thật thì phải gõ tay `/on-tap` (lô cũ nhất 14/08 → 16/08), muốn có điểm thì gõ `/kiem-tra`.

⚠️ **Cập nhật 2026-09-03:** nợ ôn tập lên **90/95 từ quá hạn**, vẫn toàn bộ ở bậc 1. Buổi #19 chạy đúng luật R9: phần A hỏi lại 5 từ của buổi 02/09, phần B bốc ngẫu nhiên bằng lệnh trúng run out of · reach out · graceful degradation · align · backfill · spare · stakeholder · feasible · catch up · heads-up — chạm cả lô cũ nhất (14/08) lẫn lô mới nhất (01/09). Nhưng khối này vẫn là hỏi-tự-trả-lời trên trang nên **không có từ nào lên bậc**. Tuần 2026-W36 đã có 20 từ (31/08 → 03/09); tuần W35 vẫn chưa có điểm quiz. Muốn nợ giảm thật thì phải gõ tay `/on-tap` (lô cũ nhất 14/08 → 16/08), muốn có điểm thì gõ `/kiem-tra` cho W35.

⚠️ **Cập nhật 2026-09-02:** nợ ôn tập lên **85/90 từ quá hạn**, vẫn toàn bộ ở bậc 1. Buổi #18 chạy đúng luật R9: phần A hỏi lại 5 từ của buổi 01/09, phần B bốc ngẫu nhiên bằng lệnh trúng sign off · fed up · leeway · turnaround · technical debt · immutable · sort out · drop by · walk through · takeaway — chạm cả lô 18/08 lẫn lô 31/08. Nhưng khối này vẫn là hỏi-tự-trả-lời trên trang nên **không có từ nào lên bậc**. Tuần 2026-W36 đã có 15 từ (31/08 + 01/09 + 02/09); tuần W35 vẫn chưa có điểm quiz. Muốn nợ giảm thật thì phải gõ tay `/on-tap` (lô cũ nhất 14/08 → 16/08), muốn có điểm thì gõ `/kiem-tra` cho W35.

⚠️ **Cập nhật 2026-09-01:** nợ ôn tập lên **80/85 từ quá hạn**, vẫn toàn bộ ở bậc 1. Buổi #17 chạy đúng luật R9: phần A hỏi lại 5 từ của buổi 31/08, phần B bốc ngẫu nhiên bằng lệnh trúng tentative · throughput · technical debt · awkward · throttle · align · circle back · on track · turnaround · brittle — chạm cả lô 19/08 lẫn lô 29/08. Nhưng khối này vẫn là hỏi-tự-trả-lời trên trang nên **không có từ nào lên bậc**. Tuần 2026-W36 mới có 10 từ (31/08 + 01/09); tuần W35 đã khép lại với 30 từ mà vẫn chưa có điểm quiz — muốn có điểm thì phải gõ tay `/kiem-tra` cho W35, muốn nợ giảm thật thì phải gõ `/on-tap` (lô cũ nhất 14/08 → 16/08).

⚠️ **Cập nhật 2026-08-31:** nợ ôn tập lên **75/80 từ quá hạn**, vẫn toàn bộ ở bậc 1. Buổi #16 mở tuần 2026-W36 và chạy đúng luật R9: phần A hỏi lại 5 từ của buổi 29/08, phần B bốc ngẫu nhiên bằng lệnh trúng sign off · verbose · brittle · backfill · turnaround · stakeholder · loop in · technical debt · tentative · trade-off — chạm cả lô 18/08 lẫn lô 25/08. Nhưng khối này vẫn là hỏi-tự-trả-lời trên trang nên **không có từ nào lên bậc**. Tuần 2026-W35 đã khép lại với 30 từ mà **vẫn chưa có điểm quiz nào** — ba tuần liên tiếp như vậy. Muốn nợ giảm thật thì phải gõ tay `/on-tap` (lô cũ nhất 14/08 → 16/08), muốn có điểm thì gõ `/kiem-tra` cho tuần W35.

_(Dọn dẹp kèm buổi #16: bốn file bài học cũ — 22/08 và 28/08, cả `.md` lẫn `.html` — bị sót thẻ rác `</content>` / `</invoke>` ở cuối file do lỗi ghi file của session trước. Đã xoá, nội dung bài không đổi.)_

⚠️ **Cập nhật 2026-08-29:** nợ ôn tập lên **70/75 từ quá hạn**, vẫn toàn bộ ở bậc 1. Buổi #15 chạy đúng luật R9: phần A hỏi lại 5 từ của buổi 28/08, phần B bốc ngẫu nhiên bằng lệnh trúng rollback · buy-in · sign off · flaky · truncate · get the hang of · boilerplate · follow up · feature flag · turnaround — chạm cả lô 15/08 lẫn lô 27/08. Nhưng khối này vẫn là hỏi-tự-trả-lời trên trang nên **không có từ nào lên bậc**. Hôm nay là Thứ Bảy và tuần 2026-W35 đã đủ **30 từ** (buổi 24 → 29/08) — mai Chủ nhật routine sẽ tự sinh bảng ôn `/on-tap-tuan`, nhưng muốn có **điểm quiz đầu tiên** thì vẫn phải gõ tay `/kiem-tra`, và muốn nợ ôn tập giảm thật thì phải gõ `/on-tap` (ưu tiên lô cũ nhất 14/08 → 16/08).

⚠️ **Cập nhật 2026-08-28:** nợ ôn tập lên **65/70 từ quá hạn**, vẫn toàn bộ ở bậc 1. Buổi #14 chạy đúng luật R9: phần A hỏi lại 5 từ của buổi 27/08, phần B bốc ngẫu nhiên bằng lệnh trúng verbose · come across · flaky · backfill · technical debt · prioritize · walk through · push back · heads-up · clarify — chạm cả lô cũ nhất (13/08) lẫn lô 24/08. Nhưng khối này vẫn là hỏi-tự-trả-lời trên trang nên **không có từ nào lên bậc**. Đã 14 buổi liên tiếp nợ chỉ tăng. Hôm nay là Thứ Sáu, tuần 2026-W35 đã đủ 25 từ — cuối tuần này là dịp tốt để gõ tay `/kiem-tra` (lấy điểm quiz đầu tiên) và một buổi `/on-tap` cho lô 14/08 → 16/08.

⚠️ **Cập nhật 2026-08-27:** nợ ôn tập lên **60/65 từ quá hạn**, vẫn toàn bộ ở bậc 1. Buổi #13 chạy đúng luật R9: phần A hỏi lại 5 từ của buổi 26/08, phần B bốc ngẫu nhiên bằng lệnh trúng clarify · technical debt · scope creep · sign off · bandwidth · escalate · throttle · put off · turnaround · stale — phủ cả lô cũ nhất (13/08) lẫn lô mới (24/08). Nhưng khối này vẫn là hỏi-tự-trả-lời trên trang nên **không có từ nào lên bậc**. Đã 13 buổi liên tiếp nợ chỉ tăng: cách duy nhất giảm thật là dành hẳn một buổi gõ tay `/on-tap` (ưu tiên lô 14/08 → 16/08), và tuần này vẫn chưa có điểm quiz nào — muốn có thì phải gõ `/kiem-tra`.

⚠️ **Cập nhật 2026-08-26:** nợ ôn tập là **55/60 từ quá hạn**, vẫn toàn bộ ở bậc 1. Bài buổi #12 đã được soạn lại theo luật R9 mới: khối "Ôn nhanh đầu giờ" giờ hỏi **15 từ** (5 từ buổi 25/08 + 10 từ bốc ngẫu nhiên trong cả vốn từ) thay vì 8 từ quét theo lô. Cách bốc ngẫu nhiên phủ đều hơn hẳn, nhưng vẫn là hỏi-tự-trả-lời trên trang nên **không có từ nào lên bậc** — mỗi ngày lại thêm 5 từ vào nợ. Cách duy nhất giảm thật là gõ tay `/on-tap` (chấm được, lên bậc được), ưu tiên lô 14/08 → 16/08.

⚠️ **Cập nhật 2026-08-25:** nợ ôn tập vẫn tăng — **50/55 từ quá hạn**, tất cả ở bậc 1. Buổi #11 đã đi tiếp lô cũ nhất còn nợ (thay vì hỏi lại đúng 8 từ của buổi #10), nên khối "Ôn nhanh đầu giờ" giờ đã quét hết lô 14/08 → 16/08 và chạm lô 18/08. Nhưng đó vẫn là hỏi-tự-trả-lời trên trang: **không từ nào lên bậc được**. Chỉ có gõ tay `/on-tap` hoặc `/kiem-tra` mới đổi được bậc.

⚠️ **Ghi nhận 2026-08-24:** tính tới hôm đó đã có **45/50 từ quá hạn ôn** trong `REVIEW_QUEUE.md`, tất cả vẫn ở bậc 1 — mỗi ngày lại thêm 5 từ. Buổi #10 đã nâng khối "Ôn nhanh đầu giờ" lên 8 từ và hỏi đúng lô cũ nhất (08-14 + 3 từ đầu lô 08-15), nhưng đó là hỏi-tự-trả-lời trên trang nên **không chấm được, không lên bậc được**. Routine tự động chỉ sinh được từ mới; `/on-tap` và `/kiem-tra` cần user trả lời mới lên/xuống bậc. Số từ đọng đã gấp ba lần `review.maxPerSession` (15) — nên dành hẳn một buổi gõ `/on-tap` để giải quyết lô cũ nhất (08-14, 08-15) trước khi nó phình thêm. Hai tuần 2026-W33 và 2026-W34 đều chưa có điểm quiz — muốn có điểm thì phải gõ tay `/kiem-tra`.
