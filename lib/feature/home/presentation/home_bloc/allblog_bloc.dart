import 'dart:io';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feature/home/domain/entities/blog.dart';
import 'package:blog_app/feature/home/domain/usecases/get_all_blog.dart';
import 'package:blog_app/feature/home/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'allblog_event.dart';
part 'allblog_state.dart';

class AllBlogBloc extends Bloc<AllBlogEvent, AllBlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlog _getAllBlog;

  AllBlogBloc(UploadBlog uploadBlog, GetAllBlog getAllBlog)
      : _uploadBlog = uploadBlog,
        _getAllBlog = getAllBlog,
        super(BlogInitial()) {
    on<AllBlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<AllBlog>(_allBlog);
  }
  void _onBlogUpload(BlogUpload event, Emitter<AllBlogState> emit) async {
    final result = await _uploadBlog(
      UploadBlogParms(
        userId: event.userId,
        title: event.title,
        content: event.content,
        file: event.file,
        topics: event.topics,
      ),
    );
    result.fold(
      (l) => emit(BlogFailure(error: l.error)),
      (r) => emit(
        BlogSuccess(),
      ),
    );
  }

  void _allBlog(AllBlog event, Emitter<AllBlogState> emit) async {
    final result = await _getAllBlog(NoParms());
    result.fold(
      (l) => emit(
        BlogFailure(error: l.error),
      ),
      (r) => emit(
        BlogDisplaySuccess(blog: r),
      ),
    );
  }
}
