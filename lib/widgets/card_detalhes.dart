import 'package:flutter/material.dart';
import 'package:pokedex/persistent/Poke.dart';
import 'package:shimmer/shimmer.dart';

class CardDetalhes extends StatelessWidget {
  final Poke pokemon;

  const CardDetalhes({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  Widget _buildText(String text, double fontSize) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.amber, // Cor da borda dourada
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
          top: 50.0, bottom: 120.0, left: 16.0, right: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.transparent, // Cor da borda transparente
            width: 5, // Largura da borda
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4B82A1), Color(0xFFC2E1F4)], // Cores ajustadas
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: _buildText(pokemon.name ?? "", 30),
              ),
              const SizedBox(height: 8),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white,
                        width: 2, // Largura da borda
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        '${pokemon.sprite}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Divider(
                color: Colors.white,
                thickness: 2,
                height: 8,
              ),
              _buildText('Type: ${pokemon.type ?? ""}', 18),
              Divider(
                color: Colors.white,
                thickness: 2,
                height: 8,
              ),
              _buildText('XP: ${pokemon.xp}', 18),
              Divider(
                color: Colors.white,
                thickness: 2,
                height: 8,
              ),
              _buildText('Height: ${pokemon.height}', 18),
              Divider(
                color: Colors.white,
                thickness: 2,
                height: 8,
              ),
              _buildText('Ability 1: ${pokemon.abilitieUm ?? ""}', 18),
              Divider(
                color: Colors.white,
                thickness: 2,
                height: 8,
              ),
              _buildText('Ability 2: ${pokemon.abilitieDois ?? ""}', 18),
              Divider(
                color: Colors.white,
                thickness: 2,
                height: 8,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
