import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'passeio.dart'; // Importa a tela de passeio
import 'main.dart'; // Importa a tela inicial (main.dart)

// Tela Principal
class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final List<String> comidas = [
    "Pizza",
    "Hambúrguer",
    "Japa",
    "Churrasco",
    "Comida Italiana",
    "Tacos",
    "Salada",
    "Cachorrão",
    "Sorvete",
    "Porções",
    "Pastel",
    "Poke",
    "Você que sabe rsrs",
    "Risoto",
    "Ceviche",
    "Comida Árabe",
    "Fast food",
    "Fritas",
    "Strogonoff"
  ];

  String _displayedComida = "";
  bool _isSpinning = false;
  Timer? _timer;

  void _startSorteio() {
    if (_isSpinning) return;

    setState(() {
      _isSpinning = true;
    });

    int counter = 0;

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _displayedComida = comidas[counter % comidas.length];
        counter++;
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      _timer?.cancel();
      setState(() {
        _isSpinning = false;
        _displayedComida = comidas[Random().nextInt(comidas.length)];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Comida escolhida: $_displayedComida",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text(
          "Decida o que Comer!",
          style: GoogleFonts.lobster(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Volta diretamente para a TelaInicial (main.dart)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TelaInicial()),
              (route) => false, // Remove todas as rotas anteriores da pilha
            );
          },
        ),
      ),
      body: Container(
        color: Colors.pink.shade50, // Fundo rosa claro
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Palavra sorteada
              Text(
                _displayedComida,
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              // Botão estilizado
              ElevatedButton(
                onPressed: _startSorteio,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shadowColor: Colors.pinkAccent,
                  elevation: 10,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "SORTEAR",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink.shade100,
        selectedItemColor: Colors.pink.shade800,
        unselectedItemColor: Colors.pink.shade400,
        currentIndex: 0, // Índice inicial da aba
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: "Comida",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: "Passeio",
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              // Não faz nada pois já está na tela principal
              break;
            case 1:
              // Navegação para a TelaPasseio
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaPasseio()),
              );
              break;
          }
        },
      ),
    );
  }
}
