# AGENTS.md — English Learning Harness · Master Rules

> Rules cho **mọi coding agent** (Claude Code, Cursor, Codex, Gemini CLI…).
> Tool-agnostic, pure markdown. Bản đặc thù Claude Code: [CLAUDE.md](CLAUDE.md).

Harness này **không phải project code**. Sản phẩm của nó là **kiến thức tiếng Anh
được lưu vết**: mỗi ngày 5 từ mới, ghi vào wiki, cuối tuần kiểm tra lại.

---

## Luật path — KHÔNG hardcode

| Ký hiệu | Nghĩa | Nguồn |
|---|---|---|
| `{harness}` | Thư mục chứa `.learning-config.yml` | agent walk-up từ cwd |
| `{wiki}` `{lessons}` `{quiz}` `{memory}` `{grammar}` | Thư mục con | config → `paths.*` |
| `{vocabIndex}` `{reviewQueue}` `{progress}` | 3 file state trung tâm | config → `paths.*` |

**Chỉ `.learning-config.yml` biết path thật.** Không file nào khác được viết path
tuyệt đối.

---

## Phase 0 — Auto-discovery (BẮT BUỘC, mọi task)

```text
1. . tools/openit.sh                         -> cfg/hnay/tuan/openit/keove/daylen
2. keove                                     -> VỀ NHÁNH CHÍNH + KÉO BÀI TỪ MÁY KHÁC (R6)
3. hnay "%Y-%m-%d %A %G-W%V"                 -> ngày + tuần ISO thật, KHÔNG đoán
4. Đọc .learning-config.yml                  -> learner, daily.mix, level, luật
5. Đọc {memory}/MEMORY.md                    -> rule đã học về cách học của user
6. Đọc {progress}                            -> streak, buổi gần nhất, level hiện tại
```

> ⚠️ **Không bao giờ tự bịa ngày.** Ngày và tuần ISO lấy bằng lệnh, không lấy bằng
> trí nhớ hay context. Tên file bài học và tuần quiz phụ thuộc trực tiếp vào nó.

> ⚠️ **`date` trần là SAI.** Harness chạy ở hai nơi: máy user (giờ VN) và VM cloud
> của Claude Code on the web (**giờ UTC**). Học lúc 22h VN thì trên VM `date` trả
> về **ngày hôm trước** → sai tên file, sai tuần, và gate R5 không thấy bài hôm nay
> nên sinh trùng bài. Luôn ép múi giờ từ config:
>
> ```bash
> . tools/openit.sh          # export TZ + định nghĩa hnay/tuan/openit
> hnay "%Y-%m-%d %A %G-W%V"  # thay cho: date "+%Y-%m-%d %A %G-W%V"
> ```
>
> Agent không dùng được shell helper thì tự ép tay:
> `TZ="Asia/Ho_Chi_Minh" date "+%Y-%m-%d %A %G-W%V"`.

---

## Sáu quy tắc CỨNG

### R1 — Không trùng từ đã học (hard gate)

Trước khi chốt danh sách 5 từ, agent **phải** grep `{vocabIndex}` cho **từng** ứng
viên. Trùng lemma **hoặc** trùng word family → loại, chọn từ khác.

```bash
grep -in "deprecate" ./wiki/VOCAB_INDEX.md   # rỗng = an toàn
```

Chỉ được viết file bài học **sau khi** đã grep xong cả 5. Trong bài học phải ghi
dòng `Đã kiểm tra trùng: <5 từ> — không trùng VOCAB_INDEX (N từ)`.

Từ cũ **được** tái xuất hiện trong câu ví dụ / mẩu đọc / quiz — đó là ôn tập, tốt.
Chỉ không được tính là từ mới.

### R2 — Không đưa đáp án trước khi user trả lời

Bài tập cuối lesson: đáp án bọc trong `<details><summary>Đáp án</summary>…</details>`.
Bài quiz tuần: đề và đáp án nằm **hai file khác nhau** (`YYYY-Www.md` và
`YYYY-Www-key.md`), agent **không** đọc/hiện file key khi đang ra đề. Chấm chỉ diễn
ra sau khi user nộp bài.

### R3 — Mọi kiến thức đều phải lưu vết

Học xong mà không ghi wiki = chưa học. Một buổi học hoàn tất khi và chỉ khi:

1. `{lessons}/<tuần>/<ngày>.md` đã tạo (bản đọc nhanh, grep được)
2. `{lessons}/<tuần>/<ngày>.html` đã render từ `{templates}/lesson.html`
3. `{vocabIndex}` đã thêm đủ 5 dòng
4. `{reviewQueue}` đã thêm lịch ôn (+1 ngày)
5. `{progress}` đã cập nhật streak + tổng số từ
6. `sh tools/build-index.sh` đã chạy lại (trang mục lục để đọc trên điện thoại)
7. `daylen "..."` đã in `DA-PUSH` (R6 — bất kỳ mã nào khác là **chưa đóng**)

Thiếu 1 trong 7 → buổi học chưa đóng, phải nói rõ với user.

**Hai bản, một nội dung.** `.md` là bản canonical để grep/diff; `.html` là bản để
đọc. Sửa nội dung một bên thì phải sửa bên kia — lệch nhau thì `.md` thắng.
Style của trang HTML nằm ở `{wiki}/assets/lesson.css` + `lesson.js` **dùng chung**;
mỗi bài chỉ link tới, không nhúng CSS riêng.

### R4 — Đúng trình độ, đúng tỷ lệ

Tỷ lệ chủ đề lấy từ config `daily.mix` (hiện: 2 IT + 2 business + 1 life). Độ khó
bám `learner.levelSelfReported` / `levelConfirmed`. Từ quá dễ (user chắc chắn đã
biết) hoặc quá hiếm (không dùng trong đời thật) đều là bài kém — ưu tiên từ **tần
suất cao trong ngữ cảnh dev/khách hàng**, và ưu tiên dạy **collocation** hơn nghĩa
đơn lẻ.

---

### R5 — Một ngày một bài, không tự sinh thêm

Hôm nay đã có file `{lessons}/<tuần>/<hôm nay>*.md` → **DỪNG, không sinh bài mới.**
Kể cả khi user gõ lại `/hoc`. Kể cả khi user đưa kèm chủ đề. Kể cả khi bài hôm nay
mới tạo cách đây vài phút.

Khi gặp trường hợp đó, agent chỉ được làm 3 việc: **mở lại** trang bài hôm nay,
**tóm tắt** 5 từ đã học, và **hỏi** user muốn gì tiếp. Ba lựa chọn để user tự chọn:
ôn lại bài hôm nay · ôn các từ tới hạn (`/on-tap`) · học thêm buổi #2.

Chỉ được sinh buổi #2 khi user **nói rõ ở lượt sau** là muốn học thêm — file
`<hôm nay>-2.md` + `.html`. Suy diễn "chắc user muốn bài mới nên gõ lại `/hoc`"
là **vi phạm luật này**.

Lý do: học nhồi 10 từ một ngày rồi nghỉ 3 ngày kém hơn hẳn 5 từ đều đặn; và mỗi
lần chạy lại `/hoc` mà không chặn sẽ thổi phồng streak, số từ, lịch ôn trong 3 file
state — làm hỏng dữ liệu tiến độ.

---

### R6 — Chưa push là chưa có

Harness sống ở **nhiều máy**: con Mac của user, và VM cloud khi user học từ điện
thoại / máy ở nhà qua Claude Code on the web. Git là thứ duy nhất nối chúng lại.

**Đầu buổi — `keove`.** Trước khi làm bất cứ việc gì (Phase 0 bước 0). Bỏ qua bước
này thì gate R5 và grep R1 đọc phải state cũ → sinh trùng từ, trùng bài, lệch
streak. Đây là cách hỏng dữ liệu dễ xảy ra nhất khi học hai nơi.

**Cuối buổi — `daylen`.** Ghi xong các file state thì lưu ngay:

```bash
. tools/openit.sh
keove                                    # đầu buổi
daylen "hoc: <YYYY-MM-DD> — <5 từ>"      # cuối buổi
```

Trên VM cloud điều này là **bắt buộc, không phải tuỳ chọn**: VM bị thu hồi sau một
thời gian không hoạt động, file chưa push sẽ mất trắng cùng cả buổi học. Trên máy
Mac cũng phải push — không thì lần sau mở điện thoại lên sẽ thấy bài cũ.

#### Một nhánh duy nhất — không branch, không PR

`keove` luôn chuyển về `remote.branch` (mặc định `main`); `daylen` luôn push thẳng
vào đó. **Agent không được tự mở branch hay tạo pull request cho việc học.**

Session trên claude.ai/code theo thói quen sẽ làm việc trên branch mới rồi chờ user
bấm merge. Ở harness này thì không: đây là sổ tay cá nhân, không ai review, mà quên
merge một PR là hôm sau `keove` không thấy bài đó → R5 tưởng chưa học, R1 grep
không ra từ → **ra trùng từ**. Bỏ PR là bỏ nguyên một lớp lỗi, đổi lại mất khả năng
review — thứ mà nội dung học không cần.

(Sửa code của harness — script, template, luật — thì branch/PR vẫn hợp lý. Luật này
chỉ nói về **nội dung học**.)

#### Báo lỗi, đừng nuốt

`keove`/`daylen` in ra mã kết quả. Gặp `PUSH-LOI`, `KHONG-KEO-DUOC`,
`DA-COMMIT-NHUNG-CHUA-CO-REMOTE`, `KHONG-CHUYEN-DUOC-NHANH` → **nói thẳng với user
là buổi học chưa lưu được lên GitHub**, kèm nguyên văn lỗi. Tuyệt đối không báo
"xong" rồi im: trên VM cloud, im lặng ở bước này nghĩa là mất trắng buổi học.

#### Xung đột

Hai máy cùng học một ngày → `{vocabIndex}` / `{reviewQueue}` / `{progress}` đụng
nhau. Không tự ý chọn bên nào: giữ **cả hai** phần từ vựng (từ đã học là đã học,
mất đi thì R1 hết tác dụng), rồi tính lại streak và tổng số từ cho khớp
`{vocabIndex}` — nó là nguồn sự thật, thắng mọi file khác.

---

## Luồng chuẩn

### Flow A — Buổi học hằng ngày

```text
Phase 0  Auto-discovery (ở trên)
Phase 0.5 ⛔ GATE R5: ls {lessons}/<tuần>/<hôm nay>*.md
         Có file -> KHÔNG sinh bài. Mở lại bài cũ, hỏi user, DỪNG tại đây.
Phase 1  Ôn nhanh: đọc {reviewQueue}, lấy các từ due hôm nay -> hỏi 3-5 câu chớp nhoáng
Phase 2  Chọn ứng viên: 2 IT + 2 business + 1 life, bám level
Phase 3  ⛔ HARD GATE R1: grep {vocabIndex} từng từ. Trùng -> quay lại Phase 2
Phase 4  Soạn bài: mỗi từ đủ mục `daily.mustInclude` + mẩu đọc + bài tập
Phase 5  Ghi file: lesson .md -> lesson .html -> VOCAB_INDEX -> REVIEW_QUEUE
         -> PROGRESS  (đủ 5, R3)
Phase 6  sh tools/build-index.sh  -> daylen "hoc: ..."  (R6 — chưa push là chưa có)
Phase 7  openit <file.html> + tóm tắt 5 từ trong chat (không bắt user tự đi tìm file)
         Máy Mac -> mở trình duyệt. VM cloud -> in link Pages để user bấm.
```

### Flow B — Kiểm tra cuối tuần

```text
Phase 0  Auto-discovery + xác định tuần ISO cần kiểm tra
Phase 1  Gom từ: mọi từ trong {lessons}/<tuần>/ + tối đa 5 từ yếu từ {reviewQueue}
Phase 2  Ra đề 4 phần A/B/C/D theo config `weekly.format` -> ghi {quiz}/<tuần>.md
         Đáp án ghi RIÊNG ra {quiz}/<tuần>-key.md  (R2)
Phase 3  User làm bài trong chat
Phase 4  Chấm: đối chiếu key, tính %, chỉ ra lỗi + giải thích tại sao sai
Phase 5  Ghi kết quả vào cuối {quiz}/<tuần>.md + {progress}
Phase 6  Từ sai -> reset interval về bậc 1 trong {reviewQueue}
         Lỗi lặp lại >= 2 lần -> ghi 1 entry {memory}
Phase 7  daylen "kiem-tra: <tuần> — <điểm>"  (R6)
```

### Flow D — Bảng ôn tuần (Chủ nhật)

```text
Phase 0  Auto-discovery + xác định tuần ISO cần ôn
Phase 1  Đọc MỌI file {lessons}/<tuần>/*.md -> gom từ + IPA + nghĩa + collocation
         + mục Bẫy + câu ví dụ đắt nhất. Không có buổi nào -> báo rồi dừng.
Phase 2  Ghi {recap}/<tuần>.md   theo {templates}/recap.md
Phase 3  Ghi {recap}/<tuần>.html theo {templates}/recap.html
Phase 4  sh tools/build-index.sh -> daylen "recap: <tuần> — <N> từ"  (R6)
Phase 5  openit + tóm tắt: bao nhiêu từ, phân bố nhóm, 2-3 chỗ dễ sai đáng nhớ
```

Đây là **trang để đọc**, không phải bài kiểm tra. Khác hai thứ dễ nhầm:

| | Nghĩa Việt | Mục đích | Chấm điểm |
|---|---|---|---|
| `{recap}` (Flow D) | **hiện sẵn** ngay cạnh từ | đọc lướt cho nhớ lại | không |
| `{quiz}` (Flow B) | giấu ở file `-key.md` | kiểm tra, tính % | có |
| `/on-tap` | giấu tới khi trả lời | hỏi–đáp, lên/xuống bậc | có |

Bốn luật riêng:

1. **Nghĩa Việt nằm ngay cột kế bên** — lý do trang này tồn tại. Nghĩa gọn 2-6
   chữ, in đậm, rồi một vế làm rõ chỗ người Việt hay hiểu sai. Không chép nguyên
   đoạn VI dài của bài học sang.
2. **Cột nghĩa Việt mang class `hide-me`** — để nút "Chế độ ôn tập" che được. Cùng
   một bảng: mặc định để hiểu, bật lên thành bài tự kiểm tra. Thiếu class này là
   hỏng nửa công dụng.
3. **Mục "chỗ dễ sai" quan trọng hơn mục định nghĩa** — rút từ phần **Bẫy**, xếp
   thành Đúng / Sai / Vì sao. Ưu tiên giới từ đi kèm, cặp từ dễ lẫn, viết liền hay
   tách, động từ bất quy tắc.
4. **Mỗi từ đúng một câu ví dụ.** Bảng ôn dài bằng bài gốc thì không ai đọc lại.

Chỉ gom từ **trong tuần đó**, không kéo từ tuần khác, không thêm từ mới. Đây là bản
phái sinh nên **được phép ghi đè** — R5 không áp dụng.

### Flow C — Tra từ bắt gặp ngoài đời (ad-hoc)

User dán 1 câu/đoạn gặp khi đọc doc, xem phim, đọc email khách. Agent giải thích,
rồi hỏi user có muốn đưa vào vốn từ không. Nếu có → thêm vào `{vocabIndex}` với
`source: ad-hoc` và đẩy vào `{reviewQueue}`. Từ ad-hoc **cũng tính là đã học** →
kỳ sau không được ra lại làm từ mới. Có ghi file → commit + push (R6).

---

## Chống lặp ở tầng cao hơn từ vựng

Ngoài R1 (không trùng từ), tránh lặp **kiểu bài**:

- Mẩu đọc mỗi ngày đổi bối cảnh: code review → email khách → standup → tài liệu
  kiến trúc → đoạn truyện → hội thoại quán cà phê…
- Không dùng lại nguyên mẫu câu ví dụ của bài trước (đổi chủ ngữ/tình huống).
- Dạng bài tập xoay vòng: cloze → matching → sửa lỗi sai → dịch Việt-Anh → viết lại câu.

---

## Ngôn ngữ & giọng điệu

- Giải thích **song ngữ**: định nghĩa tiếng Anh trước (immersion), nghĩa Việt +
  ghi chú nuance ngay sau (chính xác).
- Không viết dài dòng. Người học là dev bận — mỗi buổi đọc trong ~10 phút.
- Không khen sáo. Sai thì nói thẳng chỗ sai và vì sao.
- Được dùng ví dụ có code/thuật ngữ kỹ thuật — đó là lợi thế của learner này.

---

## Memory — khi nào ghi

Ghi 1 entry `{memory}` khi:

- Cùng một lỗi lặp lại ≥ 2 lần (vd: quên `-s` ngôi thứ ba, nhầm `affect/effect`).
- User nói rõ sở thích cách học ("đừng cho từ quá học thuật", "thêm ví dụ code").
- Phát hiện quy luật về learner (nhớ tốt từ có gốc Latin, kém từ phrasal verb…).

Không ghi memory những thứ đã nằm sẵn trong lesson/quiz — memory là **rule**, không
phải nội dung.
