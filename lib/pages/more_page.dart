import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de aplicativos com o titulo da pagina
      appBar: AppBar(
        title: const Text('Mais'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: 45.0,
      ),
      backgroundColor: const Color.fromARGB(255, 46, 46, 46),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          // Coluna para organizar as opcoes de menu uma abaixo da outra
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Opcao de Perfil
              _buildMenuItem(context, 'Perfil', Icons.person),
              const SizedBox(height: 16),
              // Opcao de Configuracoes
              _buildMenuItem(context, 'Configuracoes', Icons.settings),
              const SizedBox(height: 16),
              // Opcao de Contato
              _buildMenuItem(context, 'Contato', Icons.contact_mail),
              const SizedBox(height: 16),
              // Opcao de Versao do aplicativo
              _buildMenuItem(context, 'Versao', Icons.info),
            ],
          ),
        ),
      ),
    );
  }

  // Funcao auxiliar para construir cada item do menu
  Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 60, 60, 60),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Icone do menu
          Icon(icon, color: Colors.white),
          const SizedBox(width: 16),
          // Texto do menu (simulando um botao)
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Seta de indicacao
          const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
        ],
      ),
    );
  }
}