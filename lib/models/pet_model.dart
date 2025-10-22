import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String id;
  final String familyCode;
  final String name;
  final String species;
  final DateTime birthDate;
  final double weightKg;
  final String photoUrl;
  final DateTime createdAt;

  Pet({
    required this.id,
    required this.familyCode,
    required this.name,
    required this.species,
    required this.birthDate,
    required this.weightKg,
    required this.photoUrl,
    required this.createdAt,
  });

  factory Pet.fromMap(String id, Map<String, dynamic> data) {
    return Pet(
      id: id,
      familyCode: data['familyCode'],
      name: data['name'],
      species: data['species'],
      birthDate: (data['birthDate'] as Timestamp).toDate(),
      weightKg: data['weightKg'].toDouble(),
      photoUrl: data['photoUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'familyCode': familyCode,
      'name': name,
      'species': species,
      'birthDate': birthDate,
      'weightKg': weightKg,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
    };
  }
}
