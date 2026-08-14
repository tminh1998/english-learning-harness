---
description: Bài kiểm tra cuối tuần — toàn bộ từ đã học trong tuần, chấm và ghi kết quả
argument-hint: "[tuần ISO, vd 2026-W33 — bỏ trống = tuần hiện tại]"
---

Chạy **Flow B — Kiểm tra cuối tuần** trong `AGENTS.md`.

Tuần cần kiểm tra (bỏ trống = tuần hiện tại): $ARGUMENTS

Thứ tự bắt buộc:

1. `git pull --rebase 2>/dev/null; . tools/openit.sh; hnay "%Y-%m-%d %A %G-W%V"` —
   kéo bài từ máy khác về (R6) rồi xác định tuần ISO thật. ⚠️ **Không `date` trần**:
   VM cloud chạy giờ UTC, lệch ngày là lấy nhầm tuần, gom thiếu từ để ra đề.
2. Đọc mọi file trong `wiki/lessons/<tuần>/` → gom danh sách từ đã học.
   Không có file nào → báo user tuần này chưa học buổi nào, dừng.
3. Kéo thêm tối đa 5 từ "yếu" từ `wiki/REVIEW_QUEUE.md` (bậc thấp hoặc từng sai).
4. Ra đề 4 phần A/B/C/D theo `wiki/_templates/quiz.md`, ghi
   `wiki/quiz/<tuần>.md`. **Đáp án ghi RIÊNG** ra `wiki/quiz/<tuần>-key.md`.
5. ⛔ **R2** — trình đề trong chat, **tuyệt đối không** hiện đáp án, không đọc
   file `-key.md` ở bước này. Dừng lại chờ user trả lời.
6. User nộp bài → mở file key, chấm từng câu: đúng/sai, sai vì sao, cách nhớ đúng.
   Tính %, so `weekly.passScore` (80%).
7. Ghi mục "Kết quả" vào cuối `wiki/quiz/<tuần>.md` + cập nhật `wiki/PROGRESS.md`.
8. Từ sai → reset về bậc 1 trong `wiki/REVIEW_QUEUE.md` (next_review = mai).
9. Lỗi cùng loại lặp ≥ 2 lần trong lịch sử → tạo 1 entry `wiki/memory/` theo
   `wiki/_templates/memory-entry.md` + thêm dòng vào `wiki/memory/MEMORY.md`.
10. `sh tools/build-index.sh` rồi `git add -A && git commit -m "kiem-tra: <tuần>" && git push`
    (R6). ⚠️ Chỉ push **sau khi đã chấm xong** — push file `-key.md` lên GitHub
    trước khi user làm bài là tự lộ đáp án (R2), vì repo để public.

Chấm nghiêm túc. Sai thì nói thẳng chỗ sai, không khen sáo.
