import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feature/home/domain/entities/blog.dart';
import 'package:blog_app/feature/home/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlog implements UseCase<List<Blog>, NoParms> {
  final BlogRepository repository;

  GetAllBlog({required this.repository});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParms parms) async {
    return repository.getAllBlog();
  }
}
