import 'package:bloc_lesson/add_post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostState());
  final ImagePicker _picker = ImagePicker();

  addPost(String name, String category, String desc) {
    if (state.image.isNotEmpty) {
      emit(state.copyWith(name: name, category: category, desc: desc));
    } else {
      emit(state.copyWith(isImage: true));
    }
  }

  getPhoto() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image?.path.isNotEmpty ?? false) {
      emit(state.copyWith(image: image?.path ?? "", isImage: false));
    }
  }
}
