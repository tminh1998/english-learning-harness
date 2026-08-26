# Từ người học đánh dấu "đã biết" — không bao giờ dạy lại

**Ghi ngày:** 2026-08-24 · **Nguồn:** user nói thẳng trong buổi #10

## Quy luật

Người học là dev đi làm thật, vốn IT bị động đã khá rộng: những từ xuất hiện hằng
ngày trong git / CI / deploy (`hotfix`, `overwrite`, `cherry-pick`) thì **đã biết
sẵn**, dạy lại là phí một suất trong năm suất mỗi ngày.

## Hành động

1. User nói *"từ này tôi đã biết"* → thêm ngay vào bảng
   `## ⛔ Đã biết sẵn` ở cuối `wiki/VOCAB_INDEX.md`, **đủ word family**.
2. Không đưa từ đó vào `REVIEW_QUEUE.md`, không tính vào tổng số từ.
3. Thay bằng từ khác **cùng nhóm**, viết lại mọi chỗ trong bài (ví dụ, mẩu đọc,
   bài tập, đáp án) cho đúng R8.
4. Từ buổi sau: gate R1 grep cả file nên bảng này tự chặn — xem R1.b trong AGENTS.md.

## Chọn từ IT thế nào cho đỡ trúng từ đã biết

Tránh nhóm "lệnh gõ hằng ngày" (git/CI/log). Ưu tiên từ nằm ở **mức khái niệm và
mức trao đổi với khách**: `cutover`, `backfill`, `backpressure`, `dead letter
queue`, `soak test`, `phased rollout`… — dev Việt hiểu ý nhưng thường không chủ
động nói ra được bằng tiếng Anh.
