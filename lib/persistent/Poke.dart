import 'package:floor/floor.dart';

@Entity(tableName: 'poke')
class Poke {
  @primaryKey
  final int? id; // Pode ser nulo se for autoincrementado

  final String? name;
  late final int? height;
  late final int? xp; // Pode ser nulo se aplicável
  late final String? type; // Pode ser nulo se aplicável
  late final String? abilitieUm; // Pode ser nulo se aplicável
  late final String? abilitieDois; // Pode ser nulo se aplicável
  late final String? sprite;

  Poke({
    this.id,
    required this.name,
    int? height,
    int? xp,
    String? type,
    String? abilitieUm,
    String? abilitieDois,
    String? sprite,
    bool? existe,
  })  : height = height ?? 0,
        xp = xp ?? 0,
        type = type ?? "",
        abilitieUm = abilitieUm ?? "",
        abilitieDois = abilitieDois ?? "",
        sprite = sprite ?? "";
}
