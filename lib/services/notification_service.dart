import 'package:cloud_functions/cloud_functions.dart';

class NotificationService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> notifyFamily(String petId, String message) async {
    final HttpsCallable callable = _functions.httpsCallable('notifyFamily');
    await callable.call(<String, dynamic>{'petId': petId, 'message': message});
  }
}
