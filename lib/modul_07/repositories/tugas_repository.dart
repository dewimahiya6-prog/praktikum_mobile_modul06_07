import '../models/tugas.dart';
import 'sumber_tugas_memori.dart';

// [ORANG 3 - SOAL 3] Kontrak Repository
abstract class TugasRepository {
  Future<List<Tugas>> ambilSemua();
  Future<void> tambah(Tugas tugas);
}

// [ORANG 3 - SOAL 3] Implementasi Repository
class TugasRepositoryImpl implements TugasRepository {
  final SumberTugasMemori _sumber;

  TugasRepositoryImpl(this._sumber);

  @override
  Future<List<Tugas>> ambilSemua() => _sumber.baca();

  @override
  Future<void> tambah(Tugas tugas) => _sumber.tambah(tugas);
}