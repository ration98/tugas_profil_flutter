import 'package:sqflite/sqflite.dart';

class DatabaseSchemas {
  static Future<void> createTables(Database db) async {
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
  }
}
