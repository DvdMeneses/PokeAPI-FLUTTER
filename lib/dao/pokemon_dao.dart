import 'package:floor/floor.dart';
import 'package:pokedex/persistent/Poke.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

@dao
abstract class PokemonDao {
  @Query('SELECT * FROM Poke') // Ajuste o nome da tabela aqui
  Future<List<Poke>> findAllPokemons();

  @Query('SELECT * FROM Poke WHERE id = :id') // Ajuste o nome da tabela aqui
  Stream<Poke?> findPokemonById(int id);

  @insert
  Future<void> insertPokemon(Poke pokemon);

  @delete
  Future<void> deletePokemon(Poke pokemon);
}
