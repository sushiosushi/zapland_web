'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "fd1aeac6c2fe7fa5696da8c986281e24",
"version.json": "1509cd3d809c4b06530c39aeb22a7da5",
"splash/img/light-2x.png": "2a15e01abe83e64799f042828f96380b",
"splash/img/dark-4x.png": "a500a17e199562cb57cd09bf7aed7993",
"splash/img/light-3x.png": "00dc81cda09b2a298d3eaf787157586e",
"splash/img/dark-3x.png": "00dc81cda09b2a298d3eaf787157586e",
"splash/img/light-4x.png": "a500a17e199562cb57cd09bf7aed7993",
"splash/img/dark-2x.png": "2a15e01abe83e64799f042828f96380b",
"splash/img/dark-1x.png": "fcfcc7911611ec4bbbfb53077b7bd2ab",
"splash/img/light-1x.png": "fcfcc7911611ec4bbbfb53077b7bd2ab",
"index.html": "ff3e92e98300cbad9c733c895d38871a",
"/": "ff3e92e98300cbad9c733c895d38871a",
"main.dart.js": "437d4ba4e305bb01336cd12be4eced6b",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "495b0990685978a549a5eae64a23e387",
"icons/Icon-192.png": "fe248931ce9f467320562d6a72c07b21",
"icons/Icon-maskable-192.png": "fe248931ce9f467320562d6a72c07b21",
"icons/Icon-maskable-512.png": "c20ecb1e03b5034f20c92ec3d0e6c9cc",
"icons/Icon-512.png": "c20ecb1e03b5034f20c92ec3d0e6c9cc",
"manifest.json": "6d5136740de2782847c316313fe28106",
"assets/AssetManifest.json": "46c182b48a41da19aa781807182eeb49",
"assets/NOTICES": "cf4b2aa4b5dff0123c734a032e402dc6",
"assets/env": "b89a2fe1245471b283e4201f57a607e5",
"assets/FontManifest.json": "6aad09e4266b027f9020c9c3bd8a7594",
"assets/AssetManifest.bin.json": "2bd89c877a0755f48ad0fb69607b0bf4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/iconsax_flutter/fonts/FlutterIconsax.ttf": "83c878235f9c448928034fe5bcba1c8a",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "fe6fd115c56208e764ca40a935bd1c82",
"assets/fonts/MaterialIcons-Regular.otf": "19807cd6e62e0201427559ba2de61531",
"assets/assets/splash/splash.png": "468584ae77c23c788537279600ea6214",
"assets/assets/zapshot/icon.png": "f88b085551f82ff07166a98d575aa8a0",
"assets/assets/zapshot/logo_only.png": "e18ac4d9d7c78c483335807dedb68216",
"assets/assets/zapshot/badge.png": "3ad614f6ba17372bcf67c7d4a0adc549",
"assets/assets/roblox/Roblox_Limited_U_Label.png": "9dbd1ba731ee3c70fc98a02b32a7f7c4",
"assets/assets/roblox/icon.png": "9a38cdae0b30ae322e16314cdf4b1dbd",
"assets/assets/roblox/badge_white.png": "04be0f9b3abf194f4e3708d3e43a36a6",
"assets/assets/roblox/roblox_icon.png": "01f2f9353a4d373bec55aa397c31b32b",
"assets/assets/roblox/badge_black.png": "1f5d528394f7737dd3d802fe9a5bf048",
"assets/assets/roblox/robloxAnimation.json": "34d5fc3d8d391bbfc3308bc06338ebdd",
"assets/assets/appstore/badge.png": "5ef7ca8aee641a703e15f204f4288cf8",
"assets/assets/ogp/green.png": "93038b5153bd85514182f5045e62f565",
"assets/assets/robloxMeme/4.gif": "619507465468036368699ca11f35900d",
"assets/assets/robloxMeme/5.gif": "5a75040164b584a22b0e547182689898",
"assets/assets/robloxMeme/6.gif": "2ff1d2ce932112b8ee6660f5c11103f0",
"assets/assets/robloxMeme/2.gif": "fe9019100da3de05f60f0ee0e8ae036b",
"assets/assets/robloxMeme/3.gif": "17196992109366f6a6bb802371c46ced",
"assets/assets/robloxMeme/1.gif": "dbc2eb90262c30c512c4a97673df20f5",
"assets/assets/icon/icon.png": "e2991ef6e7d888e8c525415587792630",
"assets/assets/fonts/CarterOne/CarterOne-Regular.ttf": "3226bb55ad746ec8b6495ce6655cfc63",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
