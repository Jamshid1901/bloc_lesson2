class AddPostState {
  String image;
  String name;
  String category;
  String desc;
  bool isImage;

  AddPostState({
    this.image = "",
    this.isImage = false,
    this.name = "",
    this.category = "",
    this.desc = "",
  });

  AddPostState copyWith(
      {bool? isImage,
      String? image,
      String? name,
      String? category,
      String? desc}) {
    return AddPostState(
        isImage: isImage ?? this.isImage,
        image: image ?? this.image,
        name: name ?? this.name,
        category: category ?? this.category,
        desc: desc ?? this.desc);
  }
}
