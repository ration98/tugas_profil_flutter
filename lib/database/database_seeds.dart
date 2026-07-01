import 'package:sqflite/sqflite.dart';

class DatabaseSeeds {
  static Future<void> insertInitialData(Database db) async {
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
      'id_status_valid': 3,
      'id_profile': 4
    });
  }
}
