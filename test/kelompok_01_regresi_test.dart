import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum_mobile_modul06_07/eksperimen_kelompok/sumber_tugas_eksperimen.dart';

void main() {
  group('Uji Regresi SumberTugasEksperimen', () {
    test('R5: Mengubah Map hasil baca tidak mengubah data internal', () async {
      final sumber = SumberTugasEksperimen();
      final List<Map<String, Object>> hasilBaca = await sumber.baca();
      hasilBaca[0]['judul'] = 'Judul Telah Diubah';
      final List<Map<String, Object>> hasilBacaKedua = await sumber.baca();
      expect(hasilBacaKedua[0]['judul'], 'Data awal');
    });

    test('R6: ID dari pemanggil tidak menimpa ID sumber data', () async {
      final sumber = SumberTugasEksperimen();
      await sumber.tambah({'id': 'ID-BIKINAN-SENDIRI', 'judul': 'Tugas 1'});
      await sumber.tambah({'id': 'ID-BIKINAN-SENDIRI', 'judul': 'Tugas 2'});
      final List<Map<String, Object>> data = await sumber.baca();
      expect(data[1]['id'], 'uji-1');
      expect(data[2]['id'], 'uji-2');
      expect(data[1]['id'], isNot(data[2]['id']));
    });
  });
}