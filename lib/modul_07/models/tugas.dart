// [ORANG 3 - SOAL 3] Model/Entity untuk data tugas
class Tugas {
  final String id;
  final String judul;
  final String mataKuliah;
  final bool selesai;

  const Tugas({
    required this.id,
    required this.judul,
    required this.mataKuliah,
    this.selesai = false,
  });

  Tugas copyWith({bool? selesai}) {
    return Tugas(
      id: id,
      judul: judul,
      mataKuliah: mataKuliah,
      selesai: selesai ?? this.selesai,
    );
  }
}