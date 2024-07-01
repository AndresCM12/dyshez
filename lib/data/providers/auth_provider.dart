import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  final supabaseClient = Supabase.instance.client;

  AuthProvider();

  Future<Session?> getUserSession() async {
    Session? session = supabaseClient.auth.currentSession;
    return session;
  }
}
