import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream para observar mudanças no estado de autenticação
  Stream<User?> get userChanges => _auth.authStateChanges();

  // Usuário atual
  User? get currentUser => _auth.currentUser;

  // Cadastro com e-mail e senha
  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // null = sucesso
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e.code);
    }
  }

  // Login com e-mail e senha
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // null = sucesso
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e.code);
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Tradução dos erros do Firebase para português
  String _handleAuthError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'E-mail inválido.';
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'email-already-in-use':
        return 'Este e-mail já está em uso.';
      case 'weak-password':
        return 'Senha muito fraca. Use no mínimo 6 caracteres.';
      case 'invalid-credential':
        return 'E-mail ou senha incorretos.';
      case 'too-many-requests':
        return 'Muitas tentativas. Tente novamente mais tarde.';
      default:
        return 'Erro ao autenticar. Tente novamente.';
    }
  }
}
