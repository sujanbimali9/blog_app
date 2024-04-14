part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class GetBlogSuccess extends BlogState {
  final Blog blog;
  GetBlogSuccess({required this.blog});
}

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure({required this.error});
}
