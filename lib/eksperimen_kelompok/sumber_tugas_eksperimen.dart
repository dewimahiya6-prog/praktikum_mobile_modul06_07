class SumberTugasEksperimen {
  final List<Map<String, Object>> _baris = [
    {'id': 'contoh-0', 'judul': 'Data awal'},
  ];
  
  int _urutan = 0;

  Future<List<Map<String, Object>>> baca() async {
    
    return _baris.map((e) => Map<String, Object>.from(e)).toList();
  }

  Future<Map<String, Object>> tambah(
    Map<String, Object> nilai,
  ) async {
    // PERBAIKAN BUG 2: Urutan Spread
    // 'id' ditaruh di PALING AKHIR biar gak bisa ditimpa sama input dari luar
    final baris = <String, Object>{
      ...nilai,
      'id': 'uji-${++_urutan}',
    };
    
    _baris.add(baris);
    return Map<String, Object>.of(baris);
  }
}