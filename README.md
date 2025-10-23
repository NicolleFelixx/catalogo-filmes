# 🎬 Catálogo de Filmes

Aplicação web desenvolvida em Ruby on Rails para gerenciamento de catálogo de filmes com autenticação de usuários, sistema de comentários e integração com IA.

**Desafio Técnico - Mainô**

---

## 🚀 Tecnologias Utilizadas

- **Ruby** 3.4.0
- **Rails** 7.1.5.2
- **PostgreSQL** (banco de dados)
- **Bootstrap** 5.3.0 (interface)
- **Devise** (autenticação)
- **Kaminari** (paginação)
- **Active Storage** (upload de imagens)
- **HTTParty** (requisições HTTP)
- **Google Gemini AI** (preenchimento automático de dados)

---

## ✨ Funcionalidades

### 🌐 Área Pública (sem login)

- ✅ Listagem de filmes ordenados do mais novo para o mais antigo
- ✅ Paginação com 6 filmes por página
- ✅ Visualização completa dos detalhes do filme
- ✅ Sistema de comentários anônimos
- ✅ Comentários ordenados do mais recente para o mais antigo
- ✅ Cadastro de novos usuários
- ✅ Recuperação de senha
- ✅ Busca por título, diretor ou ano
- ✅ Filtro por categoria

### 🔐 Área Autenticada (com login)

- ✅ Logout
- ✅ Cadastro de novos filmes
- ✅ Edição de filmes (apenas do próprio usuário)
- ✅ Exclusão de filmes (apenas do próprio usuário)
- ✅ Comentários vinculados ao usuário automaticamente
- ✅ Edição de perfil
- ✅ Alteração de senha

### ⭐ Funcionalidades Opcionais Implementadas

- ✅ **Categorias de filmes** (many-to-many relationship)
  - 12 categorias predefinidas (Ação, Comédia, Drama, etc)
  - Filmes podem ter múltiplas categorias
  - Badges coloridas por categoria
  
- ✅ **Busca avançada**
  - Busca por título, diretor ou ano de lançamento
  - Integrada com filtros de categoria
  
- ✅ **Filtros por categoria**
  - Dropdown na navbar com contador de filmes
  - Combinável com busca
  
- ✅ **Upload de imagem (poster)**
  - Active Storage para gerenciamento
  - Placeholder para filmes sem poster
  - Visualização nos cards e página de detalhes

### 🌟 Super Diferencial Implementado

- ✅ **Busca e preenchimento automático com IA**
  - Integração com Google Gemini AI
  - Busca filme por título
  - Preenche automaticamente: sinopse, ano, duração e diretor
  - Sistema de retry (3 tentativas)
  - Tratamento robusto de erros
  - Fallback para preenchimento manual

---

## 🛠️ Pré-requisitos

Antes de começar, você precisa ter instalado:

- Ruby 3.4.0 ou superior
- Rails 7.1.5 ou superior
- PostgreSQL 12 ou superior
- Node.js (para gerenciamento de assets)

---

## 📥 Instalação e Configuração

### 1. Clone o repositório
```bash
git clone https://github.com/NicolleFelixx/catalogo-filmes.git
cd catalogo-filmes
```

### 2. Instale as dependências
```bash
bundle install
```

### 3. Configure o banco de dados

Edite o arquivo `config/database.yml` com suas credenciais do PostgreSQL.
```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Configure as variáveis de ambiente

Crie um arquivo `config/initializers/gemini.rb` com sua API key do Google Gemini:
```ruby
GEMINI_API_KEY = 'SUA_API_KEY_AQUI'
```

**Como obter a API key:**
1. Acesse [Google AI Studio](https://aistudio.google.com/)
2. Crie uma nova API key
3. Copie e cole no arquivo acima

⚠️ **Importante:** Não commite este arquivo! Ele está no `.gitignore` para proteger sua chave.

### 5. Inicie o servidor
```bash
rails server
```

Acesse: `http://localhost:3000`

---

## 👥 Usuários de Teste

O seed cria usuários de exemplo:
```
Email: admin@example.com
Senha: 123456

Email: user1@example.com
Senha: 123456

Email: user2@example.com
Senha: 123456
```

---

## 🎨 Estrutura do Projeto
```
app/
├── controllers/
│   ├── application_controller.rb    # Carrega categorias globalmente
│   ├── movies_controller.rb         # CRUD de filmes + busca + filtros
│   └── comments_controller.rb       # Sistema de comentários
├── models/
│   ├── movie.rb                     # Model principal com validações
│   ├── category.rb                  # Categorias de filmes
│   ├── movie_category.rb            # Join table (many-to-many)
│   ├── comment.rb                   # Comentários
│   └── user.rb                      # Usuários (Devise)
├── services/
│   └── movie_ai_service.rb          # Integração com Google Gemini AI
├── views/
│   ├── movies/                      # Views de filmes
│   ├── layouts/                     # Layout principal
│   └── devise/                      # Views de autenticação
└── helpers/
    └── movies_helper.rb             # Helper para cores de categorias
```

---

## 🤖 Funcionalidade de IA

A busca inteligente utiliza a API do Google Gemini para buscar informações sobre filmes.

**Como usar:**
1. Acesse "Novo Filme"
2. Digite o título do filme no campo de busca IA
3. Clique em "🔍 Buscar na IA"
4. Aguarde ~10-15 segundos
5. Os campos serão preenchidos automaticamente
6. Revise e edite se necessário
7. Salve o filme

**Tratamento de erros:**
- Retry automático (3 tentativas) em caso de falha
- Timeout de 30 segundos por requisição
- Mensagens amigáveis ao usuário
- Fallback para preenchimento manual

---

## 🗂️ Categorias

12 categorias predefinidas:
- Ação
- Aventura
- Comédia
- Drama
- Ficção Científica
- Terror
- Romance
- Suspense
- Animação
- Documentário
- Musical
- Fantasia

Cada filme pode ter múltiplas categorias associadas.

---

## 🔍 Busca e Filtros

**Busca:**
- Campo de busca na navbar
- Busca por: título, diretor ou ano
- Case-insensitive

**Filtros:**
- Dropdown de categorias na navbar
- Contador de filmes por categoria
- Filtros combinam com busca
- Badges visuais de filtros ativos

---

## 📸 Upload de Imagens

Utiliza Active Storage para gerenciamento de posters:
- Formatos suportados: JPG, PNG, GIF
- Tamanho máximo recomendado: 5MB
- Placeholder automático para filmes sem poster

---

## 🔒 Segurança e Autenticação

- Autenticação via Devise
- Autorização por usuário
- Apenas o criador pode editar/excluir seus filmes
- CSRF protection ativo
- Senhas criptografadas com bcrypt

---

## 📱 Responsividade

Interface totalmente responsiva com Bootstrap:
- Mobile-friendly
- Navbar adaptativa
- Grid system responsivo
- Componentes otimizados para touch

---

## 🚀 Deploy

### Produção (Render)

1. Crie uma conta no [Render](https://render.com)
2. Crie um novo Web Service conectando ao repositório GitHub
3. Configure as variáveis de ambiente:
   - `DATABASE_URL` (Render cria automaticamente com PostgreSQL)
   - `GEMINI_API_KEY` (sua chave da API)
   - `RAILS_MASTER_KEY` (da pasta `config/master.key`)
4. Build Command: `bundle install && rails db:migrate && rails db:seed`
5. Start Command: `rails server -b 0.0.0.0`

---

## 🧪 Testes

Para rodar os testes (quando implementados):
```bash
rails test
```

---

## 📝 Funcionalidades Implementadas

### Obrigatórias ✅ (15/15 - 100%)
- [x] Listagem ordenada de filmes
- [x] Paginação (6 por página)
- [x] Detalhes do filme
- [x] Comentários anônimos
- [x] Comentários ordenados
- [x] Cadastro de usuário
- [x] Recuperação de senha
- [x] Logout
- [x] CRUD de filmes
- [x] Autorização por usuário
- [x] Comentários com usuário vinculado
- [x] Editar perfil
- [x] Alterar senha

### Opcionais ✅ (4/7 - 57%)
- [x] Categorias de filmes
- [x] Busca por título, diretor e ano
- [x] Filtros por categoria
- [x] Upload de imagem (poster)
- [ ] Tags
- [ ] I18n (PT/EN)
- [ ] Testes automatizados

### Super Diferenciais ✅ (1/2 - 50%)
- [x] IA para buscar e preencher dados do filme
- [ ] Importação em massa via CSV + Sidekiq

---

## 👨‍💻 Desenvolvido por

**Nicolle Felix**

- GitHub: [@NicolleFelixx](https://github.com/NicolleFelixx)
- LinkedIn: [https://www.linkedin.com/in/nicolle-felix-4ab62b2aa/]
- Email: [nicolle.felix2002@gmail.com]

---

## 📄 Licença

Este projeto foi desenvolvido como parte do Desafio Técnico da Mainô.

---

## 🙏 Agradecimentos

- Mainô pela oportunidade do desafio
- Google Gemini AI pela API
- Comunidade Rails pelo suporte

---

**Desenvolvido com ❤️ usando Ruby on Rails**