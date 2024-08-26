import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zapland_web/pages/codeChecker.dart';
import 'package:zapland_web/pages/codeGenerator.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Routemaster.of(context)
                .push('${CodeCheckerPage.route}?code=Test'),
            icon: const Icon(Icons.qr_code)),
        title: const Text('Free UGC Secret Code'),
      ),
      body: const CodeGeneratorPage(),
    );
  }
}
