#!/bin/sh
# nghia.sh — lấy lại NGHĨA GỐC của một từ đã học, đúng như bài học cũ đã dạy.
#
#   sh tools/nghia.sh "purge" "dry run"          # tra vài từ
#   printf 'stub\nverbose\n' | sh tools/nghia.sh # hoặc đọc từ stdin (nối với lệnh bốc R9)
#
# Nghĩa lấy ở đâu: mỗi từ trong trang bài học có sẵn một khối `<p class="vi-quick">`
# — nghĩa gọn in đậm + một dòng phụ nói rõ thêm:
#
#     xoá sạch một loạt
#     dọn trắng theo một tiêu chí, không chừa cái nào
#
# Đó là bản nghĩa đã được chốt lúc dạy từ đó. Phần "Ôn nhanh đầu giờ" phải hỏi
# đúng bằng cụm này (luật R9 mục 6) chứ không được soạn lại mỗi buổi một kiểu —
# nghĩa trôi dần thì người học đang ôn một từ khác với từ đã học. Và chép thì
# phải chép bằng lệnh, không chép bằng mắt.
#
# In ra cho mỗi từ, dán thẳng vào bài được:
#   TU     <từ> · <nhóm> · học ngày <ngày> · <file bài gốc>
#   NGHIA  <dòng nghĩa gọn — dòng in đậm trong .vi-quick>
#   PHU    <dòng phụ — <span class="alt"> trong .vi-quick>
#   VD     <câu ví dụ #1 trong bài .md, đã bỏ markup>

set -e
. "$(dirname "$0")/openit.sh"
cd "$HARNESS"

INDEX="wiki/VOCAB_INDEX.md"
LESSONS="wiki/lessons"

# doc_vi_quick <file.html> <từ> — in "nghĩa gọn<TAB>dòng phụ".
# Trang bài học có hai kiểu format (bản gõ tay viết gọn một dòng, bản đã chạy qua
# prettier thì xuống dòng lung tung) nên nuốt cả file rồi cắt theo mốc, đừng bám
# vào việc thẻ nào nằm trên dòng nào.
doc_vi_quick() {
  awk -v w="$2" '
    # giua(s, a, b) — đoạn nằm giữa lần xuất hiện đầu của a và b kế tiếp nó.
    function giua(s, a, b,   i, j) {
      i = index(s, a); if (i == 0) return ""
      s = substr(s, i + length(a))
      j = index(s, b); if (j == 0) return s
      return substr(s, 1, j - 1)
    }
    # sach(s) — bỏ thẻ HTML, bỏ nút 🔊, gộp khoảng trắng.
    function sach(s) {
      gsub(/<[^>]*>/, " ", s); gsub(/🔊/, " ", s)
      gsub(/&amp;/, "\\&", s); gsub(/&lt;/, "<", s); gsub(/&gt;/, ">", s)
      gsub(/[[:space:]]+/, " ", s); gsub(/^ | $/, "", s)
      return s
    }
    # chuanhoa(s) — dạng để so khớp: bỏ ngoặc, bỏ dấu, thường hoá.
    function chuanhoa(s) {
      gsub(/\([^)]*\)/, " ", s); gsub(/[^[:alnum:] -]/, " ", s)
      gsub(/[[:space:]]+/, " ", s); gsub(/^ | $/, "", s)
      return tolower(s)
    }
    { all = all $0 "\n" }
    END {
      muc = chuanhoa(w)
      n = split(all, kh, /<article class="word"/)
      for (i = 2; i <= n; i++) {
        # Tiêu đề: bỏ số thứ tự, và bỏ phần sau dấu · (bài ghi "hand over · handover").
        h = sach(giua(kh[i], "<h2", "</h2>"))
        gsub(/^[> ]+/, "", h); sub(/^[0-9]+ */, "", h); sub(/ *·.*$/, "", h)
        if (chuanhoa(h) != muc) continue

        vq = giua(kh[i], "class=\"vi-quick", "</p>")
        sub(/^[^>]*>/, "", vq)                       # bỏ nốt phần đuôi thẻ mở
        # Thẻ mở có khi bị prettier ngắt dòng (`<span class="alt"\n  >...`)
        # nên bám vào `<span class="alt"` rồi tự tìm dấu `>` kế tiếp.
        chinh = vq; phu = ""
        p = index(vq, "<span class=\"alt\"")
        if (p > 0) {
          chinh = substr(vq, 1, p - 1)
          con = substr(vq, p + length("<span class=\"alt\""))
          q = index(con, ">"); if (q > 0) con = substr(con, q + 1)
          r = index(con, "</span"); phu = (r > 0) ? substr(con, 1, r - 1) : con
        }
        print sach(chinh) "\t" sach(phu)
        exit
      }
    }
  ' "$1"
}

tra_mot_tu() {
  tu=$1
  [ -n "$tu" ] || return 0

  # Dòng trong VOCAB_INDEX: | # | Word | family | Loại | Nhóm | Nghĩa gọn | Ngày | Nguồn |
  dong=$(awk -F'|' -v w="$tu" '
    /^\| [0-9]+ \|/ {
      t=$3; gsub(/^[ \t]+|[ \t]+$/,"",t)
      if (tolower(t)==tolower(w)) { print; exit }
    }' "$INDEX")

  if [ -z "$dong" ]; then
    printf 'TU     %s\nLOI    KHONG-CO-TRONG-VOCAB-INDEX\n\n' "$tu"
    return 0
  fi

  nhom=$(printf '%s' "$dong" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$6); print $6}')
  ngay=$(printf '%s' "$dong" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$8); print $8}')
  goc=$(printf '%s'  "$dong" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$7); print $7}')

  html=$(find "$LESSONS" -name "$ngay.html" 2>/dev/null | head -1)
  md=$(find   "$LESSONS" -name "$ngay.md"   2>/dev/null | head -1)

  printf 'TU     %s · %s · học ngày %s · %s\n' "$tu" "$nhom" "$ngay" "${html:-KHONG-TIM-THAY-FILE}"

  if [ -z "$html" ]; then
    printf 'NGHIA  %s\nLOI    KHONG-CO-TRANG-HTML (nghĩa gọn trong VOCAB_INDEX là fallback)\n\n' "$goc"
    return 0
  fi

  vq=$(doc_vi_quick "$html" "$tu")
  if [ -z "$vq" ]; then
    printf 'NGHIA  %s\nLOI    KHONG-THAY-.vi-quick-TRONG-BAI-GOC\n\n' "$goc"
    return 0
  fi

  printf 'NGHIA  %s\n' "$(printf '%s' "$vq" | cut -f1)"
  printf 'PHU    %s\n' "$(printf '%s' "$vq" | cut -f2)"

  # Ví dụ #1 lấy ở bản .md cho gọn (bản HTML có thêm <span class="rev">).
  if [ -n "$md" ]; then
    vd=$(awk -v w="$tu" '
      function chuanhoa(s) {
        gsub(/\([^)]*\)/, " ", s); gsub(/[^[:alnum:] -]/, " ", s)
        gsub(/[[:space:]]+/, " ", s); gsub(/^ | $/, "", s)
        return tolower(s)
      }
      BEGIN { muc = chuanhoa(w) }
      /^## [0-9]+\. / {
        if (inb) exit
        h = $0; sub(/^## [0-9]+\. /, "", h); sub(/^\*\*/, "", h); sub(/\*\*.*$/, "", h)
        inb = (chuanhoa(h) == muc)
      }
      inb && /^[*_]+Ví dụ[*_]+/ { v = 1; next }
      inb && v && /^- / { sub(/^- /, ""); print; exit }
    ' "$md" | sed -e 's/\*\*//g' -e 's/[_*]//g')
    [ -n "$vd" ] && printf 'VD     %s\n' "$vd"
  fi
  echo
}

if [ $# -gt 0 ]; then
  for t in "$@"; do tra_mot_tu "$t"; done
else
  while IFS= read -r t; do
    t=$(printf '%s' "$t" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    tra_mot_tu "$t"
  done
fi
