import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/favorites_page.dart';
import 'pages/more_page.dart';

void main() {
    runApp(const MyApp());
}

// Widget principal
class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            
            // Titulo do aplicativo
            title: 'Projeto Flutter',
            // Define o tema visual do aplicativo
            theme: ThemeData(
                // Configura um esquema de cores a partir de uma cor inicial
                colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 46, 46, 46)),
                // Habilita o Material 3
                useMaterial3: true,
            ),
            // Define a pagina inicial do aplicativo
            home: const MyHomePage(title: 'Meu app teste'),
        );
    }
}

// Widget de estado para a tela principal
class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key, required this.title});

    final String title;

    @override
    State<MyHomePage> createState() => _MyHomePageState(); 
} 

class _MyHomePageState extends State<MyHomePage> {

    int _selectedIndex = 0;

    // Funcao para atualizar o estado e mudar a pagina selecionada
    void _onItemTapped(int index){
        setState((){
            _selectedIndex = index;
        });
    }

    @override
    Widget build(BuildContext context) {

        // Funcao que retorna o widget da pagina com base no indice
        Widget getPage(int index){
            
            switch(index){
                case 0:
                    return const HomePage();
                case 1:
                    return const FavoritesPage();
                case 2:
                    return const MorePage();
                default:
                    return const Center(
                        child: Text
                        ('Erro: Pagina nao encontrada!'),
                    );
            }

        }

        return Scaffold(
            body: getPage(_selectedIndex),

            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            // Barra de navegacao inferior
            bottomNavigationBar: BottomNavigationBar(
                    items: const <BottomNavigationBarItem>[
                        // Pagina Inicial
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Inicio', 
                        ),

                        // Pagina de Favoritos
                        BottomNavigationBarItem(
                            icon: Icon(Icons.favorite),
                            label: 'Favoritos', 
                        ),

                        // IPagina Mais
                        BottomNavigationBarItem(
                            icon: Icon(Icons.menu),
                            label: 'Mais', 
                        ),
                        ],

                        currentIndex: _selectedIndex, 
                        // Cor do item selecionado
                        selectedItemColor: const Color.fromARGB(255, 255, 255, 255), 
                        // Cor dos itens nao selecionados
                        unselectedItemColor: const Color.fromARGB(255, 165, 165, 165), 
                        // Cor de fundo da barra de navegacao
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        onTap: _onItemTapped,
            ),
        );
    }
}