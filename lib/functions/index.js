const functions = require('firebase-functions');

// Função Firebase Callable — compatível com Flutter Web
exports.notifyFamily = functions.https.onCall((data, context) => {
  const petId = data.petId;
  const message = data.message;

  // Verificação básica
  if (!petId || !message) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Parâmetros petId e message são obrigatórios.'
    );
  }

  console.log(`🔔 Notificando família do pet ${petId}: ${message}`);

  // Aqui você pode adicionar lógica extra, como salvar no Firestore

  return {
    success: true,
    message: `Família do pet ${petId} foi notificada com a mensagem: "${message}".`,
  };
});
