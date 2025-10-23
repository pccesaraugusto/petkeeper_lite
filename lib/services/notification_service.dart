import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> enviarNotificacao(String petId, String mensagem) async {
  final url = Uri.parse('https://petkeeper-lite.onrender.com/notifyFamily');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'petId': petId, 'mensagem': mensagem}),
  );

  if (response.statusCode == 200) {
    print('✅ Notificação enviada com sucesso!');
  } else {
    print('❌ Erro: ${response.statusCode} - ${response.body}');
  }
}
