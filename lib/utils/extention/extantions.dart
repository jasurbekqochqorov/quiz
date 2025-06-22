extension ForString on String {
  bool isDigitMy() {
    for (int i = 0; i < length; i++) {
      if ("123456789".contains(this[i])) {
        return true;
      }
    }
    return false;
  }

  bool isAlphaMy() {
    for (int i = 0; i < length; i++) {
      if ("qazxswedcvfrtgbnhyujmkilop".contains(this[i])) {
        return true;
      } else if ("AQZXSWEDCVFRTGBNHYUJMKILOP".contains(this[i])) {}
    }
    return false;
  }
}

String parseHtml(String htmlString) {
  return htmlString
      .replaceAll(RegExp(r"<[^>]*>"), '')
      .replaceAll('&nbsp;', ' ')
      .trim();
}
String decodeHtml(String html) {
  return html
      .replaceAll('&ldquo;', '“')
      .replaceAll('&rdquo;', '”')
      .replaceAll('&#39;', "'")
      .replaceAll('&rsquo;', '’')
      .replaceAll('&diams;', '♦');
}