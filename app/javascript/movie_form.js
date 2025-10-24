window.fetchMovieDataFromAI = function() {
  console.log('Função chamada!');
  
  const title = document.getElementById('ai_search_title')?.value.trim();
  const loadingDiv = document.getElementById('ai-loading');
  const resultDiv = document.getElementById('ai-result');

  if (!title) {
    if (resultDiv) {
      resultDiv.innerHTML = '<div class="alert alert-warning">Por favor, digite o título do filme.</div>';
    }
    return;
  }

  if (loadingDiv) loadingDiv.style.display = 'block';
  if (resultDiv) resultDiv.innerHTML = '';

  fetch('/movies/fetch_ai_data', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    },
    body: JSON.stringify({ title: title })
  })
  .then(response => response.json())
  .then(data => {
    if (loadingDiv) loadingDiv.style.display = 'none';

    if (data.error) {
      if (resultDiv) resultDiv.innerHTML = `<div class="alert alert-danger">${data.error}</div>`;
    } else {
      const synopsisField = document.getElementById('movie_synopsis');
      const yearField = document.getElementById('movie_release_year');
      const durationField = document.getElementById('movie_duration');
      const directorField = document.getElementById('movie_director');
      
      if (synopsisField) synopsisField.value = data.synopsis || '';
      if (yearField) yearField.value = data.release_year || '';
      if (durationField) durationField.value = data.duration || '';
      if (directorField) directorField.value = data.director || '';

      if (resultDiv) {
        resultDiv.innerHTML = '<div class="alert alert-success">✅ Dados preenchidos com sucesso!</div>';
        setTimeout(() => {
          resultDiv.innerHTML = '';
        }, 3000);
      }
    }
  })
  .catch(error => {
    if (loadingDiv) loadingDiv.style.display = 'none';
    if (resultDiv) resultDiv.innerHTML = '<div class="alert alert-danger">Erro ao buscar dados. Tente novamente.</div>';
    console.error('Erro:', error);
  });
}