---
name: cach-dich-cua-user
description: Sổ bản dịch user tự viết qua /dich — agent đọc trước khi viết nghĩa Việt cho bài mới và bắt chước cách dịch này
type: preference
created: 2026-09-29
evidence: 2026-09-29 — user yêu cầu "học hỏi cách dịch của tôi cho các bài sau", tạo lệnh /dich để tự dịch lại từ trong bài
---

**Cập nhật:** 2026-09-29 · **Số bản dịch đã ghi:** 5 (3 đổi · 2 giữ)

**Rule:** Trước khi viết `.vi-quick`, cột `Nghĩa gọn`, và các câu tiếng Việt khác cho
bài mới, đọc mục **Quy luật rút ra** rồi viết theo đúng các quy luật đó. Nghĩa gọn
phải nghe như **chính user** tự nói ra — các dòng gần nhất trong **Nhật ký bản
dịch** là mẫu giọng để bắt chước. Quy luật ở đây **thắng** thói quen dịch mặc định
của agent; chỉ R7 (giữ thuật ngữ dev bằng tiếng Anh, giọng bám vai câu gốc) đứng trên nó.

**Why:** Nghĩa Việt là cái neo trí nhớ. Câu người học tự viết ra thì họ nhớ lâu hơn
câu người khác viết, và R9 chép nguyên văn `.vi-quick` vào khối ôn nhanh — viết
càng giống giọng user thì ôn càng trúng.

**How to apply:**
- `/hoc`: đọc file này ở bước 2, cùng lúc với `MEMORY.md`.
- `/dich`: thêm dòng vào nhật ký, rồi đọc lại toàn bộ để sửa mục quy luật
  (lặp ≥ 2 lần mới lên thành luật). Luật đầy đủ: Flow E trong [AGENTS.md](../../AGENTS.md).

Liên quan: [[dich-tu-nhien]] · [[R7]]

---

## Quy luật rút ra

1. **Tiếng Việt có sẵn từ chuẩn thì nghĩa gọn là đúng từ đó, không diễn giải.**
   Từ nào người Việt đã có tên gọi quen (trên hoá đơn, trong từ điển, trong sách
   giáo trình IT) thì dòng đậm `.vi-quick` chỉ ghi tên đó, thường 2-4 chữ. Phần hình
   ảnh, giải thích, "dùng khi nào" dồn hết xuống dòng `PHU` và `GHI CHÚ`.
   - `giấy đòi tiền gửi khách` → **`Hóa đơn`**
   - `đồ ăn còn lại từ bữa trước` → **`Đồ ăn thừa`**
   - `mã ngắn để soi dữ liệu còn nguyên không` → **`Kiểm tra tính toàn vẹn`**
   _(3 lần, 2026-09-29. Quy luật này đứng trên R7 mục 4 "có hình ảnh" khi đã có từ chuẩn.)_

2. **Không có từ Việt tương đương thì câu diễn giải ngắn vẫn ổn.** Khái niệm nghề
   hay thái độ làm việc mà tiếng Việt không có sẵn một từ thì user giữ nguyên bản
   diễn giải của agent.
   - `soi được bên trong hệ thống` (observability), `nhận là việc của mình` (take ownership) — **giữ**
   _(2 lần, 2026-09-29.)_

**Cách áp dụng khi viết nghĩa gọn:** hỏi trước "người Việt gọi cái này là gì?". Có
câu trả lời → ghi đúng từ đó. Không có → mới viết một cụm diễn giải ngắn.

## Đang quan sát

- Nghiêng về **từ Hán-Việt / từ chuẩn** (`tính toàn vẹn`, `hóa đơn`), kể cả với thuật
  ngữ IT — với từ IT có tên Việt chuẩn thì không cần kiểu nói chuyện bình dân. Chưa đủ
  dữ liệu để tách riêng luật cho nhóm IT.
- User viết hoa chữ đầu (`Hóa đơn`). Có vẻ là thói quen gõ form, **không** phải luật —
  bài mới vẫn viết thường như cũ, bản của user thì giữ nguyên chữ user gõ.

## Nhật ký bản dịch

Mới nhất ở cuối. `Giữ` = user thấy bản của agent ổn, không đổi.

| Ngày dịch | Từ | Bản của agent (NGHIA · PHU) | Bản của user | Khác ở đâu |
|---|---|---|---|---|
| 2026-09-29 | observability | soi được bên trong hệ thống · log, metric, trace đủ nhiều để hỏi "sao nó lỗi"… | Giữ | — không có từ Việt tương đương, diễn giải ổn |
| 2026-09-29 | checksum | mã ngắn để soi dữ liệu còn nguyên không · băm file ra một chuỗi, hai đầu so nhau… | Kiểm tra tính toàn vẹn | gọi theo **chức năng** bằng thuật ngữ chuẩn (tính toàn vẹn = integrity), bỏ hình ảnh "soi" |
| 2026-09-29 | take ownership | nhận là việc của mình · theo tới lúc xong, hỏng thì cũng đứng ra chịu… | Giữ | — cụm thái độ, không có từ Việt tương đương |
| 2026-09-29 | invoice | giấy đòi tiền gửi khách · liệt kê đã làm gì, bao nhiêu tiền… | Hóa đơn | dùng thẳng từ chuẩn, 2 chữ thay vì cụm diễn giải 5 chữ |
| 2026-09-29 | leftovers | đồ ăn còn lại từ bữa trước · cất đi để bữa sau hâm lại ăn… | Đồ ăn thừa | từ đời thường quen miệng, ngắn hơn một nửa |
