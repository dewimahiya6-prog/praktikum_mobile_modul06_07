import '../models/tugas.dart';

// [ORANG 3 - SOAL 3] Sumber Data (Data Source) yang menyimpan di memori
class SumberTugasMemori {
  final List<Tugas> _daftarTugas = [];
  bool gagalSaatTulis = false; // Untuk ngetes error di Soal 3

  Future<List<Tugas>> baca() async {
    // Simulasi jeda jaringan/disk
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return List<Tugas>.of(_daftarTugas);
  }

  Future<void> tambah(Tugas tugas) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (gagalSaatTulis) {
      throw Exception('Gagal menulis ke penyimpanan');
    }
    _daftarTugas.add(tugas);
  }

  Future<void> perbarui(Tugas tugas) async {
    final index = _daftarTugas.indexWhere((t) => t.id == tugas.id);
    if (index != -1) {
      _daftarTugas[index] = tugas;
    }
  }

  Future<void> hapus(String id) async {
    _daftarTugas.removeWhere((t) => t.id == id);
  }
}