// lib/database/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'database_schemas.dart';
import 'database_seeds.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_management.db');
    print('Database Path: $path'); // Log path database untuk development
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await DatabaseSchemas.createTables(db);
    await DatabaseSeeds.insertInitialData(db);
  }

  // ===== QUERY METHODS =====

  Future<Map<String, dynamic>?> loginUser(String username, String pass) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT 
        u.id_user,
        u.username,
        u.id_level_user,
        u.id_status_valid,
        l.nama_level_user,
        s.nama_status,
        p.id_profile,
        p.nama,
        p.nama_lengkap,
        p.nik,
        p.alamat,
        p.no_telp,
        p.email,
        p.pendidikan,
        d.id_divisi,
        d.nama_divisi,
        d.kode_divisi,
        hi.id_hoby_image,
        hi.nama_image,
        hi.namafile_image,
        hm.id_hoby_movie,
        hm.nama_movie,
        hm.namafile_movie
      FROM users u
      INNER JOIN level_user l ON u.id_level_user = l.id_level_user
      INNER JOIN status_valid s ON u.id_status_valid = s.id_status_valid
      INNER JOIN profile p ON u.id_profile = p.id_profile
      INNER JOIN divisi d ON p.id_divisi = d.id_divisi
      LEFT JOIN hoby_image hi ON p.id_hoby_image = hi.id_hoby_image
      LEFT JOIN hoby_movie hm ON p.id_hoby_movie = hm.id_hoby_movie
      WHERE u.username = ? AND u.pass = ?
    ''', [username, pass]);

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
        u.id_user,
        u.username,
        l.nama_level_user,
        s.nama_status,
        p.nama,
        p.nama_lengkap,
        p.nik,
        p.alamat,
        p.no_telp,
        p.email,
        p.pendidikan,
        d.nama_divisi,
        d.kode_divisi,
        hi.nama_image,
        hm.nama_movie
      FROM users u
      INNER JOIN level_user l ON u.id_level_user = l.id_level_user
      INNER JOIN status_valid s ON u.id_status_valid = s.id_status_valid
      INNER JOIN profile p ON u.id_profile = p.id_profile
      INNER JOIN divisi d ON p.id_divisi = d.id_divisi
      LEFT JOIN hoby_image hi ON p.id_hoby_image = hi.id_hoby_image
      LEFT JOIN hoby_movie hm ON p.id_hoby_movie = hm.id_hoby_movie
    ''');
  }

  Future<Map<String, dynamic>?> getUserById(int idUser) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT 
        u.id_user,
        u.username,
        u.id_level_user,
        l.nama_level_user,
        u.id_status_valid,
        s.nama_status,
        p.id_profile,
        p.nama,
        p.nama_lengkap,
        p.nik,
        p.alamat,
        p.no_telp,
        p.email,
        p.pendidikan,
        d.id_divisi,
        d.nama_divisi,
        d.kode_divisi,
        hi.id_hoby_image,
        hi.nama_image,
        hi.namafile_image,
        hm.id_hoby_movie,
        hm.nama_movie,
        hm.namafile_movie
      FROM users u
      INNER JOIN level_user l ON u.id_level_user = l.id_level_user
      INNER JOIN status_valid s ON u.id_status_valid = s.id_status_valid
      INNER JOIN profile p ON u.id_profile = p.id_profile
      INNER JOIN divisi d ON p.id_divisi = d.id_divisi
      LEFT JOIN hoby_image hi ON p.id_hoby_image = hi.id_hoby_image
      LEFT JOIN hoby_movie hm ON p.id_hoby_movie = hm.id_hoby_movie
      WHERE u.id_user = ?
    ''', [idUser]);

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllLevels() async {
    final db = await database;
    return await db.query('level_user');
  }

  Future<List<Map<String, dynamic>>> getAllStatus() async {
    final db = await database;
    return await db.query('status_valid');
  }

  Future<List<Map<String, dynamic>>> getAllDivisi() async {
    final db = await database;
    return await db.query('divisi');
  }

  Future<List<Map<String, dynamic>>> getAllHobyImages() async {
    final db = await database;
    return await db.query('hoby_image');
  }

  Future<List<Map<String, dynamic>>> getAllHobyMovies() async {
    final db = await database;
    return await db.query('hoby_movie');
  }

  // ===== HOBBY MAPPING METHODS (String/Emoji) =====
  
  String getHobyImageName(int? idHobyImage) {
    if (idHobyImage == null) return '-';
    
    final Map<int, String> nameMapping = {
      1: 'Fotografi',
      2: 'Melukis',
      3: 'Desain Grafis',
    };
    
    return nameMapping[idHobyImage] ?? '-';
  }

  String getHobyImageFile(int? idHobyImage) {
    if (idHobyImage == null) return '-';
    
    final Map<int, String> fileMapping = {
      1: 'foto.jpg',
      2: 'lukis.jpg',
      3: 'desain.jpg',
    };
    
    return fileMapping[idHobyImage] ?? '-';
  }

  String getHobyMovieName(int? idHobyMovie) {
    if (idHobyMovie == null) return '-';
    
    final Map<int, String> nameMapping = {
      1: 'Drama',
      2: 'Komedi',
      3: 'Action',
    };
    
    return nameMapping[idHobyMovie] ?? '-';
  }

  String getHobyMovieFile(int? idHobyMovie) {
    if (idHobyMovie == null) return '-';
    
    final Map<int, String> fileMapping = {
      1: 'drama.mp4',
      2: 'komedi.mp4',
      3: 'action.mp4',
    };
    
    return fileMapping[idHobyMovie] ?? '-';
  }

  // ===== HOBBY ICON METHODS (Material Design Icons) =====
  // Method-method baru yang direkomendasikan

  IconData getHobyImageMaterialIcon(int? idHobyImage) {
    if (idHobyImage == null) return Icons.photo_camera;
    
    final Map<int, IconData> iconMapping = {
      1: Icons.camera_alt,      // Fotografi
      2: Icons.brush,           // Melukis
      3: Icons.design_services, // Desain Grafis
    };
    
    return iconMapping[idHobyImage] ?? Icons.photo_camera;
  }

  IconData getHobyMovieMaterialIcon(int? idHobyMovie) {
    if (idHobyMovie == null) return Icons.movie;
    
    final Map<int, IconData> iconMapping = {
      1: Icons.theaters,        // Drama
      2: Icons.emoji_emotions,  // Komedi
      3: Icons.flash_on,        // Action
    };
    
    return iconMapping[idHobyMovie] ?? Icons.movie;
  }

  // Mendapatkan warna icon berdasarkan ID hobi
  Color getHobyImageColor(int? idHobyImage) {
    if (idHobyImage == null) return Colors.blue.shade700;
    
    final Map<int, Color> colorMapping = {
      1: Colors.blue.shade700,    // Fotografi - Biru
      2: Colors.orange.shade700,  // Melukis - Orange
      3: Colors.purple.shade700,  // Desain Grafis - Ungu
    };
    
    return colorMapping[idHobyImage] ?? Colors.blue.shade700;
  }

  Color getHobyMovieColor(int? idHobyMovie) {
    if (idHobyMovie == null) return Colors.purple.shade700;
    
    final Map<int, Color> colorMapping = {
      1: Colors.red.shade700,     // Drama - Merah
      2: Colors.green.shade700,   // Komedi - Hijau
      3: Colors.amber.shade700,   // Action - Kuning
    };
    
    return colorMapping[idHobyMovie] ?? Colors.purple.shade700;
  }

  // Mendapatkan background color untuk card hobi
  Color getHobyImageBgColor(int? idHobyImage) {
    if (idHobyImage == null) return Colors.blue.shade50;
    
    final Map<int, Color> colorMapping = {
      1: Colors.blue.shade50,
      2: Colors.orange.shade50,
      3: Colors.purple.shade50,
    };
    
    return colorMapping[idHobyImage] ?? Colors.blue.shade50;
  }

  Color getHobyMovieBgColor(int? idHobyMovie) {
    if (idHobyMovie == null) return Colors.purple.shade50;
    
    final Map<int, Color> colorMapping = {
      1: Colors.red.shade50,
      2: Colors.green.shade50,
      3: Colors.amber.shade50,
    };
    
    return colorMapping[idHobyMovie] ?? Colors.purple.shade50;
  }

  // Mendapatkan path gambar hoby image berdasarkan ID
  String getHobyImagePath(int? idHobyImage) {
    if (idHobyImage == null) return 'assets/images/hoby/default.jpg';
    
    final Map<int, String> imageMapping = {
      1: 'assets/images/hoby/foto.jpg',    // Fotografi
      2: 'assets/images/hoby/lukis.jpg',   // Melukis
      3: 'assets/images/hoby/desain.jpg',  // Desain Grafis
    };
    
    return imageMapping[idHobyImage] ?? 'assets/images/hoby/default.jpg';
  }

  // Mendapatkan path gambar hoby movie berdasarkan ID
  String getHobyMoviePath(int? idHobyMovie) {
    if (idHobyMovie == null) return 'assets/images/hoby/default.jpg';
    
    final Map<int, String> imageMapping = {
      1: 'assets/images/hoby/drama.jpg',   // Drama
      2: 'assets/images/hoby/komedi.jpg',  // Komedi
      3: 'assets/images/hoby/action.jpg',  // Action
    };
    
    return imageMapping[idHobyMovie] ?? 'assets/images/hoby/default.jpg';
  }
// lib/database/database_helper.dart
// Tambahkan method-method ini di dalam class DatabaseHelper

// ===== MEDIA PATH METHODS =====

// Mendapatkan path foto profil berdasarkan username
String getProfileImagePath(String username) {
  final Map<String, String> profileImages = {
    'admin': 'assets/images/Gua.jpg',
    'supervisor': 'assets/images/mirfa.jpeg',
    'staf': 'assets/images/adhimatenri.jpg',
    'customer': 'assets/images/tio.png',
  };
  
  return profileImages[username] ?? 'assets/images/default_avatar.jpg';
}

// Mendapatkan path video profil berdasarkan username
String getProfileVideoPath(String username) {
  final Map<String, String> profileVideos = {
    'admin': 'assets/videos/vid_perkenalan.mp4',
    'supervisor': 'assets/videos/vid_mirfa.mp4',
    'staf': 'assets/videos/vid_adhimatenri.mp4',
    'customer': 'assets/videos/vid_tio.mp4',
  };
  
  return profileVideos[username] ?? 'assets/videos/default_video.mp4';
}

// Mendapatkan title video berdasarkan username
String getProfileVideoTitle(String username) {
  final Map<String, String> videoTitles = {
    'admin': 'Video Perkenalan - Admin',
    'supervisor': 'Video Perkenalan - Supervisor',
    'staf': 'Video Perkenalan - Staf',
    'customer': 'Video Perkenalan - Customer',
  };
  
  return videoTitles[username] ?? 'Video Perkenalan';}
} // ← Akhir class DatabaseHelper