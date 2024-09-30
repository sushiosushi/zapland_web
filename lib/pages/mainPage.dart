import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zapland_web/pages/codeGenerator.dart';

import '../helpers/CustomizeFloatingLocation.dart';
import '../helpers/firebaseAnalytics.dart';
import '../helpers/floatingAppButton.dart';
import '../helpers/userAgent.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    final isInZapshotWebView = ref.watch(isInZapshotWebViewProvider);
    var analytics = ref.watch(analyticsRepository);

    isInZapshotWebView.when(
      data: (isInZapshot) {
        analytics.logEvent(
            name: 'is_in_zapshot_webview',
            parameters: {'is_in_zapshot': isInZapshot.toString()});
      },
      loading: () => false,
      error: (error, stackTrace) => false,
    );

    return Scaffold(
      appBar: AppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/roblox/roblox_icon.png', height: 35),
        const SizedBox(width: 5),
        const Text('Free UGC'),
        const SizedBox(width: 8),
        Image.asset('assets/zapshot/logo_only.png', height: 26),
      ])),
      body: const CodeGeneratorPage(),
      floatingActionButton: isInZapshotWebView.when(
        data: (isInZapshot) => isInZapshot ? null : floatingAppButton(context),
        loading: () => null,
        error: (error, stackTrace) => Text('Error: $error'),
      ),
      floatingActionButtonLocation: CustomizeFloatingLocation(
          FloatingActionButtonLocation.centerFloat, 0, -20),
    );
  }
}
