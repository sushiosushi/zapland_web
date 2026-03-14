# AGENTS.md

## Cursor Cloud specific instructions

### Project overview

Zapland Web is a Flutter Web application (Dart) — a promotional site for a Roblox game. It uses Firebase (Auth, Analytics, Cloud Functions) as its backend. The codebase targets **web only** (`dart:html` imports). There is no backend service, Docker, or database to run locally.

### Flutter SDK

Flutter 3.24.3 is installed at `/opt/flutter`. The PATH is configured in `~/.bashrc`. If Flutter is not on PATH, run:
```
export PATH="/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:$PATH"
```

### Key commands

| Task | Command |
|------|---------|
| Install deps | `flutter pub get` |
| Lint / analyze | `flutter analyze` |
| Build web | `flutter build web --base-href /` |
| Serve built app | `cd build/web && python3 -m http.server 8888` |
| Run tests | `flutter test --platform chrome` (see note below) |

### Known caveats

- **Tests**: The sole test file (`test/widget_test.dart`) is a default Flutter counter smoke test that does not match the actual app. It fails both on Chrome and VM platforms. This is a pre-existing issue — the test was never updated when the app was rewritten.
- **Web-only**: Tests **must** use `--platform chrome` because the app imports `dart:html`. Running `flutter test` without that flag fails with compilation errors.
- **Firebase**: The app calls Firebase Auth (anonymous sign-in) on startup. In dev without Firebase emulators, the app still renders its full UI but shows console errors for Firebase resource loading. This does not block development.
- **`flutter analyze`** reports ~44 info/warning-level issues (unused imports, file naming conventions). No errors. These are all pre-existing.
- **Env file**: The committed `env` file (no dot prefix) contains non-secret config (`REPOSITORY_NAME`, `APP_STORE_LINK`). A `.env` file (gitignored) is sourced only in `deploy.sh`.
