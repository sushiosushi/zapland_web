import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sizer/sizer.dart';
import '../helpers/urlLauncher.dart';

Widget floatingAppButton(BuildContext context) {
  return GestureDetector(
      onTap: () {
        launchUrlFromWeb(Uri.parse(dotenv.get('APP_STORE_LINK')));
      },
      child: GlassContainer(
        blur: 100,
        height: 10.h,
        width: 90.w,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: EdgeInsets.all(3.w),
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
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 1.w),
                              child: Opacity(
                                opacity: 0.5,
                                child: Icon(FontAwesome.app_store_ios_brand,
                                    size: 1.8.h),
                              ),
                            ),
                            Opacity(
                              opacity: 0.5,
                              child: Text(
                                'App Store',
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(fontSize: 10.sp),
                              ),
                            ),
                          ]),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.3.h),
                        child: Text(
                          'Zapshot - Make Friends Closer',
                          style: CupertinoTheme.of(context).textTheme.textStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          'Social Networking',
                          style: CupertinoTheme.of(context)
                              .textTheme
                              .textStyle
                              .copyWith(fontSize: 10.sp),
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
                  style:
                      CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            color: Colors.white,
                          ),
                ),
              ),
            ],
          ),
        ),
      ));
}
