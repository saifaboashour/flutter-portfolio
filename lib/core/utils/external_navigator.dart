import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'external_navigator_stub.dart'
    if (dart.library.html) 'external_navigator_web.dart' as platform;

/// Opens external URLs, mailto links, and site-relative CV downloads.
///
/// Override [launch] in tests to assert destinations without opening a browser.
abstract final class ExternalNavigator {
  static Future<bool> Function(Uri uri, {bool preferDownload}) launch =
      _defaultLaunch;

  @visibleForTesting
  static void reset() {
    launch = _defaultLaunch;
  }

  static Future<bool> openUri(Uri uri) => launch(uri);

  static Future<bool> openMailto(
    String email, {
    String? subject,
  }) {
    final params = <String, String>{
      if (subject != null && subject.isNotEmpty) 'subject': subject,
    };
    final query = params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: query.isEmpty ? null : query,
    );
    return openUri(uri);
  }

  /// Resolves [relativePath] against the document `<base href>`.
  /// Correct for GitHub Pages project sites such as `/flutter-portfolio/`.
  static Future<bool> openSiteRelative(
    String relativePath, {
    bool preferDownload = false,
  }) {
    final resolved = platform.resolveSiteRelative(relativePath);
    return launch(resolved, preferDownload: preferDownload);
  }

  static Future<bool> _defaultLaunch(
    Uri uri, {
    bool preferDownload = false,
  }) async {
    if (preferDownload && kIsWeb) {
      if (platform.tryDownload(uri)) {
        return true;
      }
    }

    if (await canLaunchUrl(uri)) {
      return launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
    }
    return false;
  }
}
