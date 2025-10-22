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