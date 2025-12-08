String slugify(String text) {
  return text
      .toLowerCase()
      .trim()
      .replaceAll(RegExp(r'[^\w\s-]'), '') // remove special chars
      .replaceAll(RegExp(r'\s+'), '-') // spaces -> hyphens
      .replaceAll(RegExp(r'-+'), '-'); // collapse multiple hyphens
}
