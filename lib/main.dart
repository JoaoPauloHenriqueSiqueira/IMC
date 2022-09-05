import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NewHome(),
  ));
}

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Fill both inputs";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Fill both inputs";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      String imcFormat = imc.toStringAsPrecision(4);
      debugPrint("${imc}");
      if (imc < 18.6) {
        _infoText = "You are under the recommended weight, IMC: ${imcFormat})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText =
            "Your weight is within the suggested value, IMC: ${imcFormat}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Slightly overweight, IMC: ${imcFormat}";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "You are overweight, Obesity grade 1. IMC: ${imcFormat}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "You are overweight, Obesity grade 2. IMC: ${imcFormat}";
      } else if (imc > 40) {
        _infoText = "You are overweight, Obesity grade 3. IMC: ${imcFormat}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC Calculator"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Padding(padding: const EdgeInsets.symmetric(vertical: 20.0)),
          Icon(Icons.person_outline, size: 120.0, color: Colors.green),
          Padding(padding: const EdgeInsets.symmetric(vertical: 20.0)),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Weight (kg)",
                labelStyle: TextStyle(color: Colors.green)),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 20.0),
            controller: weightController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Weight is required";
              }
            },
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 20.0)),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Height (cm)",
                labelStyle: TextStyle(color: Colors.green)),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 20.0),
            controller: heightController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Height is required";
              }
            },
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 20.0)),
          Container(
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _calculate();
                  }
                },
                child: Text(
                  "Calculate",
                  style: TextStyle(fontSize: 25.0),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green, minimumSize: Size(100.0, 50.0))),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 26.0)),
          Text(
            _infoText,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25),
          )
        ]),
      )),
    );
  }
}
