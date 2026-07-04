import 'package:drift/drift.dart';

part 'database.g.dart';

// 1. Tabla de Catálogo (Estática)
class EspeciesBotanicas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombreCientifico => text()();
  TextColumn get nombreComun => text()();
}

// 2. Tabla de Ubicación (Delimitación)
class ZonasTerritoriales extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombreZona => text()();
}

// 3. Tabla Transaccional (La que conecta todo)
class RegistrosCampo extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Relaciones (Aquí es donde ocurre la magia relacional)
  IntColumn get especieId => integer().references(EspeciesBotanicas, #id)();
  IntColumn get zonaId => integer().references(ZonasTerritoriales, #id)();

  RealColumn get latitud => real()();
  RealColumn get longitud => real()();
  TextColumn get fotografiaUrl => text()();
  DateTimeColumn get fechaRegistro =>
      dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [RegistrosCampo, EspeciesBotanicas, ZonasTerritoriales])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;
}
