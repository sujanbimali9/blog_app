import 'package:blog_app/feature/home/domain/entities/blog.dart';
import 'package:blog_app/feature/home/domain/usecases/get_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final GetBlog _getBlog;

  BlogBloc(GetBlog getBlog)
      : _getBlog = getBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<GetBlogs>(_blog);
  }
  void _blog(GetBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());

    final result = await _getBlog(UserId(id: event.id));
    result.fold(
      (l) => emit(BlogFailure(error: l.error)),
      (r) => emit(
        GetBlogSuccess(blog: r),
      ),
    );
  }
}
