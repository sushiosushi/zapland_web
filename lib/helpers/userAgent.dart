import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isInZapshotWebViewProvider = FutureProvider<bool>((ref) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;

  if (webBrowserInfo.userAgent != null &&
      webBrowserInfo.userAgent!.contains('zapshot')) {
    return true;
  }

  return false;
});
