# UR Games

## Présentation du projet

**UR Games** est une application mobile développée en Flutter qui permet à ses utilisateurs de partager et consulter des jeux ou fichiers liés au jeu. Le projet utilise [Supabase](https://supabase.io/) comme backend pour l’authentification et la gestion des données, et propose la sélection de fichiers et d’images à l’aide de `file_picker` et `image_picker`.

Cette application vise à offrir une expérience utilisateur fluide pour la gestion et le partage de ressources ludiques, notamment dans un contexte communautaire ou éducatif.

---

## Installation

### Prérequis

* [Flutter SDK 3.7.2+](https://docs.flutter.dev/get-started/install)
* Un éditeur comme [VS Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio)
* Un compte [Supabase](https://supabase.io/) pour configurer l’authentification et la base de données

### Étapes

1. **Cloner le dépôt**

   ```bash
   git clone https://github.com/votre-utilisateur/ur_games.git
   cd ur_games
   ```
2. **Installer les dépendances**
    flutter pub get

### Post-mortem
**Points négatifs**
* Perte de temps sur la dépendance file_picker
* Impossibilité de tester une version mobile
* manque d'organisation
* maquettes pas correspondantes à un développement sur flutter
**Points positifs**
* Apprentissage de supabase
* Expérimentation de flutter
* Premiers pas dans le développement mobile
