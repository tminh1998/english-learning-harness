# lich.awk — hàm ngày tháng dùng chung cho build-recap.sh và build-index.sh.
#
#   awk -f tools/lich.awk -f <chương-trình>.awk ...
#
# awk POSIX không có mktime/strftime, còn `date` thì BSD (Mac) với GNU (VM) khác cú
# pháp — nên tự tính bằng số học thuần. Mọi ngày đều ở dạng chuỗi "YYYY-MM-DD".

# ld_so("YYYY-MM-DD") — số thứ tự của ngày, để trừ/so hai ngày với nhau.
function ld_so(s,   y, m, d) {
  y = substr(s, 1, 4) + 0; m = substr(s, 6, 2) + 0; d = substr(s, 9, 2) + 0
  if (m < 3) { y--; m += 12 }
  return 365 * y + int(y / 4) - int(y / 100) + int(y / 400) + int((153 * (m - 3) + 2) / 5) + d
}

# ld_thu(s) — 0 = Thứ Hai … 6 = Chủ nhật. Mốc: 2026-10-05 là Thứ Hai.
function ld_thu(s,   k) {
  k = (ld_so(s) - ld_so("2026-10-05")) % 7
  return k < 0 ? k + 7 : k
}

# ld_songay(y, m) — số ngày của tháng m năm y.
function ld_songay(y, m) {
  if (m == 2) return (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)) ? 29 : 28
  return (m == 4 || m == 6 || m == 9 || m == 11) ? 30 : 31
}

# ld_cong(s, k) — ngày s cộng k ngày (k âm = lùi lại).
function ld_cong(s, k,   y, m, d) {
  y = substr(s, 1, 4) + 0; m = substr(s, 6, 2) + 0; d = substr(s, 9, 2) + 0
  while (k > 0) { if (++d > ld_songay(y, m)) { d = 1; if (++m > 12) { m = 1; y++ } }; k-- }
  while (k < 0) { if (--d < 1) { if (--m < 1) { m = 12; y-- }; d = ld_songay(y, m) }; k++ }
  return sprintf("%04d-%02d-%02d", y, m, d)
}

# ld_tuan(s) — tuần ISO "YYYY-Www", khớp `date +%G-W%V` và tên thư mục bài học.
# Tuần thuộc về năm chứa ngày Thứ Năm của nó.
function ld_tuan(s,   t, y) {
  t = ld_so(s) - ld_thu(s) + 3
  y = substr(s, 1, 4) + 0
  if (t < ld_so(y "-01-01")) y--
  else if (t >= ld_so((y + 1) "-01-01")) y++
  return sprintf("%d-W%02d", y, int((t - ld_so(y "-01-01")) / 7) + 1)
}

# ld_dm(s) — "dd/mm" để hiện trên trang.
function ld_dm(s) { return substr(s, 9, 2) "/" substr(s, 6, 2) }

# ld_quy(s) / ld_nua(s) — quý 1..4, nửa năm 1..2 của ngày s.
function ld_quy(s) { return int((substr(s, 6, 2) - 1) / 3) + 1 }
function ld_nua(s) { return substr(s, 6, 2) + 0 <= 6 ? 1 : 2 }
