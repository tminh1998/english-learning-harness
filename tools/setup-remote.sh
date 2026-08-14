#!/bin/sh
# setup-remote.sh — đưa harness lên GitHub + bật trang đọc (GitHub Pages).
#
#   gh auth login          # làm TRƯỚC, một lần, tự mở trình duyệt
#   sh tools/setup-remote.sh [ten-repo]
#
# Chạy MỘT LẦN lúc dựng. Chạy lại cũng không sao: script bỏ qua các bước đã xong.
#
# Sau khi xong, học từ điện thoại bằng cách vào claude.ai/code, chọn repo, gõ /hoc.

set -e
. "$(dirname "$0")/openit.sh"
cd "$HARNESS"

REPO=${1:-english-learning-harness}

command -v gh >/dev/null 2>&1 || { echo "THIEU-GH: brew install gh"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "CHUA-DANG-NHAP: chạy 'gh auth login' trước"; exit 1; }

USER=$(gh api user --jq .login)
SLUG="$USER/$REPO"

# ── 1. Tạo repo trên GitHub (public — để GitHub Pages miễn phí) ──
if gh repo view "$SLUG" >/dev/null 2>&1; then
  echo "[1/5] Repo $SLUG đã có, bỏ qua bước tạo."
else
  echo "[1/5] Tạo repo $SLUG..."
  gh repo create "$SLUG" --public \
    --description "Sổ tay học tiếng Anh cho dev — 5 từ mỗi ngày, có chống trùng và lịch ôn tập"
fi

# ── 2. Nối remote + push ──
git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$SLUG.git"
git remote set-url origin "https://github.com/$SLUG.git"
echo "[2/5] Push lên $SLUG..."
git push -u origin main

# ── 3. Bật GitHub Pages, phục vụ từ gốc nhánh main ──
echo "[3/5] Bật GitHub Pages..."
gh api -X POST "repos/$SLUG/pages" \
  -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 ||
  echo "      (Pages đã bật sẵn hoặc GitHub từ chối — kiểm tra ở Settings > Pages)"

PAGES_URL=$(gh api "repos/$SLUG/pages" --jq .html_url 2>/dev/null || true)
[ -n "$PAGES_URL" ] || PAGES_URL="https://$USER.github.io/$REPO/"

# ── 4. Ghi URL thật vào config — chỗ DUY NHẤT harness đọc URL ──
# Từ đây `openit` trên VM cloud biết in link nào cho user bấm.
echo "[4/5] Ghi URL vào .learning-config.yml..."
tmp=$(mktemp)
sed -e "s|^  github: .*|  github: \"https://github.com/$SLUG\"|" \
    -e "s|^  pagesBaseUrl: .*|  pagesBaseUrl: \"${PAGES_URL%/}\"|" \
    .learning-config.yml > "$tmp" && mv "$tmp" .learning-config.yml

sed -e "s|<!-- PAGES_URL -->.*|<!-- PAGES_URL -->[${PAGES_URL%/}](${PAGES_URL%/})|" \
    README.md > "$tmp" && mv "$tmp" README.md

# ── 5. Dựng lại mục lục cho khớp rồi push ──
echo "[5/5] Dựng lại mục lục + push..."
sh tools/build-index.sh
git add -A
git commit -q -m "Bật GitHub Pages: ${PAGES_URL%/}" || echo "      (không có gì để commit)"
git push

cat <<EOF

═══════════════════════════════════════════════════════════
XONG.

  Repo      https://github.com/$SLUG
  Trang đọc ${PAGES_URL%/}
            (GitHub cần 1-2 phút build lần đầu)

Học từ điện thoại / máy khác:
  1. Vào claude.ai/code, đăng nhập tài khoản Claude
  2. Kết nối GitHub (nó tự hỏi ở lần đầu), chọn repo $REPO
  3. Gõ /hoc — rồi merge PR mà nó tạo ra

Chỉ muốn ĐỌC lại bài cũ thì mở thẳng trang đọc ở trên, không cần Claude.
═══════════════════════════════════════════════════════════
EOF
