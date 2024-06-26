import 'package:supabase_flutter/supabase_flutter.dart';

class AuthReponsitory{

  late final  supabase = Supabase.instance.client;
  Future<User?> signIn(String email, String password) async {
  try{
    AuthResponse response = await supabase.auth.signInWithPassword(
        email: email,
        password: password
    );
    return response.user;
  } catch (e) {
    print('Error:$e');
    return null;
  }

  }
  Future<User?> signUp(String email, String password,) async {
    AuthResponse response= await supabase.auth.signUp(
        email: email,
        password: password
    );
    return response.user;
  }
  Future<void> signOut() async {
     await  supabase.auth.signOut();
  }

  Future<void> createUserInfo(String id, String username) async {
    DateTime timestampValue = DateTime.now();
    await supabase
        .from('users').insert({
      'id': id,
      'username': username,
      'created_at':timestampValue.toIso8601String(),
      'updated_at':timestampValue.toIso8601String()
  });
  }
}