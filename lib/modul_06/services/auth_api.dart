// =========================================================
// [MAHIYA - SOAL 1] Bagian Import Asli
// =========================================================
import '../models/sesi_pengguna.dart';

// [DIMAS - SOAL 2] Tambahan Import untuk debugPrint
import 'package:flutter/material.dart'; 

/// Kegagalan autentikasi yang aman ditampilkan ke pengguna.
class AuthException implements Exception {
  final String pesan;
  final int kode;
  const AuthException(this.pesan, {this.kode = 401});
  @override
  String toString() => 'AuthException($kode): $pesan';
}

/// API login tiruan: tidak menyentuh jaringan, hasilnya deterministik.
class AuthApi {
  
  // =========================================================
  // [DIMAS - SOAL 2] Tambahan: Variabel Counter
  // =========================================================
  int jumlahPanggilan = 0; 
  // =========================================================

  // =========================================================
  // [MAHIYA - SOAL 1] Kredensial & Konfigurasi Asli
  // =========================================================
  static const String emailDemo = 'student@trpl.test';
  static const String sandiDemo = 'belajar123';
  static const String emailTerkunci = 'terkunci@trpl.test';
  static const String emailServerGangguan = 'gangguan@trpl.test';

  /// Jeda buatan supaya keadaan "memproses" benar-benar terlihat.
  final Duration tunda;
  AuthApi({this.tunda = const Duration(milliseconds: 700)});
  // =========================================================


  // =========================================================
  // [MAHIYA - SOAL 1] Fungsi Login Utama & [DIMAS - SOAL 2] Tambahan Counter
  // =========================================================
  Future<SesiPengguna> masuk({
    required String email,
    required String sandi,
    Duration masaBerlaku = const Duration(hours: 2),
  }) async {
    
    // --- [DIMAS - SOAL 2] Tambahan Counter Eksperimen A ---
    jumlahPanggilan++;
    debugPrint('>>> API masuk() dipanggil. Total: $jumlahPanggilan kali');
    // -------------------------------------------------------

    // --- [MAHIYA - SOAL 1] Mulai Validasi Login ---
    await Future<void>.delayed(tunda);

    final String emailBersih = email.trim().toLowerCase();

    if (emailBersih.isEmpty || sandi.isEmpty) {
      throw const AuthException(
        'Email dan kata sandi wajib diisi.',
        kode: 400,
      );
    }

    if (emailBersih == emailTerkunci) {
      throw const AuthException(
        'Akun terkunci sementara karena terlalu banyak percobaan. '
        'Coba lagi beberapa menit lagi.',
        kode: 423,
      );
    }

    if (emailBersih == emailServerGangguan) {
      throw const AuthException(
        'Server sedang tidak dapat dihubungi. Periksa koneksi lalu coba lagi.',
        kode: 503,
      );
    }

    if (emailBersih != emailDemo || sandi != sandiDemo) {
      // Pesan ini SENGAJA tidak menyebut mana yang salah — menyebut
      // "email tidak terdaftar" akan membocorkan daftar pengguna.
      throw const AuthException('Email atau kata sandi salah.');
    }

    final DateTime mulai = DateTime.now();
    return SesiPengguna(
      // Token tiruan: bentuknya menyerupai token sungguhan, tetapi tidak
      // dapat dipakai ke sistem mana pun.
      token: 'dummy.${mulai.millisecondsSinceEpoch}.trpl',
      email: emailBersih,
      nama: _namaUntuk(emailBersih),
      peran: 'mahasiswa',
      masukPada: mulai.toIso8601String(),
      kedaluwarsaPada: mulai.add(masaBerlaku).toIso8601String(),
    );
    // --- [MAHIYA - SOAL 1] Selesai Validasi ---
  }

  /// Memperbarui masa berlaku sesi — meniru "refresh token".
  Future<SesiPengguna> perbaruiSesi(
    SesiPengguna sesi, {
    Duration masaBerlaku = const Duration(hours: 2),
  }) async {
    await Future<void>.delayed(tunda);
    final DateTime mulai = DateTime.now();
    return sesi.copyWith(
      masukPada: mulai.toIso8601String(),
      kedaluwarsaPada: mulai.add(masaBerlaku).toIso8601String(),
    );
  }

  static String _namaUntuk(String email) {
    if (email == emailDemo) return 'Mahasiswa TRPL';
    final String depan = email.split('@').first;
    if (depan.isEmpty) return 'Pengguna';
    return '${depan[0].toUpperCase()}${depan.substring(1)}';
  }
}