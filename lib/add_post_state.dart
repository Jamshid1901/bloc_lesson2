import 'package:bloc_lesson/post_model.dart';

class AddPostState {
  PostModel? postModel;
  List<PostModel>? listOfPost;
  bool isImage;

  AddPostState({
    this.listOfPost,
    this.postModel,
    this.isImage = false,
  });

  AddPostState copyWith({
    bool? isImage,
    PostModel? postModel,
  }) {
    return AddPostState(
      isImage: isImage ?? this.isImage,
      postModel: postModel ?? PostModel(),
    );
  }
}
