#!/bin/sh
# boc.sh — bốc 20 từ cho phần B "Ôn nhanh đầu giờ" (luật R9), DÀN ĐỀU cả vốn từ.
#
#   sh tools/boc.sh                    # in 20 từ, mỗi dòng một từ
#   sh tools/boc.sh | sh tools/nghia.sh  # nối thẳng sang lấy nghĩa gốc
#   sh tools/boc.sh -v                 # kèm ngày "gặp lần cuối" để kiểm tra
#   sh tools/boc.sh 2026-10-06         # bốc cho một ngày khác hôm nay (thử/soát lại)
#
# Vì sao không bốc ngẫu nhiên thuần nữa (chốt 2026-10-05, user yêu cầu): rand()
# mỗi buổi độc lập nên hôm nay hay trúng lại từ vừa ôn hôm qua, còn có từ cả
# tháng không quay lại. Giờ chọn theo "lâu chưa gặp nhất ra trước":
#
#   gặp lần cuối = ngày gần nhất từ đó XUẤT HIỆN ở khối ôn nhanh (phần A hoặc B)
#                  của một bài trước hôm nay; chưa xuất hiện lần nào = ngày học nó.
#
# Xếp tăng dần theo ngày đó, cùng ngày thì xáo ngẫu nhiên, lấy 20 từ đầu. Hệ quả:
# bài ngày N không trùng bài N-1, N-2, … cho tới khi đã quay hết một vòng vốn từ
# (~tổng từ / 20 buổi) — rồi mới tới lượt từ cũ nhất quay lại.
#
# Luôn loại 5 từ của buổi liền trước (đã nằm ở phần A).

set -e
. "$(dirname "$0")/openit.sh"
cd "$HARNESS"

VERBOSE=0
NGAY=$(hnay)
for a in "$@"; do
  case "$a" in
    -v) VERBOSE=1 ;;
    [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) NGAY=$a ;;
    *) echo "boc.sh: tham so la '$a'" >&2; exit 1 ;;
  esac
done

INDEX="wiki/VOCAB_INDEX.md"
SO=20

# Các bài trước hôm nay, mới nhất trước. Tên file = ngày (YYYY-MM-DD.md).
BAI=$(find wiki/lessons -name '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].md' |
  awk -F/ -v n="$NGAY" '{d=$NF; sub(/\.md$/,"",d); if (d < n) print d "\t" $0}' |
  sort -r)
TRUOC=$(printf '%s\n' "$BAI" | head -1 | cut -f1)

# Từ từng xuất hiện ở khối ôn nhanh: "ngày<TAB>từ". Đáp án nằm dạng
# `<summary>đáp án</summary> <b>từ</b>` trước mục từ mới đầu tiên (`## 1. `).
DA_ON=$(printf '%s\n' "$BAI" | while IFS="$(printf '\t')" read -r d f; do
  [ -n "$f" ] || continue
  awk '/^## 1\. /{exit} {print}' "$f" |
    grep -oE 'đáp án</summary>[[:space:]]*<b>[^<]+</b>' |
    sed -e 's/.*<b>//' -e 's/<\/b>$//' |
    awk -v d="$d" '{print d "\t" $0}'
done)

# Gộp với VOCAB_INDEX: | # | Word | family | Loại | Nhóm | Nghĩa gọn | Ngày học | Nguồn |
printf '%s\n' "$DA_ON" | awk -F'\t' -v truoc="$TRUOC" -v so="$SO" -v verbose="$VERBOSE" '
  function key(s) { s = tolower(s); gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
  NR == FNR { if (NF >= 2) { k = key($2); if ($1 > on[k]) on[k] = $1 }; next }
  /^\| [0-9]+ \|/ {
    split($0, c, "|")
    tu = c[3]; gsub(/^[ \t]+|[ \t]+$/, "", tu)
    ngay = c[8]; gsub(/^[ \t]+|[ \t]+$/, "", ngay)
    if (ngay == truoc) next                    # 5 từ buổi trước -> đã ở phần A
    cuoi = (on[key(tu)] > ngay) ? on[key(tu)] : ngay
    print cuoi "\t" rand() "\t" tu
  }
  BEGIN { srand() }
' - FS='|' "$INDEX" |
  sort -t "$(printf '\t')" -k1,1 -k2,2n |
  head -n "$SO" |
  if [ "$VERBOSE" = 1 ]; then awk -F'\t' '{print $1 "  " $3}'; else cut -f3; fi
