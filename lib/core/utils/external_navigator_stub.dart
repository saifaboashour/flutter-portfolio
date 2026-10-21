/// Non-web stub used by widget tests / VM.
Uri resolveSiteRelative(String relativePath) {
  return Uri.base.resolve(relativePath);
}

bool tryDownload(Uri uri, {String? fileName}) => false;
