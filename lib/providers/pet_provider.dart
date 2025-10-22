import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/pet_service.dart';
import '../models/pet_model.dart';

final petServiceProvider = Provider<PetService>((ref) => PetService());

final petsProvider = StreamProvider.family<List<Pet>, String>((
  ref,
  familyCode,
) {
  final service = ref.watch(petServiceProvider);
  return service.getPets(familyCode);
});
