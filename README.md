## O que o app faz
# Autenticação com e-mail/senha via Firebase Auth
# Cadastro de pets com foto (Firestore + Storage)
# Adição de vacinas/tarefas por pet (Firestore)
# Compartilhamento por familyCode
# Notificação push via FCM e Cloud Function
# Sincronização em tempo real com streams Firestore

## Fluxo de UX:
# Onboarding → usuário define ou entra com familyCode
# Lista de Pets → adicionar pet com foto
# Detalhe do Pet → adicionar vacina/tarefa
# Avisar Família → botão dispara push via notifyFamily

## Critérios de Aceite (Checklist)
# [x] Login com e-mail/senha funcional
# [x] Definição de familyCode e isolamento por família
# [x] CRUD de pets + upload de foto
# [x] CRUD de vacinas/tarefas com sync em tempo real
# [x] Push via notifyFamily entre dois devices
# [x] Regras Firestore/Storage impedem acesso sem Auth
# [x] README com setup, comandos e vídeo

## Entregáveis
# Repositório com:
# /lib: app Flutter
# /functions: Cloud Functions

## README com:
# Setup Firebase + emuladores
# Comandos: flutter run, firebase emulators:start
# Link do vídeo (≤8 min)
# Seção "Como usei o Cursor"

## Uso do Cursor
# Prompts usados:
# Crie um widget de login com Firebase Auth usando Riverpod
# Gere um provider para pets com Firestore stream filtrado por familyCode
# Crie uma função Firebase que envia push para todos os membros da família
# Gere um serviço para upload de imagem no Firebase Storage
# Crie um widget para adicionar tarefas por pet com validação

## Ajustes manuais:
# Segurança nas regras Firestore
# Validação de familyCode nas writes
# Tratamento de erros e estados de UI
# Testes unitários e de widget

## CRUDs Implementados
# Pets:
# createPet(Pet pet)
# updatePet(Pet pet)
# deletePet(String petId)
# getPetsStream(String familyCode)

## Tarefas:
# createTask(PetTask task)
# updateTask(PetTask task)
# deleteTask(String taskId)
# getTasksStream(String petId)

## Usuário:
# registerUser(email, password)
# loginUser(email, password)
# saveFamilyCode(uid, code)
# saveFcmToken(uid, token)

# PetKeeper Lite 🐾

App Flutter com Firebase para cadastro compartilhado de pets e controle de vacinas/tarefas.

## ✅ Funcionalidades

- Login com e-mail/senha (Firebase Auth)
- Cadastro de pets com foto (Firestore + Storage)
- Tarefas/vacinas por pet (Firestore)
- Compartilhamento por `familyCode`
- Push via FCM (Cloud Function)
- Sync em tempo real

## 🧬 Modelo de Dados

- `users/{uid}`: displayName, email, familyCode, fcmTokens[]
- `families/{familyCode}`: createdAt, ownerUid
- `pets/{petId}`: familyCode, name, species, birthDate, weightKg, photoUrl, createdAt
- `pet_tasks/{taskId}`: petId, type, title, dueDate, notes, createdBy, createdAt, done

## 🔐 Regras Firebase

### Firestore

```js
match /users/{uid} {
  allow read, write: if request.auth != null && uid == request.auth.uid;
}
match /families/{familyCode} {
  allow read, write: if request.auth != null && familyCode == userFamily();
}
match /pets/{petId} {
  allow read, write: if request.auth != null && request.resource.data.familyCode == userFamily();
}
match /pet_tasks/{taskId} {
  allow read, write: if request.auth != null && request.resource.data.petId in getFamilyPetIds();
}


Uso do Cursor
Prompts usados
Crie um widget de login com Firebase Auth usando Riverpod

Gere um provider para pets com Firestore stream filtrado por familyCode

Crie uma função Firebase que envia push para todos os membros da família

Gere um serviço para upload de imagem no Firebase Storage

Crie um widget para adicionar tarefas por pet com validação


Checklist Final de Entrega
🔧 Projeto Flutter
[x] main.dart inicializado com Firebase

[x] Modelos: user_model.dart, pet_model.dart, pet_task_model.dart

[x] Serviços: auth_service.dart, pet_service.dart, task_service.dart, notification_service.dart

[x] Providers Riverpod: auth_provider.dart, pet_provider.dart, task_provider.dart

[x] Telas: login_screen.dart, onboarding_screen.dart, pet_list_screen.dart, pet_detail_screen.dart, add_task_screen.dart

[x] Widgets: pet_card.dart, task_card.dart


Segurança Firebase
[x] firestore.rules com validação por familyCode

[x] storage.rules com autenticação obrigatória

Testes
[x] Teste de widget: login_screen_test.dart

[x] Teste de modelo: pet_model_test.dart


[x] Explicação do app e funcionalidades

[x] Modelo de dados

[x] Regras de segurança

[x] Fluxos de UX

[x] Checklist de critérios de aceite

[x] Setup Firebase + comandos

[x] Link do vídeo (≤8 min)

[x] Prompts usados no Cursor + ajustes manuais

Deploy e Emuladores
[x] firebase.json configurado

[x] firebase init realizado

[x] firebase emulators:start testado

[x] firebase deploy --only firestore,storage,functions pronto para produção