// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_n_crown_dream_3343/cubit/favourite_audio_cubit.dart';
import 'package:just_audio/just_audio.dart';

class SoundSettingsScreen extends StatelessWidget {
  SoundSettingsScreen({super.key});

  final List<AudioModel> _audios = [
    AudioModel(
      title: "Sounds of water",
      assetPath: "assets/music/altantic_loop.mp3",
    ),
    AudioModel(title: "Bells", assetPath: "assets/music/bells.wav"),
    AudioModel(title: "Summer mood", assetPath: "assets/music/summer_mood.wav"),
    AudioModel(
      title: "Thunderstorm",
      assetPath: "assets/music/thunder_storm.wav",
    ),
    AudioModel(title: "Meditation", assetPath: "assets/music/meditation.wav"),
    AudioModel(
      title: "Life on the pond",
      assetPath: "assets/music/life_of_pond.wav",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Relaxing audios',
              style: TextStyle(
                color: Color(0xFFAD7942),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: _audios.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final audio = _audios[index];
                    final isFav = context
                        .watch<FavoriteAudioCubit>()
                        .isFavorite(audio.title);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlayerScreen(audio: audio),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color:
                                  isFav
                                      ? Colors.black
                                      : const Color(0xFF5F472C),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/crown/2.png",
                                  height: 48,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            audio.title,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.65),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerScreen extends StatefulWidget {
  final AudioModel audio;
  const PlayerScreen({super.key, required this.audio});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final AudioPlayer _player;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _player.setAsset(widget.audio.assetPath);
    _player.play();
    setState(() => _isPlaying = true);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoriteAudioCubit>().isFavorite(
      widget.audio.title,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Color(0xFFAD7942)),
        title: const Text(
          'Playing now',
          style: TextStyle(
            color: Color(0xFFAD7942),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.amber : Color(0xFFAD7942),
            ),
            onPressed: () {
              context.read<FavoriteAudioCubit>().toggleFavorite(
                widget.audio.title,
              );
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Container(
            width: 230,
            height: 230,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFAD7942), width: 1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Image.asset(
              "assets/images/crown/2.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.audio.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          StreamBuilder<Duration>(
            stream: _player.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              final duration = _player.duration ?? Duration.zero;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(position),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          _formatDuration(duration),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: position.inSeconds.toDouble().clamp(
                      0.0,
                      duration.inSeconds.toDouble(),
                    ),
                    max: duration.inSeconds.toDouble(),
                    onChanged:
                        (val) => _player.seek(Duration(seconds: val.toInt())),
                    activeColor: const Color(0xFFAD7942),
                    inactiveColor: Colors.white24,
                  ),
                ],
              );
            },
          ),

          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              setState(() {
                _isPlaying ? _player.pause() : _player.play();
                _isPlaying = !_isPlaying;
              });
            },
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
