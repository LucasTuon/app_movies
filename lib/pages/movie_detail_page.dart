import 'package:flutter/material.dart';
import '/services/movie_services.dart';
import '/services/global.dart' as global;

class MovieDetailPage extends StatefulWidget {
  final dynamic movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final movieService = MovieService();
  dynamic movieDetails; // Armazena os detalhes adicionais do filme
  bool isLoading = true;
  List<dynamic> movieCast = []; // Armazena o elenco do filme
  bool _isFavorite = false; // Estado para controlar o icone de favorito

  @override
  void initState() {
    super.initState();
    _fetchMovieDetails(); // Busca os detalhes e creditos do filme
    _checkFavoriteStatus(); // Verifica se o filme ja e favorito
  }

  // Verifica se o filme esta na lista de favoritos
  void _checkFavoriteStatus() {
    _isFavorite = global.favoriteMovies.any((fav) => fav['id'] == widget.movie['id']);
  }

  // Funcao para adicionar ou remover o filme dos favoritos
  void _toggleFavorite() {
    if (_isFavorite) {
      // Remove o filme da lista se ele ja for favorito
      global.favoriteMovies.removeWhere((movie) => movie['id'] == widget.movie['id']);
    } else {
      // Adiciona o filme a lista se ele nao for favorito
      if (!global.favoriteMovies.any((fav) => fav['id'] == widget.movie['id'])) {
        global.favoriteMovies.add(widget.movie);
      }
    }
    // Atualiza o estado para mudar o icone do botao
    setState(() {
      _isFavorite = !_isFavorite;
    });
    // Exibe uma barra de notificacao para o usuario
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Filme adicionado aos favoritos!' : 'Filme removido dos favoritos!',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Funcao assincrona para buscar os detalhes e creditos do filme da API
  Future<void> _fetchMovieDetails() async {
    try {
      final details = await movieService.getMoreDetails(widget.movie['id']);
      final credits = await movieService.getMovieCredits(widget.movie['id']);
      setState(() {
        movieDetails = details;
        movieCast = credits['cast'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Funcao para formatar a duracao do filme de minutos para horas e minutos
  String timeFormat(int runtime) {
    final hours = runtime ~/ 60;
    final minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}min';
    } else {
      return '${minutes}min';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Constroi a URL da imagem de fundo
    final imageBackDropUrl = movieDetails != null && movieDetails['backdrop_path'] != null
        ? '${movieService.imageUrlBase}${movieDetails['backdrop_path']}'
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          // Botao de coracao
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? const Color.fromARGB(255, 238, 174, 170) : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageBackDropUrl != null)
                    Stack(
                      children: [
                        Image.network(
                          imageBackDropUrl,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          height: 250,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.0, 0.0),
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color.fromARGB(255, 0, 0, 0)],
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: 250,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      child: const Icon(Icons.movie, size: 50, color: Colors.white),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                movieDetails['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.yellow, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  '${movieDetails['vote_average'].toStringAsFixed(1)}',
                                  style: const TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movieDetails['overview'],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 172, 172, 172),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        if (movieDetails['release_date'] != null && movieDetails['release_date'].isNotEmpty)
                          Text(
                            'Lancamento: ${movieDetails['release_date']}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        if (movieDetails['runtime'] != null && movieDetails['runtime'] > 0)
                          Text(
                            'Duracao: ${timeFormat(movieDetails['runtime'])}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        if (movieDetails['genres'] != null && movieDetails['genres'].isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Generos: ${movieDetails['genres'].map((genre) => genre['name']).join(', ')}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                        if (movieCast.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
                                child: Text(
                                  'Elenco Principal',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movieCast.length > 10 ? 10 : movieCast.length, // Mostra os 10 primeiros
                                  itemBuilder: (context, index) {
                                    final actor = movieCast[index];
                                    final profileUrl = actor['profile_path'] != null
                                        ? '${movieService.imageUrlBase}${actor['profile_path']}'
                                        : null;
                                    
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(50.0), // Deixa a imagem redonda
                                            child: profileUrl != null
                                                ? Image.network(
                                                    profileUrl,
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius: BorderRadius.circular(50.0),
                                                    ),
                                                    child: const Icon(Icons.person, color: Colors.white),
                                                  ),
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            width: 80,
                                            child: Text(
                                              actor['name'],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],

                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    );
  }
}