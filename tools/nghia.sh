#!/bin/sh
# nghia.sh — lấy lại NGHĨA GỐC + VÍ DỤ GỐC của một từ đã học, từ chính bài học cũ.
#
#   sh tools/nghia.sh "dry run" "snapshot"      # tra vài từ
#   printf 'stub\nverbose\n' | sh tools/nghia.sh   # hoặc đọc từ stdin (nối với lệnh bốc R9)
#
# Vì sao có file này (luật R8b): phần "Ôn nhanh đầu giờ" trước đây để agent tự
# soạn lại câu gợi nhớ mỗi buổi, nên nghĩa cứ trôi dần khỏi bài gốc — cùng một từ
# mà mỗi buổi hỏi một kiểu. Ôn tập kiểu đó là học lại từ mới chứ không phải ôn.
# Nghĩa và ví dụ chỉ được CHÉP, không được viết lại — và chép thì phải chép bằng
# lệnh, không chép bằng mắt.
#
# In ra cho mỗi từ 4 dòng, dán thẳng vào bài được:
#   TU   <từ> · <nhóm> · học ngày <ngày> · <file bài gốc>
#   HOI  <câu đầu của dòng **VI** trong bài gốc>  ← dùng làm câu gợi nhớ
#   VI   <cả dòng **VI**>                          ← để đối chiếu khi câu đầu chưa đủ
#   VD   <câu ví dụ #1, đã bỏ markup>              ← dùng làm ví dụ trong ô đáp án

set -e
. "$(dirname "$0")/openit.sh"
cd "$HARNESS"

INDEX="wiki/VOCAB_INDEX.md"
LESSONS="wiki/lessons"

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
    echo "TU   $tu"
    echo "LOI  KHONG-CO-TRONG-VOCAB-INDEX"
    echo
    return 0
  fi

  nhom=$(printf '%s' "$dong" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$6); print $6}')
  ngay=$(printf '%s' "$dong" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$8); print $8}')
  goc=$(printf '%s' "$dong" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$7); print $7}')

  # Bài gốc: wiki/lessons/<tuần>/<ngày>.md — tuần nào thì để `find` tự tìm.
  file=$(find "$LESSONS" -name "$ngay.md" 2>/dev/null | head -1)
  if [ -z "$file" ]; then
    echo "TU   $tu · $nhom · học ngày $ngay · KHONG-TIM-THAY-FILE"
    echo "HOI  $goc"
    echo
    return 0
  fi

  echo "TU   $tu · $nhom · học ngày $ngay · $file"

  # Khối của từ này: từ dòng `## N. **<từ>**` tới dấu `---` kế tiếp.
  # Tiêu đề bài cũ hay có phần trong ngoặc (`**walk (someone) through (something)**`)
  # trong khi VOCAB_INDEX ghi gọn (`walk through`) — nên bỏ ngoặc rồi mới so.
  khoi=$(awk -v w="$tu" '
    function chuanhoa(s) {
      gsub(/\([^)]*\)/, " ", s); gsub(/[^[:alnum:] -]/, " ", s)
      gsub(/[[:space:]]+/, " ", s); gsub(/^ | $/, "", s)
      return tolower(s)
    }
    BEGIN { muc = chuanhoa(w); inb = 0 }
    /^## [0-9]+\. / {
      if (inb) exit
      h = $0; sub(/^## [0-9]+\. /, "", h)
      sub(/^\*\*/, "", h); sub(/\*\*.*$/, "", h)
      if (chuanhoa(h) == muc) inb = 1
    }
    inb && /^---[[:space:]]*$/ { exit }
    inb { print }
  ' "$file")

  if [ -z "$khoi" ]; then
    echo "HOI  $goc"
    echo "LOI  KHONG-THAY-KHOI-TU-TRONG-BAI-GOC (nghĩa gọn ở trên là fallback)"
    echo
    return 0
  fi

  # Dòng **VI** — bỏ nhãn, bỏ ** và _ và ` cho gọn.
  vi=$(printf '%s\n' "$khoi" | sed -n 's/^[*_]*VI[*_]*[[:space:]]*—[[:space:]]*//p' |
       sed -e 's/\*\*//g' -e 's/[*`_]//g')
  # Câu gợi nhớ = câu ĐẦU của dòng VI, chép nguyên văn. Câu đầu mà cụt quá
  # ("Bàn giao.") thì lấy thêm câu thứ hai — vẫn là chép, không phải viết lại.
  hoi=$(printf '%s' "$vi" | awk '{
    n = split($0, c, /\. /); out = ""
    for (i = 1; i <= n; i++) {
      out = out c[i]; if (i < n) out = out ". "
      if (length(out) >= 30 || i >= 2) break
    }
    sub(/[[:space:]]+$/, "", out); print out
  }')

  # Ví dụ #1 = gạch đầu dòng đầu tiên sau `**Ví dụ**`, bỏ markup ** và _.
  vd=$(printf '%s\n' "$khoi" | awk '
    /^[*_]+Ví dụ[*_]+/ { v = 1; next }
    v && /^- / { sub(/^- /, ""); print; exit }
  ' | sed -e 's/\*\*//g' -e 's/[_*]//g')

  echo "HOI  $hoi"
  echo "VI   $vi"
  echo "VD   $vd"
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
