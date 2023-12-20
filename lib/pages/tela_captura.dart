import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:pokeapi/model/pokemon/pokemon.dart';

import 'package:pokeapi/pokeapi.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/conexao/connection.dart';
import 'package:pokedex/database/database_helper.dart';
import 'package:pokedex/pages/tela_sobre.dart';
import 'package:pokedex/persistent/Poke.dart';
import 'package:pokedex/widgets/card_list.dart';
import 'package:provider/provider.dart';

class TelaCaptura extends StatefulWidget {
  const TelaCaptura({Key? key}) : super(key: key);

  @override
  _TelaCapturaState createState() => _TelaCapturaState();
}

class _TelaCapturaState extends State<TelaCaptura> {
  final ConnectivityService _connectivityService = ConnectivityService();
  late bool finishLoad;
  List<int> numerosSorteados = [];
  List<Pokemon> pokemons = [];
  List<bool> existem = [false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    finishLoad = true;
    sortearNumeros();
    getPokemons();
  }

  void sortearNumeros() {
    while (numerosSorteados.length < 6) {
      int numeroSorteado = Random().nextInt(1017) + 1;

      if (!numerosSorteados.contains(numeroSorteado)) {
        numerosSorteados.add(numeroSorteado);
      }
    }

    print('Números sorteados: $numerosSorteados');
  }

//  , butter free , weedle, raticate , beeedreel
  @override
  Future<void> getPokemons() async {
    final database = Provider.of<AppDatabase>(context, listen: false);

    List<Poke> pokemonsDoBanco = await database.pokemonDao.findAllPokemons();

    try {
      int cont = 0;
      for (int numeroSorteado in numerosSorteados) {
        bool achei = false;
        Pokemon? pokemon = await PokeAPI.getObject<Pokemon>(numeroSorteado);

        for (int i = 0; i < pokemonsDoBanco.length; i++) {
          if (pokemon!.id == pokemonsDoBanco[i].id) {
            print("ENTREI NO TRUE --------------------------");
            achei = true;
            print(pokemon.name);
            print(pokemon.id);
            print(i);
            existem[cont++] = true;
          } else if (!achei && i == pokemonsDoBanco.length - 1) {
            print("ENTREI NO FALSE --------------------------");
            print(pokemon.name);
            print(pokemon.id);

            print(pokemon.id);
            print(i);
            existem[cont++] = false;
          }
        }
        pokemons.add(pokemon!);
      }
    } catch (e) {
      print('Erro ao buscar Pokémon: $e');
    } finally {
      finishLoad = false;
      setState(() {});
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context, listen: false);
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
      body: FutureBuilder<bool>(
        future: _connectivityService.checkConnection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao verificar a conexão'));
          } else {
            final hasConnection = snapshot.data ?? false;

            if (hasConnection) {
              print(existem);

              if (!finishLoad && pokemons.isNotEmpty) {
                return ListView.builder(
                  itemCount: pokemons.length,
                  itemBuilder: (context, index) {
                    Pokemon pokemon = pokemons[index];
                    bool existe = existem[index];

                    return CardList(
                        pokemon: pokemon, database: database, existe: existe);
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icon/gengarGifLoad-icon.gif',
                        height: 100, // Altura do primeiro GIF
                        width: 100, // Largura do primeiro GIF
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 5), // Espaçamento entre os GIFs
                      Image.asset(
                        'assets/icon/loadText-icon.gif',
                        height: 5, // Altura do segundo GIF
                        width: 500, // Largura do segundo GIF
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                );
              }
            } else {
              return const Center(
                child: Text('Sem conexão de rede'),
              );
            }
          }
        },
      ),
    );
  }
}
