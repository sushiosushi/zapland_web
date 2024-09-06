import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:sizer/sizer.dart';

import '../helpers/codeGenerator.dart';
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

    isInZapshotWebView.when(
      data: (isInZapshot) {
        if (!isInZapshot && kIsWeb) {
          // <meta name="apple-itunes-app" content="app-id=1529511175" />
          MetaSEO meta = MetaSEO();
          meta.nameContent(
              name: 'apple-itunes-app', content: 'app-id=1529511175');
        }
      },
      loading: () => null,
      error: (error, stackTrace) => null,
    );

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5.h),
          AnimatedRadialGauge(
            duration: const Duration(seconds: 1),
            curve: Curves.elasticOut,
            radius: 25.w,
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
                  fontSize: 19.w,
                ),
                maxLines: 1,
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            'SECRET CODE',
            style: TextStyle(
              fontSize: 5.w,
            ),
          ),
          SizedBox(height: 1.h),
          isInZapshotWebView.when(
            data: (isInZapshot) => isInZapshot
                ? ElevatedButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: secretCode,
                      ));
                      showToastification(context, 'Copied to Clipboard');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(70.w, 15.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                    ),
                    icon: Icon(Icons.copy_rounded, size: 7.w),
                    label: Text(secretCode,
                        style: TextStyle(
                          fontSize: 7.w,
                        )),
                  )
                : Column(children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(
                            text: 'https://www.zapshot.me'));
                        showToastificationMildError(
                            context, "Let's Install Zapshot first!",
                            description: 'to get the secret code');
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(70.w, 15.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                      ),
                      icon: Icon(Icons.copy_rounded, size: 7.w),
                      label: ImageFiltered(
                          imageFilter:
                              ImageFilter.blur(sigmaX: 1.w, sigmaY: 1.w),
                          child: Text(fakeSecretCode,
                              style: TextStyle(
                                fontSize: 7.w,
                              ))),
                    ),
                    SizedBox(height: 1.h),
                    TextButton(
                        onPressed: () {
                          launchUrlFromWeb(Uri.parse('https://www.zapshot.me'));
                        },
                        child: Text('* Please Install Zapshot to get the CODE.',
                            style: TextStyle(
                              fontSize: 3.w,
                              color: Colors.red,
                            ))),
                  ]),
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => const Text('Error'),
          ),
          Divider(
            height: 5.h,
            thickness: 2,
            indent: 10.w,
            endIndent: 10.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3.w),
                child: Material(
                  child: Ink.image(
                    width: 15.w,
                    height: 15.w,
                    image: const AssetImage('assets/roblox/icon.png'),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => launchUrlFromWeb(Uri.parse(
                            'https://www.roblox.com/games/16273429138/')),
                        splashColor: const Color(0xff000000).withAlpha(30)),
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              ClipRRect(
                  borderRadius: BorderRadius.circular(3.w),
                  child: Material(
                      child: Ink.image(
                    fit: BoxFit.fill,
                    width: 36.w,
                    height: 16.w,
                    image:

                        // get if darkmode or lightmode
                        isDark
                            ? const AssetImage('assets/roblox/badge_white.png')
                            : const AssetImage('assets/roblox/badge_black.png'),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () => launchUrlFromWeb(Uri.parse(
                            'https://www.roblox.com/games/16273429138/')),
                        splashColor: const Color(0xff000000).withAlpha(30)),
                  ))),
            ],
          ),
        ],
      ),
    ));
  }
}
