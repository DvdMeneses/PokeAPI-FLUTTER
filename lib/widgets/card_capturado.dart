import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokedex/dao/pokemon_dao.dart';
import 'package:pokedex/database/database_helper.dart';
import 'package:pokedex/pages/tela_detalhes.dart';
import 'package:pokedex/pages/tela_soltar.dart';
import 'package:pokedex/persistent/Poke.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class CardCapturados extends StatelessWidget {
  final Poke pokemon;

  const CardCapturados({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String icone = 'assets/icon/PokemonCelular-icon.png';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaDetalhe(pokemonId: pokemon.id!),
          ),
        );
      },
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaSoltar(pokemonId: pokemon.id!),
          ),
        );
        print('Foi um toque longo');
      },
      child: Card(
        color: Color.fromARGB(255, 255, 255, 255),
        margin: const EdgeInsets.only(top: 0.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
            width: 0.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.black),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        '${pokemon.sprite}',
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 170,
                      decoration: BoxDecoration(
                        color: Colors.red[600],
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        capitalize('${pokemon.name}'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

String capitalize(String text) {
  return text.replaceAllMapped(RegExp(r"(?:^|(\s))[a-z]"), (match) {
    return match.group(0)!.toUpperCase();
  });
}
