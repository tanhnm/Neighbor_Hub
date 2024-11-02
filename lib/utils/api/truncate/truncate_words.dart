String truncateWithWords(String text, int maxWords) {
  final words = text.split(' ');
  if (words.length <= maxWords) return text;
  return '${words.sublist(0, maxWords).join(' ')}...';
}
