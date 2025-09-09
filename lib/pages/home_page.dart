import 'package:flutter/material.dart';
import '/services/movie_services.dart';
import '/pages/movie_detail_page.dart';
import '/pages/search_page.dart';

// Widget de estado para a pagina inicial
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final movieService = MovieService();
  // Listas para armazenar os filmes de cada categoria
  List<dynamic> popularMovies = [];
  List<dynamic> nowPlayingMovies = [];
  List<dynamic> topRatedMovies = [];
  bool isLoading = true; // Estado de carregamento
  String? errorMessage; // Mensagem de erro

  @override
  void initState() {
    super.initState();
    _fetchMovies(); // Inicia a busca pelos filmes
  }

  // Funcao para buscar os dados dos filmes da API
  Future<void> _fetchMovies() async {
    try {
      final popularData = await movieService.getPopularMovies();
      final nowPlayingData = await movieService.getNowPlayingMovies();
      final topRatedData = await movieService.getTopRatedMovies();
      // Verifica se o widget ainda esta montado antes de atualizar o estado
      // Adicionado, pois o app crashava quando os widgets eram trocados rapidamente
      if(mounted){
        setState(() {
          popularMovies = popularData['results'];
          nowPlayingMovies = nowPlayingData['results'];
          topRatedMovies = topRatedData['results'];
          isLoading = false;
        });
      }
    } catch (e) {
      if(mounted){
        setState(() {
          isLoading = false;
          errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('App de Filmes'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        toolbarHeight: 45.0,
        actions: [
          // Icone de pesquisa
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navega para a pagina de pesquisa
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            }
          ),
        ]
      ),
      // Se estiver carregando...
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  // Secao de filmes Populares
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Populares',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // Limita a exibicao a 10 filmes
                      itemCount: popularMovies.length > 10 ? 10 : popularMovies.length,
                      itemBuilder: (context, index) {
                        final movie = popularMovies[index];
                        final imageUrl =
                            '${movieService.imageUrlBase}${movie['poster_path']}';
                        // Somente exibe o card se houver um poster
                        if (movie['poster_path'] != null) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailPage(movie: movie),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      imageUrl,
                                      width: 120,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Adiciona a nota do filme em uma sobreposicao
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.star, color: Colors.yellow, size: 14),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${movie['vote_average'].toStringAsFixed(1)}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          // Placeholder se nao houver imagem
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                              width: 120,
                              height: 180,
                              color: const Color.fromARGB(255, 77, 77, 77),
                              child: const Icon(Icons.movie, color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  // Secao de filmes Em Cartaz (logica similar)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Em Cartaz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nowPlayingMovies.length > 10 ? 10 : nowPlayingMovies.length,
                      itemBuilder: (context, index) {
                        final movie = nowPlayingMovies[index];
                        final imageUrl =
                            '${movieService.imageUrlBase}${movie['poster_path']}';

                        if (movie['poster_path'] != null) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailPage(movie: movie),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      imageUrl,
                                      width: 120,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.star, color: Colors.yellow, size: 14),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${movie['vote_average'].toStringAsFixed(1)}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                              width: 120,
                              height: 180,
                              color: const Color.fromARGB(255, 77, 77, 77),
                              child: const Icon(Icons.movie, color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  // Secao de filmes Melhores Avaliados (logica similar)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Melhores Avaliados',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topRatedMovies.length > 10 ? 10 : topRatedMovies.length,
                      itemBuilder: (context, index) {
                        final movie = topRatedMovies[index];
                        final imageUrl =
                            '${movieService.imageUrlBase}${movie['poster_path']}';

                        if (movie['poster_path'] != null) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailPage(movie: movie),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      imageUrl,
                                      width: 120,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.star, color: Colors.yellow, size: 14),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${movie['vote_average'].toStringAsFixed(1)}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                              width: 120,
                              height: 180,
                              color: const Color.fromARGB(255, 77, 77, 77),
                              child: const Icon(Icons.movie, color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
    );
  }
}