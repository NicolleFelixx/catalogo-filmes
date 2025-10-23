# Limpar banco
puts "🧹 Limpando banco de dados..."
Comment.destroy_all
Movie.destroy_all
User.destroy_all

# Criar usuários
puts "👤 Criando usuários..."
user1 = User.create!(
  email: 'admin@example.com',
  password: '123456',
  password_confirmation: '123456'
)

user2 = User.create!(
  email: 'user@example.com',
  password: '123456',
  password_confirmation: '123456'
)

puts "✅ #{User.count} usuários criados"

# Criar filmes
puts "🎬 Criando filmes..."

movie1 = Movie.create!(
  title: 'O Poderoso Chefão',
  synopsis: 'A história da família Corleone, uma das mais poderosas famílias do crime organizado de Nova York.',
  release_year: 1972,
  duration: 175,
  director: 'Francis Ford Coppola',
  user: user1
)

movie2 = Movie.create!(
  title: 'Pulp Fiction',
  synopsis: 'Histórias interligadas de criminosos em Los Angeles.',
  release_year: 1994,
  duration: 154,
  director: 'Quentin Tarantino',
  user: user1
)

movie3 = Movie.create!(
  title: 'Matrix',
  synopsis: 'Um hacker descobre a verdadeira natureza de sua realidade.',
  release_year: 1999,
  duration: 136,
  director: 'Lana e Lilly Wachowski',
  user: user2
)

movie4 = Movie.create!(
  title: 'Inception',
  synopsis: 'Um ladrão que rouba segredos através da tecnologia de invasão de sonhos.',
  release_year: 2010,
  duration: 148,
  director: 'Christopher Nolan',
  user: user2
)

movie5 = Movie.create!(
  title: 'Parasita',
  synopsis: 'Uma família pobre se infiltra na vida de uma família rica.',
  release_year: 2019,
  duration: 132,
  director: 'Bong Joon-ho',
  user: user1
)

movie6 = Movie.create!(
  title: 'Interestelar',
  synopsis: 'Exploradores viajam através de um buraco de minhoca no espaço.',
  release_year: 2014,
  duration: 169,
  director: 'Christopher Nolan',
  user: user2
)

movie7 = Movie.create!(
  title: 'O Cavaleiro das Trevas',
  synopsis: 'Batman enfrenta o Coringa em Gotham City.',
  release_year: 2008,
  duration: 152,
  director: 'Christopher Nolan',
  user: user1
)

puts "✅ #{Movie.count} filmes criados"

# Criar comentários
puts "💬 Criando comentários..."

Comment.create!(
  content: 'Obra-prima absoluta do cinema!',
  name: 'João Silva',
  movie: movie1
)

Comment.create!(
  content: 'Um dos melhores filmes que já vi!',
  movie: movie1,
  user: user2
)

Comment.create!(
  content: 'Tarantino é um gênio!',
  name: 'Maria Santos',
  movie: movie2
)

Comment.create!(
  content: 'Revolucionou o cinema de ficção científica.',
  movie: movie3,
  user: user1
)

Comment.create!(
  content: 'Filme incrível!',
  name: 'Pedro Oliveira',
  movie: movie4
)

puts "✅ #{Comment.count} comentários criados"

puts ""
puts "🎉 Seeds concluído com sucesso!"
puts "📊 Resumo:"
puts "   👤 Usuários: #{User.count}"
puts "   🎬 Filmes: #{Movie.count}"
puts "   💬 Comentários: #{Comment.count}"
puts ""
puts "🔑 Credenciais de teste:"
puts "   Email: admin@example.com"
puts "   Senha: 123456"
# Categorias
puts "Criando categorias..."

categories = [
  "Ação",
  "Aventura",
  "Comédia",
  "Drama",
  "Ficção Científica",
  "Terror",
  "Romance",
  "Suspense",
  "Animação",
  "Documentário",
  "Musical",
  "Fantasia"
]

categories.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

puts "✅ #{Category.count} categorias criadas!"

# Associar categorias aos filmes existentes
puts "Associando categorias aos filmes..."

if Movie.exists?
  Movie.all.each do |movie|
    # Adiciona 2-3 categorias aleatórias para cada filme
    random_categories = Category.all.sample(rand(2..3))
    movie.categories << random_categories unless movie.categories.any?
  end
  puts "✅ Categorias associadas aos filmes!"
end

puts "\n🎉 Seeds concluídos!"# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
