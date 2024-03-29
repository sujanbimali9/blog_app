import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/feature/home/data/datasource/blog_remote_data_source.dart';
import 'package:blog_app/feature/home/data/model/blog_model.dart';
import 'package:blog_app/feature/home/domain/entities/blog.dart';
import 'package:blog_app/feature/home/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImp implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImp({required this.blogRemoteDataSource});
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File file,
      required String title,
      required String content,
      required String userId,
      required List<String> topics}) async {
    try {
      final uuid = const Uuid().v1();
      final String imageurl =
          await blogRemoteDataSource.uploadBlogImage(file: file, uuid: uuid);
      BlogModel blogModel = BlogModel(
        uuid,
        title,
        content,
        imageurl,
        userId,
        topics,
        DateTime.now(),
      );
      final model = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(model);
    } on ServerException catch (e) {
      return left(Failure(error: e.message));
    }
  }
}
