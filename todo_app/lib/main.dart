import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  // Garante que os bindings do Flutter estejam prontos antes de inicializar o Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as configurações geradas pelo FlutterFire CLI
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6366F1),
          secondary: Color(0xFF8B5CF6),
        ),
      ),
      // AuthGate: verifica se o usuário está logado para redirecionar a tela correta
      home: const AuthGate(),
    );
  }
}

/// Roteador automático: redireciona para Login ou Home
/// dependendo do estado de autenticação do Firebase
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Enquanto verifica o estado de autenticação
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFF0F172A),
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF6366F1)),
            ),
          );
        }

        // Se usuário está logado → vai para Home
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Se não está logado → vai para Login
        return const LoginScreen();
      },
    );
  }
}
