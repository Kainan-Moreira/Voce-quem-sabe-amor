import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tela_principal.dart'; // Importe a tela principal para navegação

class TelaPasseio extends StatefulWidget {
  @override
  _TelaPasseioState createState() => _TelaPasseioState();
}

class _TelaPasseioState extends State<TelaPasseio> {
  final List<String> passeios = [
    "Praia",
    "Montanha",
    "Cinema",
    "Parque",
    "Restaurante Temático",
    "Museu",
    "Show ao Vivo",
    "Caminhada",
    "Piquenique",
    "Spa",
    "Teatro",
    "Zoológico",
    "Aquário",
    "Shopping",
    "Esportes Radicais",
    "Camping",
    "Observação de Estrelas",
  ];

  String _displayedPasseio = "";
  bool _isSpinning = false;
  Timer? _timer;

  void _startSorteioPasseio() {
    if (_isSpinning) return;

    setState(() {
      _isSpinning = true;
    });

    int counter = 0;

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _displayedPasseio = passeios[counter % passeios.length];
        counter++;
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      _timer?.cancel();
      setState(() {
        _isSpinning = false;
        _displayedPasseio = passeios[Random().nextInt(passeios.length)];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Passeio escolhido: $_displayedPasseio",
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
        centerTitle: true, // Título centralizado
        backgroundColor: Colors.pink,
        title: Text(
          "Escolha um Passeio!",
          style: GoogleFonts.lobster(
            fontSize: 36, // Tamanho de fonte igual ao título da tela principal
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navegar diretamente para a TelaPrincipal
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TelaPrincipal()),
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
              // Passeio sorteado
              Text(
                _displayedPasseio,
                style: GoogleFonts.poppins(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              // Botão de sorteio
              ElevatedButton(
                onPressed: _startSorteioPasseio,
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
          if (index == 0) {
            // Ação para "Comida" (navegar para TelaPrincipal)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TelaPrincipal()),
            );
          } else if (index == 1) {
            // Ficar na TelaPasseio, pois já estamos nela
          }
        },
      ),
    );
  }
}
