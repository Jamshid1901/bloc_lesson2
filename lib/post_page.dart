import 'dart:io';

import 'package:bloc_lesson/add_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_post_state.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AddPostCubit, AddPostState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: (state.postModel?.image.isNotEmpty ?? false)
                    ? BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(
                              File(state.postModel?.image ?? ""),
                            ),
                            fit: BoxFit.contain),
                      )
                    : const BoxDecoration(
                        color: Colors.lightBlueAccent,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text("Name : ${state.postModel?.name ?? ""}"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text("Category : ${state.postModel?.category ?? ""}"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text("Desc :  ${state.postModel?.desc ?? ""}"),
              ),
            ],
          );
        },
      ),
    );
  }
}
