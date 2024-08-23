import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../helpers/codeGenerator.dart';

class TestPage extends ConsumerStatefulWidget {
  final String? code;
  TestPage({this.code});

  static const String route = '/404';

  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends ConsumerState<TestPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text('Test', style: TextStyle(fontSize: 15.w))));
  }
}
