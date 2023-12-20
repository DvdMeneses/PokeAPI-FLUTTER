import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokedex/pages/tela_sobre.dart';
import 'package:pokedex/persistent/Poke.dart';

class TelaDetalhe extends StatefulWidget {
  final int pokemonId;
  const TelaDetalhe({Key? key, required this.pokemonId}) : super(key: key);

  @override
  _TelaDetalheState createState() => _TelaDetalheState();
}

class _TelaDetalheState extends State<TelaDetalhe> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    final String apiUrl =
        'https://pokeapi.co/api/v2/pokemon/${widget.pokemonId}';

    try {
      http.Response response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          print(data);
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = data?['name'] ?? '';
    final height = data?['height'] ?? '';
    final abilidadeUm = data?['abilities'][0]['ability']['name'] ?? "";
    final abilidadeDois = data != null && data!['abilities'].length > 1
        ? data!['abilities'][1]['ability']['name']
        : "";

    final animationURL = data?['sprites']['other']['official-artwork']
            ['front_default'] ??
        data?['sprites']['front_default'] ??
        "";

    final order = data?['order'] ?? "";
    final statesHp = data?['stats'][0]['base_stat'] ?? "";
    final statesAttack = data?['stats'][1]['base_stat'] ?? "";
    final statesDefense = data?['stats'][2]['base_stat'] ?? "";
    final type = data?['types'][0]['type']['name'] ?? "";

    print(name);
    print(height);
    print(abilidadeUm);
    print(abilidadeDois);
    print(animationURL);
    print(order);
    print(statesHp);
    print(statesAttack);
    print(statesDefense);
    print(type);

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
        child: SingleChildScrollView(
          child: data != null
              ? Center(
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 0.0,
                      ),
                    ),
                    margin: const EdgeInsets.all(8.0),
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
                              animationURL,
                              width: 500,
                              height: 400,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildAttributeField('Name', capitalize(name)),
                          _buildAttributeField('Type', capitalize(type)),
                          _buildAttributeField(
                              'Height', capitalize(height.toString())),
                          _buildAttributeField(
                              'Ability One', capitalize(abilidadeUm)),
                          _buildAttributeField(
                              'Ability Two', capitalize(abilidadeDois)),
                          _buildAttributeField('Order', order.toString()),
                          _buildAttributeField('Hp', statesHp.toString()),
                          _buildAttributeField(
                              'Attack', statesAttack.toString()),
                          _buildAttributeField(
                              'Defense', statesDefense.toString()),
                        ],
                      ),
                    ),
                  ),
                )
              : Column(
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
        ),
      ),
    );
  }
}

// Função para criar campos de texto não editáveis para os atributos
Widget _buildAttributeField(String labelText, String? value) {
  if (value == null || value.isEmpty) {
    return SizedBox
        .shrink(); // Retorna um widget vazio se o valor for nulo ou vazio
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: InkWell(
      onTap: () {}, // Isso previne o foco no campo de texto
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
    ),
  );
}

// Função para deixar a primeira letra do nome maiúscula
String capitalize(String text) {
  return text.replaceAllMapped(RegExp(r"(?:^|(\s))[a-z]"), (match) {
    return match.group(0)!.toUpperCase();
  });
}
