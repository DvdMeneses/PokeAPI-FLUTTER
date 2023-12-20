import 'package:flutter/material.dart';
import 'package:pokedex/persistent/Poke.dart';
import '../pages/tela_sobre.dart';
import 'package:url_launcher/url_launcher.dart';

class CardSobre extends StatelessWidget {
  final Dev developer;

  const CardSobre({Key? key, required this.developer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: Image.asset(
                      developer.image,
                      fit: BoxFit.cover,
                      width: 180,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 500,
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
                      '${developer.name}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Outros atributos, se necessário
                ],
              ),
            ),
            SizedBox(height: 16), // Espaçamento abaixo do card
            GestureDetector(
              onTap: () {
                launch("${developer.githubLink}");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    developer.gitHubLinkImage,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
