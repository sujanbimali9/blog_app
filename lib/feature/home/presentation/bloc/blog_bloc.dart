import 'dart:io';
import 'package:blog_app/feature/home/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
  }
  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final result = await uploadBlog(
      UploadBlogParms(
        userId: event.userId,
        title: event.title,
        content: event.content,
        file: event.file,
        topics: event.topics,
      ),
    );
    result.fold(
        (l) => emit(BlogFailure(error: l.error)), (r) => emit(BlogSuccess()));
  }
}
