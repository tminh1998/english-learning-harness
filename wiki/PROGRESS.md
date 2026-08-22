# PROGRESS — Tiến độ học

**Cập nhật:** 2026-08-22 (chốt lộ trình v2)

| Chỉ số               | Giá trị                                                                                 |
| -------------------- | --------------------------------------------------------------------------------------- |
| Tổng số từ đã học    | 45                                                                                      |
| Phân bố              | IT 18 · Business 18 · Life 9                                                            |
| Số buổi học          | 9                                                                                       |
| Streak hiện tại      | 9 buổi (Chủ nhật 2026-08-16 là ngày nghỉ theo lịch — không tính đứt)                    |
| Streak dài nhất      | 9 buổi                                                                                  |
| Buổi gần nhất        | 2026-08-22 (Thứ Bảy) — buổi #9                                                          |
| Ngữ pháp             | **0 / 42** · chưa bắt đầu — lộ trình v2 chạy từ **2026-08-24** (thứ Hai, 2026-W35)      |
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

## Kết quả quiz tuần

| Tuần     | Ngày làm                    | Điểm | Kết quả | Từ sai |
| -------- | --------------------------- | ---- | ------- | ------ |
| 2026-W33 | _(chưa làm — Chủ nhật 2026-08-16 routine chỉ sinh bảng ôn `recap/2026-W33`; `/kiem-tra` cần user trả lời nên phải gõ tay)_ | —    | —       | —      |

## Lộ trình v2 — gắn ngữ pháp vào buổi học (chốt 2026-08-22)

Chín buổi đầu dạy 45 từ mà **không dạy một điểm ngữ pháp nào** → người học nhận ra
từ nhưng không tự ráp được câu. Từ **thứ Hai 2026-08-24**, mỗi buổi `/hoc` đổi khuôn:

| Khối | Mới? | Ghi chú |
| --- | --- | --- |
| Ôn nhanh đầu giờ | nâng 2-4 → **8 từ** | lô hạn cũ nhất trước — xoá 40 từ nợ trong ~5 buổi |
| **Ngữ pháp hôm nay** | ⭐ mới | 1 điểm/buổi, 8 mục, con trỏ ở [grammar/CURRICULUM.md](grammar/CURRICULUM.md) |
| 5 từ mới | giữ | nhưng ví dụ của **cả 5 từ** phải viết theo mẫu ngữ pháp của buổi (R9) |
| Mẩu đọc | giữ | cũng theo mẫu đó |
| **Tự viết** | ⭐ mới | 3 câu tự sản xuất, **không có đáp án** — bước duy nhất luyện vốn chủ động |
| Bài tập | giữ | thêm 2 câu ngữ pháp |

Chương trình: 42 điểm ≈ 7 tuần, 4 chặng — *khung câu* → *thì & thời gian* →
*lịch sự & modal* → *câu phức*. Mẫu giao diện đã duyệt:
[`_templates/lesson-v2-mockup.html`](_templates/lesson-v2-mockup.html).

## Đang yếu

_(chưa có dữ liệu về từ yếu — cần ít nhất 1 lượt ôn hoặc 1 bài quiz)_

⚠️ **Đáng chú ý:** tính tới 2026-08-22 đã có **40/45 từ quá hạn ôn** trong `REVIEW_QUEUE.md`, tất cả vẫn ở bậc 1 — mỗi ngày lại thêm 5 từ. Routine tự động chỉ sinh được từ mới; `/on-tap` và `/kiem-tra` cần user trả lời mới lên/xuống bậc được. Số từ đọng đã gấp gần ba lần `review.maxPerSession` (15) — nên dành hẳn một buổi gõ `/on-tap` để giải quyết lô cũ nhất (08-14, 08-15) trước khi nó phình thêm. Chủ nhật 2026-08-23 routine sẽ tự sinh bảng ôn `recap/2026-W34`, nhưng bảng ôn **không chấm điểm** — muốn có điểm và lên bậc thì phải gõ tay `/kiem-tra` cho tuần 2026-W34.
