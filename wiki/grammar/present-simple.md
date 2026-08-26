# #3 — Present simple + `-s` ngôi 3 số ít

> Chặng 1 · Khung câu · Dạy ở buổi **#12 — [2026-08-26](../lessons/2026-W35/2026-08-26.md)**

## Hiện tượng

Present simple là thì của những việc **lặp đi lặp lại** và những việc **luôn đúng**:
thói quen, quy trình, cách một hệ thống vận hành. Nó **không** phải thì của việc đang
xảy ra ngay lúc này.

Điểm #1 (`S + V + O`) lo trật tự câu. Điểm #2 (`be`) lo những câu **không có hành động**.
Điểm #3 lo phần còn lại — mọi câu **có hành động** ở dạng mặc định của nó. Đây cũng là
thì mà toàn bộ tài liệu kỹ thuật tiếng Anh được viết bằng.

### Neo vào tiếng Việt

Chỗ khác nhau nằm ở đúng một chữ cái.

| Tiếng Việt | Động từ có đổi không? | Tiếng Anh |
| --- | --- | --- |
| "Mình **chạy** test mỗi sáng." | không đổi | `I run the tests every morning.` |
| "Nó **chạy** test mỗi sáng." | vẫn "chạy" | `He runs the tests every morning.` |
| "Con server **chạy** lúc 6h." | vẫn "chạy" | `The server runs at 6am.` |
| "Bọn mình **chạy** test mỗi sáng." | vẫn "chạy" | `We run the tests every morning.` |

Tiếng Việt **không bao giờ** đổi hình dạng động từ theo chủ ngữ. Tiếng Anh thì với
**he / she / it** — và mọi chủ ngữ số ít thay được bằng *it* — phải gắn thêm **-s**.

Điều làm nó khó nhớ: cái `-s` đó **không mang nghĩa gì cả**. Bỏ đi thì câu vẫn hiểu
được, nên não bỏ qua rất tự nhiên. Nhưng người bản xứ nghe ra ngay, và đây là lỗi bị
để ý nhiều nhất ở trình độ A2–B1.

**Nguyên tắc một dòng:** chủ ngữ thay được bằng `he / she / it` → động từ phải có `-s`.

## Quy tắc

```
Khẳng định   I / you / we / they  +  V          he / she / it  +  V-s

Thêm s       thường           + s        spins · truncates · accommodates · drops
             -s -sh -ch -x -o + es       watches · fixes · goes · does
             phụ âm + y    y → ies       try → tries
             nguyên âm + y giữ nguyên    deploy → deploys · buy → buys
             bất quy tắc                 have → has · be → is

Trạng từ     always · usually · often · sometimes · never   → TRƯỚC động từ thường
             every day · twice a week · on Mondays          → cuối câu

Xem trước    Phủ định   he/she/it  doesn't + V (nguyên mẫu)     ┐ điểm #4
(#4)         Câu hỏi    Does + he/she/it + V (nguyên mẫu) ?     ┘ buổi sau
```

Ba hệ quả cần nhớ:

1. **Một câu chỉ đeo `-s` một lần**, và nó luôn đeo ở **từ đầu tiên** của cụm động từ.
   Có `does` rồi thì động từ chính về nguyên mẫu.
2. **Chia theo hình dạng chủ ngữ, không theo nghĩa**: `The build server runs…` ·
   `Everyone checks…` · `The tests run…`.
3. **Trạng từ tần suất chen vào giữa chủ ngữ và động từ**, không đứng sau động từ:
   `She never drops by…`, không phải "She drops never by…".

## Dùng khi nào

| Ca | Dấu hiệu | Ví dụ |
| --- | --- | --- |
| Thói quen, việc lặp lại | `every day`, `always`, `twice a week` | `I check the error log every morning.` |
| Cách hệ thống vận hành | đang viết tài liệu / mô tả bug | `The build server truncates any log over 5 MB.` |
| Sự thật, luật, quy định | câu đúng bất kể hôm nay là ngày nào | `We accommodate two revision rounds per milestone.` |
| Lịch cố định | có giờ giấc, lặp theo tuần | `The standup starts at 9:15.` |
| Nghĩ / muốn / cần (động từ trạng thái) | `think`, `want`, `need`, `depend` | `It depends on the client.` |

## Khi nào KHÔNG thêm `-s`

| Trường hợp | Sai | Đúng |
| --- | --- | --- |
| Sau `does` / `doesn't` (#4) | `He doesn't spins up a container` | `He doesn't spin up a container.` |
| Sau modal | `She cans accommodate it` | `She can accommodate it.` |
| Chủ ngữ `I` / `you` / số nhiều | `They accommodates every request` | `They accommodate every request.` |
| Việc đang xảy ra lúc nói (#10) | `The job runs now` | `The job is running now.` |
| Việc đã xong trong quá khứ (#7) | `The build fails at 3pm yesterday` | `The build failed at 3pm.` |

## Ví dụ đúng / sai

| ✅ Đúng | ❌ Sai | Vì sao |
| --- | --- | --- |
| `The pipeline spins up a container.` | `The pipeline spin up a container.` | `The pipeline` thay được bằng `it` → bắt buộc có `-s`. |
| `He doesn't touch base with the client.` | `He doesn't touches base with the client.` | `does` đã gánh `-s` rồi. Một câu chỉ đeo `-s` một lần. |
| `She never drops by without a call.` | `She drops never by without a call.` | Trạng từ tần suất đứng **trước** động từ thường. |
| `He goes to the client site twice a month.` | `He gos to the client site twice a month.` | Động từ tận cùng `-o` thì thêm `-es`. |
| `The API returns 404 if the token is missing.` | `The API will return 404 if the token is missing.` | Mô tả hành vi chung của hệ thống thì dùng present simple, không dùng `will`. |

## Bẫy với người Việt

**1. Quên `-s`.** Lỗi số một, và nó không tự hết khi vốn từ tăng — vì tiếng Việt không
chia động từ nên não không có chỗ nào để mà nhớ.

| Tiếng Việt | Dịch thẳng (sai) | Câu đúng |
| --- | --- | --- |
| "Con logger cắt cụt log dài." | `The logger truncate long logs.` | `The logger truncates long logs.` |
| "Anh PM nhắn khách mỗi thứ Hai." | `Our PM touch base with the client every Monday.` | `Our PM touches base with the client every Monday.` |
| "Cậu ấy hay tạt qua bàn mình." | `He often drop by my desk.` | `He often drops by my desk.` |

Sửa bằng phản xạ: viết xong câu, chỉ tay vào chủ ngữ và hỏi *"thay được bằng
he/she/it không?"* — được thì thêm `-s`.

**2. Đeo `-s` hai lần.** `Does he spins up…?` · `He doesn't truncates…` Luật gọn: `-s`
chỉ bám vào **từ đầu tiên** của cụm động từ, và chỉ **một lần** trong cả câu.

**3. Dùng present simple cho việc đang xảy ra.** "Mình **đang** sửa cái bug" →
❌ `I fix the bug now` → ✅ `I am fixing the bug now`. Chữ **"đang"** trong câu tiếng
Việt là dấu hiệu phải chuyển sang continuous (#10). Ngược lại, mô tả hành vi chung của
hệ thống thì đừng dùng `will`.

**Mẹo soát trước khi bấm gửi:** tìm chủ ngữ, thay thử bằng `it`. Thay được mà động từ
không có `-s` → thiếu. Trong câu đã có `does`/`doesn't`/modal mà động từ chính vẫn có
`-s` → thừa.

## Đã gặp ở đâu

- Buổi **#12** ([2026-08-26](../lessons/2026-W35/2026-08-26.md)) — dạy lần đầu; ví dụ của
  cả 5 từ (`spin up`, `truncate`, `touch base`, `accommodate`, `drop by`) và mẩu đọc đều
  viết theo mẫu này. Năm từ hôm đó đều là **động từ / cụm động từ** nên `-s` có chỗ bám
  ngay trong từng câu.
