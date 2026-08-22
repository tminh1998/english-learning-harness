---
description: Bài kiểm tra cuối tuần — toàn bộ từ đã học trong tuần, chấm và ghi kết quả
argument-hint: "[tuần ISO, vd 2026-W33 — bỏ trống = tuần hiện tại]"
---

Chạy **Flow B — Kiểm tra cuối tuần** trong `AGENTS.md`.

Tuần cần kiểm tra (bỏ trống = tuần hiện tại): $ARGUMENTS

Thứ tự bắt buộc:

1. `. tools/openit.sh; keove; hnay "%Y-%m-%d %A %G-W%V"` — về nhánh chính, kéo bài
   từ máy khác về (R6), rồi xác định tuần ISO thật. ⚠️ **Không `date` trần**: VM
   cloud chạy giờ UTC, lệch ngày là lấy nhầm tuần, gom thiếu từ để ra đề.
2. Đọc mọi file trong `wiki/lessons/<tuần>/` → gom danh sách từ đã học.
   Không có file nào → báo user tuần này chưa học buổi nào, dừng.
3. Kéo thêm tối đa 5 từ "yếu" từ `wiki/REVIEW_QUEUE.md` (bậc thấp hoặc từng sai).
3b. ⭐ Gom **các điểm ngữ pháp đã dạy trong tuần**: đọc `wiki/grammar/CURRICULUM.md`,
   lấy những dòng ✅ có cột "Buổi" rơi vào tuần này. Tuần trước 2026-08-24 thì bỏ qua.
3c. ⭐ Gom **3 câu tự viết của từng buổi**: mục "Tự viết" trong mỗi
   `wiki/lessons/<tuần>/*.md`. Câu người học đã gõ nằm trong localStorage của trình
   duyệt, agent **không đọc được** — nên ở bước 5 phải **hỏi user dán vào chat**.
4. Ra đề 4 phần A/B/C/D theo `wiki/_templates/quiz.md`, **cộng thêm**:
   - **Phần E — Ngữ pháp**: mỗi điểm của tuần 2-3 câu (chọn thì/dạng đúng, sửa lỗi,
     viết lại câu). Đây là phần đo thứ mà quiz cũ hoàn toàn không đo được.
   - **Phần F — Tự viết**: yêu cầu user dán lại 3 câu của **một buổi bất kỳ** trong
     tuần, hoặc viết mới 3 câu theo đề của buổi đó.
   Ghi `wiki/quiz/<tuần>.md`. **Đáp án ghi RIÊNG** ra `wiki/quiz/<tuần>-key.md`.
5. ⛔ **R2** — trình đề trong chat, **tuyệt đối không** hiện đáp án, không đọc
   file `-key.md` ở bước này. Dừng lại chờ user trả lời.
6. User nộp bài → mở file key, chấm từng câu: đúng/sai, sai vì sao, cách nhớ đúng.
   Tính %, so `weekly.passScore` (80%).

   **Phần F (tự viết) chấm khác 5 phần kia** — không có đáp án đúng-sai, chấm theo
   4 tiêu chí, mỗi câu nói rõ đạt/không đạt từng cái:
   - đúng **mẫu ngữ pháp** của buổi đó không;
   - dùng đúng **từ được chỉ định**, đúng nghĩa và đúng collocation không;
   - có **lỗi khác** không (chia động từ, mạo từ, giới từ, số ít/nhiều);
   - câu có **nghe tự nhiên** không — câu đúng ngữ pháp mà không ai nói thế thì
     phải viết lại giúp user, kèm bản sửa.

   Phần F **không tính vào %** (nó không có thang điểm khách quan), nhưng lỗi tìm
   được ở đây thì vẫn đi tiếp bước 8 và 9 như các phần khác.
7. Ghi mục "Kết quả" vào cuối `wiki/quiz/<tuần>.md` + cập nhật `wiki/PROGRESS.md`.
8. Từ sai → reset về bậc 1 trong `wiki/REVIEW_QUEUE.md` (next_review = mai).
8b. **Điểm ngữ pháp sai ≥ 2 câu** (phần E) hoặc dùng sai trong phần F → ghi chú vào
   `wiki/grammar/<slug>.md` mục "buổi/quiz nào đã gặp", và báo user nên xin dạy lại
   điểm đó thay vì đi tiếp — con trỏ trong `CURRICULUM.md` **không tự lùi**.
9. Lỗi cùng loại lặp ≥ 2 lần trong lịch sử → tạo 1 entry `wiki/memory/` theo
   `wiki/_templates/memory-entry.md` + thêm dòng vào `wiki/memory/MEMORY.md`.
10. `sh tools/build-index.sh` rồi `daylen "kiem-tra: <tuần> — <điểm>%"` (R6).
    ⚠️ Chỉ gọi `daylen` **sau khi đã chấm xong** — push file `-key.md` lên GitHub
    trước khi user làm bài là tự lộ đáp án (R2), vì repo để public.

Chấm nghiêm túc. Sai thì nói thẳng chỗ sai, không khen sáo.
