import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MeuPrimeiroAplicativo());
}

class MeuPrimeiroAplicativo extends StatelessWidget {
  const MeuPrimeiroAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GasApp - Cálculo de Consumo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
      home: const TelaConta(),
    );
  }
}

class TelaConta extends StatefulWidget {
  const TelaConta({super.key});

  @override
  State<StatefulWidget> createState() => _CalcContaEstado();
}

class _CalcContaEstado extends State<TelaConta> {
  final _formCalc = GlobalKey<FormState>();
  double _distancia = 0.0;
  double _gasvalue = 0.0;
  double _motorhp = 0.0;
  dynamic _valorTotal;
  dynamic modelo;

  void _calcTotal() {
    if (_formCalc.currentState!.validate()) {
      setState(() {
        _valorTotal = ((_distancia / _motorhp) * _gasvalue).toStringAsFixed(2);
      });
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultadoScreen(
            modelo: modelo.toString(),
            valorTotal: _valorTotal,
            distancia: _distancia.toStringAsFixed(2),
            gasvalue: _gasvalue.toStringAsFixed(2),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GasApp - Cálculo de Consumo'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formCalc,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Modelo do automóvel',
                      prefixIcon: Icon(Icons.directions_car),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Modelo obrigatório';
                      } else {
                        modelo = value;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Distância (km)',
                      prefixIcon: Icon(Icons.linear_scale),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe a distância';
                      } else {
                        _distancia = double.parse(value);
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Potência do motor',
                      prefixIcon: Icon(Icons.speed),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe a potência';
                      }
                      if (double.parse(value) <= 1) {
                        _motorhp = 13;
                      }
                      if (double.parse(value) > 1 && double.parse(value) <= 1.4) {
                        _motorhp = 11;
                      }
                      if (double.parse(value) > 1.4 && double.parse(value) <= 1.9) {
                        _motorhp = 9.5;
                      }
                      if (double.parse(value) > 1.9) {
                        _motorhp = 7.75;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Valor do litro da gasolina (R\$)',
                      prefixIcon: Icon(Icons.local_gas_station),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe o valor';
                      } else {
                        _gasvalue = double.parse(value);
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _calcTotal,
                    child: const Text('CALCULAR CONSUMO'),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      _formCalc.currentState!.reset();
                      setState(() {
                        _valorTotal = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.grey[800],
                    ),
                    child: const Text('LIMPAR DADOS'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ResultadoScreen extends StatelessWidget {
  final String modelo;
  final String valorTotal;
  final String distancia;
  final String gasvalue;

  const ResultadoScreen({
    super.key,
    required this.modelo,
    required this.valorTotal,
    required this.distancia,
    required this.gasvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado do Cálculo'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              const SizedBox(height: 30),
              Text(
                'Resultado do Cálculo',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'O ${modelo.isEmpty ? "veículo" : modelo} gasta R\$$valorTotal',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'para percorrer $distancia km,',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'com a gasolina custando R\$$gasvalue por litro.',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('VOLTAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}