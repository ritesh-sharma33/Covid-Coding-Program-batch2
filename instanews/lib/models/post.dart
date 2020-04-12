class Post {
  final String id, name, author, title, description, url, image, publishedAt;

  Post(
      {this.id,
      this.name,
      this.author,
      this.title,
      this.description,
      this.url,
      this.image,
      this.publishedAt});

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      id: json['source']['id'] != null ? json['source']['id'] : '',
      name: json['source']['name'] != null ? json['source']['name'] : '',
      author: json['author'] != null ? json['author'] : '',
      title: json['title'] != null ? json['title'] : '',
      description: json['description'] != null ? json['description'] : '',
      url: json['url'] != null ? json['url'] : '',
      image: json['urlToImage'] != null ? json['urlToImage'] : '',
      publishedAt: (json['publishedAt'] != null ? json['publishedAt'] : '')
                      .toString()
                      .replaceAll("T", " ")
                      .replaceAll("Z", "")
    );
  }

  static toMap(Post post) {
    return {
      'id': post.id,
      'title': post.title,
      'description': post.description,
      'image': post.image,
      'author': post.author,
      'name': post.name,
      'url': post.url,
      'publishedAt': post.publishedAt
    };
  }
}
