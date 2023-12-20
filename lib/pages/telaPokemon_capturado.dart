import 'dart:async';

import 'package:flutter/material.dart';

import 'package:pokedex/conexao/connection.dart';
import 'package:pokedex/database/database_helper.dart';
import 'package:pokedex/pages/tela_sobre.dart';
import 'package:pokedex/persistent/Poke.dart';
import 'package:pokedex/widgets/card_capturado.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  print(db.pokemonDao.findAllPokemons());
  runApp(
    Provider.value(
      value: db,
      child: TelaPokemonCapturado(),
    ),
  );
}

class TelaPokemonCapturado extends StatefulWidget {
  const TelaPokemonCapturado({Key? key}) : super(key: key);

  @override
  _TelaCapturadoState createState() => _TelaCapturadoState();
}

class _TelaCapturadoState extends State<TelaPokemonCapturado> {
  late AppDatabase db; // Defina uma variável para armazenar o banco de dados

  final ConnectivityService _connectivityService = ConnectivityService();
  late bool finishLoad;
  List<int> numerosSorteados = [];
  List<Poke> pokemons = [];

  @override
  void initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);
    finishLoad = true;
    getPokemons();
  }

  Future<void> getPokemons() async {
    try {
      // Use o banco de dados aqui
      List<Poke> pokemonsFromDb = (await db.pokemonDao.findAllPokemons());
      setState(() {
        pokemons = pokemonsFromDb;
      });
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
            return Center(
              // Substitua o indicador de progresso circular pelo GIF
              child: Image.asset(
                'assets/icon/gengarGifLoad-icon.gif',
                height: 100, // Altura do GIF
                width: 100, // Largura do GIF
                fit: BoxFit.cover,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao verificar a conexão'));
          } else {
            final hasConnection = snapshot.data ?? false;

            if (hasConnection && pokemons.length > 0) {
              return ListView.builder(
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  Poke pokemon = pokemons[index];
                  return CardCapturados(pokemon: pokemon);
                },
              );
            } else if (hasConnection && pokemons.length < 1) {
              return const Center(
                child: Text('Não há pokemons cadastrados !! '),
              );
            } else {
              return const Center(
                child: Text('Seu dispostivo não possui conexão com a internet'),
              );
            }
          }
        },
      ),
    );
  }
}
