// lib/models/user_model.dart
class User {
  final int idUser;
  final String username;
  final int idLevelUser;
  final String namaLevelUser;
  final int idStatusValid;
  final String namaStatus;
  final int idProfile;
  final String nama;
  final String namaLengkap;
  final String nik;
  final String alamat;
  final String noTelp;
  final String email;
  final String pendidikan;
  final int idDivisi;
  final String namaDivisi;
  final String kodeDivisi;
  final int? idHobyImage;
  final int? idHobyMovie;
  
  User({
    required this.idUser,
    required this.username,
    required this.idLevelUser,
    required this.namaLevelUser,
    required this.idStatusValid,
    required this.namaStatus,
    required this.idProfile,
    required this.nama,
    required this.namaLengkap,
    required this.nik,
    required this.alamat,
    required this.noTelp,
    required this.email,
    required this.pendidikan,
    required this.idDivisi,
    required this.namaDivisi,
    required this.kodeDivisi,
    this.idHobyImage,
    this.idHobyMovie,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      idUser: map['id_user'] ?? 0,
      username: map['username'] ?? '',
      idLevelUser: map['id_level_user'] ?? 0,
      namaLevelUser: map['nama_level_user'] ?? '',
      idStatusValid: map['id_status_valid'] ?? 0,
      namaStatus: map['nama_status'] ?? '',
      idProfile: map['id_profile'] ?? 0,
      nama: map['nama'] ?? '',
      namaLengkap: map['nama_lengkap'] ?? '',
      nik: map['nik'] ?? '',
      alamat: map['alamat'] ?? '',
      noTelp: map['no_telp'] ?? '',
      email: map['email'] ?? '',
      pendidikan: map['pendidikan'] ?? '',
      idDivisi: map['id_divisi'] ?? 0,
      namaDivisi: map['nama_divisi'] ?? '',
      kodeDivisi: map['kode_divisi'] ?? '',
      idHobyImage: map['id_hoby_image'],
      idHobyMovie: map['id_hoby_movie'],
    );
  }
}