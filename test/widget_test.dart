import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum_mobile_modul06_07/main.dart';

void main() {
  testWidgets('Aplikasi Modul 06 bisa di-build tanpa error', (WidgetTester tester) async {
    // Build aplikasi kita
    await tester.pumpWidget(const Modul06App());

    // Cek apakah teks 'Portal Akademik' muncul di layar awal
    expect(find.text('Masuk ke Portal Akademik'), findsOneWidget);
  });
}