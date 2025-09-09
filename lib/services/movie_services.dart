import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieService {
  final String apiKey =
      '1f5c675524f10740bac14e6be82e2016'; //    Minha chave pra API TMDB
  final String imageUrlBase =
      'https://image.tmdb.org/t/p/w1280'; //   Endereço base para receber imagens

  //  Requisição para os populares
  Future<dynamic> getPopularMovies() async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pt-BR',
    ); //  A url da API

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar os filmes populares');
    }
  }

  // Requisição para os em cartaz
  Future<dynamic> getNowPlayingMovies() async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=pt-BR',
    ); //  A url da API

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar os filmes em cartaz');
    }
  }

  // Requisicao para mais detalhes
  Future<dynamic> getMoreDetails(int movieId) async {
    final url = Uri.parse('https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=pt-BR');
  
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar os detalhes do filme');
    }
  }

  // Requisicao para procurar os filmes
  Future<dynamic> searchMovies(String query) async {
    final url = Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$apiKey&language=pt-BR&query=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
        return json.decode(response.body);
    } else {
        throw Exception('Erro ao pesquisar filmes');
    }
  }

  // Requisicao para pegar os creditos
  Future<dynamic> getMovieCredits(int movieId) async {
    final url = Uri.parse('https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
        return json.decode(response.body);
    } else {
        throw Exception('Erro ao carregar os creditos do filme');
    }
  }

  // Requisição para os melhores avaliados
  Future<dynamic> getTopRatedMovies() async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=pt-BR',
    ); 

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar os filmes melhores avaliados');
    }
  }


}
