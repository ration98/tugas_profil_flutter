// lib/screens/profile_page.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/user_model.dart';
import '../database/database_helper.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _isVideoError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo() async {
    try {
      String videoPath = _dbHelper.getProfileVideoPath(widget.user.username);
      _videoController = VideoPlayerController.asset(videoPath)
        ..initialize().then((_) {
          setState(() {
            _isVideoInitialized = true;
          });
          // Hanya inisialisasi, TIDAK auto play
          // _videoController?.play(); // ← Baris ini dihapus
        }).catchError((error) {
          setState(() {
            _isVideoError = true;
          });
          debugPrint('Error loading video: $error');
        });
    } catch (e) {
      setState(() {
        _isVideoError = true;
      });
      debugPrint('Error loading video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Header with Image
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              child: Column(
                children: [
                  // Profile Image
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF80E5FF),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00BFFF).withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        _dbHelper.getProfileImagePath(widget.user.username),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFB3F0FF),
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: const Color(0xFF0099CC),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.user.namaLengkap,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '@${widget.user.username}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB3F0FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.user.namaLevelUser,
                      style: const TextStyle(
                        color: Color(0xFF0099CC),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Video Player Section
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.video_library,
                        color: Color(0xFF0099CC),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Video Perkenalan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0099CC),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  if (_isVideoInitialized && _videoController != null)
                    Column(
                      children: [
                        // Video Player
                        AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: VideoPlayer(_videoController!),
                        ),
                        const SizedBox(height: 12),
                        // Video Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Tombol Play/Pause
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_videoController!.value.isPlaying) {
                                    _videoController!.pause();
                                  } else {
                                    _videoController!.play();
                                  }
                                });
                              },
                              icon: Icon(
                                _videoController!.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: const Color(0xFF0099CC),
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Progress Indicator
                            Expanded(
                              child: Column(
                                children: [
                                  Slider(
                                    value: _videoController!.value.position.inSeconds.toDouble(),
                                    min: 0,
                                    max: _videoController!.value.duration.inSeconds.toDouble(),
                                    onChanged: (value) {
                                      _videoController!.seekTo(
                                        Duration(seconds: value.toInt()),
                                      );
                                    },
                                    activeColor: const Color(0xFF0099CC),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatDuration(_videoController!.value.position),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      Text(
                                        _formatDuration(_videoController!.value.duration),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Tambahan: Tampilkan instruksi jika video belum diputar
                        if (!_videoController!.value.isPlaying && 
                            _videoController!.value.position.inSeconds == 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Tekan tombol play untuk mulai',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                      ],
                    )
                  else if (_isVideoError)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 50,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Video tidak dapat dimuat',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Memuat video...',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Profile Details
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data Diri',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  _buildDetailRow('NIK', widget.user.nik),
                  _buildDetailRow('Nama Panggilan', widget.user.nama),
                  _buildDetailRow('Alamat', widget.user.alamat),
                  _buildDetailRow('No. Telepon', widget.user.noTelp),
                  _buildDetailRow('Email', widget.user.email),
                  _buildDetailRow('Pendidikan', widget.user.pendidikan),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Division & Status
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Divisi & Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  _buildDetailRow('Divisi', widget.user.namaDivisi),
                  _buildDetailRow('Kode Divisi', widget.user.kodeDivisi),
                  _buildDetailRow('Status', widget.user.namaStatus),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Hobbies with Dynamic Icons from Database
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hobi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHobbyCard(
                          icon: _dbHelper.getHobyImageMaterialIcon(widget.user.idHobyImage),
                          label: 'Image Hoby',
                          name: _dbHelper.getHobyImageName(widget.user.idHobyImage),
                          file: _dbHelper.getHobyImageFile(widget.user.idHobyImage),
                          bgColor: _dbHelper.getHobyImageBgColor(widget.user.idHobyImage),
                          iconColor: _dbHelper.getHobyImageColor(widget.user.idHobyImage),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildHobbyCard(
                          icon: _dbHelper.getHobyMovieMaterialIcon(widget.user.idHobyMovie),
                          label: 'Movie Hoby',
                          name: _dbHelper.getHobyMovieName(widget.user.idHobyMovie),
                          file: _dbHelper.getHobyMovieFile(widget.user.idHobyMovie),
                          bgColor: _dbHelper.getHobyMovieBgColor(widget.user.idHobyMovie),
                          iconColor: _dbHelper.getHobyMovieColor(widget.user.idHobyMovie),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHobbyCard({
    required IconData icon,
    required String label,
    required String name,
    required String file,
    required Color bgColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bgColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 32,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            file,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}