part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class GetBlogs extends BlogEvent {
  final String id;

  GetBlogs({required this.id});
}
