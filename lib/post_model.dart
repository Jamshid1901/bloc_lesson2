class PostModel {
  String image;
  String name;
  String category;
  String desc;

  PostModel({
    this.image = "",
    this.name = "",
    this.category = "",
    this.desc = "",
  });

  PostModel copyWith(
      {String? image, String? name, String? category, String? desc}) {
    return PostModel(
      image: image ?? this.image,
      category: category ?? this.category,
      name: name ?? this.name,
      desc: desc ?? this.desc,
    );
  }
}
