import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> enviarNotificacao(String petId, String mensagem) async {
  final url = Uri.parse('https://petkeeper-lite.onrender.com/notifyFamily');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // Se precisar autenticação, adicione aqui:
        // 'Authorization': 'Bearer SEU_TOKEN',
      },
      body: jsonEncode({
        'petId': petId,
        'mensagem': mensagem,
      }),
    );

    if (response.statusCode == 200) {
      print('✅ Notificação enviada com sucesso!');
    } else {
      print('❌ Erro ao enviar: ${response.statusCode}');
      print('📄 Corpo da resposta: ${response.body}');
    }
  } catch (e) {
    print('❌ Erro de conexão ou inesperado: $e');
  }
}
