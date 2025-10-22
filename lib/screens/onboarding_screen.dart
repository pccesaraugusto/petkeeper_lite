import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'pet_list_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final familyCodeController = TextEditingController();

  void saveFamilyCode() async {
    final auth = ref.read(authServiceProvider);
    final uid = auth.currentUser?.uid;
    if (uid != null) {
      await auth.updateFamilyCode(uid, familyCodeController.text);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                PetListScreen(familyCode: familyCodeController.text),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Código da Família')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: familyCodeController,
                decoration: const InputDecoration(labelText: 'Ex: BORGES01')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: saveFamilyCode, child: const Text('Continuar')),
          ],
        ),
      ),
    );
  }
}
