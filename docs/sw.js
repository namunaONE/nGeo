// docs/sw.js — Service worker for offline-first Nepal Administrative Data
// Cache-first for static assets, network-first for data.json.
const CACHE_NAME = 'ngeo-v2.15.0';
const STATIC_ASSETS = [
  '/',
  '/index.html',
  '/explorer.html',
  '/api.html',
  '/brand.html',
  '/styles.css?v=20',
  '/brand-tokens.css?v=2',
  '/fonts.css?v=1',
  '/app-critical.js?v=1',
  '/app.js?v=26',
  '/favicon.svg',
  '/logo.svg',
  '/logo-full.svg',
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(STATIC_ASSETS))
  );
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(keys.filter((k) => k !== CACHE_NAME).map((k) => caches.delete(k)))
    )
  );
  self.clients.claim();
});

self.addEventListener('fetch', (event) => {
  const url = new URL(event.request.url);

  // Network-first for data.json (may be updated)
  if (url.pathname.endsWith('data.json')) {
    event.respondWith(
      fetch(event.request)
        .then((res) => {
          const clone = res.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(event.request, clone));
          return res;
        })
        .catch(() => caches.match(event.request))
    );
    return;
  }

  // Cache-first for everything else
  event.respondWith(
    caches.match(event.request).then((cached) => {
      if (cached) return cached;
      return fetch(event.request).then((res) => {
        const clone = res.clone();
        caches.open(CACHE_NAME).then((cache) => cache.put(event.request, clone));
        return res;
      });
    })
  );
});
