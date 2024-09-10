import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlFromWeb(Uri url) async {
  if (await canLaunchUrl(url)) {
    launchUrl(url,
        mode: LaunchMode.platformDefault, webOnlyWindowName: '_self');
  } else {
    print('Cannot launch url: $url');
  }
}
