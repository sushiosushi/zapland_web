import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sizer/sizer.dart';

import '../helpers/codeGenerator.dart';

Page checkIfValidCode(WidgetRef ref, {String? code}) {
  final ifValid = ref.read(secretCodeProvider.notifier).checkIfValid(code);
  if (ifValid) {
    return MaterialPage(
        child: CodeCheckerPage(
      code: code,
    ));
  }
  return const Redirect('/404');
}

//
class CodeCheckerPage extends ConsumerStatefulWidget {
  final String? code;
  CodeCheckerPage({this.code});

  static const String route = '/codeChecker';

  @override
  CodeCheckerPageState createState() => CodeCheckerPageState();
}

class CodeCheckerPageState extends ConsumerState<CodeCheckerPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
                ref
                    .read(secretCodeProvider.notifier)
                    .checkIfValid(widget.code!)
                    .toString(),
                style: TextStyle(fontSize: 15.w))));
  }
}
