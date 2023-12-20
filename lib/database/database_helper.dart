// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:pokedex/dao/pokemon_dao.dart';
import 'package:pokedex/persistent/Poke.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
// Importações devem vir antes das diretivas 'part'
part 'database_helper.g.dart';

@Database(version: 1, entities: [Poke])
abstract class AppDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
}
