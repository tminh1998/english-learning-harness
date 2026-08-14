---
description: Mở trang HTML bài học hôm nay trong trình duyệt (không sinh bài mới)
argument-hint: "[ngày YYYY-MM-DD — bỏ trống = hôm nay]"
---

Chỉ **mở file có sẵn**. Tuyệt đối không sinh bài mới, không sửa VOCAB_INDEX /
REVIEW_QUEUE / PROGRESS. Muốn học bài mới thì đó là việc của `/hoc`.

Ngày cần mở (bỏ trống = hôm nay): $ARGUMENTS

Chạy đúng đoạn này (một lần, không đoán ngày trong đầu):

```bash
git pull --rebase 2>/dev/null   # bài có thể vừa học ở máy khác (R6)
. tools/openit.sh               # ép TZ + có hàm hnay/tuan/openit

D="${ARGUMENTS:-$(hnay)}"
W=$(tuan "$D")
F=$(find "wiki/lessons/$W" -maxdepth 1 -name "$D*.html" 2>/dev/null | sort | tail -1)
if [ -n "$F" ]; then
  openit "$F"
  echo "Các buổi cùng ngày:"; find "wiki/lessons/$W" -maxdepth 1 -name "$D*.html" | sort
else
  L=$(find wiki/lessons -name "*.html" 2>/dev/null | sort | tail -1)
  if [ -n "$L" ]; then
    echo "KHONG-CO-BAI-NGAY-$D"; openit "$L"
  else
    echo "CHUA-CO-BAI-NAO"
  fi
fi
```

Trình duyệt và múi giờ đọc thẳng từ `.learning-config.yml` qua `tools/openit.sh` —
**không hardcode lại ở đây**. User đổi `ui.browser` trong config là xong, không phải
sửa command.

Báo lại cho user theo đúng kết quả:

- **DA-MO-LOCAL** → nói đã mở bài ngày nào, buổi thứ mấy, kèm đường dẫn.
  Nếu ngày đó có nhiều buổi (`<ngày>.html` và `<ngày>-2.html`) thì lệnh mở buổi
  mới nhất — nói rõ và liệt kê các buổi còn lại để user tự chọn.
- **LINK-WEB: `<url>`** → đang chạy trên VM cloud, không có trình duyệt để mở hộ.
  **Đưa nguyên link cho user bấm**, kèm nói rõ đó là bài ngày nào.
- **CHUA-CAU-HINH-PAGES** → báo user chưa bật GitHub Pages / chưa điền
  `remote.pagesBaseUrl` trong `.learning-config.yml`.
- **KHONG-CO-BAI-NGAY-...** → nói thẳng hôm nay chưa học, đã mở tạm bài gần nhất,
  và gợi ý gõ `/hoc` để có bài mới.
- **CHUA-CO-BAI-NAO** → báo chưa có bài học nào, gợi ý `/hoc`.
