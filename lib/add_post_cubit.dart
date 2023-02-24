import 'package:bloc_lesson/add_post_state.dart';
import 'package:bloc_lesson/post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostState());
  final ImagePicker _picker = ImagePicker();

  addPost(String name, String category, String desc) {
    if (state.postModel?.image.isNotEmpty ?? false) {
      PostModel newPostModel =
          state.postModel!.copyWith(name: name, category: category, desc: desc);
      emit(state.copyWith(postModel: newPostModel));
    } else {
      emit(state.copyWith(isImage: true));
    }
  }

  getPhoto() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image?.path.isNotEmpty ?? false) {
      PostModel newPostModel = state.postModel?.copyWith(
            image: image?.path ?? "",
          ) ??
          PostModel(image: image?.path ?? "");
      emit(state.copyWith(postModel: newPostModel, isImage: false));
    } else if ((image?.path.isEmpty ?? true) &&
        (state.postModel?.image.isEmpty ?? false)) {
      emit(state.copyWith(isImage: true));
    }
  }
}
