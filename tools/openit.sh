#!/bin/sh
# openit.sh — hàm dùng chung cho MỌI slash command của harness.
#
#   . tools/openit.sh          # source, đừng chạy trực tiếp
#
# Lý do tồn tại: harness chạy ở hai nơi có hệ điều hành khác nhau —
#   · máy Mac của user   : có `open`, có màn hình, giờ VN
#   · VM Linux của Claude Code on the web : không `open`, không màn hình, giờ UTC
# Nhét `date` trần hay `open` trần vào command sẽ hỏng ở một trong hai nơi.
# Mọi khác biệt môi trường gom hết vào file này.
#
# Cung cấp 4 hàm:  cfg <key>  ·  hnay [fmt]  ·  tuan [YYYY-MM-DD]  ·  openit <file>

# ── Tìm {harness} = thư mục chứa .learning-config.yml (walk-up từ cwd) ──
HARNESS=$(
  d=$(pwd)
  while [ "$d" != "/" ]; do
    [ -f "$d/.learning-config.yml" ] && printf '%s' "$d" && break
    d=$(dirname "$d")
  done
)
[ -n "$HARNESS" ] || { echo "openit.sh: KHONG-TIM-THAY-.learning-config.yml" >&2; return 1 2>/dev/null || exit 1; }

# cfg <key> — đọc 1 giá trị scalar từ .learning-config.yml.
# Cố tình thô sơ: chỉ lấy `key: value` phẳng đầu tiên, đủ cho timezone/browser/url.
cfg() {
  sed -n "s/^[[:space:]]*$1:[[:space:]]*//p" "$HARNESS/.learning-config.yml" |
    sed -e 's/[[:space:]]*#.*$//' -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//" \
        -e 's/[[:space:]]*$//' |
    head -1
}

TZL=$(cfg timezone); [ -n "$TZL" ] || TZL="Asia/Ho_Chi_Minh"
BROWSER=$(cfg browser)
PAGES=$(cfg pagesBaseUrl)
export TZ="$TZL"   # ⭐ ép múi giờ cho MỌI lệnh date về sau, kể cả trên VM UTC

# hnay [fmt] — ngày hôm nay theo giờ VN. Mặc định YYYY-MM-DD.
hnay() { date "+${1:-%Y-%m-%d}"; }

# tuan [YYYY-MM-DD] — tuần ISO (YYYY-Www). Bỏ trống = tuần này.
# `date -j -f` là cú pháp BSD (macOS), `date -d` là GNU (Linux) — thử cả hai.
tuan() {
  if [ -z "$1" ]; then date +%G-W%V; return; fi
  date -j -f %Y-%m-%d "$1" +%G-W%V 2>/dev/null ||
    date -d "$1" +%G-W%V 2>/dev/null ||
    date +%G-W%V
}

# openit <đường-dẫn-tương-đối-từ-{harness}> — mở bài học cho user xem.
# Máy Mac  -> mở trình duyệt thật.
# VM cloud -> không có trình duyệt: in link Pages để user tự bấm trên điện thoại.
openit() {
  f="$1"
  if command -v open >/dev/null 2>&1; then
    if [ -n "$BROWSER" ] && open -a "$BROWSER" "$HARNESS/$f" 2>/dev/null; then
      echo "DA-MO-LOCAL bằng $BROWSER: $f"
    else
      open "$HARNESS/$f" 2>/dev/null &&
        echo "DA-MO-LOCAL bằng trình duyệt mặc định (không thấy $BROWSER): $f" ||
        echo "KHONG-MO-DUOC: $f"
    fi
  elif [ -n "$PAGES" ]; then
    echo "LINK-WEB: ${PAGES%/}/$f"
  else
    echo "CHUA-CAU-HINH-PAGES: $f (điền remote.pagesBaseUrl trong .learning-config.yml)"
  fi
}
