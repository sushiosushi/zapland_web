import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zapland_web/pages/codeGenerator.dart';

import '../helpers/CustomizeFloatingLocation.dart';
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
    print('isInZapshotWebView: $isInZapshotWebView');

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
        data: (isInZapshot) => floatingAppButton(context),
        loading: () => null,
        error: (error, stackTrace) => Text('Error: $error'),
      ),
      floatingActionButtonLocation: CustomizeFloatingLocation(
          FloatingActionButtonLocation.centerFloat, 0, -20),
    );
  }
}
