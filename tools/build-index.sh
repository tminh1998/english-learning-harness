#!/bin/sh
# build-index.sh — dựng lại `index.html` ở gốc repo: mục lục mọi bài đã học.
#
#   sh tools/build-index.sh
#
# Đây là trang đích của GitHub Pages — thứ user mở trên điện thoại để ĐỌC bài,
# không cần Claude, không cần con Mac. Chạy lại sau mỗi buổi học (bước cuối R6).
#
# Sinh máy móc từ nội dung `wiki/lessons/` nên không bao giờ lệch với bài thật.
# Đừng sửa tay `index.html` — lần chạy sau sẽ ghi đè.
#
# Mỗi năm một khối (ô chọn năm ở đầu trang — lesson.js mục 5, mặc định năm hiện
# tại), trong năm là từng tuần ISO như cũ. Đầu mỗi năm có hàng link tới bảng ôn
# tháng/quý/nửa năm/năm — các trang đó do tools/build-recap.sh sinh, gọi trước ở đây.

set -e
. "$(dirname "$0")/openit.sh"
cd "$HARNESS"

sh "$HARNESS/tools/build-recap.sh"

OUT="index.html"
GH=$(cfg github)
TAB=$(printf '\t')
TMP=$(mktemp -d 2>/dev/null || mktemp -d -t index)
trap 'rm -rf "$TMP"' EXIT

# Số từ đã học = số dòng bảng CÓ ĐÁNH SỐ trong VOCAB_INDEX.
# Bảng "Đã biết sẵn" ở cuối file không đánh số nên tự động không bị đếm — đúng ý:
# đó là từ người học vốn đã biết, không phải từ đã dạy.
TONGTU=$(sed -n 's/^|[[:space:]]*[0-9][0-9]*[[:space:]]*|.*/x/p' wiki/VOCAB_INDEX.md 2>/dev/null | wc -l | tr -d ' ')

# chip_bai <file.md> — chip từ vựng của một buổi.
# Tách thành hàm vì `case` nằm trong `$(...)` làm sh của macOS (bash 3.2) đọc sai.
chip_bai() {
  # Heading từ vựng có dạng:  ## 3. **escalate** /ipa/ — _verb_ · `Business`
  # Nhãn nhóm chấp nhận cả tiếng Anh (IT|Business|Life) lẫn tiếng Việt
  # (`Giao tiếp` / `Đời sống`) vì bài cũ và routine viết khác nhau —
  # khớp mọi thứ nằm trong cặp backtick CUỐI dòng, đừng bó vào [A-Za-z].
  sed -n 's/^## [0-9][0-9]*\. \*\*\([^*][^*]*\)\*\*.*`\([^`][^`]*\)`[^`]*$/\2\
\1/p' "$1" | while IFS= read -r cat && IFS= read -r w; do
    case "$cat" in
      IT|it|Tech|tech)                       cls=it ;;
      Business|business|"Giao tiếp"|"Khách hàng") cls=biz ;;
      *)                                     cls=life ;;
    esac
    # Chip mục lục để ngắn: bỏ phần trong ngoặc của heading
    # ("walk (someone) through (something)" → "walk through") cho khớp
    # đúng lemma trong VOCAB_INDEX.
    w=$(printf '%s' "$w" | sed 's/[[:space:]]*([^)]*)//g; s/  */ /g; s/^ //; s/ $//')
    printf '<span class="w %s">%s</span>' "$cls" "$w"
  done
}

# ── Mỗi buổi học một dòng: tên file · đường dẫn · số từ · chip từ vựng ──
find wiki/lessons -mindepth 2 -maxdepth 2 -name '*.html' 2>/dev/null | sort -r | while IFS= read -r f; do
  md="${f%.html}.md"
  chips=""
  [ -f "$md" ] && chips=$(chip_bai "$md")
  nw=$(printf '%s' "$chips" | grep -o 'class="w ' | wc -l | tr -d ' ')
  printf '%s\t%s\t%s\t%s\n' "$(basename "$f" .html)" "$f" "$nw" "$chips"
done > "$TMP/buoi"

ls wiki/recap | sed -n 's/^\([0-9]\{4\}-W[0-9][0-9]\)\.html$/\1/p' > "$TMP/recap-tuan"
ls wiki/quiz  | sed -n 's/^\([0-9]\{4\}-W[0-9][0-9]\)\.md$/\1/p'    > "$TMP/quiz-tuan"
ls wiki/recap | sed -n -e 's/^\([0-9]\{4\}\)\.html$/\1/p' -e 's/^\([0-9]\{4\}-[0-9][0-9]\)\.html$/\1/p' \
  -e 's/^\([0-9]\{4\}-[QH][0-9]\)\.html$/\1/p' > "$TMP/recap-ky"

# ── Theo năm (cho ô chọn năm), trong năm là từng tuần ISO — mới nhất lên đầu ──
cat > "$TMP/nam.awk" <<'AWK'
FILENAME == ARGV[1] { coRecap[$1] = 1; next }
FILENAME == ARGV[2] { coQuiz[$1] = 1; next }
FILENAME == ARGV[3] { ky[++nk] = $1; next }
{ n++; tenf[n] = $1; href[n] = $2; chip[n] = $4 }

# Hàng link bảng ôn kỳ dài của năm y: cả năm · nửa năm · quý · tháng
function kyOn(y,   s, t, x, k, loai) {
  s = ""
  for (t = 1; t <= 4; t++) for (x = 1; x <= nk; x++) {
    k = ky[x]; if (substr(k, 1, 4) != y) continue
    loai = length(k) == 4 ? 1 : (substr(k, 6, 1) == "H" ? 2 : (substr(k, 6, 1) == "Q" ? 3 : 4))
    if (loai != t) continue
    if (t == 1) s = s "<a href=\"wiki/recap/" k ".html\">Cả năm " y "</a>"
    else if (t == 2) s = s "<a href=\"wiki/recap/" k ".html\">" (substr(k, 7) == "1" ? "Nửa đầu năm" : "Nửa cuối năm") "</a>"
    else if (t == 3) s = s "<a href=\"wiki/recap/" k ".html\">Quý " substr(k, 7) "</a>"
    else s = s "<a href=\"wiki/recap/" k ".html\">Tháng " (substr(k, 6, 2) + 0) "</a>"
  }
  return s
}

END {
  for (i = 1; i <= n; i++) {
    y = substr(tenf[i], 1, 4)
    split(href[i], p, "/"); wk = p[3]          # wiki/lessons/<tuần>/<ngày>.html
    if (y != yc) {
      if (wc != "") printf "      </section>\n"
      if (yc != "") printf "      </section>\n"
      printf "      <section class=\"nam\" data-year=\"%s\">\n", y
      s = kyOn(y)
      if (s != "") printf "      <nav class=\"ky-on\"><span class=\"k\">🔁 Bảng ôn %s:</span>%s</nav>\n", y, s
      yc = y; wc = ""
    }
    if (wk != wc) {
      if (wc != "") printf "      </section>\n"
      printf "      <section class=\"week\">\n        <h2>Tuần %s</h2>\n", wk
      # Bảng ôn tuần (trang để đọc) — đặt TRƯỚC danh sách buổi vì hay mở nhất
      if (coRecap[wk]) printf "        <a class=\"lesson recap\" href=\"wiki/recap/%s.html\"><span class=\"lesson-date\">🔁 Bảng ôn cả tuần %s</span></a>\n", wk, wk
      if (coQuiz[wk]) printf "        <p class=\"quiz-link\"><a href=\"wiki/quiz/%s.md\">📝 Bài kiểm tra tuần %s</a></p>\n", wk, wk
      wc = wk
    }
    ngay = tenf[i]; nhan = ""
    if (ngay ~ /-[0-9]$/) { nhan = " · buổi #" substr(ngay, 12); ngay = substr(ngay, 1, 10) }
    printf "        <a class=\"lesson\" href=\"%s\">\n", href[i]
    printf "          <span class=\"lesson-date\">%s%s</span>\n", ngay, nhan
    printf "          <span class=\"lesson-words\">%s</span>\n", chip[i]
    printf "        </a>\n"
  }
  if (wc != "") printf "      </section>\n"
  if (yc != "") printf "      </section>\n"
}
AWK

{
  cat <<'HEAD'
<!doctype html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Sổ tay tiếng Anh — mục lục</title>
    <link rel="stylesheet" href="wiki/assets/lesson.css" />
    <link rel="stylesheet" href="wiki/assets/index.css" />
  </head>
  <body>
    <div class="wrap">
      <header class="hero">
        <div class="eyebrow">Sổ tay học tiếng Anh</div>
        <h1>Mục lục bài học</h1>
HEAD
  printf '        <div class="mixline"><span class="badge it">%s từ đã học</span>' "$TONGTU"
  printf '<span class="badge biz">%s buổi</span>' "$(wc -l < "$TMP/buoi" | tr -d ' ')"
  printf '<span class="badge life">Cập nhật %s</span></div>\n' "$(hnay)"
  # Ô chọn năm — JS chọn sẵn năm hiện tại (giờ VN); năm đó chưa có bài thì lấy năm mới nhất.
  printf '        <label class="year-pick">Xem năm <select id="year-pick">'
  cut -c1-4 "$TMP/buoi" | sort -ru | while IFS= read -r y; do printf '<option value="%s">%s</option>' "$y" "$y"; done
  printf '</select></label>\n'
  cat <<'HEAD2'
      </header>

      <div class="toolbar">
        <button id="theme">🌗 Theo hệ thống</button>
        <span class="hint">Bấm vào một buổi để mở bài học đầy đủ</span>
      </div>
HEAD2

  awk -F"$TAB" -f "$TMP/nam.awk" "$TMP/recap-tuan" "$TMP/quiz-tuan" "$TMP/recap-ky" "$TMP/buoi"

  cat <<'FOOT'
      <section class="week">
        <h2>Tra cứu</h2>
        <a class="lesson" href="wiki/VOCAB_INDEX.md"><span class="lesson-date">📖 Toàn bộ từ đã học</span></a>
        <a class="lesson" href="wiki/REVIEW_QUEUE.md"><span class="lesson-date">🔁 Lịch ôn tập</span></a>
        <a class="lesson" href="wiki/PROGRESS.md"><span class="lesson-date">📈 Tiến độ</span></a>
      </section>
FOOT
  [ -n "$GH" ] && printf '      <p class="repo-link"><a href="%s">Mã nguồn trên GitHub</a></p>\n' "$GH"
  cat <<'END'
    </div>
    <script src="wiki/assets/lesson.js"></script>
  </body>
</html>
END
} > "$OUT"

echo "DA-DUNG-INDEX: $OUT ($TONGTU từ)"
