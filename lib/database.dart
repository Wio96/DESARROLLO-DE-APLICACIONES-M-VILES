import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Esta línea es obligatoria y debe ser la primera tras los imports
part 'database.g.dart';

// Definición de tablas
class RegistrosCampo extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get especieId => integer().references(EspeciesBotanicas, #id)();
  IntColumn get zonaId => integer().references(ZonasTerritoriales, #id)();
  RealColumn get latitud => real()();
  RealColumn get longitud => real()();
  TextColumn get fotografiaUrl => text()();
  DateTimeColumn get fechaRegistro =>
      dateTime().withDefault(currentDateAndTime)();
}

class EspeciesBotanicas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombreCientifico => text()();
  TextColumn get nombreComun => text()();
}

class ZonasTerritoriales extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombreZona => text()();
}

// Configuración de la base de datos
@DriftDatabase(tables: [RegistrosCampo, EspeciesBotanicas, ZonasTerritoriales])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

// ESTA FUNCIÓN DEBE ESTAR AQUÍ, FUERA DE LA CLASE AppDatabase
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
