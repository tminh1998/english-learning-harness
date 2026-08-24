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

set -e
. "$(dirname "$0")/openit.sh"
cd "$HARNESS"

OUT="index.html"
GH=$(cfg github)

# Số từ đã học = số dòng bảng CÓ ĐÁNH SỐ trong VOCAB_INDEX.
# Bảng "Đã biết sẵn" ở cuối file không đánh số nên tự động không bị đếm — đúng ý:
# đó là từ người học vốn đã biết, không phải từ đã dạy.
TONGTU=$(sed -n 's/^|[[:space:]]*[0-9][0-9]*[[:space:]]*|.*/x/p' wiki/VOCAB_INDEX.md 2>/dev/null | wc -l | tr -d ' ')

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
  printf '<span class="badge biz">%s buổi</span>' "$(find wiki/lessons -name '*.html' 2>/dev/null | wc -l | tr -d ' ')"
  printf '<span class="badge life">Cập nhật %s</span></div>\n' "$(hnay)"
  cat <<'HEAD2'
      </header>

      <div class="toolbar">
        <button id="theme">🌗 Theo hệ thống</button>
        <span class="hint">Bấm vào một buổi để mở bài học đầy đủ</span>
      </div>
HEAD2

  # ── Từng tuần ISO, mới nhất lên đầu ──
  for wk in $(find wiki/lessons -maxdepth 1 -type d -name '[0-9][0-9][0-9][0-9]-W*' 2>/dev/null | sed 's|.*/||' | sort -r); do
    printf '      <section class="week">\n        <h2>Tuần %s</h2>\n' "$wk"

    # Bảng ôn tuần (trang để đọc) — đặt TRƯỚC danh sách buổi vì hay mở nhất
    if [ -f "wiki/recap/$wk.html" ]; then
      printf '        <a class="lesson recap" href="wiki/recap/%s.html"><span class="lesson-date">🔁 Bảng ôn cả tuần %s</span></a>\n' "$wk" "$wk"
    fi

    # Quiz của tuần, nếu có
    if [ -f "wiki/quiz/$wk.md" ]; then
      printf '        <p class="quiz-link"><a href="wiki/quiz/%s.md">📝 Bài kiểm tra tuần %s</a></p>\n' "$wk" "$wk"
    fi

    for f in $(find "wiki/lessons/$wk" -maxdepth 1 -name '*.html' 2>/dev/null | sort -r); do
      base=$(basename "$f" .html)
      md="wiki/lessons/$wk/$base.md"
      case "$base" in
        *-[0-9]) ngay=${base%-*}; buoi=" · buổi #${base##*-}" ;;
        *)       ngay=$base;      buoi="" ;;
      esac

      printf '        <a class="lesson" href="%s">\n' "$f"
      printf '          <span class="lesson-date">%s%s</span>\n' "$ngay" "$buoi"
      printf '          <span class="lesson-words">'
      if [ -f "$md" ]; then
        # Heading từ vựng có dạng:  ## 3. **escalate** /ipa/ — _verb_ · `Business`
        # Nhãn nhóm chấp nhận cả tiếng Anh (IT|Business|Life) lẫn tiếng Việt
        # (`Giao tiếp` / `Đời sống`) vì bài cũ và routine viết khác nhau —
        # khớp mọi thứ nằm trong cặp backtick CUỐI dòng, đừng bó vào [A-Za-z].
        sed -n 's/^## [0-9][0-9]*\. \*\*\([^*][^*]*\)\*\*.*`\([^`][^`]*\)`[^`]*$/\2\
\1/p' "$md" | while IFS= read -r cat && IFS= read -r w; do
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
      fi
      printf '</span>\n        </a>\n'
    done
    printf '      </section>\n'
  done

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
