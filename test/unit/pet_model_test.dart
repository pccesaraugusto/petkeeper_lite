import 'package:flutter_test/flutter_test.dart';
import 'package:petkeeper_lite/models/pet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  Timestamp now = Timestamp.now();
  print(now.toDate());

  test('Pet model toMap and fromMap', () {
    final pet = Pet(
      id: '123',
      familyCode: 'FAM01',
      name: 'Rex',
      species: 'dog',
      birthDate: DateTime(2020, 1, 1),
      weightKg: 10.5,
      photoUrl: 'url',
      createdAt: DateTime(2023, 1, 1),
    );

    final map = pet.toMap();
    final petFromMap = Pet.fromMap('123', {
      ...map,
      'birthDate': Timestamp.fromDate(pet.birthDate),
      'createdAt': Timestamp.fromDate(pet.createdAt),
    });

    expect(petFromMap.name, 'Rex');
    expect(petFromMap.weightKg, 10.5);
  });
}
