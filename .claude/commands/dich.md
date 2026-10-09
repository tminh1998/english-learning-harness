---
description: Tự dịch lại nghĩa của một từ đã học bằng lời mình — hỏi từng từ một, nghĩa mới áp vào bài hôm nay và mọi bài sau
argument-hint: "[từ => nghĩa mới — bỏ trống thì agent hỏi]"
---

Chạy **Flow E — User tự dịch lại** trong `AGENTS.md`.

Đầu vào (có thể trống): $ARGUMENTS

Mục đích có hai phần, phần sau quan trọng hơn:

1. Nghĩa gọn của từ được thay bằng **lời của chính người học**. Tự nói ra thì nhớ
   lâu hơn đọc câu người khác viết, và khối ôn nhanh (R9) chép nguyên văn nghĩa này
   nên từ nay user sẽ ôn lại đúng câu mình tự viết.
2. Agent **học cách dịch của user** — mỗi bản dịch được ghi vào
   `wiki/memory/cach-dich-cua-user.md`, và `/hoc` đọc sổ đó trước khi viết nghĩa Việt
   cho bài mới.

⭐ **Làm TỪNG TỪ MỘT** (user chốt 2026-10-09). Không hỏi cả 5 từ của một buổi nữa.
Mỗi vòng: hỏi **từ nào** → hỏi **nghĩa mới** → áp xong + push → hỏi từ tiếp theo.
User chọn "Xong" thì dừng.

## 0. Chuẩn bị (một lần đầu lệnh)

```bash
. tools/openit.sh
keove
D=$(hnay)                                                     # hôm nay, giờ VN
T=$(find wiki/lessons -name "$D*.html" 2>/dev/null | sort | tail -1)   # bài hôm nay (có thể rỗng)
echo "HOM-NAY $D · BAI ${T:-chua-co}"
```

`$ARGUMENTS` có dạng `<từ> => <nghĩa>` (hoặc `<từ> thành <nghĩa>`, `<từ>: <nghĩa>`)
→ vòng đầu **bỏ qua bước 1 và 2**, đi thẳng bước 3 với từ + nghĩa đó. Chỉ có `<từ>` →
bỏ bước 1. Trống → bắt đầu từ bước 1.

## 1. Hỏi từ cần dịch

**AskUserQuestion**, một câu:

- `header`: `Từ cần dịch`
- `question`: `Bạn muốn dịch lại từ nào? (gõ từ bất kỳ đã học vào ô Other)`
- `options`: tối đa **3** từ của bài hôm nay (lấy từ VOCAB_INDEX cột Ngày = `$D`; chưa
  có bài hôm nay thì lấy bài gần nhất) — `description` = nghĩa gọn hiện tại; và luôn có
  option cuối **`Xong`** — "Dừng, không dịch thêm từ nào".

User có thể gõ từ của **bất kỳ ngày nào**, không chỉ bài hôm nay.

Tra từ đó:

```bash
sh tools/nghia.sh "<từ>"        # in TU / NGHIA / PHU / VD — hoặc LOI nếu không có
```

- In `LOI` / không có trong bảng chính `wiki/VOCAB_INDEX.md` → nói "chưa học từ này"
  (nằm ở bảng ⛔ Đã biết sẵn thì nói rõ vậy) rồi quay lại bước 1.
- Gõ dạng khác trong họ từ (`drained`, `fell back`) → quy về từ gốc của dòng đó.

## 2. Hỏi nghĩa mới của từ đó

**AskUserQuestion**, một câu:

- `header`: tên từ (cắt ≤ 12 ký tự)
- `question`: `<từ> — "<VD cắt gọn>". Hiện đang là: <NGHIA>. Bạn dịch từ này thế nào?`
- `options` (đúng hai, user tự gõ bản của mình vào ô **Other**):
  1. `Giữ bản hiện tại` — `description` = `<NGHIA> · <PHU>` nguyên văn
  2. `Bỏ qua` — `description` = "Chưa nghĩ ra, để nguyên, không ghi gì"
- ⛔ **Không** gợi ý bản dịch nào khác — thứ cần là lời của user.

Nhắc một dòng trước form: *gõ nghĩa gọn vào ô Other; muốn đổi luôn dòng phụ thì viết
`nghĩa gọn | dòng phụ`.*

Không có AskUserQuestion (vd chạy qua routine) → hỏi bằng chữ trong chat
(`Từ nào? Trả lời dạng: từ => nghĩa mới`) rồi dừng lượt chờ.

## 3. Áp nghĩa mới — bài hôm nay và mọi bài về sau

Chép **đúng chữ user gõ** — không sửa chính tả, không "làm mượt", không đổi hoa/thường,
không thêm dấu câu. Có lỗi gõ rõ ràng (sai dấu, lặp chữ) thì hỏi lại một câu.
"Giữ bản hiện tại" và "Bỏ qua" → không sửa file nào, sang bước 4.

Nghĩa mới phải hiện ở **bài hôm nay** và ở **mọi lần từ đó xuất hiện về sau** (khối ôn
nhanh, câu ví dụ mượn từ cũ, bảng ôn). Muốn vậy thì sửa đủ các lớp sau:

| Lớp | Sửa gì | Vì sao |
|---|---|---|
| **Nguồn** — bài gốc `<ngày học>.html` | dòng đậm `<p class="vi-quick">` (+ `<span class="alt">` nếu user viết `\|`) | `tools/nghia.sh` đọc chỗ này → **mọi khối ôn nhanh về sau** tự lấy nghĩa mới |
| **Nguồn** — `wiki/VOCAB_INDEX.md` | cột `Nghĩa gọn` của đúng dòng từ đó | `/hoc` tra cột này khi viết câu ví dụ mượn từ cũ (R8) |
| **Bài hôm nay** `$T` (.md + .html) | khối ôn nhanh nếu có từ này; câu dịch Việt nào đang diễn đạt từ này theo nghĩa cũ (ví dụ mượn từ cũ, mẩu đọc, bài tập) | user đang học bài này — phải thấy nghĩa mới ngay |
| **Bản chép lại** — khối ôn nhanh các bài khác + `wiki/recap/<tuần>.*` | chỗ nào chép nguyên văn nghĩa cũ | để không có hai nghĩa cãi nhau khi user mở lại bài cũ |
| Bảng ôn tháng/quý/nửa năm/năm | **không sửa tay** — `sh tools/build-index.sh` tự sinh lại | sinh máy từ `.vi-quick` |

Tìm chỗ chép lại bằng lệnh, đừng đoán:

```bash
grep -rnF "<NGHIA cũ>" wiki/lessons wiki/recap wiki/VOCAB_INDEX.md
```

Chỉ thay chỗ đúng là nghĩa **của từ này** (một cụm ngắn có thể trùng ở từ khác).

⭐ **Bài gốc cũng viết lại theo cách dịch mới** (luật 2026-09-29, vẫn giữ): trong cả
`.md` lẫn `.html` của ngày học từ đó, mọi câu tiếng Việt diễn đạt từ này theo kiểu cũ
đều sửa cho khớp — `**VI**` (.md), `GHI CHÚ` + `.def-vi` (.html), câu dịch ví dụ, bản
dịch mẩu đọc, đề bài tập tiếng Việt, Ghi chú buổi học. Chỉ đổi phần nói về **nghĩa** —
sắc thái, bẫy, collocation giữ nguyên. Từ gần nghĩa đang mang đúng chữ mới (vd
`fallback` đang ghi "phương án dự phòng" khi user đặt chữ đó cho `contingency`) → báo
user trong chat, đừng tự đổi từ kia.

Sửa xong grep lại cụm cũ cho chắc không còn sót.

## 4. Ghi vào sổ cách dịch — phần để agent học

Mở `wiki/memory/cach-dich-cua-user.md`:

1. **Thêm một dòng** vào bảng "Nhật ký bản dịch" (cả khi user chọn "Giữ bản hiện
   tại" — đó cũng là tín hiệu). "Bỏ qua" thì không ghi. Cột `Khác ở đâu` viết ngắn,
   cụ thể: ngắn hơn / bỏ hình ảnh / dùng từ chuẩn / đổi động từ / đổi giọng…
2. **Đọc lại toàn bộ bảng rồi sửa mục "Quy luật rút ra"**: lặp **≥ 2 lần** → quy luật
   (kèm 1-2 cặp `bản agent → bản user`); mới 1 lần → "Đang quan sát"; luật cũ bị nói
   ngược lại → sửa hoặc xoá.
3. Cập nhật dòng `Cập nhật:` và số bản dịch ở đầu file.

## 5. Lưu lên GitHub — sau MỖI từ, không hỏi

⛔ Xong một từ là **đẩy lên ngay** rồi mới hỏi từ tiếp theo (user chốt 2026-09-29: "khi
sửa xong luôn phải đẩy lên git"). User đọc trên Pages / điện thoại — chưa push thì vẫn
thấy bản cũ. Đẩy từng từ cũng để VM cloud bị thu hồi giữa chừng không mất gì.

```bash
sh tools/build-index.sh      # sinh lại bảng ôn tháng/quý/nửa năm/năm theo nghĩa mới
daylen "dich: <từ> -> <nghĩa mới>"
```

Không in `DA-PUSH` → nói thẳng là chưa lưu lên GitHub, kèm lỗi. "Bỏ qua" → không có gì
để push. ("Giữ" vẫn thêm dòng vào sổ → vẫn push.)

## 6. Báo một dòng rồi quay lại bước 1

Sau mỗi từ, nói ngắn trong chat: `<từ>: <cũ> → <mới>` · đã sửa những bài nào ·
`DA-PUSH`. Rồi **quay lại bước 1** để hỏi từ tiếp theo.

Khi user chọn **Xong**:

- Bảng tóm tắt các từ vừa dịch trong lượt này: từ · bản cũ → bản của user.
- Một hai câu: agent rút ra được gì về cách dịch của user, quy luật nào trong sổ vừa
  thêm/sửa.
- Mở bài hôm nay bằng `openit "$T"` nếu user muốn xem.
