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

### Imagens

<img width="200" height="400" alt="image" src="https://github.com/user-attachments/assets/2aad8f59-2b69-427d-b36f-d0420990e38c" /> <img width="200" height="400" alt="image" src="https://github.com/user-attachments/assets/5313e6f3-0656-4e23-9bde-8a474b25a964" /> <img width="200" height="400" alt="image" src="https://github.com/user-attachments/assets/965e3fe1-964d-4384-b14a-0cc3d1326789" /> <img width="200" height="400" alt="image" src="https://github.com/user-attachments/assets/a061abe9-657c-4d93-8d66-18943ce1666d" /> <img width="200" height="400" alt="image" src="https://github.com/user-attachments/assets/f8cdd3f0-b6f5-492e-bf4f-8dec6faae904" />






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
- **Acessibilidade: Implementar recursos de acessibilidade**

---

### Referências

- **Flutter**: [https://docs.flutter.dev/](https://docs.flutter.dev/)
- **Dart**: [https://dart.dev/guides](https://dart.dev/guides)
- **API TMDB**: [https://developer.themoviedb.org/docs](https://developer.themoviedb.org/docs)
- **Ícones do Google (Material Icons)**: [https://fonts.google.com/icons](https://fonts.google.com/icons)
- **Barra de Navegação (BottomAppBar)**: [https://api.flutter.dev/flutter/material/BottomAppBar-class.html](https://api.flutter.dev/flutter/material/BottomAppBar-class.html)
- **Guia para Consumo da API TMDB**: [DEV Comunnity(https://dev.to/alamjamshed17777/getting-started-with-the-tmdb-api-a-beginners-guide-52li)
- **Tutorial Oficial do Flutter**: [https://www.youtube.com/watch?v=8sAyPDLorek](https://www.youtube.com/watch?v=8sAyPDLorek)
- **Vídeo do Felipe Deschamps**: [https://www.youtube.com/watch?v=J4BVaXkwmM8](https://www.youtube.com/watch?v=J4BVaXkwmM8)
