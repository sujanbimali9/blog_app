String calculateReadingTime(String content) {
  final word = content.split(RegExp(r'\s+')).length;
  final time = word ~/ 150;
  return time >= 60 ? '${time ~/ 60} hour' : '$time min';
}
