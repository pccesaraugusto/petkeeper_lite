const express = require('express');
const cors = require('cors');
const admin = require('firebase-admin');

const app = express();
app.use(cors());
app.use(express.json());

// Corrige a chave vinda da variável de ambiente
const serviceAccount = JSON.parse(process.env.FIREBASE_CONFIG);
serviceAccount.private_key = serviceAccount.private_key.replace(/\\n/g, '\n');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});


const db = admin.firestore();

app.post('/notifyFamily', async (req, res) => {
  const { petId, mensagem } = req.body;

  if (!petId || !mensagem) {
    return res.status(400).send('Campos obrigatórios ausentes');
  }

  try {
    await db.collection('notificacoes').add({
      petId,
      mensagem,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    res.status(200).send('✅ Notificação enviada com sucesso!');
  } catch (error) {
    console.error('Erro ao salvar notificação:', error);
    res.status(500).send(`❌ Erro: ${error.message}`);
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
