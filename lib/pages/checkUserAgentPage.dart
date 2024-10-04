import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../helpers/cookies.dart';
import '../helpers/userAgent.dart';

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
    // final cookie = document.cookie!;
    // final entity = cookie.split("; ").map((item) {
    //   final split = item.split("=");
    //   return MapEntry(split[0], split[1]);
    // });
    // final cookieMap = Map.fromEntries(entity);
    // document.cookie = "key=value";

    final isInZapshotWebView = ref.watch(isInZapshotWebViewProvider);
    final viewingTimes = ref.watch(viewingTimesProvider);
    return Scaffold(
        body: Center(
            child: Padding(
                padding: EdgeInsets.all(2.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    viewingTimes.when(
                      data: (viewingTimes) => Text(
                        '👀 Viewing Times: $viewingTimes',
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) => Text('Error: $error'),
                    ),
                    Divider(
                      height: 3.h,
                      indent: 10.w,
                      endIndent: 10.w,
                    ),
                    isInZapshotWebView.when(
                      data: (isInZapshot) => Text(
                        '⚡ Is in Zapshot WebView: $isInZapshot',
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) => Text('Error: $error'),
                    ),
                  ],
                ))));
  }
}
