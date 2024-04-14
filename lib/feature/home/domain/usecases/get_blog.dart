import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feature/home/domain/entities/blog.dart';
import 'package:blog_app/feature/home/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlog implements UseCase<Blog, UserId> {
  final BlogRepository repository;

  GetBlog({required this.repository});

  @override
  Future<Either<Failure, Blog>> call(UserId id) {
    return repository.getBlog(id.id);
  }
}

class UserId {
  final String id;
  UserId({required this.id});
}
