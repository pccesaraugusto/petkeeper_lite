import 'package:flutter/material.dart';
import '../models/pet_model.dart';

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onTap;
  const PetCard({super.key, required this.pet, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: pet.photoUrl.isNotEmpty
            ? CircleAvatar(backgroundImage: NetworkImage(pet.photoUrl))
            : const CircleAvatar(child: Icon(Icons.pets)),
        title: Text(pet.name),
        subtitle: Text('${pet.species} • ${pet.weightKg} kg'),
        onTap: onTap,
      ),
    );
  }
}
