import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(
    title: "IMC",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _imcMessage = "";

  void _resetForm() {
    _formKey.currentState?.reset();
    weightController.clear();
    heightController.clear();

    setState(() {
      _imcMessage = '';
    });
  }

  void _handleCalculateImc() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _imcMessage = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _imcMessage = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _imcMessage = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _imcMessage = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _imcMessage = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _imcMessage = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC",
              style: GoogleFonts.bebasNeue(
                color: const Color(0xff644629),
              )),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: _resetForm,
                icon:
                    const Icon(Icons.refresh_rounded, color: Color(0xff644629)))
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: const Color(0xff644629),
                      decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: GoogleFonts.bebasNeue(
                            color: const Color(0xff644629),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.4),
                      ),
                      controller: weightController,
                      style: GoogleFonts.bebasNeue(
                          color: const Color(0xff644629),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.4),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Insira seu peso";
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: const Color(0xff644629),
                      decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: GoogleFonts.bebasNeue(
                            color: const Color(0xff644629),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.4),
                      ),
                      controller: heightController,
                      style: GoogleFonts.bebasNeue(
                          color: const Color(0xff644629),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.4),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Insira sua altura";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 32,
                          bottom: 32,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xfff6ebbf),
                                  fixedSize: Size(width * 0.3, 48),
                                ),
                                onPressed: _resetForm,
                                child: Text("Resetar",
                                    style: GoogleFonts.bebasNeue(
                                        color: const Color(0xff644629),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.4))),
                            TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xff644629),
                                  fixedSize:
                                      Size(width - (width * 0.3) - 48, 48),
                                ),
                                onPressed: _handleCalculateImc,
                                child: Text("Calcular",
                                    style: GoogleFonts.bebasNeue(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.4)))
                          ],
                        )),
                    Text(
                      _imcMessage,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bebasNeue(
                          color: const Color(0xff644629),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.4),
                    )
                  ],
                ))));
  }
}
