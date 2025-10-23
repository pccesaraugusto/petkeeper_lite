const functions = require('firebase-functions');
const admin = require('firebase-admin');
const cors = require('cors')({ origin: true }); // permite todas as origens

admin.initializeApp();

exports.notifyFamily = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    if (req.method !== 'POST') {
      return res.status(405).send('Método não permitido');
    }

    const { petId, mensagem } = req.body;

    if (!petId || !mensagem) {
      return res.status(400).send('Campos obrigatórios ausentes');
    }

    try {
      await admin.firestore().collection('notificacoes').add({
        petId,
        mensagem,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
      });

      res.status(200).send('✅ Notificação enviada com sucesso!');
    } catch (error) {
      console.error('Erro ao salvar notificação:', error);
      res.status(500).send(`❌ Erro ao enviar notificação: ${error.message}`);
    }
  });
});
