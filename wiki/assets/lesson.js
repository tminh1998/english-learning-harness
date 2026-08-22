/* lesson.js — hành vi dùng chung cho mọi trang bài học.
   1. Nút 🔊 đọc từ bằng giọng Anh (Web Speech API, chạy offline, không gọi mạng).
   2. Chế độ ôn tập: che mờ toàn bộ phần tiếng Việt để tự kiểm tra, bấm để hiện.
   3. Nút đổi sáng/tối, nhớ lựa chọn trong localStorage. */

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
}());


/* ══════════════════════════════════════════════════════════════════════
   KHỐI TỰ VIẾT — lưu nháp của người học vào localStorage (lộ trình v2).
   Key gắn theo tên file nên nháp bài này không đè nháp bài kia.
   Trang không có .wtask thì đoạn này không làm gì cả.
   ══════════════════════════════════════════════════════════════════════ */
(function () {
  var PAGE = 'draft:' + location.pathname.split('/').pop();
  var areas = document.querySelectorAll('.wtask textarea');
  var state = document.getElementById('save-state');
  var timer;

  function ping(msg) {
    if (!state) return;
    state.textContent = msg;
    clearTimeout(timer);
    timer = setTimeout(function () { state.textContent = ''; }, 1600);
  }

  areas.forEach(function (ta) {
    var key = PAGE + ':' + ta.dataset.key;
    try {
      var saved = localStorage.getItem(key);
      if (saved) ta.value = saved;
    } catch (e) { /* trình duyệt chặn storage — vẫn gõ được, chỉ không lưu */ }

    ta.addEventListener('input', function () {
      try {
        localStorage.setItem(key, ta.value);
        ping('đã lưu nháp ✓');
      } catch (e) { ping('không lưu được'); }
    });
  });

  var clear = document.getElementById('clear-draft');
  if (clear) clear.addEventListener('click', function () {
    if (!confirm('Xoá cả 3 câu nháp trên trang này?')) return;
    areas.forEach(function (ta) {
      ta.value = '';
      try { localStorage.removeItem(PAGE + ':' + ta.dataset.key); } catch (e) {}
    });
    ping('đã xoá');
  });
})();
