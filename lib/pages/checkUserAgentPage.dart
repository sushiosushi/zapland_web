import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

final userAgentFutureProvider = FutureProvider<String>((ref) async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
  print('Running on ${webBrowserInfo.userAgent}'); // e.g. "Mozilla/5.0
  return webBrowserInfo.userAgent ?? 'Unknown';
});

class CheckUserAgentPage extends ConsumerStatefulWidget {
  static const String route = '/checkUserAgent';

  const CheckUserAgentPage({super.key});

  @override
  CheckUserAgentPageState createState() => CheckUserAgentPageState();
}

class CheckUserAgentPageState extends ConsumerState<CheckUserAgentPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final userAgent = ref.watch(userAgentFutureProvider);
    return Scaffold(
        body: Center(
      child: userAgent.when(
        data: (userAgent) => Padding(
          padding: EdgeInsets.all(2.w),
          child: Card(
            child: Text('User agent: $userAgent'),
          ),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    ));
  }
}
