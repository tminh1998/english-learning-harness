# wiki/ — Nơi lưu toàn bộ kiến thức đã học

| File / thư mục | Vai trò | Ai ghi |
|---|---|---|
| [VOCAB_INDEX.md](VOCAB_INDEX.md) | ⭐ Mọi từ đã học — nguồn chống trùng (luật R1) | `/hoc`, `/tra-tu` |
| [REVIEW_QUEUE.md](REVIEW_QUEUE.md) | Lịch ôn spaced repetition, bậc + ngày tới hạn | `/hoc`, `/on-tap`, `/kiem-tra` |
| [PROGRESS.md](PROGRESS.md) | Streak, tổng từ, nhật ký buổi, điểm quiz | mọi lệnh |
| `lessons/YYYY-Www/YYYY-MM-DD.md` | Bài học từng ngày — bản canonical, grep được | `/hoc` |
| `lessons/YYYY-Www/YYYY-MM-DD.html` | Cùng nội dung, bản để đọc trong trình duyệt | `/hoc` |
| `assets/lesson.css` · `lesson.js` | Giao diện + phát âm + chế độ ôn tập, **dùng chung mọi bài** | *(sửa tay khi muốn đổi giao diện)* |
| `quiz/YYYY-Www.md` | Đề kiểm tra tuần + kết quả sau khi chấm | `/kiem-tra` |
| `quiz/YYYY-Www-key.md` | Đáp án — **tách file** để không lộ trước (luật R2) | `/kiem-tra` |
| `grammar/` | Điểm ngữ pháp bắt gặp, mỗi điểm một file | `/tra-tu`, `/kiem-tra` |
| `memory/` | Rule đã học về cách học của learner | `/kiem-tra` |
| `_templates/` | Khuôn lesson / quiz / memory-entry | *(chỉ đọc)* |

## Thứ tự tin cậy

`VOCAB_INDEX.md` **thắng mọi mô tả khác**. Nếu một file nào đó nói "đã học từ X"
mà VOCAB_INDEX không có dòng X → coi như **chưa học**, và phải sửa file kia.

## Quy ước tên

- Tuần dùng **ISO week**: `2026-W33`. Lấy bằng `date "+%G-W%V"`, không tự đoán.
- Ngày: `YYYY-MM-DD`. Buổi thứ hai trong cùng ngày: `YYYY-MM-DD-2.md`.
