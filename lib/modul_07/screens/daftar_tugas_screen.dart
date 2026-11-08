import 'package:flutter/material.dart';
import '../models/tugas.dart';
import '../repositories/sumber_tugas_memori.dart';
import '../repositories/tugas_repository.dart';
import '../view_models/tugas_view_model.dart';

// [ORANG 3 - SOAL 3] View (UI) yang mengonsumsi ViewModel
class DaftarTugasScreen extends StatefulWidget {
  const DaftarTugasScreen({super.key});

  @override
  State<DaftarTugasScreen> createState() => _DaftarTugasScreenState();
}

class _DaftarTugasScreenState extends State<DaftarTugasScreen> {
  late final TugasViewModel _viewModel;
  final _judulController = TextEditingController();
  final _mkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // [ORANG 3 - SOAL 3] Constructor Injection
    final sumber = SumberTugasMemori();
    final repo = TugasRepositoryImpl(sumber);
    _viewModel = TugasViewModel(repo)..muat();
  }

  @override
  void dispose() {
    _viewModel.dispose(); // [ORANG 3 - SOAL 3] Wajib dispose ViewModel
    _judulController.dispose();
    _mkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modul 07 - Tugas')),
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, _) {
          if (_viewModel.sedangMemuat) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_viewModel.pesanError != null) {
            return Center(child: Text(_viewModel.pesanError!));
          }
          return ListView.builder(
            itemCount: _viewModel.daftarTugas.length,
            itemBuilder: (context, index) {
              final tugas = _viewModel.daftarTugas[index];
              return ListTile(
                title: Text(tugas.judul),
                subtitle: Text(tugas.mataKuliah),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahData,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _tambahData() async {
    // [ORANG 3 - SOAL 3] Minta konfirmasi dialog dulu (hanya return bool)
    final bool? konfirmasi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tambah Tugas'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _mkController,
              decoration: const InputDecoration(labelText: 'Mata Kuliah'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    // Kalau user nge-klik "Simpan" (true), baru kita jalanin proses async-nya
    if (konfirmasi == true && mounted) {
      final tugasBaru = Tugas(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        judul: _judulController.text,
        mataKuliah: _mkController.text,
      );

      // Panggil ViewModel di luar dialog
      final sukses = await _viewModel.tambah(tugasBaru);

      if (sukses && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tugas berhasil ditambahkan')),
        );
        _judulController.clear();
        _mkController.clear();
      }
    }
  }
}