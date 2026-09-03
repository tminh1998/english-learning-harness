# CLAUDE.md — English Learning Harness (Claude Code addendum)

**Master rules ở [AGENTS.md](AGENTS.md) — đọc trước.** File này chỉ bổ sung phần
đặc thù Claude Code: slash command, cách chạy, checklist đóng buổi.

---

## Harness này là gì

Không phải project code. Đây là hệ thống học tiếng Anh có lưu vết cho **một dev
người Việt**: mỗi ngày 5 từ mới (2 IT + 2 giao tiếp khách hàng + 1 đời sống), ghi
vào `wiki/`, cuối tuần kiểm tra lại, không bao giờ ra trùng từ cũ.

Harness frontend VCBF cũ đã được archive ở `.archive-fe-harness/` — **không đọc,
không trích**, xoá được bất cứ lúc nào.

## Bố cục

```
ENGLISH/                          ← {harness}
├── .learning-config.yml          ← ⭐ file DUY NHẤT chứa path + cấu hình thật
├── AGENTS.md                     ← master rules (tool-agnostic)
├── CLAUDE.md                     ← file này
├── README.md                     ← hướng dẫn dùng cho người học
├── index.html                    ← mục lục cho GitHub Pages — SINH RA, đừng sửa tay
├── .claude/commands/             ← 6 slash command (xem bảng dưới)
├── tools/
│   ├── openit.sh                 ← ⭐ chỗ DUY NHẤT biết Mac vs VM và biết git
│   │                               cfg · hnay · tuan · openit · keove · daylen
│   ├── build-index.sh            ← dựng lại index.html từ wiki/lessons/
│   └── setup-remote.sh           ← chạy 1 lần lúc dựng: tạo repo + bật Pages
└── wiki/
    ├── VOCAB_INDEX.md            ← ⭐ mọi từ đã học — nguồn chống trùng (R1)
    ├── REVIEW_QUEUE.md           ← lịch ôn spaced repetition
    ├── PROGRESS.md               ← streak, tổng từ, điểm quiz, level
    ├── assets/lesson.css + .js   ← giao diện DÙNG CHUNG cho mọi trang bài học
    ├── lessons/YYYY-Www/YYYY-MM-DD.md  + .html   ← bản đọc nhanh + bản trình bày
    ├── quiz/YYYY-Www.md  +  YYYY-Www-key.md     ← đề và đáp án TÁCH FILE (R2)
    ├── recap/YYYY-Www.md + .html ← bảng ôn tuần (Chủ nhật)
    ├── memory/MEMORY.md          ← rule đã học về cách học của user
    └── _templates/               ← khuôn lesson.md / lesson.html / quiz / memory
```

## Slash command

| Lệnh | Dùng khi | Flow |
|---|---|---|
| `/hoc` | Học 5 từ mới hôm nay — sinh `.md` + `.html` rồi mở trình duyệt | Flow A (AGENTS.md) |
| `/open` | Mở lại trang bài học đã có — **không** sinh gì mới | `find` + `open` |
| `/kiem-tra` | Cuối tuần, kiểm tra từ đã học trong tuần | Flow B |
| `/on-tap` | Ôn nhanh các từ tới hạn (spaced repetition) | đọc REVIEW_QUEUE |
| `/on-tap-tuan` | Bảng ôn tuần — trang ĐỂ ĐỌC, nghĩa Việt hiện sẵn | Flow D |
| `/tra-tu` | Dán 1 từ/câu bắt gặp khi đọc doc, xem phim, đọc email | Flow C |
| `/tien-do` | Xem đã học bao nhiêu, chỗ nào yếu | đọc PROGRESS + quiz cũ |

`/hoc` không tham số = bài hôm nay. `/hoc <chủ đề>` = ưu tiên chủ đề đó nhưng vẫn
giữ nguyên tỷ lệ 2/2/1 và vẫn phải qua hard gate chống trùng.

⛔ **Harness này KHÔNG dạy ngữ pháp** (bỏ từ 2026-08-26). Không sinh khối "Ngữ pháp
hôm nay", không khối "Tự viết", không nhãn `.pattern-tag`, không thư mục
`wiki/grammar/`. Bài học = ôn nhanh → 5 từ → mẩu đọc → bài tập.

`/open` chỉ đọc, không ghi: mở `<hôm nay>.html`; hôm nay chưa học thì mở bài gần
nhất và **nói rõ là bài cũ**. `/open 2026-08-12` để mở đúng một ngày. Ngày có nhiều
buổi → mở buổi mới nhất, liệt kê các buổi còn lại.

## Tám luật dễ vi phạm nhất — kiểm lại trước khi trả lời

1. **Ngày tháng**: `. tools/openit.sh` rồi `hnay "%Y-%m-%d %A %G-W%V"`. Không suy
   đoán từ context, và **không gọi `date` trần** — xem luật 5.
2. **Một ngày một bài (R5)**: `/hoc` mà hôm nay đã có file bài học → **DỪNG**, mở
   lại bài cũ + hỏi user. Không tự sinh buổi #2. Gõ lại `/hoc` **không** có nghĩa
   là muốn học thêm.
3. **Chống trùng (R1)**: grep `wiki/VOCAB_INDEX.md` cho **từng** ứng viên **trước
   khi** soạn bài. Trùng cả word family cũng là trùng.
4. **Không lộ đáp án (R2)**: bài tập bọc `<details>`; đáp án quiz để file `-key.md`
   riêng và không hiện cho tới khi user nộp bài. Repo public → **không push
   `-key.md` trước khi chấm xong.**
5. **Hai môi trường (R6)**: harness chạy cả trên Mac lẫn VM Linux giờ UTC. `date`
   trần và `open` trần đều hỏng ở một trong hai nơi. Luôn qua `tools/openit.sh`.
   Và luôn `keove` đầu buổi, `daylen` cuối buổi — thẳng lên `main`, không PR.
6. **Nghĩa Việt không được máy móc (R7)**: dịch ý chứ không dịch cấu trúc câu tiếng
   Anh; thuật ngữ dev quen nói bằng tiếng Anh (`deploy`, `release`, `cache`,
   `endpoint`, `merge conflict`…) **để nguyên**, đừng dịch thành "bản phát hành",
   "xung đột khi gộp code". Giọng bám vai câu gốc: khách → *anh/chị*, đồng nghiệp →
   *mình/cậu*. Đọc to một lượt trước khi ghi file.

7. **Ví dụ phải ôn lại từ cũ (R8)**: **mỗi câu** ví dụ phải có ít nhất **một từ đã học
   buổi trước**, và **hai câu của cùng một từ phải mượn hai từ cũ khác nhau**; mẩu đọc
   cũng phải có một từ cũ. Đánh dấu bằng `<span class="rev">…</span>` (HTML) / `_từ cũ_`
   (md) — **không** in đậm. Trùng mặt chữ mà khác nghĩa thì không tính. Chỉ buổi #1 được miễn.

8. **Ôn nhanh đầu giờ = 25 từ, chia 5 + 20, KHỐI GẬP MẶC ĐỊNH ĐÓNG (R9)** — 15 từ
   từ **2026-08-26**, nâng lên 25 từ **2026-09-04**.
   **5** từ đầu là đúng 5 từ của **buổi liền trước**; **20** từ sau **bốc ngẫu nhiên
   bằng lệnh** trong toàn bộ `wiki/VOCAB_INDEX.md` (không phải chỉ từ tới hạn, và
   **không** bốc bằng mắt — agent tự chọn thì luôn trúng mấy từ ở đầu bảng):

   ```bash
   grep -E '^\| [0-9]+ \|' wiki/VOCAB_INDEX.md | grep -v '| <ngày buổi trước> |' \
     | awk -F'|' '{print $3}' | sed 's/^ *//;s/ *$//' \
     | awk 'BEGIN{srand()}{print rand()"\t"$0}' | sort -n | cut -f2- | head -20
   ```

   Trên trang để **hai phần riêng**, ghi rõ phần nào là bài hôm qua, phần nào là bốc
   ngẫu. Và **cả cụm** bọc trong `<details class="warm-toggle">` **không có `open`**
   — vào trang là đang ẩn, bấm mới mở. `<details>` gốc của trình duyệt, **không viết
   JS** (trang hay mở bằng `file://`). Bản `.md` cũng bọc `<details>` ngoài cùng.
   **Đáp án đi theo từng câu**, không gộp ở cuối: `<ol class="ex qa-list">` →
   `<li class="qa">` → `<span class="q">` + `<details class="ans">` (nút 👁, không
   `open`, không `id`) → `<span class="a hide-me">`.

## Checklist đóng một buổi học (R3 + R6 — thiếu 1 là chưa xong)

```
[ ] keove                                  chạy TRƯỚC khi làm gì (bài từ máy khác)
[ ] 25 từ ôn nhanh: 5 buổi trước + 20 bốc BẰNG LỆNH   R9 — khối ĐÓNG, đáp án theo TỪNG câu
[ ] wiki/lessons/<tuần>/<ngày>.md          ôn nhanh + 5 từ + mẩu đọc + bài tập
[ ] wiki/lessons/<tuần>/<ngày>.html        render từ _templates/lesson.html
[ ] đọc to lại mọi câu tiếng Việt          R7 — máy móc thì viết lại
[ ] MỌI câu ví dụ có ≥1 từ cũ, 2 câu khác nhau  R8 — mẩu đọc cũng vậy, đánh dấu .rev
[ ] wiki/VOCAB_INDEX.md                    +5 dòng, đúng cột, sắp theo ngày
[ ] wiki/REVIEW_QUEUE.md                   +5 dòng, next_review = hôm nay +1
[ ] wiki/PROGRESS.md                       streak +1, tổng từ +5
[ ] sh tools/build-index.sh                mục lục khớp lại với bài thật
[ ] daylen "hoc: ..."                      phải in DA-PUSH; khác đi = BÁO USER
[ ] openit <file>.html + tóm tắt 5 từ trong chat
```

## Giao diện HTML

CSS/JS **dùng chung** ở `wiki/assets/`. Trang bài học chỉ `<link>` tới
`../../assets/lesson.css` và `<script src="../../assets/lesson.js">` — **tuyệt đối
không nhúng style vào từng bài**, nếu không thì đổi giao diện phải sửa lại toàn bộ
bài cũ. Trang có 4 tính năng: nút 🔊 phát âm (Web Speech API, offline), "Chế độ ôn
tập" che mờ phần tiếng Việt (class `hide-me`), và nút sáng/tối.

Cấu trúc một trang bài học: `header.hero` → `.toolbar` → `section.block` (Ôn nhanh
đầu giờ — bọc `<details class="warm-toggle">` không `open`, trong có **hai phần:
5 từ buổi trước + 20 từ bốc ngẫu**, mỗi câu một `li.qa` kèm `details.ans` riêng)
→ 5 × `article.word` →
`section.block` (Mẩu đọc) → `section.block` (Bài tập) → `footer`.

## Chạy trên Claude Code on the web

User học từ điện thoại / máy ở nhà bằng cách vào `claude.ai/code`, chọn repo này,
rồi gõ `/hoc` như bình thường. Session chạy trên **VM Linux, giờ UTC, không màn
hình** — khác con Mac ở ba chỗ, và cả ba đều đủ sức làm hỏng dữ liệu:

| Khác biệt | Hỏng cái gì | Xử ở đâu |
|---|---|---|
| Giờ UTC, không phải giờ VN | Sai ngày → sai tên file, gate R5 mù, sinh trùng bài | `tools/openit.sh` export `TZ` |
| Không có lệnh `open`, không có màn hình | Command chết ở bước cuối | `openit()` in link Pages thay vì mở |
| VM bị thu hồi khi nghỉ lâu | **Mất trắng buổi học chưa push** | R6 — commit + push là bắt buộc |

Nên: mọi command đều mở đầu bằng `. tools/openit.sh` + `keove`, và kết thúc bằng
`daylen "..."`. Đừng viết `date`, `open`, hay `git` trực tiếp vào command mới —
sáu hàm trong `openit.sh` là giao diện duy nhất tới môi trường.

### Hai routine đang chạy tự động

Cấu hình ở [claude.ai/code/routines](https://claude.ai/code/routines), **không** nằm
trong repo — sửa luật ở đây không tự đổi prompt của routine, phải sửa cả hai chỗ.

| Cron (UTC) | Giờ VN | Chạy | Ghi chú |
|---|---|---|---|
| `0 0 * * 1-6` | 7h T2–T7 | `/hoc` | Chủ nhật **không** học từ mới |
| `0 0 * * 0` | 7h Chủ nhật | `/on-tap-tuan` | gom cả tuần thành bảng ôn |

Cả hai chạy khi **không có ai trả lời**, nên prompt của chúng dặn thêm: gặp gate R5
thì dừng im lặng (đừng hỏi), phần "ôn nhanh đầu giờ" viết thẳng vào file thay vì hỏi
trong chat, và `LINK-WEB` là bình thường chứ không phải lỗi.

`/on-tap` và `/kiem-tra` **không** tự động hoá được — chúng cần user trả lời mới
chấm điểm và cập nhật bậc trong REVIEW_QUEUE được.

⚠️ **2026-09-04 — prompt routine `/hoc` ĐANG LỆCH luật R9 mới.** Nó vẫn dặn "ôn nhanh
15 từ, 5 + 10". Repo đã lên **25 từ (5 + 20) + khối gập mặc định đóng** nhưng prompt
routine **không nằm trong repo** nên không tự đổi — phải sửa tay, nếu không bài do
routine 7h sáng sinh ra sẽ sai luật.

ID để tra: `/hoc` = `trig_01QfWZkEggCXjyrR4nKvaM3U`,
`/on-tap-tuan` = `trig_01DeXAVcCXsfXb3B62b9wKEq` (routine ôn tuần không đụng khối ôn
nhanh nên không ảnh hưởng). Sửa bằng `/schedule` hoặc tại claude.ai/code/routines.

_(2026-08-26: cả hai prompt đã được viết lại một lần cho luật bỏ ngữ pháp + ôn nhanh
15 từ. Cứ đổi luật trong repo là phải sửa tay ở cả hai chỗ.)_

### Không branch, không PR

⛔ **Cho nội dung học.** `keove` chuyển về `remote.branch`,
`daylen` push thẳng vào đó, kể cả trên VM cloud. Session cloud theo thói quen sẽ
muốn mở branch rồi chờ merge — ở đây thì không, vì quên merge một lần là hôm sau
`keove` không thấy bài, R5 tưởng chưa học, R1 grep không ra từ, và agent ra trùng
từ. (Sửa *code* của harness thì branch/PR vẫn bình thường.)

## Không có build/test

Đây là repo tri thức, không có `npm`, không có test runner. "Verify" ở đây nghĩa là:
grep VOCAB_INDEX không thấy trùng, 5 file state đã cập nhật khớp nhau, và
`sh tools/build-index.sh` chạy không lỗi.

Hai script trong `tools/` là **shell POSIX thuần** (`/bin/sh`), chạy được trên cả
macOS lẫn Linux, không phụ thuộc `bash`/`node`/`python`. Sửa chúng thì test bằng:

```bash
sh tools/build-index.sh                                    # phải in DA-DUNG-INDEX
TZ=Pacific/Midway sh -c '. ./tools/openit.sh; hnay'        # phải ra ngày giờ VN
```

## Source of truth (thứ tự ưu tiên)

1. `.learning-config.yml` — cấu hình + mọi path thật
2. [AGENTS.md](AGENTS.md) — luật + flow
3. `wiki/VOCAB_INDEX.md` — sự thật về "đã học gì" (thắng mọi mô tả khác)
4. `wiki/memory/MEMORY.md` — rule đã học về learner

Doc mâu thuẫn với VOCAB_INDEX → VOCAB_INDEX thắng, sửa doc.
