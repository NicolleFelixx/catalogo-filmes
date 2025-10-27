# 🎬 Catálogo de Filmes

Aplicação web para gerenciamento de catálogo de filmes desenvolvida em Ruby on Rails.

🌐 **[VER APLICAÇÃO AO VIVO](https://catalogo-filmes-1.onrender.com)**

---

## 📋 Sobre o Projeto

Sistema completo de catálogo de filmes com autenticação, comentários e integração com IA para busca automática de informações.

**Desenvolvido por:** Nicolle Felix  
**Prazo:** 17/10/2025 a 26/10/2025  
**Desafio:** Estágio Backend - Mainô

---

## ✨ Funcionalidades Implementadas

### 🔹 Obrigatórias (15/15 - 100%)

- ✅ Listagem de filmes ordenada (mais novo → mais antigo)
- ✅ Paginação (6 filmes por página)
- ✅ Visualização detalhada (título, sinopse, ano, duração, diretor)
- ✅ Comentários anônimos (nome + conteúdo)
- ✅ Comentários ordenados (mais recente → mais antigo)
- ✅ Cadastro de usuários
- ✅ Recuperação de senha (funcional via SendGrid)
- ✅ Login/Logout
- ✅ CRUD completo de filmes (autenticado)
- ✅ Autorização (usuário só edita/apaga seus filmes)
- ✅ Comentários autenticados (nome vinculado)
- ✅ Edição de perfil
- ✅ Alteração de senha

### 🔹 Opcionais (4/7 - 57%)

- ✅ **Categorias** (many-to-many, múltiplas por filme)
- ✅ **Busca** (por título, diretor e ano)
- ✅ **Filtros** (por categoria)
- ✅ **Upload de imagens** (Active Storage)

### 🔹 Super Diferenciais

- ✅ **Integração com IA** (Google Gemini)
  - Busca automática de informações de filmes
  - Preenchimento de sinopse, ano, duração e diretor
  - Tratamento de erros

---

## 🛠️ Stack Tecnológica

- **Backend:** Ruby on Rails 7.1.5
- **Banco de Dados:** PostgreSQL
- **Frontend:** HTML, CSS (Bootstrap 5), JavaScript
- **Autenticação:** Devise
- **Upload de Arquivos:** Active Storage
- **Paginação:** Kaminari
- **IA:** Google Gemini API
- **Email:** SendGrid
- **Deploy:** Render

---

## 🚀 Como Rodar Localmente

### Pré-requisitos
- Ruby 3.4.7
- PostgreSQL
- Node.js

### Instalação
```bash
# Clone o repositório
git clone https://github.com/NicolleFelixx/catalogo-filmes.git
cd catalogo-filmes

# Instale as dependências
bundle install

# Configure o banco de dados
rails db:create db:migrate db:seed

# Configure variáveis de ambiente
# Crie um arquivo .env com:
# GEMINI_API_KEY=sua_chave_aqui
# SENDGRID_API_KEY=sua_chave_aqui

# Inicie o servidor
rails s
```

Acesse: http://localhost:3000

---

## 👤 Credenciais de Teste

**Email:** admin@example.com  
**Senha:** 123456

---

## 📧 Recuperação de Senha

A funcionalidade de recuperação de senha está **implementada e funcional** via SendGrid.

**Para testar:**
1. Clique em "Esqueceu sua senha?" na página de login
2. Digite um email de usuário cadastrado
3. O email será enviado via SendGrid

**Nota:** A funcionalidade está 100% implementada. Para receber o email de teste, cadastre-se com seu email real.

---

## 🎨 Funcionalidades da IA

No formulário de cadastro de filmes:
1. Digite o título do filme
2. Clique em "🔍 Buscar na IA"
3. Aguarde ~10 segundos
4. Campos preenchidos automaticamente!

**Filmes testados com sucesso:**
- Matrix
- Barbie
- A Viagem de Chihiro
- Vingadores

---

## 📂 Estrutura do Projeto
```
catalogo_filmes/
├── app/
│   ├── controllers/
│   ├── models/
│   ├── views/
│   └── services/
│       └── movie_ai_service.rb  # Integração com Gemini
├── config/
│   ├── routes.rb
│   └── environments/
├── db/
│   ├── migrate/
│   └── seeds.rb
└── README.md
```

---

## 🎯 Diferenciais Técnicos

- ✅ Código limpo e organizado
- ✅ Service Objects (MovieAiService)
- ✅ Relacionamentos N:N implementados
- ✅ Validações robustas
- ✅ Tratamento de erros
- ✅ Seeds com dados realistas
- ✅ Interface responsiva
- ✅ Commits organizados

---

## 📸 Screenshots

- Listagem de filmes com paginação ✅
- Busca com IA funcionando ✅
- Sistema de categorias ✅
- Upload de posters ✅

---

## 📞 Contato

**Nicolle Felix**  
GitHub: [github.com/NicolleFelixx](https://github.com/NicolleFelixx)

---

**Desenvolvido com ❤️ para o Desafio Técnico Mainô**