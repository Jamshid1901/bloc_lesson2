import 'dart:io';

import 'package:bloc_lesson/add_post_cubit.dart';
import 'package:bloc_lesson/add_post_state.dart';
import 'package:bloc_lesson/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  GlobalKey<FormState> validateKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final category = TextEditingController();
  final desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: validateKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            InkWell(
              onTap: () {
                context.read<AddPostCubit>().getPhoto();
              },
              child: BlocConsumer<AddPostCubit, AddPostState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: state.image.isNotEmpty
                            ? BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(
                                      File(state.image),
                                    ),
                                    fit: BoxFit.contain),
                              )
                            : const BoxDecoration(
                                color: Colors.lightBlueAccent,
                              ),
                      ),
                      state.isImage
                          ? const Text("Rasmi tanlash majburiy")
                          : const SizedBox.shrink()
                    ],
                  );
                },
                listener: (context, state) {
                  if (state.image.isNotEmpty && state.name.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<AddPostCubit>(context),
                                  child: PostPage(),
                                )));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: "Nomi"),
                validator: (s) {
                  if (s?.isEmpty ?? true) {
                    return "Buni toldirish majburiy";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: category,
                validator: (s) {
                  if (s?.isEmpty ?? true) {
                    return "Buni toldirish majburiy";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(labelText: "Kategoriya"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              child: TextFormField(
                controller: desc,
                validator: (s) {
                  if (s?.isEmpty ?? true) {
                    return "Buni toldirish majburiy";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(labelText: "Malumoti"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (validateKey.currentState?.validate() ?? false) {
                    context
                        .read<AddPostCubit>()
                        .addPost(name.text, category.text, desc.text);
                  }
                },
                child: Text("Davom Etish")),
            BlocBuilder<AddPostCubit, AddPostState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text("Name : ${state.name}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text("Category : ${state.category}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text("Desc :  ${state.desc}"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
