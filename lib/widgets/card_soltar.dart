import 'package:flutter/material.dart';
import 'package:pokedex/database/database_helper.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/persistent/Poke.dart';

class CardSoltar extends StatelessWidget {
  final Poke pokemon;

  const CardSoltar({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(8.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 0.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Image.network(
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png',
                    width: 500,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                _buildAttributeField('Name', capitalize(pokemon.name ?? "")),
                _buildAttributeField('Type', capitalize(pokemon.type ?? "")),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Lógica para soltar o Pokémon
                        final db = await $FloorAppDatabase
                            .databaseBuilder('app_database.db')
                            .build();
                        await db.pokemonDao.deletePokemon(pokemon);
                        Navigator.pop(context);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                        print('Deletar Pokémon: ${pokemon.name}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Cor de fundo do botão
                        foregroundColor: Colors.white, // Cor do texto do botão
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 24.0), // Espaçamento interno
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Borda arredondada
                          side: BorderSide(
                              color: Colors.black,
                              width: 2.0), // Borda com espessura e cor
                        ),
                      ),
                      child: Text('Soltar'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        print('Cancelar');
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Cor de fundo do botão
                        foregroundColor: Colors.white, // Cor do texto do botão
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 24.0), // Espaçamento interno
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Borda arredondada
                          side: BorderSide(
                              color: Colors.black,
                              width: 2.0), // Borda com espessura e cor
                        ),
                      ),
                      child: Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttributeField(String labelText, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
        child: Text(
          value.isEmpty ? labelText : value,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  String capitalize(String text) {
    return text.replaceAllMapped(RegExp(r"(?:^|(\s))[a-z]"), (match) {
      return match.group(0)!.toUpperCase();
    });
  }
}
