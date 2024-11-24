import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Pacote para fontes personalizadas
import 'tela_principal.dart'; // Certifique-se de importar a TelaPrincipal corretamente

void main() {
  runApp(MaterialApp(
    home: TelaInicial(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.pink,
      scaffoldBackgroundColor: Color(0xFFFDE1E6),
    ),
  ));
}

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo com gradiente
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade300, Colors.purple.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Column(
            children: [
              // Barra superior derretida
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 120),
                painter: AppBarDerretidaPainter(),
                child: Container(
                  height: 120,
                  alignment: Alignment.center,
                  child: Text(
                    "Você Quem Sabe Amor!",
                    style: GoogleFonts.lobster(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _animation,
                        child: Icon(
                          Icons.favorite,
                          size: 150,
                          color: Color.fromARGB(255, 147, 19, 19),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Decida o que comer e onde passear com diversão e amor!",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(179, 0, 0, 0),
                          fontFamily: 'DancingScript',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Navegação para a TelaPrincipal
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaPrincipal(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade700,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'DECIDA AQUI!',
                          style: TextStyle(
                              fontSize: 20,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Painter para criar o efeito derretido na barra superior
class AppBarDerretidaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink.shade700
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(size.width * 0.1, size.height, size.width * 0.2,
        size.height - 20);
    path.quadraticBezierTo(size.width * 0.3, size.height - 40, size.width * 0.4,
        size.height - 20);
    path.quadraticBezierTo(size.width * 0.5, size.height, size.width * 0.6,
        size.height - 20);
    path.quadraticBezierTo(size.width * 0.7, size.height - 40, size.width * 0.8,
        size.height - 20);
    path.quadraticBezierTo(
        size.width * 0.9, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
