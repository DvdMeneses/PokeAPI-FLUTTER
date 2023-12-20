import 'package:flutter/material.dart';
import 'package:pokedex/widgets/card_sobre.dart';

class TelaSobre extends StatefulWidget {
  const TelaSobre({Key? key}) : super(key: key);

  @override
  _TelaSobreState createState() => _TelaSobreState();
}

class _TelaSobreState extends State<TelaSobre> {
  final List<Dev> developers = [
    Dev(
        githubLink: 'https://github.com/DvdMeneses',
        image: 'assets/icon/dvd-treinador.jpg',
        name: 'David Meneses',
        gitHubLinkImage: 'assets/icon/github-icon.png'),
    Dev(
        githubLink: 'https://github.com/DaviBragaDev',
        image: 'assets/icon/davi-treinador.jpg',
        name: 'Davi Braga',
        gitHubLinkImage: 'assets/icon/github-icon.png'),

    // Adicione quantos desenvolvedores desejar
  ];

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
        ),
      ),
      body: ListView.builder(
        itemCount: developers.length,
        itemBuilder: (BuildContext context, int index) {
          return CardSobre(developer: developers[index]);
        },
      ),
    );
  }
}

class Dev {
  final String gitHubLinkImage;
  final String githubLink;
  final String image;
  final String name;

  Dev({
    required this.githubLink,
    required this.image,
    required this.name,
    required this.gitHubLinkImage,
  });
}
