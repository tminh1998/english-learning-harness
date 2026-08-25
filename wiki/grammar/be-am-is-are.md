# #2 — Động từ `be` (am / is / are)

> Chặng 1 · Khung câu · Dạy ở buổi **#11 — [2026-08-25](../lessons/2026-W35/2026-08-25.md)**

## Hiện tượng

`be` là động từ **nối**. Nó không tả hành động nào cả — nó chỉ **gắn chủ ngữ với thứ
mô tả chủ ngữ đó**. Ở hiện tại nó có đúng ba hình dạng, và chọn hình nào là do **chủ
ngữ** quyết, không do nghĩa:

```
I            am
he/she/it    is
you/we/they  are
```

Điểm #1 (`S + V + O`) lo những câu **có hành động**. Điểm #2 lo tất cả những câu **không
có hành động nào** — mà loại đó chiếm phần lớn những gì một dev viết trong ngày: mô tả
trạng thái, mô tả tính chất, báo mình đang ở đâu.

### Neo vào tiếng Việt

Đây là chỗ tiếng Việt **chỉ có một nửa**, và chính cái nửa còn thiếu đẻ ra lỗi.

| Tiếng Việt | Có chữ "là" không? | Tiếng Anh |
| --- | --- | --- |
| "Anh ấy **là** dev." | có — nối với **danh từ** | `He is a developer.` |
| "Cái test này chập chờn." | **không có gì cả** | `The test is flaky.` |
| "Mình mệt rồi." | **không có gì cả** | `I am tired.` |
| "Server ở Singapore." | **không có gì cả** | `The server is in Singapore.` |

Tiếng Việt chỉ cần "là" khi nối hai **danh từ**. Nối với **tính từ** hay **nơi chốn**
thì tiếng Việt bỏ trống — tiếng Anh thì **không bao giờ** được bỏ trống.

Vì vậy `The test flaky` với người bản xứ nghe như một mẩu tiêu đề bị cắt cụt, chứ chưa
phải một câu.

**Nguyên tắc một dòng:** câu tiếng Anh nào **không có động từ thường** thì bắt buộc phải
có `be`.

## Dùng khi nào

| # | Trường hợp | Dấu hiệu | Ví dụ |
| --- | --- | --- | --- |
| 1 | Tả tính chất, trạng thái | sau `be` là **tính từ** | `The build is slow.` · `Our workers are stateless.` |
| 2 | Nói X là ai / là cái gì | sau `be` là **danh từ** | `This is a workaround.` · `She is our main stakeholder.` |
| 3 | Nói vị trí, đang ở đâu | sau `be` là **giới từ nơi chốn** | `The config is in the repo.` · `I am on the call.` |
| 4 | Tuổi, giá, giờ, con số | sau `be` là **số** | `It is 3pm in Hanoi.` · `I am thirty.` |
| 5 | Hỏi và phủ định | `be` **đảo lên đầu** / thêm `not` | `Is the API stateless?` · `The date is not final.` |

Ca 1 là ca dùng nhiều nhất, và cũng đúng là ca hay quên `be` nhất.

## Quy tắc

```
Khẳng định     I am        ·  he/she/it is   ·  you/we/they are
Viết tắt       I'm         ·  he's / it's    ·  you're / we're / they're
Phủ định       I am not    ·  is not = isn't ·  are not = aren't
Câu hỏi        Am I …?     ·  Is it …?       ·  Are we …?
Có / tồn tại   There is + số ít   ·   There are + số nhiều
```

Ba hệ quả cần nhớ:

1. **`be` tự đảo lên đầu để hỏi** — không mượn `do/does` bao giờ.
2. **`not` đứng ngay sau `be`**, không cần trợ động từ nào khác.
3. **Chia theo hình dạng chủ ngữ, không theo nghĩa**: `The data is…` (số ít) ·
   `Everyone is…` (số ít) · `The tests are…`.

## Khi nào KHÔNG dùng

| Trường hợp | Sai | Đúng |
| --- | --- | --- |
| Đã có động từ thường | `I am agree` | `I agree.` |
| Đã có động từ thường | `We are need more time` | `We need more time.` |
| `be + V-ing` là thì tiếp diễn (#10) | `I am check it` | `I am checking it.` |
| Sở hữu thì dùng `have` | `I am two tickets` | `I have two tickets.` |
| Hỏi động từ thường thì dùng `do` (#4) | `Are you need the log?` | `Do you need the log?` |

Ngoại lệ dễ nhớ ngược chiều: **tuổi** thì dùng `be` chứ không dùng `have` —
`I am thirty`, không phải "I have thirty years".

## Ví dụ đúng / sai

| ✅ Đúng | ❌ Sai | Vì sao |
| --- | --- | --- |
| `The test is flaky.` | `The test flaky.` | Tiếng Việt để tính từ đứng một mình được; tiếng Anh thiếu động từ thì câu chưa thành câu. |
| `I agree with the plan.` | `I am agree with the plan.` | `agree` đã là động từ thường — thêm `be` là hai động từ đứng cạnh nhau. |
| `Are you free at 3pm?` | `Do you are free at 3pm?` | `be` tự đảo lên đầu, không mượn `do`. |
| `The data is still incomplete.` | `The data are still incomplete.` | Trong văn phong kỹ thuật thường ngày `data` coi là số ít. |
| `Everyone is in the standup.` | `Everyone are in the standup.` | `everyone` số ít, dù nghĩa là nhiều người. |

## Bẫy với người Việt

**1. Quên hẳn `be` trước tính từ.** Lỗi số một, và nó **không tự hết** khi vốn từ tăng
lên — vì nó là thói quen tiếng Việt chứ không phải lỗ hổng từ vựng.

| Tiếng Việt | Dịch thẳng (sai) | Câu đúng |
| --- | --- | --- |
| "Cái API này chậm." | `This API slow.` | `This API is slow.` |
| "Báo cáo xong rồi." | `The report ready.` | `The report is ready.` |
| "Mình đang ở chỗ bug thanh toán." | `I on the payment bug.` | `I am on the payment bug.` |

**2. Nhét `be` vào trước động từ thường.** `I am agree`, `We are need`. Bẫy này sinh ra
vì tiếng Việt "đồng ý", "cần" nghe như trạng thái, còn `agree`, `need` trong tiếng Anh
là **hành động**.

**3. Chia sai theo chủ ngữ tập hợp.** Nhìn **hình dạng** của chủ ngữ, đừng nhìn nghĩa:
`The data is` · `Everyone is` · `The team is` (Anh-Mỹ) · `The tests are`.

**Mẹo soát trước khi bấm gửi:** đọc lại câu và tìm động từ.
Không thấy động từ nào → **thiếu `be`**. Thấy hai động từ (`am` + một động từ thường) →
**thừa `be`**.

## Đã gặp ở đâu

- Buổi **#11** ([2026-08-25](../lessons/2026-W35/2026-08-25.md)) — dạy lần đầu; ví dụ của
  cả 5 từ (`stateless`, `verbose`, `on track`, `tentative`, `fed up`) và mẩu đọc đều viết
  theo mẫu này. Năm từ hôm đó đều đứng **sau `be`** nên mẫu và từ vựng khớp nhau tự nhiên.
