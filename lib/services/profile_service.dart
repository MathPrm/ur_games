import 'dart:io';

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

  Future<String> uploadProfileImage(File imageFile) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Générer un nom de fichier unique
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath = 'profiles/$userId/$fileName';

      // Upload du fichier
      await _supabase.storage
          .from('avatars')  // Le nom de votre bucket Supabase Storage
          .upload(filePath, imageFile);

      // Récupérer l'URL publique
      final imageUrl = _supabase.storage
          .from('avatars')
          .getPublicUrl(filePath);

      // Mettre à jour le profil avec l'URL de l'image
      await _supabase
          .from('profile')
          .update({'avatar_url': imageUrl})
          .eq('id', userId);

      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
