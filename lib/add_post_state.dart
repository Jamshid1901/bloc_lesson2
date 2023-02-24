import 'package:bloc_lesson/post_model.dart';

class AddPostState {
  PostModel? postModel;
  bool isImage;

  AddPostState({
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
