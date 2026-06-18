# 📝 Todo App — Sistema de Tarefas Pessoais

Aplicativo mobile/web desenvolvido com **Flutter** e **Firebase**, como projeto avaliativo da disciplina de Desenvolvimento Mobile

---

## 📱 Descrição do Aplicativo

O **Todo App** é um sistema de gerenciamento de tarefas pessoais com autenticação de usuário. Cada usuário possui uma conta individual e acessa somente as suas próprias tarefas, garantindo privacidade e segurança dos dados.

---

## ✅ Funcionalidades Principais

| Funcionalidade | Descrição |
|---|---|
| 🔐 **Login** | Autenticação com e-mail e senha |
| 📋 **Cadastro** | Criação de conta com validação de campos |
| 🚪 **Logout** | Encerramento seguro da sessão |
| 🔒 **Proteção de rotas** | Telas acessíveis somente após autenticação |
| ➕ **Criar tarefa** | Formulário com título e descrição |
| 📖 **Listar tarefas** | Visualização em tempo real das tarefas do usuário |
| ✏️ **Editar tarefa** | Atualização de título e descrição |
| 🗑️ **Deletar tarefa** | Exclusão com confirmação |
| ✅ **Concluir tarefa** | Marcação de tarefas como concluídas |
| 📊 **Progresso** | Barra de progresso com percentual de tarefas concluídas |
| ⚠️ **Tratamento de erros** | Mensagens em português para erros de autenticação |

---

## 🛠️ Tecnologias Utilizadas

- **Flutter** 3.x — Framework de desenvolvimento multiplataforma
- **Dart** — Linguagem de programação
- **Firebase Authentication** — Autenticação de usuários com e-mail e senha
- **Cloud Firestore** — Banco de dados NoSQL em tempo real
- **FlutterFire CLI** — Ferramenta de integração Flutter + Firebase

---

## 📁 Estrutura do Projeto

```
/lib
├── main.dart                    # Entrada do app + AuthGate (proteção de rotas)
├── firebase_options.dart        # Configurações do Firebase (gerado automaticamente)
│
├── /screens
│   ├── login_screen.dart        # Tela de login
│   ├── register_screen.dart     # Tela de cadastro
│   ├── home_screen.dart         # Tela principal com lista de tarefas
│   └── task_form_screen.dart    # Formulário de criar/editar tarefas
│
├── /services
│   ├── auth_service.dart        # Serviço de autenticação (login, cadastro, logout)
│   └── database_service.dart   # Serviço de CRUD no Firestore
│
├── /models
│   └── task_model.dart          # Modelo de dados da tarefa
│
└── /widgets                     # Componentes reutilizáveis (disponível para expansão)
```

---

## 🔐 Autenticação

A autenticação é feita via **Firebase Authentication** com e-mail e senha.

- O `AuthService` encapsula todas as operações de autenticação
- Erros do Firebase são tratados e traduzidos para português
- O `AuthGate` no `main.dart` monitora o estado de autenticação via `Stream` e redireciona automaticamente para Login ou Home
- Nenhuma tela protegida é acessível sem sessão ativa

---

## 🗄️ Banco de Dados (Firestore)

As tarefas são armazenadas no **Cloud Firestore** com a seguinte estrutura:

```
users/
  {userId}/
    tasks/
      {taskId}/
        title: string
        description: string
        isDone: boolean
        createdAt: timestamp
```

- Cada usuário acessa **apenas os próprios dados** (regras de segurança do Firestore)
- A listagem de tarefas usa `Stream` para atualização em **tempo real**

---

## 🚀 Como Executar o Projeto

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado
- [Android Studio](https://developer.android.com/studio) ou emulador/dispositivo Android
- [Node.js](https://nodejs.org) instalado
- Conta no [Firebase](https://console.firebase.google.com)

### Passo 1 — Clonar o repositório

```bash
git clone https://github.com/SEU_USUARIO/todo_app.git
cd todo_app
```

### Passo 2 — Instalar dependências

```bash
flutter pub get
```

### Passo 3 — Configurar o Firebase

1. Crie um projeto no [Firebase Console](https://console.firebase.google.com)
2. Ative **Authentication → E-mail/senha**
3. Crie o **Firestore Database** em modo de teste
4. Instale o FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```
5. Configure o projeto:
   ```bash
   flutterfire configure
   ```
   Isso irá gerar automaticamente o arquivo `lib/firebase_options.dart`

6. Configure as regras do Firestore (aba "Regras"):
   ```
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{userId}/{document=**} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
     }
   }
   ```

### Passo 4 — Rodar o aplicativo

```bash
# Android (com emulador ou dispositivo conectado)
flutter run

# Web (Chrome)
flutter run -d chrome
```

---

## 📸 Telas do Aplicativo

| Tela | Descrição |
|---|---|
| Login | Campo de e-mail e senha com validação e mensagens de erro |
| Cadastro | Criação de conta com confirmação de senha |
| Home | Lista de tarefas com barra de progresso, marcar, editar e deletar |
| Formulário | Criar ou editar tarefas com título e descrição |

---

## 👨‍🎓 Informações Acadêmicas

- **Instituição:** FATEC
- **Disciplina:** Desenvolvimento Mobile
- **Aluno:** Arthur Aliberti
- **Tecnologias:** Flutter + Firebase

---

## 📄 Licença

Projeto acadêmico — uso educacional.
