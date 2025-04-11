import 'package:flutter_bloc/flutter_bloc.dart';

class AudioModel {
  final String title;
  final String assetPath;

  AudioModel({required this.title, required this.assetPath});
}


class FavoriteAudioCubit extends Cubit<Set<String>> {
  FavoriteAudioCubit() : super({});

  void toggleFavorite(String title) {
    final updated = Set<String>.from(state);
    if (updated.contains(title)) {
      updated.remove(title);
    } else {
      updated.add(title);
    }
    emit(updated);
  }

  bool isFavorite(String title) => state.contains(title);
}
