import 'package:flutter/material.dart';
import '/services/movie_services.dart';
import '/pages/movie_detail_page.dart';
import '../services/global.dart' as global; // Importa o arquivo da variavel global

// Widget de estado para a pagina de favoritos
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    // Acessa a lista de filmes favoritos diretamente da variavel global
    final List<dynamic> favoriteMovies = global.favoriteMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Favoritos'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: 45.0,
      ),
      // Se a lista de favoritos estiver vazia, exibe uma mensagem
      body: favoriteMovies.isEmpty
          ? const Center(
              child: Text(
                'Voce ainda nao tem filmes favoritos.',
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          // Caso contrario, constroi uma lista de filmes
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                // Cria a URL da imagem do poster do filme
                final imageUrl = movie['poster_path'] != null
                    ? '${movieService.imageUrlBase}${movie['poster_path']}'
                    : null;

                // Detector de gestos
                return GestureDetector(
                  onTap: () async {
                    // Navega para a pagina de detalhes do filme e aguarda o retorno
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(movie: movie),
                      ),
                    );
                    // Atualiza a tela apos retornar para garantir que a lista esta correta
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 60, 60, 60),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        // Exibe a imagem do poster ou um icone de fallback
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: imageUrl != null
                              ? Image.network(
                                  imageUrl,
                                  width: 80,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 80,
                                  height: 120,
                                  color: const Color.fromARGB(255, 77, 77, 77),
                                  child: const Icon(Icons.movie, color: Colors.white),
                                ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie['title'] ?? 'Titulo desconhecido',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Exibe o ano de lancamento, se disponivel
                              if (movie['release_date'] != null && movie['release_date'].isNotEmpty)
                                Text(
                                  'Lancamento: ${movie['release_date'].substring(0, 4)}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              const SizedBox(height: 4),
                              // Exibe a avaliacao do filme
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${movie['vote_average'].toStringAsFixed(1)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      backgroundColor: const Color.fromARGB(255, 46, 46, 46),
    );
  }
}