# recap/ — Bảng ôn

Hai loại trang nằm chung thư mục này:

| File | Kỳ | Ai làm | Sửa tay? |
|---|---|---|---|
| `YYYY-Www.md` + `.html` | tuần | agent soạn — `/on-tap-tuan`, 7h sáng Chủ nhật | được (ghi đè khi tuần học thêm) |
| `YYYY-MM.html` | tháng | **sinh máy** — `tools/build-recap.sh` | ⛔ không |
| `YYYY-Qn.html` | quý | **sinh máy** | ⛔ không |
| `YYYY-Hn.html` | nửa năm | **sinh máy** | ⛔ không |
| `YYYY.html` | năm | **sinh máy** | ⛔ không |

## Bảng ôn tuần

Luật đầy đủ: **Flow D** trong [AGENTS.md](../../AGENTS.md).

Đây là trang **để đọc**, không phải để chấm điểm. Nghĩa Việt **hiện sẵn** ngay cột
kế bên từ tiếng Anh — liếc một cái là hiểu. Bấm nút "🙈 Chế độ ôn tập" thì cột
tiếng Việt mờ đi, cùng trang đó thành bài tự kiểm tra.

`quiz/` thì ngược lại: giấu đáp án ở file `-key.md` riêng, chỉ mở sau khi nộp bài.

Nội dung mỗi trang tuần:

1. **Tra nhanh cả tuần** — bảng: từ · nghĩa Việt · nhóm · cụm hay đi kèm
2. **Chỗ dễ sai** — Đúng / Sai / Vì sao, rút từ mục *Bẫy* của các bài trong tuần
3. **Chi tiết** — mỗi từ đúng một câu ví dụ thật
4. **Tự kiểm tra** — 4-6 câu, đáp án bọc `<details>`

Đây là bản phái sinh từ `lessons/`, **được phép ghi đè** khi tuần đó học thêm buổi.

## Bảng ôn tháng / quý / nửa năm / năm

Kỳ dài gom hàng trăm từ nên **sinh bằng máy**, chép nguyên từ bài gốc — không ai
soạn lại chữ nào. `sh tools/build-index.sh` gọi `build-recap.sh` trước, nên sau mỗi
buổi học các trang này tự cập nhật.

- Một bảng tra nhanh: từ + IPA + 🔊 · **nghĩa Việt** (khối `.vi-quick` của bài gốc,
  có `hide-me`) · 3 cụm đi kèm + câu ví dụ #1. Bấm ngày học dưới từ để mở bài gốc.
- Chia nhóm (không gập/mở): trang tháng gom theo tuần, trang quý /
  nửa năm / năm gom theo tháng. Mỗi nhóm có link xuống bảng ôn của nhóm đó.
- Từ xếp vào kỳ theo **ngày học**: tuần vắt hai tháng thì mỗi tháng giữ phần của mình.
- Kỳ chưa hết vẫn có trang, ghi "đang diễn ra".

Nghĩa sai thì sửa ở **bài gốc** (Flow E) rồi build lại — sửa tay ở đây sẽ bị ghi đè.
