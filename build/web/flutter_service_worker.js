'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "1509cd3d809c4b06530c39aeb22a7da5",
"splash/img/light-2x.png": "2a15e01abe83e64799f042828f96380b",
"splash/img/dark-4x.png": "a500a17e199562cb57cd09bf7aed7993",
"splash/img/light-3x.png": "00dc81cda09b2a298d3eaf787157586e",
"splash/img/dark-3x.png": "00dc81cda09b2a298d3eaf787157586e",
"splash/img/light-4x.png": "a500a17e199562cb57cd09bf7aed7993",
"splash/img/dark-2x.png": "2a15e01abe83e64799f042828f96380b",
"splash/img/dark-1x.png": "fcfcc7911611ec4bbbfb53077b7bd2ab",
"splash/img/light-1x.png": "fcfcc7911611ec4bbbfb53077b7bd2ab",
"index.html": "dbbb41dae2e7bdf0f8e938fa3b30bcd5",
"/": "dbbb41dae2e7bdf0f8e938fa3b30bcd5",
"main.dart.js": "d781ecba385b0ff687ad9e94768e5de2",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "495b0990685978a549a5eae64a23e387",
"icons/Icon-192.png": "fe248931ce9f467320562d6a72c07b21",
"icons/Icon-maskable-192.png": "fe248931ce9f467320562d6a72c07b21",
"icons/Icon-maskable-512.png": "c20ecb1e03b5034f20c92ec3d0e6c9cc",
"icons/Icon-512.png": "c20ecb1e03b5034f20c92ec3d0e6c9cc",
"manifest.json": "6d5136740de2782847c316313fe28106",
"assets/AssetManifest.json": "a42191d67f86fa5aea147969c5c4ba79",
"assets/NOTICES": "70a28191d6d0de46b2603b5a614d502e",
"assets/env": "9d9b55d81dd8d2879b64f017f0d0f862",
"assets/FontManifest.json": "6aad09e4266b027f9020c9c3bd8a7594",
"assets/AssetManifest.bin.json": "a299fce4c97295d4bcd85938b8d3da72",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/iconsax_flutter/fonts/FlutterIconsax.ttf": "83c878235f9c448928034fe5bcba1c8a",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "a7e0ee11dd37c2576a65f8bb0b1ef12b",
"assets/fonts/MaterialIcons-Regular.otf": "0af6e01d856c2c79c1968def942ef87e",
"assets/assets/splash/splash.png": "468584ae77c23c788537279600ea6214",
"assets/assets/test/public.pem": "0c96ad04309fd7b7c9f647a48e1d9f3f",
"assets/assets/test/private.pem": "05666ae0359a7a83fb360340573253bf",
"assets/assets/roblox/icon.png": "9a38cdae0b30ae322e16314cdf4b1dbd",
"assets/assets/roblox/badge_white.png": "04be0f9b3abf194f4e3708d3e43a36a6",
"assets/assets/roblox/badge_black.png": "1f5d528394f7737dd3d802fe9a5bf048",
"assets/assets/ogp/default.png": "d13c125c073f24c62287c4f7c00f2864",
"assets/assets/icon/icon.png": "e2991ef6e7d888e8c525415587792630",
"assets/assets/fonts/CarterOne/CarterOne-Regular.ttf": "3226bb55ad746ec8b6495ce6655cfc63",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
