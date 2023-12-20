import 'package:flutter/material.dart';
import 'package:pokedex/database/database_helper.dart';
import 'package:pokedex/pages/tela_sobre.dart';
import 'package:pokedex/persistent/Poke.dart';
import 'package:pokedex/widgets/card_soltar.dart';
import 'package:provider/provider.dart';

class TelaSoltar extends StatefulWidget {
  final int pokemonId;

  const TelaSoltar({Key? key, required this.pokemonId}) : super(key: key);

  @override
  _TelaSoltarState createState() => _TelaSoltarState();
}

class _TelaSoltarState extends State<TelaSoltar> {
  late AppDatabase database;

  @override
  void initState() {
    super.initState();
  }

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
      body: StreamBuilder<Poke?>(
        stream: database.pokemonDao.findPokemonById(widget.pokemonId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final pokemon = snapshot.data;

            if (pokemon != null) {
              return CardSoltar(pokemon: pokemon);
            } else {
              return Center(child: Text('No Pokémon found'));
            }
          }
        },
      ),
    );
  }
}
