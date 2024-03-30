import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/feature/home/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({required File file, required String uuid});
  Future<List<BlogModel>> getAllBLog();
}

class BlogRemoteDataSourceimpl implements BlogRemoteDataSource {
  final SupabaseClient _supabaseClient;

  BlogRemoteDataSourceimpl({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await _supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File file, required String uuid}) async {
    try {
      await _supabaseClient.storage.from('blogimage').upload(uuid, file);
      log(_supabaseClient.storage.from('blogimage').getPublicUrl(uuid));
      return _supabaseClient.storage.from('blogimage').getPublicUrl(uuid);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBLog() async {
    try {
      final blog =
          await _supabaseClient.from('blogs').select(' * , profiles(name)');
      return blog.map((e) => BlogModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }
}
