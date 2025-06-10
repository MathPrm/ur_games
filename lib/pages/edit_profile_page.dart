import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../file_stub.dart'
    if (dart.library.io) 'file_io.dart';

class EditProfilePage {
  final supabase = Supabase.instance.client;

  // Upload l'image et retourne l'URL publique (mobile ou web)
  Future<String> uploadProfileImage({
    dynamic file, // Utilise dynamic pour accepter File sur mobile/desktop
    Uint8List? bytes,
    required String fileName,
  }) async {
    final userId = supabase.auth.currentUser!.id;
    final fileExt = fileName.split('.').last;
    final filePath = 'avatars/$userId.$fileExt';

    try {
      if (kIsWeb) {
        if (bytes == null) throw 'Aucun fichier sélectionné (web)';
        await supabase.storage
            .from('avatars')
            .uploadBinary(filePath, bytes, fileOptions: const FileOptions(upsert: true));
      } else {
        if (file == null) throw 'Aucun fichier sélectionné (mobile)';
        await supabase.storage
            .from('avatars')
            .upload(filePath, file, fileOptions: const FileOptions(upsert: true));
      }

      final publicUrl = supabase.storage.from('avatars').getPublicUrl(filePath);

      await supabase
          .from('user')
          .update({'avatar_url': publicUrl})
          .eq('id', userId);

      return publicUrl;
    } catch (e) {
      throw 'Erreur lors de l\'upload de l\'image: $e';
    }
  }

  // Méthode pour récupérer le profil
  Future<Map<String, dynamic>> getProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final response = await supabase
        .from('user')
        .select()
        .eq('id', userId)
        .single();
    return response;
  }

  // Méthode pour update le profil
  Future<void> updateProfile({String? username, String? email}) async {
    final userId = supabase.auth.currentUser!.id;
    await supabase.from('user').update({
      if (username != null) 'username': username,
      if (email != null) 'email': email,
    }).eq('id', userId);
  }
}