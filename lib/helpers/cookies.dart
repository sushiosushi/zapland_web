import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:html';

const _key = "viewingTimes";
const _value = 1;

final viewingTimesProvider = FutureProvider<int>((ref) async {
  final cookie = document.cookie;

  if (cookie == null || cookie.isEmpty) {
    document.cookie = "$_key=$_value";
    return _value;
  }

  final entity = cookie.split("; ").map((item) {
    final split = item.split("=");
    return MapEntry(split[0], split[1]);
  });

  final cookieMap = Map.fromEntries(entity);

  if (cookieMap[_key] == null) {
    document.cookie = "$_key=$_value";
    return _value;
  } else {
    final value = int.parse(cookieMap[_key]!);
    document.cookie = "$_key=${value + 1}";
    return value + 1;
  }
});
