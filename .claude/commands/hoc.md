---
description: Bài học mới hôm nay — 5 từ (2 IT + 2 giao tiếp + 1 đời sống), sinh trang HTML và mở trong trình duyệt
argument-hint: "[chủ đề tuỳ chọn, vd: docker, email khách hàng]"
---

Chạy **Flow A — Buổi học hằng ngày** trong `AGENTS.md`.

Chủ đề ưu tiên (có thể rỗng): $ARGUMENTS
Nếu có chủ đề, vẫn giữ nguyên tỷ lệ 2 IT + 2 business + 1 life và vẫn phải qua hard gate.

## Thứ tự bắt buộc

0. **Về nhánh chính + kéo bài từ máy khác về** (R6) — user có thể đã học từ điện
   thoại. Lấy luôn ngày + tuần ISO thật ở đây, **không đoán**. ⚠️ Không dùng `date`
   trần: trên VM cloud nó chạy giờ UTC, học buổi tối giờ VN sẽ ra sai ngày.

   ```bash
   . tools/openit.sh          # ép TZ + có hnay/tuan/openit/keove/daylen
   keove
   hnay "%Y-%m-%d %A %G-W%V"
   ```

   `keove` in ra `DA-KEO-VE` là ổn. In `KHONG-KEO-DUOC` / `KHONG-CHUYEN-DUOC-NHANH`
   → vẫn đi tiếp được, nhưng **phải báo user ở cuối** là buổi này chưa đồng bộ với
   máy khác và vì sao.

1b. ⛔ **GATE R5 — MỘT NGÀY MỘT BÀI.** Kiểm tra ngay sau khi có ngày:

   ```bash
   find "wiki/lessons/$(tuan)" -maxdepth 1 -name "$(hnay)*.md" 2>/dev/null
   ```

   Có kết quả → **DỪNG. KHÔNG sinh bài mới, không đụng file state nào.**
   Thay vào đó: mở lại trang HTML hôm nay bằng `openit`, tóm tắt các từ đã học,
   rồi hỏi user muốn (a) ôn lại bài hôm nay, (b) `/on-tap` các từ tới hạn, hay
   (c) học thêm buổi #2. Rồi kết thúc lượt, chờ user trả lời.

   Chỉ khi user **nói rõ ở lượt sau** là muốn buổi #2 mới đi tiếp từ bước 2,
   ghi ra `<YYYY-MM-DD>-2.md` + `.html`. Rỗng → đi tiếp bình thường.
2. Đọc `.learning-config.yml`, `wiki/memory/MEMORY.md`, `wiki/PROGRESS.md`.
3. ⭐ **Ôn nhanh đầu giờ — 25 từ (R9), chia hai phần cố định** (`review.warmup`):

   - **5 từ của buổi LIỀN TRƯỚC** — lấy từ `wiki/PROGRESS.md` (bảng "Nhật ký buổi
     học", dòng cuối) hoặc file bài học gần nhất. Đúng thứ tự trong bài.
   - **20 từ BỐC NGẪU NHIÊN** trong **toàn bộ** `wiki/VOCAB_INDEX.md` — không phải
     chỉ từ tới hạn trong REVIEW_QUEUE. Bốc **bằng lệnh**, không bốc bằng mắt:

     ```bash
     grep -E '^\| [0-9]+ \|' wiki/VOCAB_INDEX.md | grep -v '| <ngày buổi trước> |' \
       | awk -F'|' '{print $3}' | sed 's/^ *//;s/ *$//' \
       | awk 'BEGIN{srand()}{print rand()"\t"$0}' | sort -n | cut -f2- | head -20
     ```

     (`shuf` không có sẵn trên macOS nên dùng `awk`. Agent tự "chọn ngẫu nhiên" thì
     luôn trúng mấy từ vừa đọc thấy ở đầu bảng — phải chạy lệnh thật.)

   Trên trang để **hai phần riêng biệt**, ghi rõ phần nào là bài hôm qua, phần nào
   là bốc ngẫu. Hỏi gợi nhớ bằng tiếng Việt. Chưa đủ 20 từ cũ → lấy hết những gì
   có, không bịa thêm.

   ⭐ **Cả cụm ôn nhanh phải gập được và mặc định ĐANG ẨN**: bọc trong
   `<details class="warm-toggle">`, **không** thêm `open`. Không viết JS cho việc
   này — `<details>` gốc chạy được cả khi mở bằng `file://`. Bản `.md` cũng bọc
   `<details>` ngoài cùng cho khớp.

   ⭐ **Đáp án đi theo TỪNG câu**, không gộp một khối ở cuối nữa (đổi 2026-09-04) —
   xem khuôn trong `wiki/_templates/lesson.html`.

4. Chọn ứng viên 5 từ theo mix + level trong config.
5. ⛔ **HARD GATE R1** — grep từng ứng viên:
   `grep -in "<word>" wiki/VOCAB_INDEX.md`
   Kết quả rơi vào bảng `## ⛔ Đã biết sẵn` ở cuối file **cũng là trùng** (R1.b) —
   đó là từ người học đã báo là biết rồi, tuyệt đối không dạy lại.
   Trùng lemma hoặc word family → loại, chọn từ khác, grep lại. Chỉ đi tiếp khi cả 5 sạch.
5b. ⛔ **Không soạn khối ngữ pháp, không khối "Tự viết".** Harness bỏ hẳn ngữ pháp
   từ 2026-08-26. Bài học chỉ gồm: ôn nhanh đầu giờ → 5 từ → mẩu đọc → bài tập.
   Bài tập là **5 câu về từ vựng**, không có câu ngữ pháp.

6. **Ghi bản Markdown** theo `wiki/_templates/lesson.md` →
   `wiki/lessons/<YYYY-Www>/<YYYY-MM-DD>.md` (tạo thư mục tuần nếu chưa có).
7. **Ghi bản HTML** theo `wiki/_templates/lesson.html` →
   `wiki/lessons/<YYYY-Www>/<YYYY-MM-DD>.html` — xem luật render bên dưới.
8. Cập nhật đủ **4 file state** (R3): lesson → `VOCAB_INDEX.md` (+5 dòng) →
   `REVIEW_QUEUE.md` (+5 dòng, next_review = hôm nay +1) → `PROGRESS.md` (streak,
   tổng từ, nhật ký buổi học).
9. **Dựng lại trang mục lục + lưu lên GitHub** (R6 — chưa push là chưa có):

   ```bash
   sh tools/build-index.sh
   daylen "hoc: $(hnay) — <5 từ, cách nhau bởi dấu phẩy>"
   ```

   ⛔ **Không tự mở branch, không tạo pull request.** `daylen` push thẳng vào nhánh
   chính, kể cả khi đang chạy trên VM cloud — đó là chủ ý, xem R6.

   Không in ra `DA-PUSH` → **nói thẳng với user là bài chưa lưu được lên GitHub**,
   kèm nguyên văn lỗi. Tuyệt đối không báo "xong": trên VM cloud, VM bị thu hồi là
   mất trắng cả buổi học.
10. Đưa bài cho user xem — **đừng gọi `open` trực tiếp**, dùng hàm `openit` để nó
    tự xử đúng theo môi trường (máy Mac mở trình duyệt / VM cloud in link Pages):

    ```bash
    openit "wiki/lessons/<YYYY-Www>/<YYYY-MM-DD>.html"
    ```

    - `DA-MO-LOCAL ...` → nói đã mở trong trình duyệt.
    - `LINK-WEB: <url>` → **đưa nguyên link đó cho user bấm** (đang chạy trên cloud,
      máy user ở chỗ khác nên không mở hộ được).
    - `CHUA-CAU-HINH-PAGES` → báo user điền `remote.pagesBaseUrl` trong config.
11. Tóm tắt trong chat: 5 từ (mỗi từ 2-3 dòng) + đường dẫn/link bài.
    Đừng dán lại toàn bộ bài — trang HTML là nơi để đọc kỹ.

## Luật render HTML

- **Không nhúng CSS/JS vào từng bài.** Trang chỉ link
  `../../assets/lesson.css` và `../../assets/lesson.js`. Muốn đổi giao diện toàn bộ
  bài học → sửa 2 file trong `wiki/assets/`, không sửa từng bài.
- `data-cat` của mỗi `<article class="word">`: `it` | `biz` | `life` — quyết định
  màu viền trái và badge.
- **BẮT BUỘC — nghĩa Việt gọn đặt sát dưới từ.** Ngay sau `</div>` đóng
  `.word-head`, trước mọi thứ khác:
  `<p class="vi-quick hide-me">nghĩa gọn<span class="alt">nghĩa phụ</span></p>`
  Đây là dòng nổi bật nhất card — người học liếc một cái là thấy nghĩa, không phải
  đọc định nghĩa tiếng Anh trước. Viết **2-6 chữ**, đúng nghĩa dùng nhiều nhất;
  đừng nhét cả đoạn giải thích vào đây. Phần dài để xuống dòng `GHI CHÚ` bên dưới.
- **BẮT BUỘC — định nghĩa EN phải kèm bản dịch Việt của chính câu đó**, nằm trong
  cùng thẻ `<p class="def">`:
  `<span class="def-vi hide-me">→ dịch trọn câu định nghĩa</span>`
  Dịch **sát cả câu**, không tóm tắt, không lặp lại `.vi-quick` — mục đích là để
  người học đối chiếu từng vế và quen lối diễn đạt của định nghĩa tiếng Anh.
- Dòng `<p class="def hide-me">` dùng tag `GHI CHÚ` (không phải `VI`) — chứa sắc
  thái, dùng ở đâu, khác gì từ gần nghĩa. Nghĩa thuần tuý đã nằm ở `.vi-quick`.
- Tóm lại mỗi card có **3 tầng tiếng Việt**, không tầng nào thay được tầng nào:
  `.vi-quick` (nghĩa gọn 2-6 chữ) → `.def-vi` (dịch câu định nghĩa) →
  `GHI CHÚ` (sắc thái, phân biệt). Tất cả đều mang class `hide-me`.
- Mọi đoạn **tiếng Việt** (nghĩa VI, câu dịch, bản dịch mẩu đọc) phải có class
  `hide-me` để "Chế độ ôn tập" che được. Câu tiếng Anh thì **không** che.
- Trong câu ví dụ và mẩu đọc, bọc `<b>` quanh chính từ đang học.
- Nút 🔊: `<button class="say" data-say="...">` — `data-say` là từ, hoặc một cụm
  ngắn tự nhiên hơn khi đọc lên (vd `follow up on the contract`).
- Khối **Ôn nhanh đầu giờ** là `<section class="block warmup">` chứa
  `<details class="warm-toggle">` (**không** `open` — vào trang là đang ẩn). Trong
  `<details>` đó: `<summary>` gồm `<h2>Ôn nhanh đầu giờ <span class="cnt">25 từ</span></h2>`
  + `<span class="wt-state"></span>` (để **rỗng**, chữ "bấm để mở / bấm để ẩn" do CSS
  sinh), rồi **hai** danh sách tách nhau (`<div class="warm-part">`): phần A "5 từ
  buổi trước", phần B "20 từ bốc ngẫu nhiên".
- Mỗi câu ôn nhanh: `<ol class="ex qa-list">` → `<li class="qa">` chứa **đúng hai**
  con — `<span class="q">` (câu hỏi tiếng Việt) và `<details class="ans">` (nút đáp
  án). Trong `details.ans`: `<summary>đáp án</summary>` + `<span class="a hide-me">`
  (từ bọc `<b>`, câu ví dụ bọc `<em>`). **Không** `open`, **không** `id`, **không**
  thêm con thứ ba vào `li.qa` — layout flex sẽ vỡ. Thiếu class `qa-list` là mất số
  thứ tự của cả danh sách.
- ⛔ **Không** có `<section class="grammar">`, `<section class="write">`,
  `.gram-progress`, `.pattern-tag` — harness đã bỏ ngữ pháp.
- Đáp án bài tập **luôn** nằm trong `<details>` (luật R2).
- Xoá hết comment hướng dẫn của template khi ghi file thật.

## Nhắc lại luật R5

Gõ `/hoc` lần thứ hai trong ngày **không** phải là tín hiệu "muốn học thêm" — đừng
suy diễn như vậy. Người học hay gõ lại chỉ để mở bài ra đọc. Tự sinh thêm bài sẽ
thổi phồng streak, tổng số từ và lịch ôn trong 3 file state — hỏng dữ liệu tiến độ,
sửa lại rất mất công.
