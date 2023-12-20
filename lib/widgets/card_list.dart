import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokedex/dao/pokemon_dao.dart';
import 'package:pokedex/database/database_helper.dart';
import 'package:pokedex/persistent/Poke.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class CardList extends StatefulWidget {
  final Pokemon pokemon;
  final AppDatabase database;
  final bool existe;

  const CardList({
    Key? key,
    required this.pokemon,
    required this.database,
    required this.existe,
  }) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  String icone = 'assets/icon/pokebolaRed-icon.png';

  @override
  void initState() {
    super.initState();
    _getExiste();
  }

  Future<void> _getExiste() async {
    setState(() {
      icone = widget.existe
          ? 'assets/icon/pokebolaGray-icon.png'
          : 'assets/icon/pokebolaRed-icon.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      color: Colors.white, // Altera para a cor do fundo
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: Colors.black), // Adiciona a borda preta
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      '${widget.pokemon.sprites!.frontDefault}',
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
                        horizontal: 3.0, vertical: 4.0),
                    child: Text(
                      capitalize('${widget.pokemon.name}'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: GestureDetector(
                    onTap: () async {
                      String type = widget.pokemon.types![0].type!.name ?? "";

                      String abilityUm = widget.pokemon.abilities!.isNotEmpty
                          ? widget.pokemon.abilities![0].ability!.name ?? ""
                          : ""; // Verifica se a lista de habilidades não está vazia antes de acessar a primeira habilidade

                      String abilityDois = widget.pokemon.abilities!.length > 1
                          ? widget.pokemon.abilities![1].ability!.name ?? ""
                          : ""; // Verifica se há pelo menos duas habilidades antes de acessar a segunda habilidade

                      String sprite =
                          widget.pokemon.sprites!.frontDefault ?? "";
                      final database =
                          Provider.of<AppDatabase>(context, listen: false);

                      final pokemonTable = Poke(
                        id: widget.pokemon.id,
                        name: widget.pokemon.name ?? "",
                        height: widget.pokemon.height,
                        xp: widget.pokemon.baseExperience ?? 0,
                        type: type,
                        abilitieUm: abilityUm,
                        abilitieDois: abilityDois,
                        sprite: sprite,
                      );

                      await database.pokemonDao.insertPokemon(pokemonTable);

                      // Atualiza o ícone após a inserção do Pokémon
                      setState(() {
                        icone = 'assets/icon/pokebolaGray-icon.png';
                      });
                    },
                    child: Image.asset(
                      '${icone}',
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// deixar a primeira letra do nome maiuscula
String capitalize(String text) {
  return text.replaceAllMapped(RegExp(r"(?:^|(\s))[a-z]"), (match) {
    return match.group(0)!.toUpperCase();
  });
}
