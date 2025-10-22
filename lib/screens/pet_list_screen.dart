import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pet_provider.dart';
import '../models/pet_model.dart';
import 'pet_detail_screen.dart';

class PetListScreen extends ConsumerWidget {
  final String familyCode;
  const PetListScreen({super.key, required this.familyCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petsAsync = ref.watch(petsProvider(familyCode));

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Pets')),
      body: petsAsync.when(
        data: (pets) => ListView.builder(
          itemCount: pets.length,
          itemBuilder: (_, i) {
            final pet = pets[i];
            return ListTile(
              title: Text(pet.name),
              subtitle: Text(pet.species),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PetDetailScreen(pet: pet)),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro ao carregar pets: $e')),
      ),
    );
  }
}
