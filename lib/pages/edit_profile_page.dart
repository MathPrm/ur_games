import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class ProfileService {
  final supabase = Supabase.instance.client;

  // Upload l'image et retourne l'URL publique
  Future<String> uploadProfileImage(File file) async {
    final userId = supabase.auth.currentUser!.id;
    final fileExt = file.path.split('.').last;
    final filePath = 'avatars/$userId.$fileExt';

    try {
      // Upload dans le bucket 'avatars'
      await supabase.storage
          .from('avatars')
          .upload(filePath, file, fileOptions: const FileOptions(upsert: true));

      // Récupère l'URL publique
      final publicUrl = supabase.storage.from('avatars').getPublicUrl(filePath);

      // Met à jour la table user avec l'URL de l'avatar
      await supabase
          .from('user')
          .update({'avatar_url': publicUrl})
          .eq('id', userId);

      return publicUrl;
    } catch (e) {
      throw 'Erreur lors de l\'upload de l\'image: $e';
    }
  }

  // Méthode pour récupérer le profil (déjà présente chez toi)
  Future<Map<String, dynamic>> getProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final response = await supabase
        .from('user')
        .select()
        .eq('id', userId)
        .single();
    return response;
  }

  // Méthode pour update le profil (déjà présente chez toi)
  Future<void> updateProfile({String? username, String? email}) async {
    final userId = supabase.auth.currentUser!.id;
    await supabase.from('user').update({
      if (username != null) 'username': username,
      if (email != null) 'email': email,
    }).eq('id', userId);
  }
}