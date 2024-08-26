import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../helpers/codeGenerator.dart';

class NotFoundPage extends ConsumerStatefulWidget {
  static const String route = '/404';

  const NotFoundPage({super.key});

  @override
  NotFoundPageState createState() => NotFoundPageState();
}

class NotFoundPageState extends ConsumerState<NotFoundPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text('404', style: TextStyle(fontSize: 15.w))));
  }
}
