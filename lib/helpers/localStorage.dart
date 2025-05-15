import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:html';

const _key = "viewingTimes(localStorage)";
const _initialValue = 1;

final viewingTimesLocalStorageProvider = FutureProvider<int>((ref) async {
  final stored = window.localStorage[_key];

  if (stored == null) {
    // 初回アクセス
    window.localStorage[_key] = _initialValue.toString();
    return _initialValue;
  } else {
    // すでに保存されている場合、カウントアップ
    final current = int.tryParse(stored) ?? 0;
    final updated = current + 1;
    window.localStorage[_key] = updated.toString();
    return updated;
  }
});
