# app/services/movie_ai_service.rb

require 'httparty'

class MovieAiService
  include HTTParty
  
  API_KEY = GEMINI_API_KEY
  BASE_URI = "https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent"

  def self.fetch_movie_data(title)
    # Validação básica
    return { error: 'Título não pode estar vazio' } if title.blank?
    
    # Monta o prompt para a IA
    prompt = build_prompt(title)
    
    # Faz a requisição para a API
    response = make_api_request(prompt)
    
    # Processa a resposta
    parse_response(response)
  rescue StandardError => e
    # Se der erro, retorna mensagem
    { error: "Erro ao buscar dados: #{e.message}" }
  end

  private

  def self.build_prompt(title)
    <<~PROMPT
      Você é um assistente que fornece informações sobre filmes.
      Para o filme "#{title}", retorne APENAS um JSON válido com estas informações:
      
      {
        "synopsis": "sinopse do filme em português do Brasil (máximo 400 caracteres)",
        "release_year": ano de lançamento (número inteiro, exemplo: 1999),
        "duration": duração em minutos (número inteiro, exemplo: 136),
        "director": "nome completo do diretor"
      }
      
      REGRAS IMPORTANTES:
      - Retorne APENAS o JSON, sem texto adicional antes ou depois
      - NÃO use markdown (```json)
      - Se o filme não existir, retorne: {"error": "Filme não encontrado"}
      - Use aspas duplas no JSON
      - Não adicione comentários
    PROMPT
  end

  def self.make_api_request(prompt)
    url = "#{BASE_URI}?key=#{API_KEY}"
    
    body = {
      contents: [{
        parts: [{
          text: prompt
        }]
      }],
      generationConfig: {
        temperature: 0.3,
        maxOutputTokens: 1000
      }
    }
    
    response = HTTParty.post(
      url,
      headers: { 'Content-Type' => 'application/json' },
      body: body.to_json,
      timeout: 30
    )
    
    unless response.success?
      raise "API retornou erro: #{response.code} - #{response.body}"
    end
    
    response.parsed_response
  end

  def self.parse_response(api_response)
    # Extrai o texto da resposta da API
    text = api_response.dig('candidates', 0, 'content', 'parts', 0, 'text')
    
    return { error: 'Resposta vazia da API' } unless text
    
    # Remove markdown code blocks e quebras de linha
    clean_text = text
      .gsub(/```json\n?/, '')     # Remove ```json no início
      .gsub(/```\n?/, '')          # Remove ``` no fim
      .gsub(/\n/, ' ')             # Substitui quebras de linha por espaço
      .strip                       # Remove espaços nas extremidades
    
    # Log para debug
    Rails.logger.info("Texto limpo: #{clean_text[0..100]}...")
    
    # Converte JSON para hash
    data = JSON.parse(clean_text)
    
    # Valida se tem os campos necessários
    if data['error']
      { error: data['error'] }
    elsif data['synopsis'] && data['release_year'] && data['duration'] && data['director']
      {
        synopsis: data['synopsis'].to_s.strip,
        release_year: data['release_year'].to_i,
        duration: data['duration'].to_i,
        director: data['director'].to_s.strip
      }
    else
      { error: 'Dados incompletos retornados pela IA' }
    end
  rescue JSON::ParserError => e
    Rails.logger.error("Erro ao parsear JSON: #{e.message}")
    Rails.logger.error("Texto recebido: #{clean_text}")
    { error: "Erro ao processar resposta da IA. Tente novamente." }
  end
end