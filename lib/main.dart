import 'package:flutter/material.dart';
import 'screens/detail_exercise_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hidup Sehat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B6E4F)),
        useMaterial3: true,
      ),
      // Sementara langsung buka halaman Push Up (/detail) agar bisa langsung dites
      initialRoute: '/detail',
      routes: {
        '/detail': (context) => const DetailExerciseScreen(),
        // Rute halaman temanmu nanti tinggal diaktifkan di sini:
        // '/login': (context) => const LoginScreen(),
        // '/dashboard': (context) => const DashboardScreen(),
        // '/exercise': (context) => const ExerciseScreen(),
        // '/tambah': (context) => const TambahExerciseScreen(),
      },
    );
  }
}