part of 'allblog_bloc.dart';

@immutable
sealed class AllBlogState {}

final class BlogInitial extends AllBlogState {}

final class BlogSuccess extends AllBlogState {}

final class BlogLoading extends AllBlogState {}

final class BlogDisplaySuccess extends AllBlogState {
  final List<Blog> blog;

  BlogDisplaySuccess({required this.blog});
}

final class GetBlogSuccess extends AllBlogState {
  final Blog blog;
  GetBlogSuccess({required this.blog});
}

final class BlogFailure extends AllBlogState {
  final String error;
  BlogFailure({required this.error});
}
