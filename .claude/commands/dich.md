---
description: Tự dịch lại 5 từ của một buổi học bằng lời của mình — agent ghi vào bài và học theo cách dịch đó cho các bài sau
argument-hint: "[ngày YYYY-MM-DD — bỏ trống = hôm nay]"
---

Chạy **Flow E — User tự dịch lại** trong `AGENTS.md`.

Ngày cần dịch lại (bỏ trống = hôm nay): $ARGUMENTS

Mục đích có hai phần, phần sau quan trọng hơn:

1. Nghĩa gọn của từ được thay bằng **lời của chính người học**. Tự nói ra thì nhớ
   lâu hơn đọc câu người khác viết, và khối ôn nhanh (R9) chép nguyên văn nghĩa này
   nên từ nay user sẽ ôn lại đúng câu mình tự viết.
2. Agent **học cách dịch của user** — mỗi bản dịch được ghi vào
   `wiki/memory/cach-dich-cua-user.md`, và `/hoc` đọc sổ đó trước khi viết nghĩa Việt
   cho bài mới.

## 1. Lấy 5 từ của buổi đó

```bash
. tools/openit.sh
keove

D="${ARGUMENTS:-$(hnay)}"
F=$(find wiki/lessons -name "$D.html" 2>/dev/null | head -1)
if [ -z "$F" ]; then
  F=$(find wiki/lessons -name "20*.html" 2>/dev/null | sort | tail -1)
  D=$(basename "$F" .html | cut -c1-10)
  echo "KHONG-CO-BAI-NGAY-${ARGUMENTS:-hom-nay} -> dung bai $D"
fi
echo "BAI $F"
awk -F'|' -v d="$D" '/^\| [0-9]+ \|/ { n=$8; gsub(/ /,"",n); if (n==d) { t=$3; gsub(/^ +| +$/,"",t); print t } }' \
  wiki/VOCAB_INDEX.md | sh tools/nghia.sh
```

In ra `KHONG-CO-BAI-NGAY-...` → nói rõ với user là đang dịch bài ngày nào (bài cũ).
Chưa có bài nào → báo rồi dừng.

## 2. Hiện form cho user dịch

⭐ **Hỏi lại TẤT CẢ các từ của bài ngày đó, lần nào gõ `/dich` cũng vậy** (user chốt
2026-09-29). Không bỏ từ nào vì "đã dịch rồi", không tự chọn ra vài từ — user muốn
được xem lại và quyết lại nghĩa của từng từ. Từ đã dịch trước đó thì option "Giữ bản
hiện tại" hiện đúng bản user đã chốt lần trước.

Dùng **AskUserQuestion** — mỗi lần tối đa 4 câu, nên 5 từ gọi **hai lần** (lần 1: từ
1-4, lần 2: từ 5); ngày có buổi #2 (`<ngày>-2`) thì hỏi nốt các từ đó. Mỗi câu hỏi:

- `header`: `Từ 1/5`, `Từ 2/5`… (tổng = số từ thật của ngày đó)
- `question`: `<từ> — "<câu ví dụ VD, cắt gọn>". Bạn dịch từ này thế nào?`
- `options` (đúng hai, user tự gõ bản của mình vào ô **Other**):
  1. `Giữ bản hiện tại` — `description` = `<NGHIA> · <PHU>` nguyên văn
  2. `Bỏ qua` — `description` = "Chưa nghĩ ra, để nguyên, không ghi gì"
- ⛔ **Không** gợi ý bản dịch nào khác trong option — thứ cần là lời của user, gợi ý
  sẵn thì user sẽ chọn luôn cho nhanh.

Nhắc user một dòng trước khi hiện form: *gõ nghĩa gọn vào ô Other; muốn đổi luôn
dòng phụ thì viết `nghĩa gọn | dòng phụ`.*

Không có AskUserQuestion (vd chạy qua routine) → in 5 từ thành danh sách đánh số
kèm bản hiện tại, bảo user trả lời theo dạng `1. …` rồi dừng lượt chờ.

## 3. Ghi bản dịch của user vào bài (từ nào user gõ bản mới)

Chép **đúng chữ user gõ** — không sửa chính tả, không "làm mượt", không thêm dấu câu.
Có lỗi gõ rõ ràng (sai dấu, lặp chữ) thì hỏi lại một câu, đừng tự sửa.

Nghĩa cũ đang được chép ở nhiều chỗ, **sửa đủ cả**, không thì R9 hỏi một đằng, bài
gốc ghi một nẻo:

| Chỗ | Sửa gì |
|---|---|
| Bài gốc `<ngày>.html` | dòng đậm trong `<p class="vi-quick">` (và `<span class="alt">` nếu user viết `\|`) |
| `wiki/VOCAB_INDEX.md` | cột `Nghĩa gọn` của đúng dòng từ đó |
| Khối ôn nhanh các bài **sau** ngày đó + `wiki/recap/*` | chỗ nào đang chép nguyên văn nghĩa cũ |

Tìm chỗ chép lại bằng lệnh, đừng đoán:

```bash
grep -rnF "<NGHIA cũ>" wiki/lessons wiki/recap wiki/VOCAB_INDEX.md
```

Chỉ thay chỗ nào đúng là nghĩa **của từ này** (một cụm ngắn có thể trùng ở từ khác).
"Giữ bản hiện tại" và "Bỏ qua" → không sửa file bài nào.

⭐ **Rồi sửa luôn cả bài gốc theo cách dịch mới** (user đòi 2026-09-29: đổi mỗi dòng
nghĩa gọn là chưa đủ). Trong **cả `.md` lẫn `.html`** của ngày đó, mọi câu tiếng Việt
đang diễn đạt từ này theo kiểu cũ đều viết lại cho khớp bản của user:

| Chỗ trong bài | Ví dụ (invoice: `giấy đòi tiền gửi khách` → `Hóa đơn`) |
|---|---|
| `**VI**` (.md) · `GHI CHÚ` (.html) | "**Giấy đòi tiền** mình gửi cho khách" → "**Hóa đơn** mình gửi cho khách" |
| `.def-vi` (.html) | "Invoice là tờ giấy mình gửi khách" → "Invoice là hóa đơn mình gửi khách" |
| câu dịch ví dụ | "ăn đồ hôm qua" → "ăn đồ thừa hôm qua" |
| bản dịch mẩu đọc · câu đề bài tập tiếng Việt · Ghi chú buổi học (.md) | cùng kiểu |

Dùng đúng chữ và cách viết của user (vd `hóa đơn` chứ không `hoá đơn`) ở mọi chỗ trong
bài cho đồng bộ. Chỉ đổi phần nói về **nghĩa** của từ — sắc thái, bẫy, collocation
giữ nguyên. Sửa xong thì grep lại cụm cũ trong hai file cho chắc không còn sót.

## 4. Ghi vào sổ cách dịch — phần để agent học

Mở `wiki/memory/cach-dich-cua-user.md`:

1. **Thêm mỗi từ một dòng** vào bảng "Nhật ký bản dịch" (cả từ user chọn "Giữ bản
   hiện tại" — đó cũng là tín hiệu: kiểu viết đó user thấy ổn). "Bỏ qua" thì không
   ghi. Cột `Khác ở đâu` viết ngắn, nói cụ thể: ngắn hơn / bỏ hình ảnh / dùng từ tiếng
   Anh thay vì dịch / đổi động từ / đổi giọng…
2. **Đọc lại toàn bộ bảng rồi sửa mục "Quy luật rút ra"**:
   - Một kiểu khác biệt lặp **≥ 2 lần** → lên thành quy luật, ghi kèm 1-2 cặp ví dụ
     `bản agent → bản user`.
   - Mới thấy 1 lần → để ở mục "Đang quan sát", chưa thành luật.
   - Quy luật cũ bị bản dịch mới nói ngược lại → sửa hoặc xoá, đừng để hai luật cãi nhau.
3. Cập nhật dòng `Cập nhật:` ở đầu file.

## 5. Lưu lên GitHub — LUÔN LUÔN, không hỏi

⛔ Sửa xong là **đẩy lên ngay**, không hỏi user có muốn push không (user chốt
2026-09-29: "khi sửa xong luôn phải đẩy lên git"). User hay đọc bài trên GitHub Pages /
điện thoại — chưa push thì user vẫn thấy bản cũ và tưởng chưa sửa.

```bash
daylen "dich: $D — <các từ user dịch lại, cách nhau dấu phẩy>"
```

Không in `DA-PUSH` → nói thẳng là chưa lưu lên GitHub, kèm lỗi. Không có từ nào đổi
và sổ cũng không đổi → bỏ qua bước này. (Sổ có thêm dòng "Giữ" cũng là có đổi → push.)

## 6. Báo lại trong chat

- Bảng ngắn: từ · bản cũ → bản của user (từ giữ nguyên / bỏ qua thì ghi thế).
- Một hai câu: agent rút ra được gì về cách dịch của user lần này, và quy luật nào
  trong sổ vừa được thêm/sửa.
- Mở lại trang bài bằng `openit "$F"` nếu user muốn xem.
