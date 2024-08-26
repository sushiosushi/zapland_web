import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sizer/sizer.dart';
import 'package:zapland_web/pages/codeChecker.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'helpers/theme.dart';
import 'pages/mainPage.dart';
import 'pages/notFound.dart';

Future<void> main() async {
  // usePathUrlStrategy(); //TODO: Remove # from URL
  await dotenv.load(fileName: 'env');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    // final ThemeMode themeMode = ref.watch(themeModeProvider);

    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        routerDelegate: RoutemasterDelegate(
          routesBuilder: (context) => RouteMap(
            routes: {
              '/': (routeData) => const MaterialPage(child: MainPage()),
              CodeCheckerPage.route: (routeData) => checkIfValidCode(ref,
                  code: routeData.queryParameters['code']),
              NotFoundPage.route: (routeData) =>
                  const MaterialPage(child: NotFoundPage()),
            },
            // onUnknownRoute: (route) {
            //   return const MaterialPage(child: NotFoundPage());
            // },
          ),
        ),
        routeInformationParser: const RoutemasterParser(),
      );
    });
  }
}
