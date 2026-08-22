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
    ├── grammar/
    │   ├── CURRICULUM.md         ← ⭐ 42 điểm ngữ pháp + con trỏ "đang dạy tới đâu" (R9)
    │   └── <slug>.md             ← mỗi điểm 1 file, ghi ra khi dạy tới
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

8. **Ngữ pháp là khung câu của cả buổi (R9)** — áp dụng từ **2026-08-24**. Điểm ngữ
   pháp hôm nay lấy từ dòng *"Điểm kế tiếp"* trong `wiki/grammar/CURRICULUM.md`,
   **không suy từ số buổi**. Ví dụ của **cả 5 từ** và mẩu đọc đều phải viết theo mẫu
   đó (R8 vẫn cộng dồn). Khối ngữ pháp phải đủ **8 mục**, và hai mục *"Nó là gì"* +
   *"Dùng khi nào"* phải đứng **trước** công thức. Buổi phải có khối **"Tự viết"** 3 câu
   không đáp án. Đóng buổi nhớ đánh ✅ lại vào `CURRICULUM.md` — quên là hôm sau dạy lại.

## Checklist đóng một buổi học (R3 + R6 — thiếu 1 là chưa xong)

```
[ ] keove                                  chạy TRƯỚC khi làm gì (bài từ máy khác)
[ ] điểm ngữ pháp lấy từ CURRICULUM.md      R9 — dòng "Điểm kế tiếp", không đoán
[ ] wiki/lessons/<tuần>/<ngày>.md          đủ 5 từ + khối ngữ pháp + tự viết + mẩu đọc + bài tập
[ ] wiki/lessons/<tuần>/<ngày>.html        render từ _templates/lesson.html
[ ] khối ngữ pháp đủ 8 mục, "nó là gì" trước công thức   R9.2
[ ] khối tự viết 3 đề, 3 dạng, KHÔNG đáp án              R9.4
[ ] đọc to lại mọi câu tiếng Việt          R7 — máy móc thì viết lại
[ ] MỌI câu ví dụ có ≥1 từ cũ, 2 câu khác nhau  R8 — mẩu đọc cũng vậy, đánh dấu .rev
[ ] MỌI câu ví dụ viết theo mẫu ngữ pháp hôm nay R9.3 — có nhãn .pattern-tag
[ ] wiki/VOCAB_INDEX.md                    +5 dòng, đúng cột, sắp theo ngày
[ ] wiki/REVIEW_QUEUE.md                   +5 dòng, next_review = hôm nay +1
[ ] wiki/PROGRESS.md                       streak +1, tổng từ +5, ngữ pháp x/42
[ ] wiki/grammar/<slug>.md                 file chi tiết của điểm vừa dạy
[ ] wiki/grammar/CURRICULUM.md             ✅ dòng vừa dạy + sửa "Đang ở đâu"  ← QUÊN LÀ DẠY LẠI
[ ] sh tools/build-index.sh                mục lục khớp lại với bài thật
[ ] daylen "hoc: ..."                      phải in DA-PUSH; khác đi = BÁO USER
[ ] openit <file>.html + tóm tắt 5 từ trong chat
```

## Giao diện HTML

CSS/JS **dùng chung** ở `wiki/assets/`. Trang bài học chỉ `<link>` tới
`../../assets/lesson.css` và `<script src="../../assets/lesson.js">` — **tuyệt đối
không nhúng style vào từng bài**, nếu không thì đổi giao diện phải sửa lại toàn bộ
bài cũ. Trang có 4 tính năng: nút 🔊 phát âm (Web Speech API, offline), "Chế độ ôn
tập" che mờ phần tiếng Việt (class `hide-me`), nút sáng/tối, và **ô tự viết lưu nháp
vào localStorage** (`.wtask textarea[data-key]`).

Từ lộ trình v2 (2026-08-24) trang có thêm hai khối: `<section class="grammar">` và
`<section class="write">`. CSS/JS của chúng **đã nằm trong `wiki/assets/`** — mẫu đầy
đủ để đối chiếu hình dạng: `wiki/_templates/lesson-v2-mockup.html`.
⚠️ Tiếng Việt trong khối ngữ pháp **không** mang `hide-me` (trừ `.uc-vi`) — đó là bài
giảng, làm mờ nó thì bật "Chế độ ôn tập" là không đọc được gì.

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
