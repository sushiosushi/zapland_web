import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:sizer/sizer.dart';
import '../helpers/urlLauncher.dart';
import 'sizer.dart';

Widget floatingAppButton(BuildContext context) {
  var width = SizerUtil.getWebResponsiveSize(
      smallSize: 90.w, mediumSize: 65.w, largeSize: 590);

  return GestureDetector(
      onTap: () {
        launchUrlFromWeb(Uri.parse(dotenv.get('APP_STORE_LINK')));
      },
      child: GlassContainer(
          blur: 100,
          // color: Colors.white.withOpacity(0.9),
          width: width,
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 90 / 22,
            child: Padding(
              padding: EdgeInsets.all(2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/zapshot/icon.png',
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: 0.6,
                            child: Text(
                              'App Store',
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.2.w),
                            child: Text(
                              'Zapshot - Make Friends Closer',
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                      fontSize: CupertinoTheme.of(context)
                                              .textTheme
                                              .textStyle
                                              .fontSize! *
                                          1.2,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Opacity(
                            opacity: 0.6,
                            child: Text(
                              'Social Networking',
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xff017AFF),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Get',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          )));
}
