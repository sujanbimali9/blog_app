import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/feature/home/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog(
      {required File file,
      required String title,
      required String content,
      required String userId,
      required List<String> topics});
}
