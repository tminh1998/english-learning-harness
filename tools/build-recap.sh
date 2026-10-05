#!/bin/sh
# build-recap.sh — sinh BẢNG ÔN THÁNG / QUÝ / NỬA NĂM / NĂM vào wiki/recap/.
#
#   sh tools/build-recap.sh        # build-index.sh tự gọi — thường không cần chạy tay
#
# Khác bảng ôn TUẦN (Flow D — agent soạn tay, có mục "chỗ dễ sai"): kỳ dài gom hàng
# trăm từ nên SINH BẰNG MÁY, chép nguyên từ bài gốc, không soạn lại chữ nào:
#   · danh sách từ, ngày học, nhóm, từ loại = VOCAB_INDEX (nguồn sự thật)
#   · nghĩa Việt = khối .vi-quick của bài gốc, lấy qua tools/nghia.sh (cùng nguồn R9)
#   · IPA, 3 cụm đi kèm đầu tiên, câu ví dụ #1 = bản .md của bài gốc
# Sửa nghĩa ở bài gốc (Flow E) rồi build lại là mọi bảng ôn tự khớp theo.
# ⛔ Đừng sửa tay các trang này — lần build sau ghi đè.
#
# Sinh ra, chỉ cho kỳ có ít nhất một từ (kỳ chưa hết thì ghi "đang diễn ra"):
#   wiki/recap/YYYY.html      năm         wiki/recap/YYYY-Qn.html   quý
#   wiki/recap/YYYY-Hn.html   nửa năm     wiki/recap/YYYY-MM.html   tháng
# Từ xếp vào kỳ theo NGÀY HỌC, không theo tuần ISO: tuần vắt qua hai tháng thì mỗi
# tháng giữ đúng phần của mình.

set -e
. "$(dirname "$0")/openit.sh"
cd "$HARNESS"

OUTDIR="wiki/recap"
TAB=$(printf '\t')
TMP=$(mktemp -d 2>/dev/null || mktemp -d -t recap)
trap 'rm -rf "$TMP"' EXIT

# Dọn trang kỳ dài cũ (kỳ không còn từ nào thì không để trang mồ côi).
# Bảng ôn tuần YYYY-Www.* là bản soạn tay — không đụng tới.
for f in "$OUTDIR"/*.html; do
  case "${f##*/}" in
    [0-9][0-9][0-9][0-9].html | [0-9][0-9][0-9][0-9]-[0-9][0-9].html | \
    [0-9][0-9][0-9][0-9]-[QH][0-9].html) rm -f "$f" ;;
  esac
done

# 1. Vốn từ: bảng CÓ ĐÁNH SỐ của VOCAB_INDEX, xếp theo ngày học rồi theo số thứ tự.
#    Cột ra: # · từ · loại · nhóm · nghĩa gọn · ngày học
awk -F'|' '/^\| [0-9]+ \|/ {
  for (i = 2; i <= 8; i++) gsub(/^[ \t]+|[ \t]+$/, "", $i)
  print $2 "\t" $3 "\t" $5 "\t" $6 "\t" $7 "\t" $8
}' wiki/VOCAB_INDEX.md | sort -t "$TAB" -k6,6 -k1,1n > "$TMP/vocab"

[ -s "$TMP/vocab" ] || { echo "DA-DUNG-RECAP: 0 trang (chưa học từ nào)"; exit 0; }

# 2. Nghĩa gốc — mỗi từ một khối TU/NGHIA/PHU, đúng thứ tự file vocab.
cut -f2 "$TMP/vocab" | sh tools/nghia.sh > "$TMP/nghia"

# 3. Bảng ôn tuần nào đang có (để gắn link từ trang tháng).
ls "$OUTDIR" | sed -n 's/^\([0-9]\{4\}-W[0-9][0-9]\)\.html$/\1/p' > "$TMP/tuan"

cat > "$TMP/recap.awk" <<'AWK'
function esc(s) {
  gsub(/&/, "\\&amp;", s); gsub(/</, "\\&lt;", s); gsub(/>/, "\\&gt;", s); gsub(/"/, "\\&quot;", s)
  return s
}
# chuanhoa — y hệt nghia.sh: bỏ ngoặc, bỏ dấu, thường hoá. Dùng để khớp từ trong
# VOCAB_INDEX với heading bài học ("walk (someone) through" → "walk through").
function chuanhoa(s) {
  gsub(/\([^)]*\)/, " ", s); gsub(/[^[:alnum:] -]/, " ", s)
  gsub(/[[:space:]]+/, " ", s); gsub(/^ | $/, "", s)
  return tolower(s)
}
# md — một dòng markdown của bài học → HTML: `code`, **đậm**; bỏ _từ cũ_ / *nghiêng*.
function md(s,   out, i, mo) {
  s = esc(s)
  out = ""; mo = 0
  while ((i = index(s, "`")) > 0) { out = out substr(s, 1, i - 1) (mo ? "</code>" : "<code>"); mo = !mo; s = substr(s, i + 1) }
  s = out s; if (mo) s = s "</code>"
  out = ""; mo = 0
  while ((i = index(s, "**")) > 0) { out = out substr(s, 1, i - 1) (mo ? "</b>" : "<b>"); mo = !mo; s = substr(s, i + 2) }
  s = out s; if (mo) s = s "</b>"
  gsub(/[*_]/, "", s)
  return s
}
# cumtu — 3 cụm đầu tiên trong dòng **Collocation** của bài.
function cumtu(s,   out, n, i, j) {
  out = ""; n = 0
  while (n < 3 && (i = index(s, "`")) > 0) {
    s = substr(s, i + 1); j = index(s, "`"); if (j == 0) break
    out = out "<code>" esc(substr(s, 1, j - 1)) "</code>"; s = substr(s, j + 1); n++
  }
  return out
}

# ── Đọc dữ liệu ──
FILENAME == ARGV[1] { N++; tu[N] = $2; loai[N] = $3; nhom[N] = $4; goc[N] = $5; ngay[N] = $6; next }
FILENAME == ARGV[2] {
  if ($0 ~ /^TU /) K++
  else if ($0 ~ /^NGHIA /) nghia[K] = substr($0, 8)
  else if ($0 ~ /^PHU /) phu[K] = substr($0, 8)
  next
}
FILENAME == ARGV[3] { coTuan[$1] = 1; next }
# Bài học .md: heading  ## 3. **escalate** /ɪˈskæl.eɪt/ — *verb* · `Business`
{
  if (FNR == 1) inb = 0
  if ($0 ~ /^## /) {
    inb = 0
    if ($0 ~ /^## [0-9]+\. \*\*/) {
      h = $0; sub(/^## [0-9]+\. \*\*/, "", h)
      sau = h; sub(/^[^*]*\*\*/, "", sau)
      sub(/\*\*.*$/, "", h); sub(/ *·.*$/, "", h)
      k = chuanhoa(h); inb = 1; vd = 0
      bai[k] = FILENAME
      if (match(sau, /\/[^\/]+\//)) ipa[k] = substr(sau, RSTART, RLENGTH)
    }
    next
  }
  if (!inb) next
  if ($0 ~ /^[*_]+Ví dụ[*_]+/) { vd = 1; next }
  if (vd == 1 && $0 ~ /^- /) { s = $0; sub(/^- /, "", s); vidu[k] = md(s); vd = 2; next }
  if ($0 ~ /^\*\*Collocation\*\*/) cum[k] = cumtu($0)
}

# ── Tên kỳ ──
function tenKy(P,   n) {
  if (length(P) == 4) return "Năm " P
  n = substr(P, 7) + 0
  if (substr(P, 6, 1) == "H") return (n == 1 ? "Nửa đầu năm " : "Nửa cuối năm ") substr(P, 1, 4)
  if (substr(P, 6, 1) == "Q") return "Quý " n "/" substr(P, 1, 4)
  return "Tháng " (substr(P, 6, 2) + 0) "/" substr(P, 1, 4)
}
function tenNgan(P,   n) {
  if (length(P) == 4) return "Năm " P
  n = substr(P, 7) + 0
  if (substr(P, 6, 1) == "H") return n == 1 ? "Nửa đầu năm" : "Nửa cuối năm"
  if (substr(P, 6, 1) == "Q") return "Quý " n
  return "Tháng " (substr(P, 6, 2) + 0)
}

function dongBang(i, k, cls,   s, b, nghe, nv) {
  b = bai[k]; sub(/^wiki\//, "../", b); sub(/\.md$/, ".html", b)
  nghe = tu[i]; gsub(/ *\([^)]*\) */, " ", nghe); gsub(/^ | $/, "", nghe)
  nv = nghia[i] != "" ? nghia[i] : goc[i]
  s = "            <tr data-cat=\"" cls "\">\n"
  s = s "              <td class=\"c-tu\">\n"
  s = s "                <span class=\"tu\"><b>" esc(tu[i]) "</b> <button class=\"say\" data-say=\"" esc(nghe) "\">🔊</button></span>\n"
  s = s "                <span class=\"ipa\">" (ipa[k] != "" ? esc(ipa[k]) " · " : "") esc(loai[i]) "</span>\n"
  if (b != "") s = s "                <a class=\"ngay\" href=\"" b "\">học " ld_dm(ngay[i]) "</a>\n"
  else         s = s "                <span class=\"ngay\">học " ld_dm(ngay[i]) " · tra ngoài</span>\n"
  s = s "              </td>\n"
  s = s "              <td class=\"c-vi hide-me\">" esc(nv) (phu[i] != "" ? "<span class=\"phu\">" esc(phu[i]) "</span>" : "") "</td>\n"
  s = s "              <td class=\"c-cum\">" cum[k] (vidu[k] != "" ? "<span class=\"vd\">" vidu[k] "</span>" : "") "</td>\n"
  s = s "            </tr>"
  return s
}

function viet(P,   j, f, y, n, m, dau, cuoi, nhan, x, i, g, gc, mon, sun, meta, con) {
  j = loaiKy[P]; f = OUTDIR "/" P ".html"; y = substr(P, 1, 4)
  if (j == 1)      { dau = y "-01-01"; cuoi = y "-12-31"; nhan = "năm" }
  else if (j == 2) { n = substr(P, 7) + 0; dau = y (n == 1 ? "-01-01" : "-07-01"); cuoi = y (n == 1 ? "-06-30" : "-12-31"); nhan = "nửa năm" }
  else if (j == 3) { n = substr(P, 7) + 0; dau = sprintf("%s-%02d-01", y, 3 * n - 2); cuoi = sprintf("%s-%02d-%02d", y, 3 * n, ld_songay(y, 3 * n)); nhan = "quý" }
  else             { m = substr(P, 6, 2) + 0; dau = P "-01"; cuoi = sprintf("%s-%02d", P, ld_songay(y, m)); nhan = "tháng" }

  print "<!doctype html>" > f
  print "<html lang=\"vi\">" > f
  print "  <head>" > f
  print "    <meta charset=\"utf-8\" />" > f
  print "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />" > f
  print "    <title>Ôn " tolower(substr(tenKy(P), 1, 1)) substr(tenKy(P), 2) " — " dem[P] " từ</title>" > f
  print "    <!-- SINH RA bởi tools/build-recap.sh — đừng sửa tay, lần build sau ghi đè." > f
  print "         Sửa nghĩa thì sửa ở BÀI GỐC (.vi-quick) rồi chạy sh tools/build-index.sh. -->" > f
  print "    <link rel=\"stylesheet\" href=\"../assets/lesson.css\" />" > f
  print "    <link rel=\"stylesheet\" href=\"../assets/recap.css\" />" > f
  print "  </head>" > f
  print "  <body>" > f
  print "    <div class=\"wrap\">" > f
  print "      <header class=\"hero\">" > f

  # Đường dẫn ngược lên: Mục lục › Năm › Nửa năm › Quý › Tháng
  con = "        <nav class=\"crumbs\"><a href=\"../../index.html\">Mục lục</a>"
  if (j > 1) con = con " › <a href=\"" y ".html\">" tenNgan(y) "</a>"
  if (j > 2) con = con " › <a href=\"" y "-H" ld_nua(dau) ".html\">" tenNgan(y "-H" ld_nua(dau)) "</a>"
  if (j > 3) con = con " › <a href=\"" y "-Q" ld_quy(dau) ".html\">" tenNgan(y "-Q" ld_quy(dau)) "</a>"
  print con " › <span>" tenNgan(P) "</span></nav>" > f

  print "        <div class=\"eyebrow\">Bảng ôn " nhan " · " ld_dm(dau) "–" ld_dm(cuoi) "/" y (HOM_NAY <= cuoi ? " · đang diễn ra" : "") "</div>" > f
  print "        <h1>" tenKy(P) "</h1>" > f
  print "        <div class=\"mixline\">" > f
  print "          <span class=\"badge it\">" demNhom[P, "it"] + 0 " IT</span>" > f
  print "          <span class=\"badge biz\">" demNhom[P, "biz"] + 0 " Giao tiếp</span>" > f
  print "          <span class=\"badge life\">" demNhom[P, "life"] + 0 " Đời sống</span>" > f
  print "          <span class=\"badge\">" buoi[P] + 0 " buổi học</span>" > f
  print "        </div>" > f
  print "      </header>" > f
  print "" > f
  print "      <div class=\"toolbar\">" > f
  print "        <button id=\"quiz-mode\" aria-pressed=\"false\">🙈 Chế độ ôn tập</button>" > f
  print "        <button id=\"theme\">🌗 Theo hệ thống</button>" > f
  print "        <span class=\"hint\">Bấm 🔊 để nghe · bật chế độ ôn tập để che cột tiếng Việt, bấm vào chỗ mờ để hiện lại</span>" > f
  print "      </div>" > f
  print "" > f

  # Năm / nửa năm: thêm lối tắt xuống các kỳ con không hiện thành nhóm trong trang.
  con = ""
  for (x = 1; x <= nKy; x++) {
    g = thuTu[x]
    if (substr(g, 1, 4) != y || g == P) continue
    if (j == 1 && (loaiKy[g] == 2 || loaiKy[g] == 3)) con = con "<a href=\"" g ".html\">" tenNgan(g) "</a>"
    if (j == 2 && loaiKy[g] == 3 && ld_nua(sprintf("%s-%02d-01", y, 3 * substr(g, 7))) == substr(P, 7) + 0) con = con "<a href=\"" g ".html\">" tenNgan(g) "</a>"
  }
  if (con != "") print "      <nav class=\"ky-con\"><span class=\"k\">Ôn theo kỳ nhỏ hơn</span>" con "</nav>\n" > f

  print "      <p class=\"passage\">" dem[P] " từ đã học trong " tolower(substr(tenKy(P), 1, 1)) substr(tenKy(P), 2) ", xếp theo ngày học và gom theo " (j == 4 ? "tuần" : "tháng") ". Nghĩa Việt chép nguyên từ bài gốc — muốn tự kiểm tra thì bật 🙈 rồi nhìn từ đoán nghĩa.</p>" > f

  gc = ""
  for (x = 1; x <= dem[P]; x++) {
    i = ds[P, x]
    g = (j == 4) ? ld_tuan(ngay[i]) : substr(ngay[i], 1, 7)
    if (g != gc) {
      if (gc != "") print "          </tbody>\n        </table>" > f
      gc = g
      if (j == 4) {
        mon = ld_cong(ngay[i], -ld_thu(ngay[i])); sun = ld_cong(mon, 6)
        meta = ld_dm(mon) "–" ld_dm(sun) " · " demCon[P, g] " từ" (substr(mon, 6, 2) != substr(sun, 6, 2) ? " · tuần vắt 2 tháng" : "")
        con = coTuan[g] ? "<a class=\"nhom-on\" href=\"" g ".html\">🔁 Ôn tuần</a>" : ""
        print "\n      <h2 class=\"nhom\"><span class=\"nhom-ten\">Tuần " g "</span><span class=\"nhom-meta\">" meta "</span>" con "</h2>" > f
      } else {
        print "\n      <h2 class=\"nhom\"><span class=\"nhom-ten\">" tenKy(g) "</span><span class=\"nhom-meta\">" demCon[P, g] " từ</span><a class=\"nhom-on\" href=\"" g ".html\">🔁 Ôn tháng</a></h2>" > f
      }
      print "        <table class=\"tra-nhanh\">" > f
      print "          <thead><tr><th class=\"c-tu\">Từ</th><th class=\"c-vi\">Nghĩa tiếng Việt</th><th class=\"c-cum\">Cụm đi kèm · câu ví dụ</th></tr></thead>\n          <tbody>" > f
    }
    print row[i] > f
  }
  print "          </tbody>\n        </table>" > f
  print "" > f
  print "      <footer>Sinh tự động bởi <code>tools/build-recap.sh</code> từ " buoi[P] + 0 " buổi học · nghĩa Việt chép nguyên khối nghĩa của bài gốc · <a href=\"../../index.html\">← Mục lục</a></footer>" > f
  print "    </div>" > f
  print "    <script src=\"../assets/lesson.js\"></script>" > f
  print "  </body>" > f
  print "</html>" > f
  close(f)
}

END {
  for (i = 1; i <= N; i++) {
    d = ngay[i]; y = substr(d, 1, 4)
    k = chuanhoa(tu[i])
    cls = nhom[i] == "IT" ? "it" : (nhom[i] == "Business" ? "biz" : "life")
    row[i] = dongBang(i, k, cls)
    p[1] = y; p[2] = y "-H" ld_nua(d); p[3] = y "-Q" ld_quy(d); p[4] = substr(d, 1, 7)
    for (j = 1; j <= 4; j++) {
      P = p[j]
      if (!(P in loaiKy)) { loaiKy[P] = j; thuTu[++nKy] = P }
      dem[P]++; ds[P, dem[P]] = i; demNhom[P, cls]++
      b = (k in bai) ? bai[k] : "tra-ngoai"
      if (!((P, b) in daDem)) { daDem[P, b] = 1; if (b != "tra-ngoai") buoi[P]++ }
      demCon[P, (j == 4) ? ld_tuan(d) : substr(d, 1, 7)]++
    }
  }
  for (x = 1; x <= nKy; x++) viet(thuTu[x])
  print "DA-DUNG-RECAP: " nKy " trang (năm/nửa năm/quý/tháng, " N " từ)"
}
AWK

awk -F"$TAB" -v OUTDIR="$OUTDIR" -v HOM_NAY="$(hnay)" \
  -f tools/lich.awk -f "$TMP/recap.awk" \
  "$TMP/vocab" "$TMP/nghia" "$TMP/tuan" $(find wiki/lessons -mindepth 2 -name '*.md' | sort)
