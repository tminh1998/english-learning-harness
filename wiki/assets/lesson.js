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
