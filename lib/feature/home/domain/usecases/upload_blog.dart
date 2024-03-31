import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feature/home/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<void, UploadBlogParms> {
  final BlogRepository blogRepository;

  UploadBlog({required this.blogRepository});

  @override
  Future<Either<Failure, void>> call(UploadBlogParms parms) async {
    return await blogRepository.uploadBlog(
      file: parms.file,
      title: parms.title,
      content: parms.content,
      userId: parms.userId,
      topics: parms.topics,
    );
  }
}

class UploadBlogParms {
  final String userId;
  final String title;
  final String content;
  final File file;
  final List<String> topics;

  UploadBlogParms(
      {required this.userId,
      required this.title,
      required this.content,
      required this.file,
      required this.topics});
}
