// lib/database/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

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
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabel LEVEL_USER
    await db.execute('''
      CREATE TABLE level_user (
        id_level_user INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_level_user TEXT NOT NULL
      )
    ''');

    // Tabel STATUS_VALID
    await db.execute('''
      CREATE TABLE status_valid (
        id_status_valid INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_status TEXT NOT NULL
      )
    ''');

    // Tabel DIVISI
    await db.execute('''
      CREATE TABLE divisi (
        id_divisi INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_divisi TEXT NOT NULL,
        kode_divisi TEXT NOT NULL
      )
    ''');

    // Tabel HOBY_IMAGE
    await db.execute('''
      CREATE TABLE hoby_image (
        id_hoby_image INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_image TEXT NOT NULL,
        namafile_image TEXT NOT NULL
      )
    ''');

    // Tabel HOBY_MOVIE
    await db.execute('''
      CREATE TABLE hoby_movie (
        id_hoby_movie INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_movie TEXT NOT NULL,
        namafile_movie TEXT NOT NULL
      )
    ''');

    // Tabel PROFILE
    await db.execute('''
      CREATE TABLE profile (
        id_profile INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        nama_lengkap TEXT NOT NULL,
        nik TEXT NOT NULL,
        alamat TEXT NOT NULL,
        no_telp TEXT NOT NULL,
        email TEXT NOT NULL,
        pendidikan TEXT NOT NULL,
        id_divisi INTEGER NOT NULL,
        id_hoby_image INTEGER,
        id_hoby_movie INTEGER,
        FOREIGN KEY (id_divisi) REFERENCES divisi(id_divisi),
        FOREIGN KEY (id_hoby_image) REFERENCES hoby_image(id_hoby_image),
        FOREIGN KEY (id_hoby_movie) REFERENCES hoby_movie(id_hoby_movie)
      )
    ''');

    // Tabel USERS
    await db.execute('''
      CREATE TABLE users (
        id_user INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        pass TEXT NOT NULL,
        id_level_user INTEGER NOT NULL,
        id_status_valid INTEGER NOT NULL,
        id_profile INTEGER NOT NULL,
        FOREIGN KEY (id_level_user) REFERENCES level_user(id_level_user),
        FOREIGN KEY (id_status_valid) REFERENCES status_valid(id_status_valid),
        FOREIGN KEY (id_profile) REFERENCES profile(id_profile)
      )
    ''');

    // Insert seed data
    await _insertSeedData(db);
  }

  Future<void> _insertSeedData(Database db) async {
    // Insert LEVEL_USER
    await db.insert('level_user', {'id_level_user': 1, 'nama_level_user': 'Admin'});
    await db.insert('level_user', {'id_level_user': 2, 'nama_level_user': 'Supervisor'});
    await db.insert('level_user', {'id_level_user': 3, 'nama_level_user': 'Staf'});
    await db.insert('level_user', {'id_level_user': 4, 'nama_level_user': 'Customer'});

    // Insert STATUS_VALID
    await db.insert('status_valid', {'id_status_valid': 1, 'nama_status': 'Aktif'});
    await db.insert('status_valid', {'id_status_valid': 2, 'nama_status': 'Tidak Aktif'});
    await db.insert('status_valid', {'id_status_valid': 3, 'nama_status': 'Pending'});

    // Insert DIVISI
    await db.insert('divisi', {'id_divisi': 1, 'nama_divisi': 'Teknologi Informasi', 'kode_divisi': 'TI'});
    await db.insert('divisi', {'id_divisi': 2, 'nama_divisi': 'Sumber Daya Manusia', 'kode_divisi': 'SDM'});
    await db.insert('divisi', {'id_divisi': 3, 'nama_divisi': 'Keuangan', 'kode_divisi': 'KEU'});
    await db.insert('divisi', {'id_divisi': 4, 'nama_divisi': 'Marketing', 'kode_divisi': 'MKT'});
    await db.insert('divisi', {'id_divisi': 5, 'nama_divisi': 'Operasional', 'kode_divisi': 'OPS'});

    // Insert HOBY_IMAGE
    await db.insert('hoby_image', {'id_hoby_image': 1, 'nama_image': 'Fotografi', 'namafile_image': 'foto.jpg'});
    await db.insert('hoby_image', {'id_hoby_image': 2, 'nama_image': 'Melukis', 'namafile_image': 'lukis.jpg'});
    await db.insert('hoby_image', {'id_hoby_image': 3, 'nama_image': 'Desain Grafis', 'namafile_image': 'desain.jpg'});

    // Insert HOBY_MOVIE
    await db.insert('hoby_movie', {'id_hoby_movie': 1, 'nama_movie': 'Drama', 'namafile_movie': 'drama.mp4'});
    await db.insert('hoby_movie', {'id_hoby_movie': 2, 'nama_movie': 'Komedi', 'namafile_movie': 'komedi.mp4'});
    await db.insert('hoby_movie', {'id_hoby_movie': 3, 'nama_movie': 'Action', 'namafile_movie': 'action.mp4'});

    // Insert PROFILE
    await db.insert('profile', {
      'id_profile': 1,
      'nama': 'Yfta',
      'nama_lengkap': 'Yfta Kurnia',
      'nik': '1234567890',
      'alamat': 'Jl. Merdeka No. 1',
      'no_telp': '081234567890',
      'email': 'yfta@example.com',
      'pendidikan': 'S1 Teknik Informatika',
      'id_divisi': 1,
      'id_hoby_image': 1,
      'id_hoby_movie': 1
    });

    await db.insert('profile', {
      'id_profile': 2,
      'nama': 'Mirfan',
      'nama_lengkap': 'Mirfananda',
      'nik': '0987654321',
      'alamat': 'Jl. Sudirman No. 2',
      'no_telp': '081298765432',
      'email': 'mirfan@example.com',
      'pendidikan': 'S1 Manajemen',
      'id_divisi': 2,
      'id_hoby_image': 2,
      'id_hoby_movie': 2
    });

    await db.insert('profile', {
      'id_profile': 3,
      'nama': 'Adhima',
      'nama_lengkap': 'Adhima Putra',
      'nik': '1122334455',
      'alamat': 'Jl. Gatot Subroto No. 3',
      'no_telp': '081212345678',
      'email': 'adhima@example.com',
      'pendidikan': 'S1 Ekonomi',
      'id_divisi': 3,
      'id_hoby_image': 3,
      'id_hoby_movie': 3
    });

    await db.insert('profile', {
      'id_profile': 4,
      'nama': 'Tio',
      'nama_lengkap': 'Tio Anggie',
      'nik': '5544332211',
      'alamat': 'Jl. Thamrin No. 4',
      'no_telp': '081287654321',
      'email': 'tio@example.com',
      'pendidikan': 'S1 Komunikasi',
      'id_divisi': 4,
      'id_hoby_image': 1,
      'id_hoby_movie': 2
    });

    // Insert USERS
    await db.insert('users', {
      'id_user': 1,
      'username': 'admin',
      'pass': 'admin123',
      'id_level_user': 1,
      'id_status_valid': 1,
      'id_profile': 1
    });

    await db.insert('users', {
      'id_user': 2,
      'username': 'supervisor',
      'pass': 'super123',
      'id_level_user': 2,
      'id_status_valid': 1,
      'id_profile': 2
    });

    await db.insert('users', {
      'id_user': 3,
      'username': 'staf',
      'pass': 'staf123',
      'id_level_user': 3,
      'id_status_valid': 1,
      'id_profile': 3
    });

    await db.insert('users', {
      'id_user': 4,
      'username': 'customer',
      'pass': 'cust123',
      'id_level_user': 4,
      'id_status_valid': 1,
      'id_profile': 4
    });
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