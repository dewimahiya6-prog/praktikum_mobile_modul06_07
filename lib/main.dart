import 'package:flutter/material.dart';
import 'modul_06/screens/login_screen.dart';
import 'modul_06/services/auth_api.dart';
import 'modul_06/services/sesi_memori.dart';

void main() {
  runApp(const Modul06App());
}

class Modul06App extends StatefulWidget {
  const Modul06App({super.key});

  @override
  State<Modul06App> createState() => _Modul06AppState();
}

class _Modul06AppState extends State<Modul06App> {
  // SesiMemori dibuat sekali di sini biar gak keresus tiap layar di-render ulang
  late final SesiMemori _sesiMemori = SesiMemori();
  
  // Pake jeda 2 detik biar lo bisa liat state "Memproses..." di tombolnya
  late final AuthApi _api = AuthApi(tunda: const Duration(milliseconds: 900));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 06 — Login & Session Dasar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      home: LoginScreen(api: _api, sesiMemori: _sesiMemori),
    );
  }
}