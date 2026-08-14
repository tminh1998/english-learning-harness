---
description: Ôn nhanh các từ tới hạn theo lịch spaced repetition
argument-hint: "[số từ tối đa, mặc định 15]"
---

1. `git pull --rebase 2>/dev/null; . tools/openit.sh; hnay` — kéo bài từ máy khác về
   (R6) rồi lấy ngày thật. ⚠️ **Không dùng `date` trần**: trên VM cloud nó chạy giờ
   UTC, lấy sai ngày là lọc sai danh sách từ tới hạn.
2. Đọc `wiki/REVIEW_QUEUE.md`, lấy các dòng có `next_review` ≤ hôm nay.
   Giới hạn: $ARGUMENTS (mặc định `review.maxPerSession` = 15). Ưu tiên bậc thấp nhất trước.
3. Không có từ nào tới hạn → nói rõ, gợi ý chạy `/hoc` thay vì bịa bài ôn.
4. Hỏi từng từ: đưa **nghĩa Việt hoặc câu cloze**, user tự nhớ từ tiếng Anh.
   ⛔ Không hiện từ trước khi user trả lời (R2).
5. Chấm từng câu ngay. Sau khi xong toàn bộ, cập nhật `wiki/REVIEW_QUEUE.md`:
   - đúng → lên bậc kế theo `review.intervalsDays` [1, 3, 7, 16, 35], tính `next_review` mới
   - sai → tụt về bậc 1, `next_review` = mai, đánh dấu cột `sai` +1
6. Cập nhật `wiki/PROGRESS.md` (số lượt ôn, từ đang yếu).
7. `git add -A && git commit -m "on-tap: $(hnay)" && git push` (R6). Push lỗi → nói
   thẳng là kết quả ôn chưa lưu lên GitHub, đừng báo xong.
