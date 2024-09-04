import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

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
    final isInZapshotWebView = ref.watch(isInZapshotWebViewProvider);
    return Scaffold(
        body: Center(
      child: isInZapshotWebView.when(
        data: (isInZapshot) => Padding(
          padding: EdgeInsets.all(2.w),
          child: Card(
            child: Text('Is in Zapshot WebView: $isInZapshot'),
          ),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    ));
  }
}
