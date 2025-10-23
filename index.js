const express = require('express');
const cors = require('cors');
const admin = require('firebase-admin');

const app = express();

// ✅ Configuração de CORS para permitir chamadas do Flutter Web
app.use(cors({
  origin: true, // ou substitua por 'http://localhost:57224' se quiser restringir
  methods: ['GET', 'POST', 'OPTIONS'],
  allowedHeaders: ['Content-Type']
}));

app.use(express.json());

// ✅ Carrega e corrige a chave do Firebase vinda da variável de ambiente
const serviceAccount = JSON.parse(process.env.FIREBASE_CONFIG);
serviceAccount.private_key = serviceAccount.private_key.replace(/\\n/g, '\n');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

// ✅ Rota principal para notificar a família
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

// ✅ Rota de teste opcional
app.get('/', (req, res) => {
  res.send('🚀 API PetKeepr está rodando com sucesso!');
});

// ✅ Inicia o servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
