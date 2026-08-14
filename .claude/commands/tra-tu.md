---
description: Tra từ/câu bắt gặp ngoài đời (doc, email khách, phim, truyện) và lưu vào vốn từ
argument-hint: "<từ hoặc câu tiếng Anh cần hiểu>"
---

Chạy **Flow C — Tra từ ad-hoc** trong `AGENTS.md`.

Nội dung cần tra: $ARGUMENTS

1. Grep `wiki/VOCAB_INDEX.md` xem đã học chưa.
   - Đã học → nói rõ đã học ngày nào, nhắc lại nghĩa + collocation, hỏi user còn
     thấy khó ở đâu, và cân nhắc reset bậc trong `REVIEW_QUEUE.md`.
   - Chưa học → đi tiếp.
2. Giải thích song ngữ: IPA, từ loại, định nghĩa EN, nghĩa Việt + nuance, tại sao
   tác giả dùng từ đó ở đây, 1-2 câu ví dụ khác bối cảnh, collocation, bẫy hay mắc.
   Nếu là cả câu: phân tích cấu trúc + điểm ngữ pháp đáng chú ý.
3. Hỏi user: **có đưa vào vốn từ để ôn không?**
   - Có → thêm dòng vào `wiki/VOCAB_INDEX.md` với `source = ad-hoc` +
     đẩy vào `wiki/REVIEW_QUEUE.md` (bậc 1, next_review = mai).
     Từ này từ nay **không được ra lại** làm từ mới trong `/hoc`.
   - Không → chỉ giải thích, không ghi gì.
4. Nếu là điểm ngữ pháp đáng lưu → tạo/ghi thêm file trong `wiki/grammar/`.
5. **Có ghi file ở bước 3 hoặc 4** → `. tools/openit.sh; daylen "tra-tu: <từ>"` (R6).
   Không ghi gì thì bỏ qua. Không in `DA-PUSH` → nói thẳng là từ chưa lưu lên GitHub.
