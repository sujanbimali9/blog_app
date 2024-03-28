import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/feature/auth/data/model/usermodel.dart';
import 'package:supabase/supabase.dart';

abstract interface class AuthRemoteDataSource {
  final Session? currentUserSession;

  AuthRemoteDataSource({required this.currentUserSession});
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email, required String name, required String password});
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImplement implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImplement({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from("profiles")
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first)
            .copyWith(email: currentUserSession?.user.email);
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse resposne = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (resposne.user != null) {
        return UserModel.fromJson(resposne.user!.toJson())
            .copyWith(email: currentUserSession?.user.email);
      } else {
        throw ServerException(message: "user is null");
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final AuthResponse resposne = await supabaseClient.auth
          .signUp(email: email, password: password, data: {"name": name});
      if (resposne.user != null) {
        return UserModel.fromJson(resposne.user!.toJson())
            .copyWith(email: currentUserSession?.user.email);
      } else {
        throw ServerException(message: "user is null");
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
