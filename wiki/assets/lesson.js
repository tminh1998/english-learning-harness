/* lesson.js — hành vi dùng chung cho mọi trang bài học.
   1. Nút 🔊 đọc từ bằng giọng Anh (Web Speech API, chạy offline, không gọi mạng).
   2. Chế độ ôn tập: che mờ toàn bộ phần tiếng Việt để tự kiểm tra, bấm để hiện.
   3. Nút đổi sáng/tối, nhớ lựa chọn trong localStorage.
   4. Ôn nhanh đầu giờ: nút đổi chiều Anh->Việt / Việt->Anh (mặc định Anh->Việt). */

(function () {
  'use strict';

  /* ── 1. Phát âm ────────────────────────────────────── */
  var synth = window.speechSynthesis;

  function speak(text) {
    if (!synth) { return; }
    synth.cancel();
    var u = new SpeechSynthesisUtterance(text);
    u.lang = 'en-US';
    u.rate = 0.9;
    var v = synth.getVoices().filter(function (x) { return /^en[-_]/i.test(x.lang); });
    if (v.length) { u.voice = v[0]; }
    synth.speak(u);
  }

  document.addEventListener('click', function (e) {
    var btn = e.target.closest('button.say');
    if (btn) { speak(btn.dataset.say || btn.closest('article').querySelector('h2').textContent); }
  });

  if (!synth) {
    document.querySelectorAll('button.say').forEach(function (b) { b.style.display = 'none'; });
  }

  /* ── 2. Chế độ ôn tập ──────────────────────────────── */
  var quizBtn = document.getElementById('quiz-mode');

  if (quizBtn) {
    quizBtn.addEventListener('click', function () {
      var on = document.body.classList.toggle('quiz-mode');
      quizBtn.setAttribute('aria-pressed', String(on));
      quizBtn.textContent = on ? '🙈 Đang che nghĩa Việt' : '🙈 Chế độ ôn tập';
      if (!on) {
        document.querySelectorAll('.hide-me.shown').forEach(function (el) {
          el.classList.remove('shown');
        });
      }
    });
  }

  document.addEventListener('click', function (e) {
    if (!document.body.classList.contains('quiz-mode')) { return; }
    var el = e.target.closest('.hide-me');
    if (el) { el.classList.toggle('shown'); }
  });

  /* ── 3. Sáng / tối ─────────────────────────────────── */
  var themeBtn = document.getElementById('theme');
  var saved = null;
  try { saved = localStorage.getItem('en-theme'); } catch (err) { /* file:// chặn */ }
  if (saved) { document.documentElement.setAttribute('data-theme', saved); }

  function label() {
    var t = document.documentElement.getAttribute('data-theme');
    if (!t) { return '🌗 Theo hệ thống'; }
    return t === 'dark' ? '🌙 Tối' : '☀️ Sáng';
  }

  if (themeBtn) {
    themeBtn.textContent = label();
    themeBtn.addEventListener('click', function () {
      var cur = document.documentElement.getAttribute('data-theme');
      var next = cur === 'dark' ? 'light' : cur === 'light' ? '' : 'dark';
      if (next) {
        document.documentElement.setAttribute('data-theme', next);
      } else {
        document.documentElement.removeAttribute('data-theme');
      }
      try { localStorage.setItem('en-theme', next); } catch (err) { /* bỏ qua */ }
      themeBtn.textContent = label();
    });
  }

  /* ── 4. Ôn nhanh đầu giờ: đổi chiều hỏi (từ 2026-09-09) ────────
     File bài học chỉ viết MỘT chiều: <span class="q"> là câu gợi nhớ tiếng
     Việt, <b> trong đáp án là từ tiếng Anh. Chiều còn lại dựng tại chỗ từ chính
     hai mẩu đó — không phải sửa khuôn bài học, không phải viết thêm dữ liệu.
       · EN → VI (MẶC ĐỊNH): hiện từ tiếng Anh + nút 🔊, đáp án là nghĩa Việt.
       · VI → EN: y nguyên như file viết ra.
     Nút bấm do JS chèn vào, KHÔNG động gì tới <details> gốc của trình duyệt. */
  var warmSec = document.querySelector('section.warmup');
  var DIR_KEY = 'en-warm-dir';

  function setupWarmDir(sec) {
    var items = [].filter.call(sec.querySelectorAll('li.qa'), function (li) {
      return li.querySelector(':scope > .q') && li.querySelector('details.ans .a b');
    });
    if (!items.length) { return; }

    items.forEach(function (li) {
      li._q = li.querySelector(':scope > .q');
      li._b = li.querySelector('details.ans .a b');
      li._viHTML = li._q.innerHTML;                       /* câu hỏi gốc */
      li._enHTML = li._b.innerHTML;                       /* đáp án gốc */
      li._word = li._b.textContent.trim();
      /* nghĩa Việt = chính câu gợi nhớ, bỏ dấu hỏi cuối câu */
      li._viAns = li._viHTML.replace(/\s*\?+\s*$/, '');
    });

    function render(dir) {
      sec.classList.toggle('dir-en', dir === 'en');
      sec.classList.toggle('dir-vi', dir !== 'en');
      items.forEach(function (li) {
        if (dir === 'en') {
          li._q.textContent = '';
          var w = document.createElement('span');
          w.className = 'w-en';
          w.textContent = li._word;
          li._q.appendChild(w);
          if (synth) {
            var say = document.createElement('button');
            say.type = 'button';
            say.className = 'say';
            say.dataset.say = li._word;
            say.textContent = '\uD83D\uDD0A';
            li._q.appendChild(say);
          }
          li._b.innerHTML = li._viAns;
          li._b.className = 'vi-ans';
        } else {
          li._q.innerHTML = li._viHTML;
          li._b.innerHTML = li._enHTML;
          li._b.className = '';
        }
      });
    }

    var sw = document.createElement('div');
    sw.className = 'dir-switch';
    sw.innerHTML =
      '<span class="ds-label">Chiều ôn</span>' +
      '<button type="button" class="ds-btn" data-dir="en">Anh → Việt</button>' +
      '<button type="button" class="ds-btn" data-dir="vi">Việt → Anh</button>';

    function apply(dir) {
      dir = dir === 'vi' ? 'vi' : 'en';
      render(dir);
      [].forEach.call(sw.querySelectorAll('.ds-btn'), function (b) {
        b.setAttribute('aria-pressed', String(b.dataset.dir === dir));
      });
      try { localStorage.setItem(DIR_KEY, dir); } catch (err) { /* file:// chặn */ }
    }

    sw.addEventListener('click', function (e) {
      var b = e.target.closest('button.ds-btn');
      if (b) { apply(b.dataset.dir); }
    });

    var host = sec.querySelector('details.warm-toggle') || sec;
    var sub = host.querySelector(':scope > .sub');
    if (sub && sub.nextSibling) {
      host.insertBefore(sw, sub.nextSibling);
    } else if (sub) {
      host.appendChild(sw);
    } else {
      host.insertBefore(sw, host.querySelector('.warm-part') || null);
    }

    var start = null;
    try { start = localStorage.getItem(DIR_KEY); } catch (err) { /* bỏ qua */ }
    apply(start || 'en');
  }

  if (warmSec) { setupWarmDir(warmSec); }
}());
