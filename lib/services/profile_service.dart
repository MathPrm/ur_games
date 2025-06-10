import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final profile = await _supabase
        .from('profile')
        .select('id, username, email, created_at')
        .eq('id', userId)
        .single();
      
      return profile;
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  Future<void> updateProfile({
    required String username,
    required String email,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      await _supabase
        .from('profile')
        .update({
          'username': username,
          'email': email,
        })
        .eq('id', userId);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}