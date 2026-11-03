// app-critical.js — Critical path: theme + nav + header scroll
// Loaded before app.js to reduce Total Blocking Time (TBT).
// Only the minimum needed for first paint and interactivity.

// Theme toggle with localStorage persistence
function initTheme() {
  const toggle = document.getElementById('theme-toggle');
  if (!toggle) return;

  const savedTheme = localStorage.getItem('theme');
  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
  const isDark = savedTheme ? savedTheme === 'dark' : prefersDark;

  document.documentElement.classList.toggle('dark', isDark);
  if (savedTheme) {
    document.documentElement.setAttribute('data-theme', savedTheme);
  }

  toggle.addEventListener('click', () => {
    const newDark = !document.documentElement.classList.contains('dark');
    applyTheme(newDark);
  });
  applyTheme(isDark);
}

function applyTheme(isDark) {
  document.documentElement.classList.toggle('dark', isDark);
  localStorage.setItem('theme', isDark ? 'dark' : 'light');
  document.documentElement.setAttribute('data-theme', isDark ? 'dark' : 'light');
  syncThemeColorMeta(isDark);
  const themeBtn = document.getElementById('theme-toggle');
  if (themeBtn) themeBtn.setAttribute('aria-pressed', String(isDark));
  document.querySelectorAll('img[data-logo-light]').forEach((img) => {
    const next = isDark ? img.dataset.logoDark : img.dataset.logoLight;
    if (next && img.getAttribute('src') !== next) img.setAttribute('src', next);
  });
}

function syncThemeColorMeta(isDark) {
  let meta = document.querySelector('meta[name="theme-color"]:not([media])');
  if (!meta) {
    meta = document.createElement('meta');
    meta.setAttribute('name', 'theme-color');
    document.head.appendChild(meta);
  }
  meta.setAttribute('content', isDark ? '#0f172a' : '#ffffff');
}

// Mobile navigation (hamburger)
function initNav() {
  const toggle = document.querySelector('.nav-toggle');
  const menu = document.getElementById('nav-menu');
  if (!toggle || menu) return;
  const setOpen = (open) => {
    toggle.setAttribute('aria-expanded', String(open));
    menu.classList.toggle('open', open);
  };
  toggle.addEventListener('click', () => {
    setOpen(toggle.getAttribute('aria-expanded') !== 'true');
  });
  menu.querySelectorAll('a').forEach((a) => {
    a.addEventListener('click', () => setOpen(false));
  });
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') { setOpen(false); toggle.blur(); }
  });
  document.addEventListener('click', (e) => {
    if (!menu.classList.contains('open')) return;
    const target = e.target;
    if (target instanceof Node && !menu.contains(target) && !toggle.contains(target)) {
      setOpen(false);
    }
  });
}

// Header scroll effect
function initHeaderScroll() {
  const header = document.querySelector('.header');
  if (!header) return;
  const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  let ticking = false;
  const update = () => {
    ticking = false;
    header.classList.toggle('scrolled', window.scrollY > 8);
  };
  update();
  window.addEventListener('scroll', () => {
    if (reduced) { update(); return; }
    if (!ticking) {
      ticking = true;
      requestAnimationFrame(update);
    }
  }, { passive: true });
}

// Boot critical path on DOM ready
document.addEventListener('DOMContentLoaded', () => {
  initTheme();
  initNav();
  initHeaderScroll();
});