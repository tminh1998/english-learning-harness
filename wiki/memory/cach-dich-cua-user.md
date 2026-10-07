---
name: cach-dich-cua-user
description: Sổ bản dịch user tự viết qua /dich — agent đọc trước khi viết nghĩa Việt cho bài mới và bắt chước cách dịch này
type: preference
created: 2026-09-29
evidence: 2026-09-29 — user yêu cầu "học hỏi cách dịch của tôi cho các bài sau", tạo lệnh /dich để tự dịch lại từ trong bài
---

**Cập nhật:** 2026-10-07 · **Số bản dịch đã ghi:** 14 (11 đổi · 3 giữ — observability đổi ý từ giữ sang đổi)

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
   - `chia đôi khoảng cách` → **`nhượng bộ đôi bên`** (bỏ bản dịch sát chữ, dùng từ Việt chỉ đúng hành động)
   - `chuyện xã giao` → **`chuyện phiếm`**
   _(7 lần, 2026-09-29 → 2026-10-02. Quy luật này đứng trên R7 mục 4 "có hình ảnh" khi đã có từ chuẩn.)_
   ⚠️ **Thành ngữ không dịch sát chữ.** `split the difference` ≠ "chia đôi khoảng
   cách": người Việt không nói thế. Hỏi "người Việt nói việc này bằng chữ gì?" chứ
   đừng dịch từng chữ của idiom.

2. **Thuật ngữ IT: nghĩa gọn dùng tên Việt chuẩn trong tài liệu/sách, kể cả khi dev
   hay nói tiếng Anh.** User chọn cách gọi kiểu giáo trình (thường là Hán-Việt), không
   chọn cách nói hình ảnh bình dân, và hay gọi theo **chức năng** (cái này để làm gì).
   - `mã ngắn để soi dữ liệu còn nguyên không` → **`Kiểm tra tính toàn vẹn`**
   - `soi được bên trong hệ thống` → **`khả năng quan sát`**
   - `chèn mã đo vào code` → **`Gắn công cụ đo / Theo dõi hệ thống`**
   - `hỏng thì kéo theo bao nhiêu` → **`phạm vi ảnh hưởng`**
   - `bia mộ dữ liệu / bản ghi báo đã xoá` → **`bản ghi đánh dấu đã xóa`**
   _(5 lần, 2026-09-29 → 2026-10-07.)_ Chỉ áp cho **nghĩa gọn của chính từ đang học**.
   ⚠️ **Thuật ngữ IT mượn ẩn dụ (bia mộ, vụ nổ…) thì KHÔNG dịch theo hình ảnh** —
   gọi thẳng cái nó *là* hoặc cái nó *làm*. `tombstone` ≠ "bia mộ dữ liệu",
   `blast radius` ≠ "bán kính vụ nổ". Hình ảnh gốc để dành cho dòng `Bẫy` / `GHI CHÚ`.
   Các thuật ngữ khác trong câu ví dụ / mẩu đọc vẫn theo R7 mục 2: `deploy`, `cache`,
   `log`… để nguyên tiếng Anh.

3. **Nghĩa gọn hay là HAI cách gọi nối bằng ` / `.** Một cách gọi chưa đủ thì user
   ghép thêm cách thứ hai: một từ chuẩn/khái quát + một cách nói cụ thể hoặc nghĩa
   khác của từ. Không phải hai câu dài — mỗi vế vẫn 2-5 chữ.
   - `nhượng bộ đôi bên / lấy số ở giữa` (khái quát / cụ thể)
   - `chuyện phiếm / trò chuyện xã giao` (đời thường / lịch sự)
   - `Gắn công cụ đo / Theo dõi hệ thống` (hành động / mục đích)
   - `chìm ngập trong chi tiết vụn vặt / quá bận rộn/quá tải` (nghĩa 1 / nghĩa 2)
   _(4 lần, 2026-10-02.)_ Khi viết bài mới: từ nào có một từ Việt chuẩn đủ trọn nghĩa
   thì ghi một cái thôi (vd `Hóa đơn`, `Băng thông`, `phạm vi ảnh hưởng`, `bản ghi
   đánh dấu đã xóa`); từ nào một cách gọi bị hụt nghĩa thì ghi hai, nối bằng ` / `.
   Đừng ghép vế thứ hai chỉ để chứa hình ảnh — `tombstone` user gạch vế "bia mộ dữ
   liệu", giữ một vế chức năng (2026-10-07).

4. **Từ có hai nghĩa thì nghĩa gọn ghi cả hai, đừng chôn nghĩa thứ hai xuống
   GHI CHÚ.** `in the weeds`: agent để "ngập việc tới cổ" trong ghi chú, user đưa
   lên nghĩa gọn: `… / quá bận rộn/quá tải`. _(1 lần, đi kèm luật 3 — áp luôn vì là
   trường hợp riêng của luật 3.)_

**Cách áp dụng khi viết nghĩa gọn:** hỏi trước "người Việt, hay sách tiếng Việt, gọi
cái này là gì?". Có câu trả lời → ghi đúng từ đó. Một chữ chưa đủ → thêm vế thứ hai
sau ` / `. Không có từ nào → mới viết một cụm diễn giải ngắn.

## Đang quan sát

- **Không có từ Việt tương đương thì cụm diễn giải ngắn (≤ 5 chữ) là ổn.** Hai lần
  user giữ: `nhận là việc của mình` (take ownership), `sinh sẵn bộ khung` (scaffold).
  Đã đủ 2 lần nhưng cả hai đều là "Giữ" chứ chưa phải user tự viết, nên vẫn để đây.
- **User thích từ có sắc thái "ngập / chìm" hơn "lún"**: `lún vào chi tiết vụn` →
  `chìm ngập trong chi tiết vụn vặt`, và dùng `vụn vặt` thay vì `vụn`. 1 lần.
- User viết hoa chữ đầu ở vài bản (`Hóa đơn`, `Băng thông`, `Gắn công cụ đo / Theo
  dõi hệ thống`), nhưng có bản viết thường (`khả năng quan sát`, `chuyện phiếm`). Là
  thói quen gõ, **không** phải luật: bài mới vẫn viết thường, còn bản của user thì
  giữ nguyên đúng chữ user gõ — kể cả khoảng trắng quanh `/` (`quá bận rộn/quá tải`).

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
| 2026-10-02 | instrument | chèn mã đo vào code · thêm sẵn log, metric, trace để sau này soi được… | Gắn công cụ đo / Theo dõi hệ thống | `gắn` thay `chèn mã`; thêm vế thứ hai gọi theo **mục đích** (theo dõi hệ thống) |
| 2026-10-02 | scaffold | sinh sẵn bộ khung · chạy một lệnh là ra đủ file rỗng đúng chỗ… | Giữ | — cụm ngắn 4 chữ, không có từ Việt chuẩn |
| 2026-10-02 | in the weeds | lún vào chi tiết vụn · đang sa đà vào tiểu tiết, mất cái nhìn tổng thể… | chìm ngập trong chi tiết vụn vặt / quá bận rộn/quá tải | đưa **nghĩa thứ hai** (agent để ở GHI CHÚ) lên nghĩa gọn; `chìm ngập` thay `lún`, `vụn vặt` thay `vụn` |
| 2026-10-02 | split the difference | chia đôi khoảng cách · hai bên mỗi bên nhường một nửa… | nhượng bộ đôi bên / lấy số ở giữa | bỏ bản **dịch sát chữ** của idiom; từ Việt chuẩn (`nhượng bộ`) + vế cụ thể |
| 2026-10-02 | small talk | chuyện xã giao · mấy câu thời tiết, cuối tuần, cà phê… | chuyện phiếm / trò chuyện xã giao | thêm từ đời thường `chuyện phiếm` đứng trước, giữ `xã giao` làm vế hai (user gõ "xã gia", xác nhận là "xã giao") |
| 2026-10-07 | blast radius | hỏng thì kéo theo bao nhiêu · phạm vi thiệt hại nếu cái này chết | phạm vi ảnh hưởng | nhắn thẳng trong chat — bỏ câu diễn giải bình dân, dùng **thuật ngữ chuẩn** (đúng chữ agent đã dùng trong câu dịch ví dụ); hình ảnh "kéo theo" dồn xuống `PHU` |
| 2026-10-07 | tombstone | bia mộ dữ liệu / bản ghi báo đã xoá · xoá xong chưa biến mất ngay mà để lại một dấu "đã xoá"… | bản ghi đánh dấu đã xóa | bỏ vế **dịch sát hình ảnh** ("bia mộ"), chỉ giữ một vế gọi theo **chức năng**; không cần hai vế khi một cụm đã đủ nghĩa |
