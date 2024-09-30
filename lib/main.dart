import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'helpers/firebaseAnalytics.dart';
import 'helpers/theme.dart';
import 'pages/checkUserAgentPage.dart';
import 'pages/mainPage.dart';
import 'pages/notFound.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  usePathUrlStrategy(); //TODO: Remove # from URL
  await dotenv.load(fileName: 'env');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

    var analytics = ref.watch(analyticsRepository);
    var analyticsObserver = ref.watch(analyticsObserverRepository);

    analytics.logAppOpen();

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
                // CodeCheckerPage.route: (routeData) => checkIfValidCode(ref,
                //     code: routeData.queryParameters['code']),
                CheckUserAgentPage.route: (routeData) =>
                    const MaterialPage(child: CheckUserAgentPage()),
              },
              onUnknownRoute: (route) =>
                  const MaterialPage(child: NotFoundPage())),
        ),
        routeInformationParser: const RoutemasterParser(),
      );
    });
  }
}
