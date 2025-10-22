import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pet_model.dart';

class PetService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Pet>> getPets(String familyCode) {
    return _firestore
        .collection('pets')
        .where('familyCode', isEqualTo: familyCode)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((doc) => Pet.fromMap(doc.id, doc.data())).toList(),
        );
  }

  Future<void> createPet(Pet pet) async {
    if (pet.familyCode.isEmpty) throw Exception('familyCode obrigatório');
    await _firestore.collection('pets').doc(pet.id).set(pet.toMap());
  }

  Future<void> updatePet(Pet pet) async {
    await _firestore.collection('pets').doc(pet.id).update(pet.toMap());
  }

  Future<void> deletePet(String petId) async {
    await _firestore.collection('pets').doc(petId).delete();
  }
}
