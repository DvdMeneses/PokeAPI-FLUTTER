import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/pages/tela_sobre.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(76),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 17, 0),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon/Pokemon-Logo.png',
                width: 200, // Ajuste o tamanho conforme necessário
                height: 100,
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaSobre(),
                    ),
                  );
                },
                padding: EdgeInsets.all(
                    1), // Ajuste o tamanho do ícone alterando este valor
                icon: Image.asset(
                  'assets/icon/pokedex-icon.png',
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Olá treinador!',
                  style: TextStyle(
                    fontFamily: 'PokemonHollow',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Image.asset(
                  'assets/icon/ash-icon.png',
                  height: 300,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 5),
                Text(
                  " Seja bem-vindo, treinador! Você está convidado a explorar o vasto mundo Pokémon, capturar novos espécimes, possuir informações detalhadas e descobrir coisas fascinantes sobre cada criatura.",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
