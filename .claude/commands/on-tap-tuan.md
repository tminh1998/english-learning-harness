---
description: Bảng ôn tuần — gom mọi từ đã học trong tuần thành một trang tra nhanh, nghĩa Việt ngay cạnh từ
argument-hint: "[tuần ISO, vd 2026-W33 — bỏ trống = tuần hiện tại]"
---

Chạy **Flow D — Bảng ôn tuần** trong `AGENTS.md`.

Tuần cần ôn (bỏ trống = tuần hiện tại): $ARGUMENTS

Đây **không phải** bài kiểm tra (`/kiem-tra`) và **không phải** buổi ôn hỏi–đáp
(`/on-tap`). Đây là một **trang để đọc**: mọi từ đã học trong tuần, nghĩa Việt nằm
ngay cột kế bên. Nghĩa Việt **hiện sẵn**, không giấu — người học liếc một cái là
hiểu. Ai muốn tự kiểm tra thì bấm nút "Chế độ ôn tập" để che cột đó đi.

## Thứ tự bắt buộc

1. `. tools/openit.sh; keove; hnay "%Y-%m-%d %A %G-W%V"` — về nhánh chính, kéo bài
   từ máy khác về (R6), lấy tuần ISO thật. ⚠️ **Không `date` trần** (VM cloud chạy
   giờ UTC).
2. Đọc **mọi** file `wiki/lessons/<tuần>/*.md`. Không có file nào → báo tuần này
   chưa học buổi nào rồi dừng, **đừng bịa từ**.
3. Gom danh sách từ: tất cả từ mới của các buổi trong tuần. Với mỗi từ lấy sẵn
   IPA, từ loại, nghĩa Việt, collocation, mục **Bẫy**, và câu ví dụ đắt nhất.
   ⛔ Chỉ lấy từ **trong tuần đó**. Không kéo từ tuần khác, không thêm từ mới.
4. **Ghi bản Markdown** theo `wiki/_templates/recap.md` → `wiki/recap/<tuần>.md`.
5. **Ghi bản HTML** theo `wiki/_templates/recap.html` → `wiki/recap/<tuần>.html`.
6. `sh tools/build-index.sh` rồi `daylen "recap: <tuần> — <N> từ"` (R6).
   Không mở branch, không tạo PR. Không in `DA-PUSH` → báo thẳng cho user.
7. `openit "wiki/recap/<tuần>.html"` rồi tóm tắt trong chat: bao nhiêu từ, phân bố
   IT/Business/Life, và 2-3 chỗ dễ sai đáng chú ý nhất của tuần.

## Bốn luật riêng của bảng ôn

1. **Nghĩa Việt nằm ngay cột kế bên** — đây là lý do trang này tồn tại. Cột nghĩa
   in đậm, nổi hơn mọi cột khác. Viết nghĩa gọn **2-6 chữ**, rồi gạch ngang thêm
   một vế làm rõ chỗ người Việt hay hiểu sai (vd: *deliverable* — hạng mục bàn
   giao — **thứ khách nhận được**, không phải việc mình làm). Đừng chép nguyên
   đoạn VI dài của bài học sang.

2. **Cột nghĩa Việt phải mang class `hide-me`** — để nút "Chế độ ôn tập" của
   `lesson.js` che được. Cùng một bảng: mặc định để hiểu, bật lên thành bài tự
   kiểm tra. Thiếu class này là hỏng nửa công dụng của trang.

3. **Mục "chỗ dễ sai" quan trọng hơn mục định nghĩa.** Rút từ phần **Bẫy** của các
   bài trong tuần, xếp thành Đúng / Sai / Vì sao. Ưu tiên: giới từ đi kèm
   (`escalate to`, `follow up on/with`), cặp từ dễ lẫn (`deliverable`/`delivery`),
   viết liền hay tách (`a workaround` / `work around it`), động từ bất quy tắc
   (`came`, `ran`). Nhớ nghĩa thì dễ, dùng đúng mới khó.

4. **Mỗi từ đúng MỘT câu ví dụ.** Chọn câu đắt nhất trong bài gốc, không bê cả bài
   sang. Bảng ôn dài bằng bài học gốc thì không ai đọc lại — mà không đọc lại thì
   trang này vô nghĩa.

## Ghi đè

Tuần đó đã có `wiki/recap/<tuần>.md` rồi → **được phép ghi đè**, vì tuần có thể
vừa học thêm buổi mới. Đây là bản tổng hợp phái sinh, không phải bài học gốc —
luật R5 (một ngày một bài) **không** áp dụng ở đây.
