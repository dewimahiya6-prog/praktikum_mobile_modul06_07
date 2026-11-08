import 'package:flutter/material.dart';
// [ORANG 3 - SOAL 3] Import layar Modul 07
import 'modul_07/screens/daftar_tugas_screen.dart'; 

void main() {
  runApp(const Modul07App());
}

class Modul07App extends StatelessWidget {
  const Modul07App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 07 - Arsitektur',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      // [ORANG 3 - SOAL 3] Langsung arahkan ke layar Modul 07
      home: const DaftarTugasScreen(), 
    );
  }
}