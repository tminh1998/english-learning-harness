# Từ người học đánh dấu "đã biết" — không bao giờ dạy lại

**Ghi ngày:** 2026-08-24 · **Nguồn:** user nói thẳng trong buổi #10
**Cập nhật:** 2026-09-01 (buổi #17) — thêm `debounce` · `payload`

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

**Mở rộng sau buổi #17 (2026-09-01).** Lần đó trượt tiếp hai từ nữa: `debounce` và
`payload`. Cả hai đều **không** phải lệnh git/CI, nên bộ lọc cũ không bắt được —
chúng là **từ nằm sẵn trong code người học viết hằng ngày** (hàm FE, field của
request). Bộ lọc vì thế phải rộng hơn một bậc:

> ⛔ Từ mà người học **gõ ra trong lúc làm việc** — tên hàm, tên field, tên tham số,
> option trong config — thì gần như chắc chắn đã biết. Không chỉ lệnh terminal.
>
> ✅ Từ người học **nghe/đọc thấy trong tài liệu kiến trúc, email khách, bản SLA,
> postmortem** — hiểu ý nhưng ít khi tự viết ra — mới là suất đáng dạy.

Phép thử nhanh trước khi chốt một từ IT: *"từ này có khả năng xuất hiện trong code
hoặc trong tên biến của user không?"* Có → bỏ. Ví dụ đã kiểm chứng là an toàn:
`failover`, `graceful degradation` (buổi #17) — dev đọc hiểu ngay, nhưng để tự nói
thành câu với khách thì hay bí.
