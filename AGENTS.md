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

## Chín quy tắc CỨNG

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

**R1.b — Bảng "Đã biết sẵn" cũng là trùng.** Cuối `{vocabIndex}` có bảng
`## ⛔ Đã biết sẵn — KHÔNG BAO GIỜ dạy lại`: từ người học tự báo là đã biết. Lệnh
grep ở trên quét cả file nên tự bắt được — **không được** bỏ qua kết quả chỉ vì nó
nằm ở bảng dưới. Trúng bảng này = loại y như trùng từ đã dạy.

**Khi user nói "từ này tôi đã biết"** (đang mở một bài học bất kỳ):

1. Thêm dòng vào bảng **Đã biết sẵn** — đủ word family, để lần sau grep bắt được.
2. Xoá từ đó khỏi bảng chính (nếu đã lỡ ghi) và khỏi `{reviewQueue}`.
3. Chọn từ thay thế **cùng nhóm** (IT/Business/Life), qua lại hard gate R1.
4. Viết lại **mọi** chỗ trong bài có từ cũ: khối từ, ví dụ, mẩu đọc, khối tự viết,
   bài tập, đáp án, ghi chú buổi học — R8 và R9 vẫn phải đúng sau khi thay.
5. Cập nhật lại 5 file state + `sh tools/build-index.sh` + `daylen`.

Người học đã biết một từ thì việc dạy lại là **lãng phí một suất trong ngày** —
mỗi buổi chỉ có 5 suất.

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

`keove`/`daylen` in ra mã kết quả. **Hai mã là THÀNH CÔNG:**

| Mã | Nghĩa |
|---|---|
| `DA-PUSH: <sha> -> origin/<nhánh>` | đã lưu lên GitHub |
| `KHONG-CO-GI-DE-LUU` | cây làm việc sạch, không có thay đổi nào — **không phải lỗi** |

Mọi mã còn lại (`PUSH-LOI`, `COMMIT-LOI`, `KHONG-KEO-DUOC`, `KHONG-CHUYEN-DUOC-NHANH`,
`DA-COMMIT-NHUNG-CHUA-CO-REMOTE`) là **thất bại** → nói thẳng với user là buổi học
chưa lưu được lên GitHub, kèm nguyên văn lỗi. Tuyệt đối không báo "xong" rồi im:
trên VM cloud, im lặng ở bước này nghĩa là mất trắng buổi học.

#### Xung đột

Hai máy cùng học một ngày → `{vocabIndex}` / `{reviewQueue}` / `{progress}` đụng
nhau. Không tự ý chọn bên nào: giữ **cả hai** phần từ vựng (từ đã học là đã học,
mất đi thì R1 hết tác dụng), rồi tính lại streak và tổng số từ cho khớp
`{vocabIndex}` — nó là nguồn sự thật, thắng mọi file khác.

---

### R7 — Nghĩa Việt phải nghe như người Việt nói

Bản dịch **không phải bản chuyển ngữ từng chữ**. Người học đọc câu tiếng Việt để
*cảm* được câu tiếng Anh, nên câu tiếng Việt phải là câu một dev Việt thật sự nói
ra. Luật này áp cho **mọi** chỗ có tiếng Việt: cột `Nghĩa gọn` trong
`{vocabIndex}`, mục `**VI**`, `vi-quick`, `def-vi`, câu dịch ví dụ, bản dịch mẩu
đọc, và cột nghĩa trong `{recap}`.

1. **Dịch ý, không dịch cấu trúc.** Tiếng Anh treo mệnh đề phụ ở cuối thì tiếng
   Việt thường phải đưa lên đầu. Bỏ "một cách…", "việc mà…", "điều gì đó", chủ ngữ
   giả, và mọi thứ chỉ tồn tại vì câu gốc có nó.
   - ✗ _"Một cách tạm thời để làm xong việc gì đó bằng cách né tránh vấn đề thay vì sửa nó."_
   - ✓ _"Cách làm tạm cho xong việc bằng cách né chỗ lỗi, chứ không phải sửa lỗi."_

2. **Thuật ngữ nào dev nói bằng tiếng Anh thì để nguyên tiếng Anh.** `deploy` ·
   `release` · `cache` · `endpoint` · `rebase` · `merge conflict` · `refactor` ·
   `test` · `staging` · `sprint` · `PR` · `review` · `database` · `job` · `retry` ·
   `query` · `export`… Dịch chúng ra ("bản phát hành", "xung đột khi gộp code",
   "tác vụ đồng bộ", "bộ chọn ngày") là **dấu hiệu rõ nhất của bản dịch máy** — không
   ai trong nghề nói vậy. Nghĩa tiếng Việt của chính từ đang học đã nằm ở mục `**VI**`
   và cột `Nghĩa gọn` rồi, câu ví dụ không phải gánh thêm việc đó.
   *Ngoại lệ:* từ nào đã có tiếng Việt quen miệng thì dùng tiếng Việt — nút thắt cổ
   chai, chập chờn, quen tay, gượng gạo.

3. **Giữ đúng vai của câu gốc.** Câu email/họp với khách → _anh/chị, bên em, …ạ_.
   Câu chat/standup với đồng nghiệp → _mình, bọn mình, tớ/cậu_. Câu đời sống → xưng
   hô đời thường. Một bài có cả ba giọng là bình thường; **dùng một giọng cho cả bài
   mới là sai**.

4. **Nghĩa gọn viết như nói, không như từ điển.** Ngắn, có hình ảnh, đọc phát hiểu.
   - ✗ "quỹ thời gian / sức làm còn rảnh" → ✓ "còn rảnh sức mà nhận việc không"
   - ✗ "xung đột khi gộp code" → ✓ "hai nhánh sửa cùng chỗ, Git chịu"

5. **Đọc to lên một lượt trước khi ghi file.** Câu nào phải đọc hai lần mới xuôi thì
   viết lại. Đây là kiểm tra cuối, không bỏ qua được.

---

### R8 — Mỗi câu ví dụ phải kéo theo một từ cũ, hai câu không trùng nhau

Câu ví dụ không chỉ để dạy từ hôm nay — nó còn là **chỗ ôn lại** từ hôm qua. Gặp
lại một từ trong ngữ cảnh mới là cách nhớ tốt hơn nhiều so với đọc lại định nghĩa.

1. **Mọi câu ví dụ** — không phải "một trong hai" — đều phải chứa **≥ 1 từ đã học ở
   buổi trước** (bất kỳ buổi nào, không riêng buổi liền trước).
2. **Hai câu của cùng một từ phải dùng hai từ cũ KHÁC nhau.** Câu 1 mượn
   `rollback` thì câu 2 phải mượn từ khác — mỗi khối 5 từ vì thế ôn lại được 10 từ cũ.
3. **Mẩu đọc**: cũng phải có ≥ 1 từ cũ.
4. **Đánh dấu từ cũ**: HTML dùng `<span class="rev">từ cũ</span>`, Markdown dùng
   `_từ cũ_`. **Không in đậm** — in đậm chỉ dành cho từ mới của bài. CSS `.rev`
   nằm sẵn ở `{assets}/lesson.css` (gạch chân chấm chấm), đừng nhúng style riêng.
5. **Phải đúng nghĩa đã học**, không phải trùng mặt chữ: `reach the client` KHÔNG
   tính là ôn `reach out`; `on the scope` KHÔNG tính là ôn `scope creep`.
6. **Ưu tiên** từ đang tới hạn trong `{reviewQueue}`, và ưu tiên từ **khác nhóm**
   với từ mới (từ IT kéo theo một từ giao tiếp và ngược lại) để nối mạng từ vựng.
7. Câu vẫn phải tự nhiên. Nhồi ba từ cũ vào một câu cho đủ chỉ tiêu là hỏng —
   một từ, đặt đúng chỗ, là đủ.
8. **Ngoại lệ duy nhất**: buổi #1 (chưa có từ cũ nào để tái sử dụng).

Cách tự kiểm trước khi đóng buổi: với **từng câu** ví dụ, chỉ ra được từ cũ nằm ở
đâu, nó thuộc buổi nào, và nó khác từ cũ của câu kia. Không chỉ ra được = viết lại câu.

---

### R9 — Ngữ pháp là khung câu của cả buổi

Từ **2026-08-24** (`grammar.startDate`) mỗi buổi dạy **đúng một** điểm ngữ pháp, và
điểm đó không phải phần phụ nằm cạnh từ vựng — nó là **khung câu** để 5 từ mới của
ngày được đặt vào. Lý do: 9 buổi đầu dạy 45 từ mà không dạy khung, nên người học
nhận ra từ nhưng không ráp được câu.

1. **Điểm nào là do `{grammar}/CURRICULUM.md` quyết** — đọc dòng *"Điểm kế tiếp"*.
   Tuyệt đối không suy ra từ số buổi, từ ngày tháng, hay từ trí nhớ của agent.
2. **Khối "Ngữ pháp hôm nay" phải đủ 8 mục** theo `grammar.blockSections`, đúng thứ
   tự. Hai mục **"Nó là gì"** và **"Dùng khi nào"** là bắt buộc và phải đứng trước
   công thức — nhảy thẳng vào công thức chính là lối dạy đã làm người học mất gốc.
   Mục "Nó là gì" phải **neo vào tiếng Việt**: chỉ ra cách nói tiếng Việt gần nhất,
   hoặc nói thẳng là tiếng Việt không có nên phải hiểu bằng công dụng.
3. **Ví dụ của cả 5 từ và mẩu đọc đều phải viết theo mẫu ngữ pháp đó.** R8 vẫn giữ
   nguyên và cộng dồn: một câu vừa theo mẫu ngữ pháp mới, vừa mượn một từ cũ. Trên
   HTML, gắn nhãn `<div class="ex-label">Ví dụ <span class="pattern-tag">…</span></div>`.
   Viết nhãn mà câu không theo mẫu là nói dối người học — thà bỏ nhãn.
4. **Buổi phải có khối "Tự viết"** (`production`): 3 đề, ba dạng câu **khác nhau**
   (khẳng định / câu hỏi / phủ định), mỗi đề buộc dùng mẫu ngữ pháp + một từ mới.
   **Không có đáp án** cho 3 đề — chỉ 2 câu **mẫu**, bọc `<details>`. Đây là bước
   duy nhất bắt người học tự sản xuất câu; bỏ nó thì buổi học quay về đọc-rồi-quên.
5. **Đóng buổi phải cập nhật con trỏ**: đánh ✅ dòng tương ứng trong `CURRICULUM.md`,
   sửa lại mục *"Đang ở đâu"*, ghi `{grammar}/<slug>.md`, và cập nhật dòng ngữ pháp
   trong `{progress}`. Quên bước này thì hôm sau dạy lại đúng điểm cũ.
6. **Điểm không liên quan thời gian** (mạo từ, giới từ, modal, mệnh đề quan hệ…) thì
   mục "trục thời gian" đổi thành hai ô so sánh khác — `a/an` vs `the`, `must` vs
   `have to` — vẫn dùng class `.tl` / `.tl-card`, đừng bỏ trống mục.
7. **Ngoại lệ**: bài học có ngày **trước** `grammar.startDate` thì không có khối ngữ
   pháp lẫn khối tự viết, và không gắn nhãn `.pattern-tag`. Đừng đi sửa bài cũ.

---

## Luồng chuẩn

### Flow A — Buổi học hằng ngày

```text
Phase 0  Auto-discovery (ở trên)
Phase 0.5 ⛔ GATE R5: ls {lessons}/<tuần>/<hôm nay>*.md
         Có file -> KHÔNG sinh bài. Mở lại bài cũ, hỏi user, DỪNG tại đây.
Phase 1  Ôn nhanh: đọc {reviewQueue}, lấy `review.warmupPerSession` từ (8) tới hạn,
         LÔ CŨ NHẤT TRƯỚC -> hỏi gợi nhớ, đáp án bọc <details>
Phase 1.5 ⭐ Ngữ pháp (R9): đọc {grammar}/CURRICULUM.md -> dòng "Điểm kế tiếp".
         Ngày học < `grammar.startDate` -> bỏ qua Phase 1.5 và Phase 4.5.
Phase 2  Chọn ứng viên: 2 IT + 2 business + 1 life, bám level
Phase 3  ⛔ HARD GATE R1: grep {vocabIndex} từng từ. Trùng -> quay lại Phase 2
Phase 4  Soạn bài: mỗi từ đủ mục `daily.mustInclude` + mẩu đọc + bài tập.
         ⛔ R9: ví dụ của CẢ 5 TỪ + mẩu đọc viết theo mẫu ngữ pháp Phase 1.5.
         ⛔ R8 vẫn cộng dồn: mỗi câu vẫn phải mượn 1 từ cũ, 2 câu 2 từ khác nhau.
Phase 4.5 ⭐ Tự viết (R9.4): 3 đề — khẳng định / câu hỏi / phủ định. Không đáp án,
         chỉ 2 câu mẫu bọc <details>.
Phase 5  Ghi file: lesson .md -> lesson .html -> VOCAB_INDEX -> REVIEW_QUEUE
         -> PROGRESS -> {grammar}/<slug>.md -> CURRICULUM.md (✅ + "Đang ở đâu")
         (R3 + R9.5)
Phase 6  sh tools/build-index.sh  -> daylen "hoc: ..."  (R6 — chưa push là chưa có)
Phase 7  openit <file.html> + tóm tắt 5 từ trong chat (không bắt user tự đi tìm file)
         Máy Mac -> mở trình duyệt. VM cloud -> in link Pages để user bấm.
```

### Flow B — Kiểm tra cuối tuần

```text
Phase 0  Auto-discovery + xác định tuần ISO cần kiểm tra
Phase 1  Gom từ: mọi từ trong {lessons}/<tuần>/ + tối đa 5 từ yếu từ {reviewQueue}
         + các điểm ngữ pháp đã dạy trong tuần (đọc {grammar}/CURRICULUM.md)
Phase 2  Ra đề 4 phần A/B/C/D theo config `weekly.format`, THÊM phần E — Ngữ pháp
         (các điểm của tuần) -> ghi {quiz}/<tuần>.md
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
Phase 1.5 Gom điểm ngữ pháp của tuần: {grammar}/CURRICULUM.md, các dòng ✅ có cột
         "Buổi" thuộc tuần này. Tuần trước `grammar.startDate` -> BỎ HẲN mục này.
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
- **Câu tiếng Việt phải nghe như người Việt nói** — luật đầy đủ ở [R7](#r7--nghĩa-việt-phải-nghe-như-người-việt-nói).

---

## Memory — khi nào ghi

Ghi 1 entry `{memory}` khi:

- Cùng một lỗi lặp lại ≥ 2 lần (vd: quên `-s` ngôi thứ ba, nhầm `affect/effect`).
- User nói rõ sở thích cách học ("đừng cho từ quá học thuật", "thêm ví dụ code").
- Phát hiện quy luật về learner (nhớ tốt từ có gốc Latin, kém từ phrasal verb…).

Không ghi memory những thứ đã nằm sẵn trong lesson/quiz — memory là **rule**, không
phải nội dung.
