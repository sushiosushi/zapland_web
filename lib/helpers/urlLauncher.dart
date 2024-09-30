import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlFromWeb(Uri url) async {
  if (await canLaunch(url.toString())) {
    launch(url.toString(),
        forceSafariVC: false,
        forceWebView: false,
        enableJavaScript: true,
        enableDomStorage: true,
        universalLinksOnly: false,
        headers: <String, String>{},
        webOnlyWindowName: '_blank');
    // mode: LaunchMode.platformDefault, webOnlyWindowName: '_blank');
  } else {
    print('Cannot launch url: $url');
  }
}
