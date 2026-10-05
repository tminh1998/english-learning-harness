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
# Mục lục là một cây gập/mở: Năm › Nửa năm › Quý › Tháng › Tuần › buổi học, mặc
# định mở hết, đầu trang có ô chọn năm (lesson.js mục 5 — mặc định năm hiện tại).
# Buổi học xếp vào kỳ theo NGÀY HỌC: tuần vắt qua hai tháng hiện ở cả hai tháng,
# mỗi bên đúng phần buổi của mình. Mỗi kỳ có link bảng ôn riêng — bảng ôn
# tháng/quý/nửa năm/năm do tools/build-recap.sh sinh, script này gọi nó trước.

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

# ── Cây Năm › Nửa năm › Quý › Tháng › Tuần (mới nhất lên đầu) ──
cat > "$TMP/cay.awk" <<'AWK'
FILENAME == ARGV[1] { coRecap[$1] = 1; next }
FILENAME == ARGV[2] { coQuiz[$1] = 1; next }
{
  n++; tenf[n] = $1; href[n] = $2; sotu[n] = $3; chip[n] = $4
  d = substr($1, 1, 10); y = substr(d, 1, 4)
  # khoá từng tầng — tháng/tuần gắn kèm tầng cha để tuần vắt tháng tách làm hai
  K[1, n] = y
  K[2, n] = y "-H" ld_nua(d)
  K[3, n] = y "-Q" ld_quy(d)
  K[4, n] = substr(d, 1, 7)
  K[5, n] = substr(d, 1, 7) "|" ld_tuan(d)
  for (t = 1; t <= 5; t++) { buoi[t, K[t, n]]++; tu[t, K[t, n]] += $3 }
}

function meta(t, k) { return buoi[t, k] " buổi · " tu[t, k] " từ" }
function pill(href, chu) { return "<a class=\"lv-recap\" href=\"" href "\">🔁 " chu "</a>" }

function mo(t, i,   k, y, d, wk, mon, sun, ten, phu, nut, lop) {
  k = K[t, i]; y = substr(k, 1, 4)
  if (t == 1) {
    printf "      <section class=\"nam\" data-year=\"%s\">\n", y
    ten = "Năm " y; nut = pill("wiki/recap/" y ".html", "Ôn cả năm"); lop = "lv-y lv-top"
  } else if (t == 2) {
    ten = (substr(k, 7) == "1" ? "Nửa đầu năm " : "Nửa cuối năm ") y
    nut = pill("wiki/recap/" k ".html", "Ôn nửa năm"); lop = "lv-h"
  } else if (t == 3) {
    ten = "Quý " substr(k, 7) "/" y; nut = pill("wiki/recap/" k ".html", "Ôn quý"); lop = "lv-q"
  } else if (t == 4) {
    ten = "Tháng " (substr(k, 6, 2) + 0) "/" y; nut = pill("wiki/recap/" k ".html", "Ôn tháng"); lop = "lv-m"
  } else {
    wk = substr(k, 9); d = substr(tenf[i], 1, 10)
    mon = ld_cong(d, -ld_thu(d)); sun = ld_cong(mon, 6)
    ten = "Tuần " wk
    phu = ld_dm(mon) "–" ld_dm(sun) " · "
    if (substr(mon, 6, 2) != substr(sun, 6, 2)) phu = phu "phần tháng " (substr(k, 6, 2) + 0) " · "
    nut = coRecap[wk] ? pill("wiki/recap/" wk ".html", "Ôn tuần") : ""; lop = "lv-w"
  }
  printf "      <details class=\"lv %s\" open>\n", lop
  printf "        <summary><span class=\"lv-name\">%s</span><span class=\"lv-meta\">%s%s</span>%s</summary>\n", ten, phu, meta(t, k), nut
  printf "        <div class=\"lv-body\">\n"
  if (t == 5 && coQuiz[wk]) printf "        <p class=\"quiz-link\"><a href=\"wiki/quiz/%s.md\">📝 Bài kiểm tra tuần %s</a></p>\n", wk, wk
}

function dong(t) {
  printf "        </div>\n      </details>\n"
  if (t == 1) printf "      </section>\n"
}

END {
  sau = 0                                  # số tầng đang mở
  for (i = 1; i <= n; i++) {
    for (t = 1; t <= 5; t++) if (K[t, i] != dang[t]) break
    while (sau >= t) dong(sau--)           # đóng từ tầng sâu nhất lên tới tầng đổi
    for (; t <= 5; t++) { mo(t, i); dang[t] = K[t, i]; sau = t }
    for (t2 = sau + 1; t2 <= 5; t2++) dang[t2] = ""

    ngay = tenf[i]; nhan = ""
    if (ngay ~ /-[0-9]$/) { nhan = " · buổi #" substr(ngay, 12); ngay = substr(ngay, 1, 10) }
    printf "        <a class=\"lesson\" href=\"%s\">\n", href[i]
    printf "          <span class=\"lesson-date\">%s%s</span>\n", ngay, nhan
    printf "          <span class=\"lesson-words\">%s</span>\n", chip[i]
    printf "        </a>\n"
  }
  while (sau >= 1) dong(sau--)
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
        <button id="toggle-all">⊟ Thu gọn tất cả</button>
        <span class="hint">Bấm tên kỳ để gập/mở · 🔁 mở bảng ôn của kỳ đó</span>
      </div>
HEAD2

  awk -F"$TAB" -f tools/lich.awk -f "$TMP/cay.awk" "$TMP/recap-tuan" "$TMP/quiz-tuan" "$TMP/buoi"

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
