import 'package:web/web.dart' as web;

/// Resolve a relative path against the document base URI (`<base href>`).
Uri resolveSiteRelative(String relativePath) {
  final base = web.document.baseURI;
  return Uri.parse(base).resolve(relativePath);
}

/// Trigger a browser download / open for same-origin static files.
bool tryDownload(Uri uri, {String? fileName}) {
  final href = uri.toString();
  final name = fileName ??
      (uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'download');

  final anchor = web.HTMLAnchorElement()
    ..href = href
    ..download = name
    ..target = '_blank'
    ..rel = 'noopener noreferrer';

  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();
  return true;
}
