import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:logging/logging.dart';

class UrlLauncherService {
  final _log = Logger('UrlLauncherService');

  Future<bool> launch(String url) async {
    _log.finer('Opening Url: $url');

    try {
      if (await launcher.canLaunchUrl(Uri.parse(url))) {
        final result = await launcher.launchUrl(Uri.parse(url));
        return result;
      }
    } on PlatformException catch (ex) {
      _log.severe('Was not able to open url: $url', ex);
      return false;
    }

    return false;
  }
}
