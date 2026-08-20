---
name: dich-tu-nhien
description: User muốn nghĩa Việt nghe như người Việt nói, không dịch từng chữ, giữ nguyên thuật ngữ dev tiếng Anh
type: preference
created: 2026-08-20
evidence: 2026-08-20 — user đọc lại 7 buổi đầu (W33 + W34) và nói bản dịch "hơi máy móc", yêu cầu sửa cả các bản ghi cũ
---

**Rule:** Mọi câu tiếng Việt trong bài (Nghĩa gọn · `**VI**` · `vi-quick` · `def-vi` ·
câu dịch ví dụ · bản dịch mẩu đọc · cột nghĩa recap) phải viết như một dev Việt nói
ra, không phải chuyển ngữ từng chữ từ câu tiếng Anh. Thuật ngữ dev quen nói bằng
tiếng Anh (`deploy`, `release`, `cache`, `endpoint`, `rebase`, `merge conflict`,
`refactor`, `sprint`, `query`…) **để nguyên tiếng Anh**.

**Why:** Sau 7 buổi user tự đọc lại và thấy bản dịch "máy móc". Hai nguồn gây ra cảm
giác đó: (1) dịch bám cấu trúc câu tiếng Anh — "Một cách tạm thời để làm xong việc gì
đó bằng cách né tránh vấn đề thay vì sửa nó"; (2) dịch cứng thuật ngữ — "bản phát
hành", "xung đột khi gộp code", "bộ chọn ngày" — không ai trong nghề nói vậy, nên câu
dịch nghe xa lạ hơn cả câu gốc. Nghĩa Việt mà đọc không vào thì mất luôn tác dụng
neo trí nhớ.

**How to apply:** Trước khi ghi file, đọc to từng câu dịch một lượt; câu nào phải đọc
hai lần mới xuôi thì viết lại. Giọng bám theo vai của câu gốc: email/họp với khách →
*anh/chị, bên em, …ạ*; chat/standup → *mình, bọn mình, tớ/cậu*; đời sống → xưng hô đời
thường. Giữ mức chuẩn mực (tôi/chúng tôi/bạn), không suồng sã hoá toàn bộ — đó là lựa
chọn user đã chốt 2026-08-20. Luật đầy đủ: R7 trong [AGENTS.md](../../AGENTS.md).

Liên quan: [[R7]]
