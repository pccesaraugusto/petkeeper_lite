import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

/// Provider do serviço de autenticação
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

/// Provider que escuta mudanças de autenticação (login/logout)
final authStateProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(authServiceProvider);
  return auth.authStateChanges;
});

/// Provider que retorna o usuário atual (se estiver logado)
final currentUserProvider = Provider<User?>((ref) {
  return FirebaseAuth.instance.currentUser;
});
