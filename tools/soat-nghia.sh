#!/bin/sh
# soat-nghia.sh — soát chữ tiếng Việt trên khối ôn nhanh và bảng ôn tuần có đúng là
# chép NGUYÊN VĂN từ bài đã học không (luật cứng R9 + R10, user chốt 2026-10-27).
#
#   sh tools/soat-nghia.sh                                   # soát mọi bài + mọi bảng ôn tuần
#   sh tools/soat-nghia.sh wiki/lessons/2026-W44/2026-10-27.html wiki/recap/2026-W44.md
#
# Nguồn đúng = đầu ra của tools/nghia.sh (NGHIA · PHU · VD · DICH · DNVI của bài gốc).
# Soát những gì:
#   bài học  .html  ôn nhanh: span.q (NGHIA) · span.alt (PHU) · <em> đáp án (VD)
#            .md    ôn nhanh: dòng câu hỏi "NGHIA — PHU" · <em> đáp án (VD)
#   ôn tuần  .html  thẻ từ: .vi-quick (NGHIA · PHU) · .def-vi (DNVI) · Câu thật (VD · DICH)
#            .md    bảng tra nhanh "**NGHIA** — PHU" · phần chi tiết (VD · DICH)
# Bảng ôn tháng/quý/nửa năm/năm do build-recap.sh sinh thẳng từ nghia.sh nên không cần soát.
#
# In ra một dòng SAI cho mỗi chỗ lệch (kèm bản đang có và bản gốc), cuối cùng in
# KHOP-HET hoặc CO-CHO-SAI <số chỗ>. Lệch thì chép lại từ nghia.sh — nghĩa gốc chưa
# ổn thì sửa ở BÀI GỐC trước, đừng sửa riêng ở khối ôn.

set -e
. "$(dirname "$0")/openit.sh"
cd "$HARNESS"

TMP=$(mktemp -d "${TMPDIR:-/tmp}/soat.XXXXXX")
trap 'rm -rf "$TMP"' EXIT
TAB=$(printf '\t')

# Mặc định: mọi bài từ 2026-09-04 (khuôn li.qa — bài trước đó còn khuôn ôn nhanh cũ,
# câu hỏi tách khỏi đáp án, không soát được) + mọi bảng ôn tuần.
if [ $# -eq 0 ]; then
  set -- $(find wiki/lessons -name '*.html' -o -name '*.md' | sort \
           | awk -F/ '{ d = $NF; sub(/\.[a-z]+$/, "", d); if (d >= "2026-09-04") print }') \
         $(find wiki/recap -name '*-W[0-9][0-9].html' -o -name '*-W[0-9][0-9].md' | sort)
fi

# Hàm awk dùng chung: cắt giữa hai mốc + bỏ markup.
cat > "$TMP/chung.awk" <<'AWK'
function giua(s, a, b,   i, j) {
  i = index(s, a); if (i == 0) return ""
  s = substr(s, i + length(a)); j = index(s, b); if (j == 0) return s
  return substr(s, 1, j - 1)
}
function sach(s) {
  gsub(/<[^>]*>/, " ", s); gsub(/🔊/, " ", s)
  gsub(/&amp;/, "\\&", s); gsub(/&lt;/, "<", s); gsub(/&gt;/, ">", s); gsub(/&quot;/, "\"", s); gsub(/&#39;/, "'", s)
  gsub(/[[:space:]]+/, " ", s); gsub(/^ | $/, "", s); return s
}
# Tên từ bỏ phần trong ngoặc: bảng ôn ghi "walk (sb) through", VOCAB_INDEX ghi "walk through".
function ra(f, tu, truong, v) { tu = sach(tu); gsub(/ *\([^)]*\) */, " ", tu); print f "\t" sach(tu) "\t" truong "\t" sach(v) }
AWK

# trich <file> — in "file<TAB>từ<TAB>trường<TAB>giá trị" cho mọi chỗ cần soát.
trich() {
  f=$1
  case "$f" in
  wiki/lessons/*.html)
    cat > "$TMP/p1.awk" <<'AWK'

      { all = all $0 "\n" }
      END {
        w = giua(all, "class=\"warm-toggle", "<section class=\"block")
        n = split(w, kh, /<li class="qa">/)
        for (i = 2; i <= n; i++) {
          q = giua(kh[i], "<span class=\"q\">", "</span></span>")
          p = index(q, "<span class=\"alt\">"); chinh = q; phu = ""
          if (p) { chinh = substr(q, 1, p - 1); phu = substr(q, p + 18) }
          tu = giua(kh[i], "<b>", "</b>")
          vd = sach(giua(kh[i], "<em>", "</em>")); gsub(/^"|"$/, "", vd)
          ra(F, tu, "NGHIA", chinh); ra(F, tu, "PHU", phu); ra(F, tu, "VD", vd)
        }
      }
AWK
    awk -v F="$f" -f "$TMP/chung.awk" -f "$TMP/p1.awk" "$f" ;;
  wiki/lessons/*.md)
    cat > "$TMP/p2.awk" <<'AWK'

      /^## Ôn nhanh/ { on = 1; next }
      on && /^## / { exit }
      on && /^[0-9]+\. / { q = $0; sub(/^[0-9]+\. /, "", q); next }
      on && q != "" && /<b>/ {
        tu = giua($0, "<b>", "</b>")
        vd = sach(giua($0, "<em>", "</em>")); gsub(/^"|"$/, "", vd)
        ra(F, tu, "NGHIA+PHU", q); ra(F, tu, "VD", vd); q = ""
      }
AWK
    awk -v F="$f" -f "$TMP/chung.awk" -f "$TMP/p2.awk" "$f" ;;
  wiki/recap/*.html)
    cat > "$TMP/p3.awk" <<'AWK'

      { all = all $0 "\n" }
      END {
        n = split(all, kh, /<article class="word"/)
        for (i = 2; i <= n; i++) {
          tu = sach(giua(kh[i], "<h2>", "</h2>")); sub(/ *·.*$/, "", tu)
          vq = giua(kh[i], "class=\"vi-quick", "</p>"); sub(/^[^>]*>/, "", vq)
          p = index(vq, "<span class=\"alt\">"); chinh = vq; phu = ""
          if (p) { chinh = substr(vq, 1, p - 1); phu = substr(vq, p + 18) }
          dn = sach(giua(kh[i], "class=\"def-vi", "</span>")); sub(/^[^>]*> ?/, "", dn); sub(/^→ */, "", dn)
          v = giua(kh[i], "<span class=\"v\">", "</span></span>")
          j = index(v, "<span class=\"hide-me\">"); vd = v; dich = ""
          if (j) { vd = substr(v, 1, j - 1); dich = sach(substr(v, j)); sub(/^→ */, "", dich) }
          ra(F, tu, "NGHIA", chinh); ra(F, tu, "PHU", phu); ra(F, tu, "DNVI", dn)
          ra(F, tu, "VD", vd); ra(F, tu, "DICH", dich)
        }
      }
AWK
    awk -v F="$f" -f "$TMP/chung.awk" -f "$TMP/p3.awk" "$f" ;;
  wiki/recap/*.md)
    cat > "$TMP/p4.awk" <<'AWK'

      /^## / { muc = $0 }
      muc ~ /Tra nhanh/ && /^\| \*\*/ {
        split($0, c, "|"); tu = giua(c[2], "**", "**")
        x = c[3]; gsub(/^ +| +$/, "", x); sub(/^\*\*/, "", x)
        k = index(x, "**"); chinh = substr(x, 1, k - 1); phu = substr(x, k + 2); sub(/^ *— */, "", phu)
        ra(F, tu, "NGHIA", chinh); ra(F, tu, "PHU", phu)
      }
      muc ~ /Chi tiết/ && /^[0-9]+\. \*\*/ {
        tu = giua($0, "**", "**"); vd = $0; sub(/^[^—]*— */, "", vd); ra(F, tu, "VD", vd); cho = tu; next
      }
      muc ~ /Chi tiết/ && cho != "" && /^[[:space:]]+→/ { d = $0; sub(/^[[:space:]]+→ */, "", d); ra(F, cho, "DICH", d); cho = "" }
      
AWK
    awk -v F="$f" -f "$TMP/chung.awk" -f "$TMP/p4.awk" "$f" ;;
  esac
}

for f in "$@"; do trich "$f"; done > "$TMP/co"
[ -s "$TMP/co" ] || { echo "KHONG-CO-GI-DE-SOAT"; exit 0; }

# Nghĩa gốc của mọi từ xuất hiện, tra một lượt.
cut -f2 "$TMP/co" | sort -u | sh tools/nghia.sh | awk -v OFS="$TAB" '
  /^TU / { t = $0; sub(/^TU +/, "", t); sub(/ ·.*/, "", t); next }
  /^[A-Z]+ / { k = $1; v = $0; sub(/^[A-Z]+ +/, "", v); print tolower(t), k, v }' > "$TMP/goc"

awk -F"$TAB" '
  # So mà không vấp vào markup: bỏ ** _ ` \ và mọi khoảng trắng (bỏ thẻ <b> hay để thừa dấu cách).
  function chuan(s) { gsub(/[*_`\\[:space:]]/, "", s); return s }
  NR == FNR { g[$1 SUBSEP $2] = $3; if ($2 == "LOI") loi[$1] = $3; next }
  {
    t = tolower($2); k = $3
    if (t in loi) { print "SAI  " $1 " · " $2 " · " loi[t]; sai++; next }
    if (k == "NGHIA+PHU") want = g[t SUBSEP "NGHIA"] (g[t SUBSEP "PHU"] != "" ? " — " g[t SUBSEP "PHU"] : "")
    else want = g[t SUBSEP k]
    if (chuan($4) != chuan(want)) {
      print "SAI  " $1 " · " $2 " · " k; print "     co : " $4; print "     goc: " want; sai++
    } else ok++
  }
  END { print (sai ? "CO-CHO-SAI " sai : "KHOP-HET") " (" ok + 0 " chỗ khớp)" }
' "$TMP/goc" "$TMP/co"
