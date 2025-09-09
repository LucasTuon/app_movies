import 'package:flutter/material.dart';
import '/services/movie_services.dart';
import '/pages/movie_detail_page.dart';

// Widget de estado para a pagina de pesquisa
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final movieService = MovieService();
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = []; // Lista para armazenar os resultados da pesquisa
  bool isLoading = false; // Estado de carregamento

  // Funcao para fazer a pesquisa
  Future<void> _search(String query) async {
    if (query.isEmpty) {
      // Limpa os resultados se o campo de busca estiver vazio
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final searchData = await movieService.searchMovies(query);
      List<dynamic> results = searchData['results'];

      // Ordena os resultados por ano de lancamento, do mais novo para o mais antigo,
      // e depois por titulo em ordem alfabetica
      results.sort((a, b) {
        String releaseDateA = a['release_date'] ?? '';
        String releaseDateB = b['release_date'] ?? '';
        String titleA = a['title'] ?? '';
        String titleB = b['title'] ?? '';

        int yearA = releaseDateA.isNotEmpty ? int.tryParse(releaseDateA.substring(0, 4)) ?? 0 : 0;
        int yearB = releaseDateB.isNotEmpty ? int.tryParse(releaseDateB.substring(0, 4)) ?? 0 : 0;

        int yearComparison = yearB.compareTo(yearA);
        if (yearComparison != 0) {
          return yearComparison;
        }
        return titleA.compareTo(titleB);
      });

      setState(() {
        searchResults = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true, // Foca automaticamente no campo de texto ao abrir a pagina
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Pesquisar filmes...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none, // Remove a borda padrao
          ),
          onChanged: (value) => _search(value), // Chama a funcao de pesquisa a cada alteracao
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      // Se estiver carregando...
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildSearchResults(),
      backgroundColor: const Color.fromARGB(255, 46, 46, 46),
    );
  }

  // Funcao que constroi a lista de resultados da pesquisa
  Widget _buildSearchResults() {
    if (searchResults.isEmpty && _searchController.text.isNotEmpty) {
      // Mensagem para quando nao tem resultados
      return const Center(
        child: Text(
          'Nenhum resultado encontrado.',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else if (searchResults.isEmpty) {
      // Mensagem inicial quando o campo de busca esta vazio
      return const Center(
        child: Text(
          'Digite algo para comecar a pesquisar.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    // Construtor de lista para os resultados
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final movie = searchResults[index];
        final imageUrl = movie['poster_path'] != null
            ? '${movieService.imageUrlBase}${movie['poster_path']}'
            : null;

        return GestureDetector(
          onTap: () {
            // Navega para a pagina de detalhes ao tocar no item
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailPage(movie: movie),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 46, 46, 46),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
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
                          color: const Color.fromARGB(255, 46, 46, 46),
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
                      if (movie['release_date'] != null && movie['release_date'].isNotEmpty)
                        Text(
                          'Lancamento: ${movie['release_date'].substring(0, 4)}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      const SizedBox(height: 4),
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
    );
  }
}