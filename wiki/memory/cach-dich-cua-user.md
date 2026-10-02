---
name: cach-dich-cua-user
description: Sổ bản dịch user tự viết qua /dich — agent đọc trước khi viết nghĩa Việt cho bài mới và bắt chước cách dịch này
type: preference
created: 2026-09-29
evidence: 2026-09-29 — user yêu cầu "học hỏi cách dịch của tôi cho các bài sau", tạo lệnh /dich để tự dịch lại từ trong bài
---

**Cập nhật:** 2026-10-02 · **Số bản dịch đã ghi:** 7 (5 đổi · 2 giữ — observability đổi ý từ giữ sang đổi)

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
   Từ nào người Việt đã có tên gọi quen (trên hóa đơn, trong từ điển, trong sách
   giáo trình IT) thì dòng đậm `.vi-quick` chỉ ghi tên đó, thường 2-4 chữ. Phần hình
   ảnh, giải thích, "dùng khi nào" dồn hết xuống dòng `PHU` và `GHI CHÚ`.
   - `giấy đòi tiền gửi khách` → **`Hóa đơn`**
   - `đồ ăn còn lại từ bữa trước` → **`Đồ ăn thừa`**
   - `soi được bên trong hệ thống` → **`khả năng quan sát`**
   - `còn rảnh sức mà nhận việc không` → **`Băng thông`** (nghĩa bóng vẫn gọi đúng tên từ Việt có sẵn)
   _(5 lần, 2026-09-29 → 2026-10-02. Quy luật này đứng trên R7 mục 4 "có hình ảnh" khi đã có từ chuẩn.)_

2. **Thuật ngữ IT: nghĩa gọn dùng tên Việt chuẩn trong tài liệu/sách, kể cả khi dev
   hay nói tiếng Anh.** User chọn cách gọi kiểu giáo trình (thường là Hán-Việt), không
   chọn cách nói hình ảnh bình dân.
   - `mã ngắn để soi dữ liệu còn nguyên không` → **`Kiểm tra tính toàn vẹn`**
   - `soi được bên trong hệ thống` → **`khả năng quan sát`**
   - `còn rảnh sức mà nhận việc không` → **`Băng thông`** (nghĩa bóng vẫn gọi đúng tên từ Việt có sẵn)
   _(2 lần, 2026-09-29.)_ Chỉ áp cho **nghĩa gọn của chính từ đang học**. Các thuật
   ngữ khác trong câu ví dụ / mẩu đọc vẫn theo R7 mục 2: `deploy`, `cache`, `log`…
   để nguyên tiếng Anh.

**Cách áp dụng khi viết nghĩa gọn:** hỏi trước "người Việt, hay sách tiếng Việt, gọi
cái này là gì?". Có câu trả lời → ghi đúng từ đó. Không có → mới viết một cụm diễn
giải ngắn.

## Đang quan sát

- **Không có từ Việt tương đương thì giữ câu diễn giải ngắn.** Mới có một ví dụ:
  `nhận là việc của mình` (take ownership), user giữ. _(Trước đây có cả observability,
  nhưng user đổi ý sang `khả năng quan sát`, nên chỉ còn 1 lần.)_
- User viết hoa chữ đầu ở vài bản (`Hóa đơn`), nhưng có bản viết thường (`khả năng
  quan sát`). Là thói quen gõ, **không** phải luật: bài mới vẫn viết thường, còn bản
  của user thì giữ nguyên đúng chữ user gõ.

## Nhật ký bản dịch

Mới nhất ở cuối. `Giữ` = user thấy bản của agent ổn, không đổi.

| Ngày dịch | Từ | Bản của agent (NGHIA · PHU) | Bản của user | Khác ở đâu |
|---|---|---|---|---|
| 2026-09-29 | observability | soi được bên trong hệ thống · log, metric, trace đủ nhiều để hỏi "sao nó lỗi"… | Giữ | — không có từ Việt tương đương, diễn giải ổn |
| 2026-09-29 | checksum | mã ngắn để soi dữ liệu còn nguyên không · băm file ra một chuỗi, hai đầu so nhau… | Kiểm tra tính toàn vẹn | gọi theo **chức năng** bằng thuật ngữ chuẩn (tính toàn vẹn = integrity), bỏ hình ảnh "soi" |
| 2026-09-29 | take ownership | nhận là việc của mình · theo tới lúc xong, hỏng thì cũng đứng ra chịu… | Giữ | — cụm thái độ, không có từ Việt tương đương |
| 2026-09-29 | invoice | giấy đòi tiền gửi khách · liệt kê đã làm gì, bao nhiêu tiền… | Hóa đơn | dùng thẳng từ chuẩn, 2 chữ thay vì cụm diễn giải 5 chữ |
| 2026-09-29 | leftovers | đồ ăn còn lại từ bữa trước · cất đi để bữa sau hâm lại ăn… | Đồ ăn thừa | từ đời thường quen miệng, ngắn hơn một nửa |
| 2026-09-29 | observability (lần 2) | soi được bên trong hệ thống · log, metric, trace đủ nhiều để hỏi "sao nó lỗi"… | khả năng quan sát | **đổi ý** so với lần đầu (Giữ) — thuật ngữ Việt chuẩn thay cho diễn giải hình ảnh "soi" |
| 2026-10-02 | bandwidth | còn rảnh sức mà nhận việc không · thời gian, người, sức — gộp lại một chữ | Băng thông | nhắn thẳng trong chat — dùng tên Việt có sẵn kể cả khi từ đang dùng **nghĩa bóng** (sức làm việc); phần "nghĩa bóng" dồn xuống `PHU` |
