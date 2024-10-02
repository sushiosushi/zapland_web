import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:sizer/sizer.dart';

import '../helpers/codeGenerator.dart';
import '../helpers/firebaseAnalytics.dart';
import '../helpers/toast.dart';
import '../helpers/urlLauncher.dart';
import '../helpers/userAgent.dart';

class CodeGeneratorPage extends ConsumerStatefulWidget {
  const CodeGeneratorPage({super.key});

  @override
  CodeGeneratorPageState createState() => CodeGeneratorPageState();
}

class CodeGeneratorPageState extends ConsumerState<CodeGeneratorPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final remainingSec = ref.watch(remainingSecProvider);
    final isInZapshotWebView = ref.watch(isInZapshotWebViewProvider);

    final secretCode = ref.watch(secretCodeProvider);
    final fakeSecretCode = ref.watch(fakeSecretCodeProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    var safeWidth = SizerUtil.getWebResponsiveSize(
        smallSize: 95.w, mediumSize: 60.w, largeSize: 500);

    var analytics = ref.watch(analyticsRepository);

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: safeWidth * 0.25,
                  height: safeWidth * 0.25,
                  // round corner
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Theme.of(context).disabledColor,
                  ),

                  child: Stack(fit: StackFit.expand, children: [
                    Image.network(
                      'https://tr.rbxcdn.com/e165aa0c8736732bc206818ff49072d7/700/700/Hat/Png',
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/roblox/Roblox_Limited_U_Label.png',
                        width: safeWidth * 0.2,
                      ),
                    ),
                  ]),
                ),
                SizedBox(width: safeWidth * 0.05),
                AnimatedRadialGauge(
                  duration: const Duration(seconds: 1),
                  curve: Curves.elasticOut,
                  radius: safeWidth * 0.2,
                  value: remainingSec.toDouble(),
                  axis: GaugeAxis(
                    min: 0,
                    max: MAX_SEC.toDouble(),
                    degrees: 300,
                    style: const GaugeAxisStyle(
                      background: Colors.transparent,
                      thickness: 20,
                      segmentSpacing: 4,
                    ),
                    progressBar: const GaugeProgressBar.rounded(
                        // color: Color(0xFFB4C2F8),
                        gradient: GaugeAxisGradient(colors: [
                      Color(0xFF3CFF8A),
                      Color(0xFF3CADFF),
                    ], colorStops: [
                      0.3,
                      0.7,
                    ])),
                    segments: [
                      GaugeSegment(
                        from: 0,
                        to: MAX_SEC.toDouble() / 3,
                        color: const Color(0xFFDFE2EC),
                        cornerRadius: const Radius.circular(10),
                      ),
                      GaugeSegment(
                        from: MAX_SEC.toDouble() / 3,
                        to: MAX_SEC.toDouble() / 3 * 2,
                        color: const Color(0xFFDFE2EC),
                        cornerRadius: const Radius.circular(10),
                      ),
                      GaugeSegment(
                        from: MAX_SEC.toDouble() / 3 * 2,
                        to: MAX_SEC.toDouble(),
                        color: const Color(0xFFDFE2EC),
                        cornerRadius: const Radius.circular(10),
                      ),
                    ],
                  ),
                  builder: (context, child, value) => Center(
                    child: Text(
                      remainingSec.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: safeWidth * 0.15,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(width: safeWidth * 0.05),
                Container(
                  width: safeWidth * 0.25,
                  height: safeWidth * 0.25,
                  // round corner
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Theme.of(context).disabledColor,
                  ),

                  child: Stack(fit: StackFit.expand, children: [
                    Image.network(
                      'https://tr.rbxcdn.com/e6bc625e982b8b79fcb9f2d5fd20f66b/700/700/Hat/Png',
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/roblox/Roblox_Limited_U_Label.png',
                        width: safeWidth * 0.2,
                      ),
                    ),
                  ]),
                ),
              ]),
          const SizedBox(height: 20),
          Text(
            'SECRET CODE',
            style: TextStyle(
              fontSize: safeWidth * 0.06,
            ),
          ),
          const SizedBox(height: 20 / 2),
          isInZapshotWebView.when(
            data: (isInZapshot) => isInZapshot
                ? ElevatedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: secretCode,
                      ));
                      showToastification(context, 'Copied to Clipboard');
                      analytics.logEvent(name: 'secret_code_button_valid');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        safeWidth * 0.7,
                        safeWidth * 0.7 / 60 * 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                    ),
                    icon: Icon(Icons.copy_rounded, size: 6.w),
                    label: Text(secretCode,
                        style: TextStyle(
                          fontSize: safeWidth * 0.08,
                        )),
                  )
                : Column(children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: dotenv.get('APP_STORE_LINK')));
                        showToastificationMildError(
                            context, "Let's Install Zapshot first!",
                            description: 'to get the secret code');
                        analytics.logEvent(name: 'secret_code_button_invalid');
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          safeWidth * 0.7,
                          safeWidth * 0.7 / 60 * 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: Icon(
                        Icons.copy_rounded,
                        size: safeWidth * 0.08,
                      ),
                      label: ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: safeWidth * 0.014,
                            sigmaY: safeWidth * 0.014,
                          ),
                          child: Text(fakeSecretCode,
                              style: TextStyle(
                                fontSize: safeWidth * 0.08,
                              ))),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                        onPressed: () {
                          launchUrlFromWeb(
                              Uri.parse(dotenv.get('APP_STORE_LINK')));
                          analytics.logEvent(
                              name: '_install_zapshot_text_button',
                              parameters: {
                                "isInZapshot": isInZapshot.toString()
                              });
                        },
                        child: Text('* Please Install Zapshot to get the CODE.',
                            style: TextStyle(
                              fontSize: safeWidth * 0.03,
                              color: Colors.red,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                              decorationThickness: 2,
                            ))),
                    const SizedBox(height: 10),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Material(
                            child: Ink.image(
                          fit: BoxFit.contain,
                          width: safeWidth * 0.5,
                          height: safeWidth * 0.5 / 50 * 11,
                          image: isDark
                              ? const AssetImage('assets/zapshot/badge.png')
                              : const AssetImage('assets/zapshot/badge.png'),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                launchUrlFromWeb(
                                    Uri.parse(dotenv.get('APP_STORE_LINK')));

                                analytics.logEvent(
                                    name: '_view_in_zapshot_button',
                                    parameters: {
                                      "isInZapshot": isInZapshot.toString()
                                    });
                              },
                              splashColor:
                                  const Color(0xff000000).withAlpha(30)),
                        ))),
                  ]),
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => const Text('Error'),
          ),
          Divider(
            height: 20 * 2,
            thickness: 2,
            indent: (100.w - safeWidth) / 2,
            endIndent: (100.w - safeWidth) / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  child: Ink.image(
                    width: safeWidth * 0.18,
                    height: safeWidth * 0.18,
                    image: const AssetImage('assets/roblox/icon.png'),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          launchUrlFromWeb(Uri.parse(
                              'https://www.roblox.com/games/16273429138/'));

                          analytics.logEvent(
                              name: 'roblox_button_l', parameters: {});
                        },
                        splashColor: const Color(0xff000000).withAlpha(30)),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                      child: Ink.image(
                    fit: BoxFit.fill,
                    width: safeWidth * 0.4,
                    height: safeWidth * 0.4 / 36 * 16,
                    image:

                        // get if darkmode or lightmode
                        isDark
                            ? const AssetImage('assets/roblox/badge_white.png')
                            : const AssetImage('assets/roblox/badge_black.png'),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          launchUrlFromWeb(Uri.parse(
                              'https://www.roblox.com/games/16273429138/'));
                          analytics.logEvent(
                              name: 'roblox_button_r', parameters: {});
                        },
                        splashColor: const Color(0xff000000).withAlpha(30)),
                  ))),
            ],
          ),
          const SizedBox(height: 20),
          Image.asset(
            // 'assets/robloxMeme/${Random().nextInt(6) + 1}.gif',
            'assets/robloxMeme/1.gif',
            fit: BoxFit.contain,
            width: safeWidth * 0.9,
            height: safeWidth * 0.9 / 16 * 9,
          ),
          const SizedBox(height: 150),
        ],
      ),
    ));
  }
}
