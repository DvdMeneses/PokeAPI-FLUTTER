# PokéFlutter

https://github.com/DvdMeneses/PokeAPI-FLUTTER/assets/115294207/c742441e-856a-40bc-ad2b-b3cd25d3b4a1



PokéFlutter é um aplicativo em Flutter que permite capturar e gerenciar Pokémon. Este aplicativo foi desenvolvido como parte de um desafio que envolve a integração com a PokeAPI, banco de dados local e funcionalidades de captura e visualização de Pokémon.

## Funcionalidades

### Icons
- Utiliza um ícone customizado através do pacote `flutter_launcher_icons`.

### TelaHome
- Apresenta informações sobre o aplicativo.

### Data Class de Pokémon
- Define a estrutura de dados para guardar informações sobre os Pokémon obtidas da PokeAPI.
- Utiliza SQFLITE através da biblioteca Floor para armazenar os dados no banco de dados local.
- Métodos implementados: criar, deletar, listar todos e listar por ID.

### TelaCaptura
- Verifica a disponibilidade de internet utilizando `connectivity_plus`.
- Se não houver internet, informa com uma mensagem e não exibe a ListView.
- Se houver internet, sorteia 6 números de 0 até 1017 e obtém dados dos Pokémon da PokeAPI.
- Preenche a ListView com os Pokémon sorteados, exibindo botões de captura.

### Capturar Pokémon
- Botão na TelaCaptura que salva os dados do Pokémon relacionado no banco de dados local.

### TelaPokemonCapturado
- Lista todos os Pokémons capturados cadastrados no banco de dados local.
- Se nenhum Pokémon foi capturado ainda, exibe uma mensagem informativa.

### Navegação
- Toque simples nos ListItems da TelaPokemonCapturado navega para TelaDetalhesPokemon.
- Toque longo nos ListItems da TelaPokemonCapturado navega para TelaSoltarPokemon.

### TelaDetalhesPokemon
- Recebe um ID como parâmetro e exibe informações detalhadas do Pokémon utilizando dados da API e do banco de dados local.

### TelaSoltarPokemon
- Recebe um ID como parâmetro e exibe informações do Pokémon do banco de dados local.
- Possui botões para confirmar ou cancelar a liberação do Pokémon.

### Menu
- Organização do aplicativo com acesso às Telas de Captura e Pokémons Capturados.

### TelaSobre
- Apresenta informações estáticas sobre os desenvolvedores do aplicativo.
- Adiciona um ícone na AppBar para navegar para a tela de informações sobre os(as) desenvolvedores(as).

## Instalação

1. Clone o repositório.
2. Certifique-se de ter o Flutter instalado e configurado.
3. Execute `flutter pub get` para obter as dependências.
4. Execute o aplicativo com `flutter run`.


## Autores

- [David Meneses](https://github.com/DvdMeneses)
- [Davi Samuel](https://github.com/DaviBragDev)


