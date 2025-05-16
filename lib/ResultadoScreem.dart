import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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