import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Esquema de lectura y almacenamiento offline minimizado
class RegistrosCampo extends Table {
  // Se reemplaza autoIncrement() por UUID generado en el cliente
  TextColumn get id => text()();
  TextColumn get nombreEspecie => text().withLength(min: 3, max: 100)();
  RealColumn get latitud => real()();
  RealColumn get longitud => real()();
  TextColumn get fotografiaUrl => text()();
  DateTimeColumn get fechaRegistro =>
      dateTime().withDefault(currentDateAndTime)();

  // Campos de control del cliente (Semana 12)
  BoolColumn get sincronizado => boolean().withDefault(const Constant(false))();
  BoolColumn get marcadoEliminacion =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get ultimaActualizacion => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Tabla de cola de salida para modo avión
class OperacionesPendientes extends Table {
  TextColumn get idOperacion => text()();
  TextColumn get tipoOperacion => text()(); // Ej: 'POST', 'PATCH', 'DELETE'
  TextColumn get payloadJson => text()(); // Cuerpo de la petición serializado
  IntColumn get intentosReenvio => integer().withDefault(const Constant(0))();
  DateTimeColumn get fechaEncolado =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {idOperacion};
}

@DriftDatabase(tables: [RegistrosCampo, OperacionesPendientes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  // Se incrementa la versión para migrar el esquema sin destruir datos
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          // Migración: Añadir nuevas columnas y la tabla de cola
          await m.addColumn(registrosCampo, registrosCampo.sincronizado);
          await m.addColumn(registrosCampo, registrosCampo.marcadoEliminacion);
          await m.addColumn(registrosCampo, registrosCampo.ultimaActualizacion);
          await m.createTable(operacionesPendientes);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
