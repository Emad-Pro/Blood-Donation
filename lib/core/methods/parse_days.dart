List<String> parseDays(String? days) {
  if (days == null || days.isEmpty) {
    return [];
  }
  try {
    return days
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((e) => e.trim())
        .toList();
  } catch (e) {
    print('Error parsing days: $e');
    return [];
  }
}
