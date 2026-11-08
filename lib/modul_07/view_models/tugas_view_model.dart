import 'package:flutter/foundation.dart';
import '../models/tugas.dart';
import '../repositories/tugas_repository.dart';

// [ORANG 3 - SOAL 3] ViewModel sebagai pengatur state
class TugasViewModel extends ChangeNotifier {
  final TugasRepository _repository;

  TugasViewModel(this._repository);

  List<Tugas> _daftarTugas = [];
  bool _sedangMemuat = false;
  String? _pesanError;

  List<Tugas> get daftarTugas => _daftarTugas;
  bool get sedangMemuat => _sedangMemuat;
  String? get pesanError => _pesanError;

  Future<void> muat() async {
    _sedangMemuat = true;
    _pesanError = null;
    notifyListeners();

    try {
      _daftarTugas = await _repository.ambilSemua();
    } catch (e) {
      _pesanError = e.toString();
    } finally {
      _sedangMemuat = false;
      notifyListeners();
    }
  }

  // [ORANG 3 - SOAL 3] Fungsi tambah mengembalikan Future<bool>
  Future<bool> tambah(Tugas tugas) async {
    try {
      await _repository.tambah(tugas);
      await muat(); // Refresh data setelah nambah
      return true;
    } catch (e) {
      _pesanError = e.toString();
      notifyListeners();
      return false;
    }
  }
}