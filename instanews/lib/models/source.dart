class Source {
  final String name, url, category, language, country;

  Source({this.name, this.url, this.category, this.language, this.country});

  factory Source.fromJSON(Map<String, dynamic> json) {
    return Source(
      name: json["name"],
      url: json['url'],
      category: json["category"],
      language: json["language"],
      country: json["country"]
    );
  }
}