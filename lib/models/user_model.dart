class AppUser {
  final String uid;
  final String displayName;
  final String email;
  final String familyCode;
  final List<String> fcmTokens;

  AppUser({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.familyCode,
    required this.fcmTokens,
  });

  factory AppUser.fromMap(String uid, Map<String, dynamic> data) {
    return AppUser(
      uid: uid,
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      familyCode: data['familyCode'] ?? '',
      fcmTokens: List<String>.from(data['fcmTokens'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'familyCode': familyCode,
      'fcmTokens': fcmTokens,
    };
  }
}
