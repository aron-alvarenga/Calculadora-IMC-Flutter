import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);

      if (bmi < 18.6) {
        _infoText = "Abaixo do Peso (${bmi.toStringAsPrecision(3)})";
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _infoText = "Peso Ideal (${bmi.toStringAsPrecision(3)})";
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _infoText = "Levemente Acima do Peso (${bmi.toStringAsPrecision(3)})";
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _infoText = "Obesidade Grau I (${bmi.toStringAsPrecision(3)})";
      } else if (bmi >= 34.9 && bmi < 39.9) {
        _infoText = "Obesidade Grau II (${bmi.toStringAsPrecision(3)})";
      } else if (bmi >= 40) {
        _infoText = "Obesidade Grau III (${bmi.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  bottom: 15.0,
                ),
                child: Icon(Icons.person_outline,
                    size: 120.0, color: Colors.green),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(color: Colors.green),
                  //textField underline color
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    //  when the TextFormField in unfocused
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    //  when the TextFormField in focused
                  ),
                ),
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
                // TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira seu Peso';
                  }

                  double? e = double.tryParse(value);
                  if (e == null) {
                    return 'Insira somente números válidos';
                  }
                },
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.green),
                    //textField underline color
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      //  when the TextFormField in unfocused
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      //  when the TextFormField in focused
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                  // TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira sua Altura';
                    }

                    double? e = double.tryParse(value);
                    if (e == null) {
                      return 'Insira somente números válidos';
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: GoogleFonts.openSans(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      // TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                // TextStyle(
                //   color: Colors.green,
                //   fontSize: 25.0,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
