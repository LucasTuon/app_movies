# App de Filmes

### Visão Geral

Este projeto é um aplicativo de filmes desenvolvido em Flutter, com o objetivo de demonstrar habilidades de desenvolvimento mobile, incluindo o consumo de APIs, gerenciamento de estado e navegação entre telas. O aplicativo permite ao usuário explorar listas de filmes populares, em cartaz e com as melhores avaliações, além de pesquisar por títulos específicos e gerenciar uma lista de filmes favoritos.

### Recursos

- **Exploração de Filmes**: Navegue por listas categorizadas de filmes (Populares, Em Cartaz e Melhores Avaliados).
- **Detalhes do Filme**: Veja informações detalhadas sobre cada filme, incluindo sinopse, data de lançamento, duração, gêneros e elenco principal.
- **Pesquisa**: Use a barra de pesquisa para encontrar filmes específicos por título.
- **Lista de Favoritos**: Adicione ou remova filmes de uma lista de favoritos, que persiste durante a sessão do aplicativo.
- **UI Responsiva**: A interface foi projetada para se adaptar a diferentes tamanhos de tela.

---

### API

Este aplicativo utiliza a API pública do **The Movie Database (TMDB)** para obter todas as informações sobre filmes e atores. A chave da API está configurada no arquivo `movie_services.dart` e é necessária para que as requisições funcionem.

As principais chamadas API usadas no projeto são:

- `GET /movie/popular`: Obtém a lista de filmes populares.
- `GET /movie/now_playing`: Obtém a lista de filmes em exibição.
- `GET /movie/top_rated`: Obtém a lista de filmes com as melhores avaliações.
- `GET /search/movie`: Realiza a pesquisa de filmes por título.
- `GET /movie/{movie_id}`: Retorna os detalhes de um filme específico.
- `GET /movie/{movie_id}/credits`: Retorna o elenco e equipe de um filme.

---

### Aprimoramentos Futuros

- **Autenticação de Usuário**: Implementar um sistema de login para que cada usuário possa ter sua própria lista de favoritos, persistindo entre sessões (mesmo após fechar o app).
- **Mais Categorias**: Adicionar mais seções de filmes, como os que serão lançados em breve.
- **Pagina de Mais**: A Pagina de mais ainda é só um conceito, não tendo sua implementação real.
- **Testes**: Escrever testes unitários e de widget para garantir a estabilidade e o bom funcionamento do código.

---

### Referências

- **Flutter**: [https://docs.flutter.dev/](https://docs.flutter.dev/)
- **Dart**: [https://dart.dev/guides](https://dart.dev/guides)
- **API TMDB**: [https://developer.themoviedb.org/docs](https://developer.themoviedb.org/docs)
- **Ícones do Google (Material Icons)**: [https://fonts.google.com/icons](https://fonts.google.com/icons)
- **Barra de Navegação (BottomAppBar)**: [https://api.flutter.dev/flutter/material/BottomAppBar-class.html](https://api.flutter.dev/flutter/material/BottomAppBar-class.html)
- **Guia para Consumo da API TMDB**: [Medium](https://medium.com/@amrendrachoudhary664/movie-app-in-flutter-with-tmdb-api-a9c08647e33e) [GeeksforGeeks](https://www.geeksforgeeks.org/flutter-rest-api-with-the-movie-database-tmdb/)
- **Tutorial Oficial do Flutter**: [https://www.youtube.com/watch?v=8sAyPDLorek](https://www.youtube.com/watch?v=8sAyPDLorek)
- **Vídeo do Felipe Deschamps**: [https://www.youtube.com/watch?v=J4BVaXkwmM8](https://www.youtube.com/watch?v=J4BVaXkwmM8)
