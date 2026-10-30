---
name: cach-dich-cua-user
description: Sổ bản dịch user tự viết qua /dich — agent đọc trước khi viết nghĩa Việt cho bài mới và bắt chước cách dịch này
type: preference
created: 2026-09-29
evidence: 2026-09-29 — user yêu cầu "học hỏi cách dịch của tôi cho các bài sau", tạo lệnh /dich để tự dịch lại từ trong bài
---

**Cập nhật:** 2026-10-30 · **Số bản dịch đã ghi:** 25 (22 đổi · 3 giữ — observability đổi ý từ giữ sang đổi)

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
   - `nói thẳng ra chỗ đó` → **`chỉ đích danh`** (call out — thành ngữ Việt có sẵn, 2026-10-30)
   _(8 lần, 2026-09-29 → 2026-10-30. Quy luật này đứng trên R7 mục 4 "có hình ảnh" khi đã có từ chuẩn.)_
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
   - `Điểm nóng, chỗ chiếm tài nguyên nhiều` (từ chuẩn / chức năng — hotspot, 2026-10-28)
   _(5 lần, 2026-10-02 → 2026-10-28.)_ Vế nối có thể là ` / ` hoặc dấu phẩy `, ` (`wire up`, `give or take`, `hotspot`) — giữ đúng dấu user gõ. Khi viết bài mới: từ nào có một từ Việt chuẩn đủ trọn nghĩa
   thì ghi một cái thôi (vd `Hóa đơn`, `Băng thông`, `phạm vi ảnh hưởng`, `bản ghi
   đánh dấu đã xóa`); từ nào một cách gọi bị hụt nghĩa thì ghi hai, nối bằng ` / `.
   Đừng ghép vế thứ hai chỉ để chứa hình ảnh — `tombstone` user gạch vế "bia mộ dữ
   liệu", giữ một vế chức năng (2026-10-07).

4. **Từ có hai nghĩa thì nghĩa gọn ghi cả hai, đừng chôn nghĩa thứ hai xuống
   GHI CHÚ.** `in the weeds`: agent để "ngập việc tới cổ" trong ghi chú, user đưa
   lên nghĩa gọn: `… / quá bận rộn/quá tải`. _(1 lần, đi kèm luật 3 — áp luôn vì là
   trường hợp riêng của luật 3.)_
   ⭐ **Nghĩa user dùng hằng ngày đứng trước.** `nail down`: agent để "chốt cứng" làm
   nghĩa gọn, "truy ra nguyên nhân" làm `PHU`; user đảo lên: **`Truy ra đúng nguyên nhân`**
   — với dev, nghĩa debug gặp nhiều hơn nghĩa chốt scope. Bài mới: từ hai nghĩa thì
   nghĩa dev/IT hay gặp nằm ở dòng đậm, nghĩa kia xuống `PHU`.
   _(2 lần: `in the weeds` 2026-10-02 đưa nghĩa 2 lên, `nail down` 2026-10-29 đảo hẳn.)_

5. **Hai từ gần nghĩa thì tách bằng danh từ đầu, đừng để trùng nghĩa gọn.** Trước
   2026-10-08 `fallback` và `contingency` cùng mang chữ "phương án". User tách:
   `contingency` → **`Phương án dự phòng`** (kế hoạch do *người* lập),
   `fallback` → **`Cơ chế dự phòng`** (thứ *kỹ thuật* tự chạy). Viết nghĩa gọn cho từ
   mới thì grep cột `Nghĩa gọn` trong VOCAB_INDEX trước: đã có từ khác mang đúng chữ
   đó thì chọn danh từ đầu khác (`phương án` / `cơ chế` / `quy trình` / `khả năng`…).
   _(1 lần nhưng gồm 2 từ — áp luôn.)_

6. **Từ chỉ một quá trình / luồng dữ liệu → nghĩa gọn kể thẳng các bước nó làm,
   nói như một hành động — kể cả khi tiếng Anh là danh từ.** Không dịch gốc chữ,
   không dùng hình ảnh; thà dài hơn 5 chữ mà đủ bước còn hơn gọn mà phải đoán.
   - `rút hết việc rồi mới tắt` → **`ngưng nhận công việc mới và làm nốt việc đang dở`** (drain)
   - `nuốt dữ liệu từ ngoài vào` → **`Parse dữ liệu rồi lưu lại`** (ingest)
   - `dữ liệu đo xa / số liệu máy tự gửi về` → **`tự thu thập dữ liệu gửi về`** (telemetry —
     danh từ, nhưng user nói thành hành động *thu thập → gửi về*)
   _(3 lần, 2026-10-08 → 2026-10-26.)_ ⚠️ Từ ghép kiểu Hy Lạp/Latin (`tele-` + `-metry`)
   thì **đừng** dịch sát gốc chữ thành Hán-Việt (`đo xa`) rồi ghép thêm vế thứ hai theo
   luật 3 — user bỏ cả cụm hai vế, giữ một cụm chức năng.

7. **Thuật ngữ dev mà dev Việt quen nói bằng tiếng Anh thì để nguyên tiếng Anh ngay
   trong nghĩa gọn — kể cả khi sách có tên Hán-Việt.** R7 không chỉ áp cho câu ví dụ:
   user tự gõ chữ tiếng Anh vào dòng đậm, rồi chỉ thêm phần tiếng Việt nói nó làm gì.
   - `nuốt dữ liệu từ ngoài vào` → **`Parse dữ liệu rồi lưu lại`** (ingest)
   - `phụ thuộc bắc cầu / package cài kèm chứ mình không khai` → **`dependency được cài kèm`**
     (transitive dependency — bỏ tên giáo trình `phụ thuộc bắc cầu`)
   _(2 lần, 2026-10-09 → 2026-10-30.)_ ⚠️ Giới hạn luật 2: tên Hán-Việt kiểu sách chỉ
   dùng khi dev **không** quen nói tiếng Anh (`Kiểm tra tính toàn vẹn`, `phạm vi ảnh hưởng`).
   Thuật ngữ ghép (`transitive dependency`): giữ danh từ dev quen (`dependency`), phần
   tính từ khó (`transitive`) thì nói bằng chức năng (`được cài kèm`) chứ đừng dịch gốc
   chữ (`bắc cầu`) — cùng hướng ⚠️ của luật 6 (`đo xa`).

**Cách áp dụng khi viết nghĩa gọn:** hỏi trước "người Việt, hay sách tiếng Việt, gọi
cái này là gì?". Có câu trả lời → ghi đúng từ đó. Một chữ chưa đủ → thêm vế thứ hai
sau ` / `. Không có từ nào → mới viết một cụm diễn giải ngắn.

## Đang quan sát

- **Không có từ Việt tương đương thì cụm diễn giải ngắn (≤ 5 chữ) là ổn.** Hai lần
  user giữ: `nhận là việc của mình` (take ownership), `sinh sẵn bộ khung` (scaffold).
  Đã đủ 2 lần nhưng cả hai đều là "Giữ" chứ chưa phải user tự viết, nên vẫn để đây.
  ⚠️ Ngược lại (2026-10-08): `drain` — từ chỉ một **quy trình nhiều bước**, user tự viết
  `ngưng nhận công việc mới và làm nốt việc đang dở` (11 chữ). Tức là ngắn không quan
  trọng bằng **đủ các bước**: thà dài mà rõ từng bước còn hơn gọn mà phải đoán.
  → **Đã nâng thành quy luật 6** (2026-10-26, sau `ingest` và `telemetry`).
- **User hay nhặt đúng cụm agent đã viết ở `PHU` hoặc câu dịch ví dụ lên làm nghĩa gọn**: `sweet tooth` (`thích ăn đồ ngọt` ← PHU), `blast radius` (`phạm vi ảnh hưởng` ← câu dịch), `nail down` (← PHU), `transitive dependency` (`cài kèm` ← câu dịch), `call out` (`chỉ đích danh` ← đầu PHU). Tức là bản tốt hay đã nằm sẵn trong bài, chỉ bị đặt sai chỗ: khi viết bài mới, cụm gọn và trúng nhất phải lên dòng đậm chứ đừng để dưới PHU.
- **User thích từ có sắc thái "ngập / chìm" hơn "lún"**: `lún vào chi tiết vụn` →
  `chìm ngập trong chi tiết vụn vặt`, và dùng `vụn vặt` thay vì `vụn`. 1 lần.
- User viết hoa chữ đầu ở vài bản (`Hóa đơn`, `Băng thông`, `Gắn công cụ đo / Theo
  dõi hệ thống`), nhưng có bản viết thường (`khả năng quan sát`, `chuyện phiếm`). Là
  thói quen gõ, **không** phải luật: bài mới vẫn viết thường, còn bản của user thì
  giữ nguyên đúng chữ user gõ — kể cả khoảng trắng quanh `/` (`quá bận rộn/quá tải`).

- **Bỏ phủ định, đổi khẩu ngữ sang chữ chuẩn của dự án.** `gold-plating`: `làm thừa cái khách không xin` → `Làm thừa cái khách yêu cầu` — thay `không xin` bằng `yêu cầu` (chữ hay dùng trong spec/hợp đồng). Cùng hướng với `give or take` (`xê xích` → `xấp xỉ`) và `splurge` (`vung tay` → `phung phí`): user hay đổi khẩu ngữ sang chữ chuẩn hơn — nhưng `sweet tooth` thì ngược lại (`hảo ngọt` → `thích ăn đồ ngọt`), nên chưa thành luật. Gặp thêm một lần bỏ phủ định thì nâng thành luật.

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
| 2026-10-08 | drain | rút hết việc rồi mới tắt · chặn request mới, chờ mấy cái đang chạy xong đã | ngưng nhận công việc mới và làm nốt việc đang dở | nhắn thẳng trong chat — không có từ Việt chuẩn nên user **mô tả đủ hai vế hành động** (dừng nhận + làm nốt), bỏ vế kết quả "rồi mới tắt"; dài 11 chữ, vượt ngưỡng ≤ 5 chữ của mục "Đang quan sát" |
| 2026-10-08 | contingency | phương án phòng khi hỏng · chưa chắc xảy ra, nhưng phải có sẵn đường lui | Phương án dự phòng | nhắn thẳng trong chat, đi cặp với `fallback` — từ chuẩn Hán-Việt; danh từ đầu **`Phương án`** = kế hoạch do người lập |
| 2026-10-08 | fallback | phương án dự phòng · cái chính hỏng thì tự chạy cái này | Cơ chế dự phòng | đổi cùng lúc với `contingency` để **tách hai từ gần nghĩa**: `Cơ chế` = thứ kỹ thuật tự chạy, `Phương án` = kế hoạch của người |
| 2026-10-08 | wire up | đấu nối / gắn vào cho chạy được · gắn phần mới vào đúng chỗ — thêm route, truyền props, bind event… | đấu nối, tích hợp | nhắn thẳng trong chat — giữ `đấu nối`, bỏ vế diễn giải "gắn vào cho chạy được", thay bằng **thuật ngữ chuẩn** `tích hợp` (= integrate); vế diễn giải dồn xuống `PHU`. User gõ "đấu nối , tích hợp" — bỏ khoảng trắng trước dấu phẩy |
| 2026-10-08 | give or take | xê xích chừng đó / cộng trừ một chút · dán ngay sau con số để nói "khoảng đó, hơn kém một chút"… | xấp xỉ, khoảng chừng, cộng trừ không đáng kể | nhắn thẳng trong chat — bỏ `xê xích` (khẩu ngữ), đưa **từ chuẩn** `xấp xỉ` lên đầu; giữ `cộng trừ` nhưng đổi `một chút` → `không đáng kể`; ba vế ngăn bằng dấu phẩy như `wire up` |
| 2026-10-08 | sweet tooth | hảo ngọt · thích đồ ngọt, thấy bánh kẹo là khó chối | thích ăn đồ ngọt | nhắn thẳng trong chat — bỏ từ Hán-Việt ít dùng trong văn nói (`hảo ngọt`), lấy **cách nói đời thường** (chính là vế PHU cũ của agent, thêm chữ `ăn`) |
| 2026-10-09 | ingest | nuốt dữ liệu từ ngoài vào · nhận, parse rồi ghi xuống kho — không chỉ là đọc file | Parse dữ liệu rồi lưu lại | bỏ hình ảnh **"nuốt"**, dịch thẳng **hai bước chức năng** (parse → lưu); giữ `Parse` bằng tiếng Anh vì là thuật ngữ dev (R7); hai vế nối bằng `rồi` như `drain` |
| 2026-10-09 | splurge | vung tay tiêu một phát · chi hẳn một khoản to cho thứ mình thích, thường là tự thưởng | Sự phung phí | bỏ cụm khẩu ngữ 4 chữ, dùng **danh từ Hán-Việt 2 chữ** (`Sự` + từ chuẩn); chuyển động từ thành danh từ (từ vừa là verb vừa là noun); sắc thái "tự thưởng" dồn xuống `PHU` |
| 2026-10-19 | gold-plating | làm thừa cái khách không xin · tự ý đánh bóng thêm ngoài yêu cầu — tốn giờ, dễ trễ hạn… | Làm thừa cái khách yêu cầu | bỏ vế **phủ định** `không xin`, nói theo mốc so sánh là **cái khách yêu cầu** (làm thừa ra so với yêu cầu); `yêu cầu` là chữ chuẩn của dự án thay cho khẩu ngữ `xin`; giữ nguyên dòng PHU |
| 2026-10-26 | telemetry | dữ liệu đo xa / số liệu máy tự gửi về · log, metric, trace, số lần crash… chương trình tự bắn về để bên mình theo dõi, không ai ngồi thu tay | tự thu thập dữ liệu gửi về | bỏ vế dịch **sát gốc chữ** `đo xa` (tele + metry) và bỏ luôn kiểu **hai vế** `/`; danh từ mà user nói thành **hành động hai bước** (thu thập → gửi về), giữ chữ `tự` của vế cũ; giữ nguyên dòng PHU — lần thứ 3 sau `drain`, `ingest` → nâng thành quy luật 6 |
| 2026-10-28 | hotspot | điểm nóng · chỗ ngốn gần hết thời gian chạy, hoặc chỗ hứng gần hết request — profiler chỉ vào đâu thì sửa đúng đó | Điểm nóng, chỗ chiếm tài nguyên nhiều | nhắn thẳng trong chat — giữ từ chuẩn `Điểm nóng` nhưng thấy **một mình nó hụt nghĩa** (dễ lẫn điểm nóng du lịch/Wi-Fi), ghép thêm vế **chức năng** `chỗ chiếm tài nguyên nhiều`; nối bằng dấu phẩy như `wire up`, `give or take`. User gõ "Điểm nóng , chỗ…" — bỏ khoảng trắng trước dấu phẩy; giữ nguyên dòng PHU |
| 2026-10-29 | nail down | chốt cứng cho hết lửng lơ · hoặc: truy cho ra đúng nguyên nhân | Truy ra đúng nguyên nhân | nhắn thẳng trong chat — **đảo hai nghĩa**: lấy nghĩa ở `PHU` (debug, tìm nguyên nhân) lên dòng đậm, bỏ chữ `cho` và `hoặc:`; nghĩa "chốt cứng" (chốt scope với khách) chuyển xuống `PHU` để không mất. Không có `\|` nên agent tự đảo PHU — báo user |
| 2026-10-30 | transitive dependency | phụ thuộc bắc cầu / package cài kèm chứ mình không khai · mình chỉ khai một package, nó kéo theo cả chùm package khác… | dependency được cài kèm | bỏ vế Hán-Việt **dịch sát gốc chữ** `phụ thuộc bắc cầu` (transitive = bắc cầu) dù đó là tên sách giáo trình; **giữ `dependency` bằng tiếng Anh** (dev nói vậy hằng ngày), thay `package` bằng `dependency`; bỏ vế phủ định `chứ mình không khai` và bỏ kiểu hai vế — một cụm duy nhất. Lấy đúng chữ `cài kèm` agent đã dùng trong câu dịch ví dụ; giữ nguyên dòng PHU — lần 2 giữ thuật ngữ dev tiếng Anh sau `Parse` (ingest) → nâng thành quy luật 7 |
| 2026-10-30 | call out | nói thẳng ra chỗ đó · chỉ đích danh một điểm cho mọi người cùng thấy — khen hay nhắc lỗi đều dùng được | chỉ đích danh | nhắn thẳng trong chat — lấy đúng **cụm đầu dòng PHU** của agent lên dòng đậm (như `sweet tooth`, `nail down`); bỏ cụm khẩu ngữ 5 chữ `nói thẳng ra chỗ đó`, chọn **thành ngữ Việt có sẵn** 3 chữ chỉ đúng hành động (luật 1); giữ nguyên dòng PHU |
