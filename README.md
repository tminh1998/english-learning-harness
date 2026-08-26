# ENGLISH — Harness học tiếng Anh cho dev

Mỗi ngày 5 từ mới, ghi vào wiki, cuối tuần kiểm tra lại, **không bao giờ trùng từ cũ**.

## Dùng thế nào

Mở Claude Code tại thư mục này rồi gõ:

| Lệnh | Làm gì |
|---|---|
| `/hoc` | Bài hôm nay — 5 từ mới (2 IT + 2 giao tiếp khách hàng + 1 đời sống), tự mở trang HTML |
| `/on-tap` | Ôn nhanh các từ tới hạn theo lịch spaced repetition (có chấm điểm) |
| `/on-tap-tuan` | **Bảng ôn tuần** — mọi từ trong tuần, nghĩa Việt ngay cạnh từ, để đọc lướt |
| `/tra-tu <từ/câu>` | Gặp từ lạ khi đọc doc, email khách, phim, truyện → tra và lưu lại |
| `/kiem-tra` | **Chủ nhật** — kiểm tra toàn bộ từ đã học trong tuần (có chấm điểm) |
| `/tien-do` | Xem đã học bao nhiêu, đang yếu chỗ nào |
| `/open` | Mở lại trang HTML bài hôm nay (`/open 2026-08-12` để mở đúng ngày) |

Ba lệnh ôn dễ nhầm nhau — khác ở chỗ **nghĩa Việt có hiện sẵn không**:

| | Nghĩa Việt | Dùng khi |
|---|---|---|
| `/on-tap-tuan` | **hiện sẵn** ngay cạnh từ | đọc lướt cả tuần cho nhớ lại, 5 phút |
| `/on-tap` | giấu tới khi bạn trả lời | muốn được hỏi và chấm, cập nhật lịch ôn |
| `/kiem-tra` | giấu ở file riêng | kiểm tra nghiêm túc, tính điểm % |

## Tự động chạy

Không cần gõ gì, không cần bật máy — hai routine chạy trên cloud của Anthropic:

| Khi nào | Chạy gì | Kết quả |
|---|---|---|
| **7h sáng T2–T7** | `/hoc` | 5 từ mới, đẩy thẳng lên GitHub |
| **7h sáng Chủ nhật** | `/on-tap-tuan` | bảng ôn cả tuần (Chủ nhật không học từ mới) |

Sáng dậy mở [trang đọc](https://tminh1998.github.io/english-learning-harness) là có
sẵn. Xem/sửa/tắt lịch tại [claude.ai/code/routines](https://claude.ai/code/routines).

Hai việc **vẫn phải tự gõ** vì cần bạn trả lời: `/on-tap` và `/kiem-tra`. Máy không
tự chấm điểm cho một người không ngồi đó trả lời được.

## Học từ máy khác / điện thoại

Không cần ngồi đúng con máy này. Có hai cách, dùng cho hai việc khác nhau:

**Chỉ ĐỌC lại bài** → mở trang mục lục, không cần Claude, không cần đăng nhập:

> 📖 <!-- PAGES_URL -->[https://tminh1998.github.io/english-learning-harness](https://tminh1998.github.io/english-learning-harness)

**HỌC bài mới (gõ `/hoc`)** → cần một agent Claude thật chạy:

1. Vào [claude.ai/code](https://claude.ai/code) trên trình duyệt bất kỳ (điện thoại
   cũng được), đăng nhập tài khoản Claude như thường.
2. Chọn repo này → gõ `/hoc`. Session chạy trên VM cloud của Anthropic, sinh bài
   y hệt như ở máy, rồi tự commit + push thẳng lên nhánh `main`.
3. Hết. **Không có bước merge nào** — vài chục giây sau bài đã có trên trang đọc.

Cần gói Claude Pro/Max/Team. App Claude trên điện thoại xem/điều khiển được session
đang chạy.

> ⚠️ **Học hai nơi thì phải đồng bộ.** Chống trùng từ và luật một-ngày-một-bài đều
> dựa vào `VOCAB_INDEX.md`. Agent tự kéo về đầu buổi và đẩy lên cuối buổi (luật
> R6) — nhưng nếu nó báo push lỗi thì buổi đó **chưa được lưu ở đâu cả**, đừng bỏ
> qua dòng báo lỗi ấy.

## Kiến thức nằm ở đâu

```
wiki/
├── VOCAB_INDEX.md        ⭐ mọi từ đã học — grep file này là biết đã học gì
├── REVIEW_QUEUE.md       lịch ôn: từ nào tới hạn ngày nào
├── PROGRESS.md           streak, tổng từ, điểm quiz
├── assets/               lesson.css + lesson.js — giao diện dùng chung
├── lessons/2026-W33/2026-08-12.md     bản đọc nhanh
│                        2026-08-12.html    bản trình bày (mở bằng trình duyệt)
├── quiz/2026-W33.md                   đề kiểm tra tuần (+ file -key.md riêng)
├── recap/2026-W33.md                  bảng ôn cả tuần (+ .html)
└── memory/MEMORY.md      rule đã học về cách học của bạn
```

## Trang HTML có gì

Mỗi buổi `/hoc` sinh một trang mở thẳng trong trình duyệt:

- **🔊 Nghe phát âm** từng từ (chạy offline bằng giọng có sẵn của máy)
- **🙈 Chế độ ôn tập** — che mờ toàn bộ phần tiếng Việt để tự kiểm tra, bấm vào
  chỗ mờ thì hiện ra
- **🌗 Sáng / tối**, đọc tốt trên điện thoại, in ra giấy được (Cmd+P)

Muốn đổi giao diện cho **tất cả** bài học (kể cả bài cũ): sửa
`wiki/assets/lesson.css`, không phải sửa từng bài.

## Ba đảm bảo của harness

1. **Không trùng** — trước khi ra từ mới, agent bắt buộc grep `VOCAB_INDEX.md`;
   trùng cả họ từ (`deploy`/`deployment`) cũng bị loại.
2. **Không lộ đáp án** — bài tập bọc `<details>`, đề quiz và đáp án nằm hai file
   khác nhau, chỉ chấm sau khi bạn nộp bài.
3. **Không học chay** — mỗi buổi phải cập nhật đủ 5 file state, dựng lại mục lục,
   rồi push lên GitHub. Thiếu 1 là buổi chưa đóng.

## Cấu hình

Sửa `.learning-config.yml` nếu muốn đổi: số từ/ngày, tỷ lệ chủ đề, ngày kiểm tra,
khoảng cách ôn tập, trình độ. Đây là **file duy nhất** chứa cấu hình + path thật.

Luật đầy đủ: [AGENTS.md](AGENTS.md) · Phần riêng cho Claude Code: [CLAUDE.md](CLAUDE.md)

---

> `.archive-fe-harness/` là harness frontend VCBF cũ từng nằm ở thư mục này.
> Không liên quan đến việc học — xoá được bất cứ lúc nào.
