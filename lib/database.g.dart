// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $EspeciesBotanicasTable extends EspeciesBotanicas
    with TableInfo<$EspeciesBotanicasTable, EspeciesBotanica> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EspeciesBotanicasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreCientificoMeta = const VerificationMeta(
    'nombreCientifico',
  );
  @override
  late final GeneratedColumn<String> nombreCientifico = GeneratedColumn<String>(
    'nombre_cientifico',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreComunMeta = const VerificationMeta(
    'nombreComun',
  );
  @override
  late final GeneratedColumn<String> nombreComun = GeneratedColumn<String>(
    'nombre_comun',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombreCientifico, nombreComun];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'especies_botanicas';
  @override
  VerificationContext validateIntegrity(
    Insertable<EspeciesBotanica> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre_cientifico')) {
      context.handle(
        _nombreCientificoMeta,
        nombreCientifico.isAcceptableOrUnknown(
          data['nombre_cientifico']!,
          _nombreCientificoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nombreCientificoMeta);
    }
    if (data.containsKey('nombre_comun')) {
      context.handle(
        _nombreComunMeta,
        nombreComun.isAcceptableOrUnknown(
          data['nombre_comun']!,
          _nombreComunMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nombreComunMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EspeciesBotanica map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EspeciesBotanica(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombreCientifico: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_cientifico'],
      )!,
      nombreComun: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_comun'],
      )!,
    );
  }

  @override
  $EspeciesBotanicasTable createAlias(String alias) {
    return $EspeciesBotanicasTable(attachedDatabase, alias);
  }
}

class EspeciesBotanica extends DataClass
    implements Insertable<EspeciesBotanica> {
  final int id;
  final String nombreCientifico;
  final String nombreComun;
  const EspeciesBotanica({
    required this.id,
    required this.nombreCientifico,
    required this.nombreComun,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre_cientifico'] = Variable<String>(nombreCientifico);
    map['nombre_comun'] = Variable<String>(nombreComun);
    return map;
  }

  EspeciesBotanicasCompanion toCompanion(bool nullToAbsent) {
    return EspeciesBotanicasCompanion(
      id: Value(id),
      nombreCientifico: Value(nombreCientifico),
      nombreComun: Value(nombreComun),
    );
  }

  factory EspeciesBotanica.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EspeciesBotanica(
      id: serializer.fromJson<int>(json['id']),
      nombreCientifico: serializer.fromJson<String>(json['nombreCientifico']),
      nombreComun: serializer.fromJson<String>(json['nombreComun']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombreCientifico': serializer.toJson<String>(nombreCientifico),
      'nombreComun': serializer.toJson<String>(nombreComun),
    };
  }

  EspeciesBotanica copyWith({
    int? id,
    String? nombreCientifico,
    String? nombreComun,
  }) => EspeciesBotanica(
    id: id ?? this.id,
    nombreCientifico: nombreCientifico ?? this.nombreCientifico,
    nombreComun: nombreComun ?? this.nombreComun,
  );
  EspeciesBotanica copyWithCompanion(EspeciesBotanicasCompanion data) {
    return EspeciesBotanica(
      id: data.id.present ? data.id.value : this.id,
      nombreCientifico: data.nombreCientifico.present
          ? data.nombreCientifico.value
          : this.nombreCientifico,
      nombreComun: data.nombreComun.present
          ? data.nombreComun.value
          : this.nombreComun,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EspeciesBotanica(')
          ..write('id: $id, ')
          ..write('nombreCientifico: $nombreCientifico, ')
          ..write('nombreComun: $nombreComun')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombreCientifico, nombreComun);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EspeciesBotanica &&
          other.id == this.id &&
          other.nombreCientifico == this.nombreCientifico &&
          other.nombreComun == this.nombreComun);
}

class EspeciesBotanicasCompanion extends UpdateCompanion<EspeciesBotanica> {
  final Value<int> id;
  final Value<String> nombreCientifico;
  final Value<String> nombreComun;
  const EspeciesBotanicasCompanion({
    this.id = const Value.absent(),
    this.nombreCientifico = const Value.absent(),
    this.nombreComun = const Value.absent(),
  });
  EspeciesBotanicasCompanion.insert({
    this.id = const Value.absent(),
    required String nombreCientifico,
    required String nombreComun,
  }) : nombreCientifico = Value(nombreCientifico),
       nombreComun = Value(nombreComun);
  static Insertable<EspeciesBotanica> custom({
    Expression<int>? id,
    Expression<String>? nombreCientifico,
    Expression<String>? nombreComun,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombreCientifico != null) 'nombre_cientifico': nombreCientifico,
      if (nombreComun != null) 'nombre_comun': nombreComun,
    });
  }

  EspeciesBotanicasCompanion copyWith({
    Value<int>? id,
    Value<String>? nombreCientifico,
    Value<String>? nombreComun,
  }) {
    return EspeciesBotanicasCompanion(
      id: id ?? this.id,
      nombreCientifico: nombreCientifico ?? this.nombreCientifico,
      nombreComun: nombreComun ?? this.nombreComun,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombreCientifico.present) {
      map['nombre_cientifico'] = Variable<String>(nombreCientifico.value);
    }
    if (nombreComun.present) {
      map['nombre_comun'] = Variable<String>(nombreComun.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EspeciesBotanicasCompanion(')
          ..write('id: $id, ')
          ..write('nombreCientifico: $nombreCientifico, ')
          ..write('nombreComun: $nombreComun')
          ..write(')'))
        .toString();
  }
}

class $ZonasTerritorialesTable extends ZonasTerritoriales
    with TableInfo<$ZonasTerritorialesTable, ZonasTerritoriale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ZonasTerritorialesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreZonaMeta = const VerificationMeta(
    'nombreZona',
  );
  @override
  late final GeneratedColumn<String> nombreZona = GeneratedColumn<String>(
    'nombre_zona',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombreZona];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'zonas_territoriales';
  @override
  VerificationContext validateIntegrity(
    Insertable<ZonasTerritoriale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre_zona')) {
      context.handle(
        _nombreZonaMeta,
        nombreZona.isAcceptableOrUnknown(data['nombre_zona']!, _nombreZonaMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreZonaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ZonasTerritoriale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ZonasTerritoriale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombreZona: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_zona'],
      )!,
    );
  }

  @override
  $ZonasTerritorialesTable createAlias(String alias) {
    return $ZonasTerritorialesTable(attachedDatabase, alias);
  }
}

class ZonasTerritoriale extends DataClass
    implements Insertable<ZonasTerritoriale> {
  final int id;
  final String nombreZona;
  const ZonasTerritoriale({required this.id, required this.nombreZona});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre_zona'] = Variable<String>(nombreZona);
    return map;
  }

  ZonasTerritorialesCompanion toCompanion(bool nullToAbsent) {
    return ZonasTerritorialesCompanion(
      id: Value(id),
      nombreZona: Value(nombreZona),
    );
  }

  factory ZonasTerritoriale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ZonasTerritoriale(
      id: serializer.fromJson<int>(json['id']),
      nombreZona: serializer.fromJson<String>(json['nombreZona']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombreZona': serializer.toJson<String>(nombreZona),
    };
  }

  ZonasTerritoriale copyWith({int? id, String? nombreZona}) =>
      ZonasTerritoriale(
        id: id ?? this.id,
        nombreZona: nombreZona ?? this.nombreZona,
      );
  ZonasTerritoriale copyWithCompanion(ZonasTerritorialesCompanion data) {
    return ZonasTerritoriale(
      id: data.id.present ? data.id.value : this.id,
      nombreZona: data.nombreZona.present
          ? data.nombreZona.value
          : this.nombreZona,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ZonasTerritoriale(')
          ..write('id: $id, ')
          ..write('nombreZona: $nombreZona')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombreZona);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ZonasTerritoriale &&
          other.id == this.id &&
          other.nombreZona == this.nombreZona);
}

class ZonasTerritorialesCompanion extends UpdateCompanion<ZonasTerritoriale> {
  final Value<int> id;
  final Value<String> nombreZona;
  const ZonasTerritorialesCompanion({
    this.id = const Value.absent(),
    this.nombreZona = const Value.absent(),
  });
  ZonasTerritorialesCompanion.insert({
    this.id = const Value.absent(),
    required String nombreZona,
  }) : nombreZona = Value(nombreZona);
  static Insertable<ZonasTerritoriale> custom({
    Expression<int>? id,
    Expression<String>? nombreZona,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombreZona != null) 'nombre_zona': nombreZona,
    });
  }

  ZonasTerritorialesCompanion copyWith({
    Value<int>? id,
    Value<String>? nombreZona,
  }) {
    return ZonasTerritorialesCompanion(
      id: id ?? this.id,
      nombreZona: nombreZona ?? this.nombreZona,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombreZona.present) {
      map['nombre_zona'] = Variable<String>(nombreZona.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ZonasTerritorialesCompanion(')
          ..write('id: $id, ')
          ..write('nombreZona: $nombreZona')
          ..write(')'))
        .toString();
  }
}

class $RegistrosCampoTable extends RegistrosCampo
    with TableInfo<$RegistrosCampoTable, RegistrosCampoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegistrosCampoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _especieIdMeta = const VerificationMeta(
    'especieId',
  );
  @override
  late final GeneratedColumn<int> especieId = GeneratedColumn<int>(
    'especie_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES especies_botanicas (id)',
    ),
  );
  static const VerificationMeta _zonaIdMeta = const VerificationMeta('zonaId');
  @override
  late final GeneratedColumn<int> zonaId = GeneratedColumn<int>(
    'zona_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES zonas_territoriales (id)',
    ),
  );
  static const VerificationMeta _latitudMeta = const VerificationMeta(
    'latitud',
  );
  @override
  late final GeneratedColumn<double> latitud = GeneratedColumn<double>(
    'latitud',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudMeta = const VerificationMeta(
    'longitud',
  );
  @override
  late final GeneratedColumn<double> longitud = GeneratedColumn<double>(
    'longitud',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fotografiaUrlMeta = const VerificationMeta(
    'fotografiaUrl',
  );
  @override
  late final GeneratedColumn<String> fotografiaUrl = GeneratedColumn<String>(
    'fotografia_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaRegistroMeta = const VerificationMeta(
    'fechaRegistro',
  );
  @override
  late final GeneratedColumn<DateTime> fechaRegistro =
      GeneratedColumn<DateTime>(
        'fecha_registro',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    especieId,
    zonaId,
    latitud,
    longitud,
    fotografiaUrl,
    fechaRegistro,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'registros_campo';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegistrosCampoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('especie_id')) {
      context.handle(
        _especieIdMeta,
        especieId.isAcceptableOrUnknown(data['especie_id']!, _especieIdMeta),
      );
    } else if (isInserting) {
      context.missing(_especieIdMeta);
    }
    if (data.containsKey('zona_id')) {
      context.handle(
        _zonaIdMeta,
        zonaId.isAcceptableOrUnknown(data['zona_id']!, _zonaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_zonaIdMeta);
    }
    if (data.containsKey('latitud')) {
      context.handle(
        _latitudMeta,
        latitud.isAcceptableOrUnknown(data['latitud']!, _latitudMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudMeta);
    }
    if (data.containsKey('longitud')) {
      context.handle(
        _longitudMeta,
        longitud.isAcceptableOrUnknown(data['longitud']!, _longitudMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudMeta);
    }
    if (data.containsKey('fotografia_url')) {
      context.handle(
        _fotografiaUrlMeta,
        fotografiaUrl.isAcceptableOrUnknown(
          data['fotografia_url']!,
          _fotografiaUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fotografiaUrlMeta);
    }
    if (data.containsKey('fecha_registro')) {
      context.handle(
        _fechaRegistroMeta,
        fechaRegistro.isAcceptableOrUnknown(
          data['fecha_registro']!,
          _fechaRegistroMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RegistrosCampoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegistrosCampoData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      especieId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}especie_id'],
      )!,
      zonaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}zona_id'],
      )!,
      latitud: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitud'],
      )!,
      longitud: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitud'],
      )!,
      fotografiaUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fotografia_url'],
      )!,
      fechaRegistro: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_registro'],
      )!,
    );
  }

  @override
  $RegistrosCampoTable createAlias(String alias) {
    return $RegistrosCampoTable(attachedDatabase, alias);
  }
}

class RegistrosCampoData extends DataClass
    implements Insertable<RegistrosCampoData> {
  final int id;
  final int especieId;
  final int zonaId;
  final double latitud;
  final double longitud;
  final String fotografiaUrl;
  final DateTime fechaRegistro;
  const RegistrosCampoData({
    required this.id,
    required this.especieId,
    required this.zonaId,
    required this.latitud,
    required this.longitud,
    required this.fotografiaUrl,
    required this.fechaRegistro,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['especie_id'] = Variable<int>(especieId);
    map['zona_id'] = Variable<int>(zonaId);
    map['latitud'] = Variable<double>(latitud);
    map['longitud'] = Variable<double>(longitud);
    map['fotografia_url'] = Variable<String>(fotografiaUrl);
    map['fecha_registro'] = Variable<DateTime>(fechaRegistro);
    return map;
  }

  RegistrosCampoCompanion toCompanion(bool nullToAbsent) {
    return RegistrosCampoCompanion(
      id: Value(id),
      especieId: Value(especieId),
      zonaId: Value(zonaId),
      latitud: Value(latitud),
      longitud: Value(longitud),
      fotografiaUrl: Value(fotografiaUrl),
      fechaRegistro: Value(fechaRegistro),
    );
  }

  factory RegistrosCampoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegistrosCampoData(
      id: serializer.fromJson<int>(json['id']),
      especieId: serializer.fromJson<int>(json['especieId']),
      zonaId: serializer.fromJson<int>(json['zonaId']),
      latitud: serializer.fromJson<double>(json['latitud']),
      longitud: serializer.fromJson<double>(json['longitud']),
      fotografiaUrl: serializer.fromJson<String>(json['fotografiaUrl']),
      fechaRegistro: serializer.fromJson<DateTime>(json['fechaRegistro']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'especieId': serializer.toJson<int>(especieId),
      'zonaId': serializer.toJson<int>(zonaId),
      'latitud': serializer.toJson<double>(latitud),
      'longitud': serializer.toJson<double>(longitud),
      'fotografiaUrl': serializer.toJson<String>(fotografiaUrl),
      'fechaRegistro': serializer.toJson<DateTime>(fechaRegistro),
    };
  }

  RegistrosCampoData copyWith({
    int? id,
    int? especieId,
    int? zonaId,
    double? latitud,
    double? longitud,
    String? fotografiaUrl,
    DateTime? fechaRegistro,
  }) => RegistrosCampoData(
    id: id ?? this.id,
    especieId: especieId ?? this.especieId,
    zonaId: zonaId ?? this.zonaId,
    latitud: latitud ?? this.latitud,
    longitud: longitud ?? this.longitud,
    fotografiaUrl: fotografiaUrl ?? this.fotografiaUrl,
    fechaRegistro: fechaRegistro ?? this.fechaRegistro,
  );
  RegistrosCampoData copyWithCompanion(RegistrosCampoCompanion data) {
    return RegistrosCampoData(
      id: data.id.present ? data.id.value : this.id,
      especieId: data.especieId.present ? data.especieId.value : this.especieId,
      zonaId: data.zonaId.present ? data.zonaId.value : this.zonaId,
      latitud: data.latitud.present ? data.latitud.value : this.latitud,
      longitud: data.longitud.present ? data.longitud.value : this.longitud,
      fotografiaUrl: data.fotografiaUrl.present
          ? data.fotografiaUrl.value
          : this.fotografiaUrl,
      fechaRegistro: data.fechaRegistro.present
          ? data.fechaRegistro.value
          : this.fechaRegistro,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegistrosCampoData(')
          ..write('id: $id, ')
          ..write('especieId: $especieId, ')
          ..write('zonaId: $zonaId, ')
          ..write('latitud: $latitud, ')
          ..write('longitud: $longitud, ')
          ..write('fotografiaUrl: $fotografiaUrl, ')
          ..write('fechaRegistro: $fechaRegistro')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    especieId,
    zonaId,
    latitud,
    longitud,
    fotografiaUrl,
    fechaRegistro,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegistrosCampoData &&
          other.id == this.id &&
          other.especieId == this.especieId &&
          other.zonaId == this.zonaId &&
          other.latitud == this.latitud &&
          other.longitud == this.longitud &&
          other.fotografiaUrl == this.fotografiaUrl &&
          other.fechaRegistro == this.fechaRegistro);
}

class RegistrosCampoCompanion extends UpdateCompanion<RegistrosCampoData> {
  final Value<int> id;
  final Value<int> especieId;
  final Value<int> zonaId;
  final Value<double> latitud;
  final Value<double> longitud;
  final Value<String> fotografiaUrl;
  final Value<DateTime> fechaRegistro;
  const RegistrosCampoCompanion({
    this.id = const Value.absent(),
    this.especieId = const Value.absent(),
    this.zonaId = const Value.absent(),
    this.latitud = const Value.absent(),
    this.longitud = const Value.absent(),
    this.fotografiaUrl = const Value.absent(),
    this.fechaRegistro = const Value.absent(),
  });
  RegistrosCampoCompanion.insert({
    this.id = const Value.absent(),
    required int especieId,
    required int zonaId,
    required double latitud,
    required double longitud,
    required String fotografiaUrl,
    this.fechaRegistro = const Value.absent(),
  }) : especieId = Value(especieId),
       zonaId = Value(zonaId),
       latitud = Value(latitud),
       longitud = Value(longitud),
       fotografiaUrl = Value(fotografiaUrl);
  static Insertable<RegistrosCampoData> custom({
    Expression<int>? id,
    Expression<int>? especieId,
    Expression<int>? zonaId,
    Expression<double>? latitud,
    Expression<double>? longitud,
    Expression<String>? fotografiaUrl,
    Expression<DateTime>? fechaRegistro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (especieId != null) 'especie_id': especieId,
      if (zonaId != null) 'zona_id': zonaId,
      if (latitud != null) 'latitud': latitud,
      if (longitud != null) 'longitud': longitud,
      if (fotografiaUrl != null) 'fotografia_url': fotografiaUrl,
      if (fechaRegistro != null) 'fecha_registro': fechaRegistro,
    });
  }

  RegistrosCampoCompanion copyWith({
    Value<int>? id,
    Value<int>? especieId,
    Value<int>? zonaId,
    Value<double>? latitud,
    Value<double>? longitud,
    Value<String>? fotografiaUrl,
    Value<DateTime>? fechaRegistro,
  }) {
    return RegistrosCampoCompanion(
      id: id ?? this.id,
      especieId: especieId ?? this.especieId,
      zonaId: zonaId ?? this.zonaId,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      fotografiaUrl: fotografiaUrl ?? this.fotografiaUrl,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (especieId.present) {
      map['especie_id'] = Variable<int>(especieId.value);
    }
    if (zonaId.present) {
      map['zona_id'] = Variable<int>(zonaId.value);
    }
    if (latitud.present) {
      map['latitud'] = Variable<double>(latitud.value);
    }
    if (longitud.present) {
      map['longitud'] = Variable<double>(longitud.value);
    }
    if (fotografiaUrl.present) {
      map['fotografia_url'] = Variable<String>(fotografiaUrl.value);
    }
    if (fechaRegistro.present) {
      map['fecha_registro'] = Variable<DateTime>(fechaRegistro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegistrosCampoCompanion(')
          ..write('id: $id, ')
          ..write('especieId: $especieId, ')
          ..write('zonaId: $zonaId, ')
          ..write('latitud: $latitud, ')
          ..write('longitud: $longitud, ')
          ..write('fotografiaUrl: $fotografiaUrl, ')
          ..write('fechaRegistro: $fechaRegistro')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EspeciesBotanicasTable especiesBotanicas =
      $EspeciesBotanicasTable(this);
  late final $ZonasTerritorialesTable zonasTerritoriales =
      $ZonasTerritorialesTable(this);
  late final $RegistrosCampoTable registrosCampo = $RegistrosCampoTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    especiesBotanicas,
    zonasTerritoriales,
    registrosCampo,
  ];
}

typedef $$EspeciesBotanicasTableCreateCompanionBuilder =
    EspeciesBotanicasCompanion Function({
      Value<int> id,
      required String nombreCientifico,
      required String nombreComun,
    });
typedef $$EspeciesBotanicasTableUpdateCompanionBuilder =
    EspeciesBotanicasCompanion Function({
      Value<int> id,
      Value<String> nombreCientifico,
      Value<String> nombreComun,
    });

final class $$EspeciesBotanicasTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EspeciesBotanicasTable,
          EspeciesBotanica
        > {
  $$EspeciesBotanicasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$RegistrosCampoTable, List<RegistrosCampoData>>
  _registrosCampoRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.registrosCampo,
    aliasName: 'especies_botanicas__id__registros_campo__especie_id',
  );

  $$RegistrosCampoTableProcessedTableManager get registrosCampoRefs {
    final manager = $$RegistrosCampoTableTableManager(
      $_db,
      $_db.registrosCampo,
    ).filter((f) => f.especieId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_registrosCampoRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EspeciesBotanicasTableFilterComposer
    extends Composer<_$AppDatabase, $EspeciesBotanicasTable> {
  $$EspeciesBotanicasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreCientifico => $composableBuilder(
    column: $table.nombreCientifico,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreComun => $composableBuilder(
    column: $table.nombreComun,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> registrosCampoRefs(
    Expression<bool> Function($$RegistrosCampoTableFilterComposer f) f,
  ) {
    final $$RegistrosCampoTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.registrosCampo,
      getReferencedColumn: (t) => t.especieId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosCampoTableFilterComposer(
            $db: $db,
            $table: $db.registrosCampo,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EspeciesBotanicasTableOrderingComposer
    extends Composer<_$AppDatabase, $EspeciesBotanicasTable> {
  $$EspeciesBotanicasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreCientifico => $composableBuilder(
    column: $table.nombreCientifico,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreComun => $composableBuilder(
    column: $table.nombreComun,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EspeciesBotanicasTableAnnotationComposer
    extends Composer<_$AppDatabase, $EspeciesBotanicasTable> {
  $$EspeciesBotanicasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombreCientifico => $composableBuilder(
    column: $table.nombreCientifico,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nombreComun => $composableBuilder(
    column: $table.nombreComun,
    builder: (column) => column,
  );

  Expression<T> registrosCampoRefs<T extends Object>(
    Expression<T> Function($$RegistrosCampoTableAnnotationComposer a) f,
  ) {
    final $$RegistrosCampoTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.registrosCampo,
      getReferencedColumn: (t) => t.especieId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosCampoTableAnnotationComposer(
            $db: $db,
            $table: $db.registrosCampo,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EspeciesBotanicasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EspeciesBotanicasTable,
          EspeciesBotanica,
          $$EspeciesBotanicasTableFilterComposer,
          $$EspeciesBotanicasTableOrderingComposer,
          $$EspeciesBotanicasTableAnnotationComposer,
          $$EspeciesBotanicasTableCreateCompanionBuilder,
          $$EspeciesBotanicasTableUpdateCompanionBuilder,
          (EspeciesBotanica, $$EspeciesBotanicasTableReferences),
          EspeciesBotanica,
          PrefetchHooks Function({bool registrosCampoRefs})
        > {
  $$EspeciesBotanicasTableTableManager(
    _$AppDatabase db,
    $EspeciesBotanicasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EspeciesBotanicasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EspeciesBotanicasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EspeciesBotanicasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombreCientifico = const Value.absent(),
                Value<String> nombreComun = const Value.absent(),
              }) => EspeciesBotanicasCompanion(
                id: id,
                nombreCientifico: nombreCientifico,
                nombreComun: nombreComun,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombreCientifico,
                required String nombreComun,
              }) => EspeciesBotanicasCompanion.insert(
                id: id,
                nombreCientifico: nombreCientifico,
                nombreComun: nombreComun,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EspeciesBotanicasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({registrosCampoRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (registrosCampoRefs) db.registrosCampo,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (registrosCampoRefs)
                    await $_getPrefetchedData<
                      EspeciesBotanica,
                      $EspeciesBotanicasTable,
                      RegistrosCampoData
                    >(
                      currentTable: table,
                      referencedTable: $$EspeciesBotanicasTableReferences
                          ._registrosCampoRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EspeciesBotanicasTableReferences(
                            db,
                            table,
                            p0,
                          ).registrosCampoRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.especieId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EspeciesBotanicasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EspeciesBotanicasTable,
      EspeciesBotanica,
      $$EspeciesBotanicasTableFilterComposer,
      $$EspeciesBotanicasTableOrderingComposer,
      $$EspeciesBotanicasTableAnnotationComposer,
      $$EspeciesBotanicasTableCreateCompanionBuilder,
      $$EspeciesBotanicasTableUpdateCompanionBuilder,
      (EspeciesBotanica, $$EspeciesBotanicasTableReferences),
      EspeciesBotanica,
      PrefetchHooks Function({bool registrosCampoRefs})
    >;
typedef $$ZonasTerritorialesTableCreateCompanionBuilder =
    ZonasTerritorialesCompanion Function({
      Value<int> id,
      required String nombreZona,
    });
typedef $$ZonasTerritorialesTableUpdateCompanionBuilder =
    ZonasTerritorialesCompanion Function({
      Value<int> id,
      Value<String> nombreZona,
    });

final class $$ZonasTerritorialesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ZonasTerritorialesTable,
          ZonasTerritoriale
        > {
  $$ZonasTerritorialesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$RegistrosCampoTable, List<RegistrosCampoData>>
  _registrosCampoRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.registrosCampo,
    aliasName: 'zonas_territoriales__id__registros_campo__zona_id',
  );

  $$RegistrosCampoTableProcessedTableManager get registrosCampoRefs {
    final manager = $$RegistrosCampoTableTableManager(
      $_db,
      $_db.registrosCampo,
    ).filter((f) => f.zonaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_registrosCampoRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ZonasTerritorialesTableFilterComposer
    extends Composer<_$AppDatabase, $ZonasTerritorialesTable> {
  $$ZonasTerritorialesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreZona => $composableBuilder(
    column: $table.nombreZona,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> registrosCampoRefs(
    Expression<bool> Function($$RegistrosCampoTableFilterComposer f) f,
  ) {
    final $$RegistrosCampoTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.registrosCampo,
      getReferencedColumn: (t) => t.zonaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosCampoTableFilterComposer(
            $db: $db,
            $table: $db.registrosCampo,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ZonasTerritorialesTableOrderingComposer
    extends Composer<_$AppDatabase, $ZonasTerritorialesTable> {
  $$ZonasTerritorialesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreZona => $composableBuilder(
    column: $table.nombreZona,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ZonasTerritorialesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ZonasTerritorialesTable> {
  $$ZonasTerritorialesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombreZona => $composableBuilder(
    column: $table.nombreZona,
    builder: (column) => column,
  );

  Expression<T> registrosCampoRefs<T extends Object>(
    Expression<T> Function($$RegistrosCampoTableAnnotationComposer a) f,
  ) {
    final $$RegistrosCampoTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.registrosCampo,
      getReferencedColumn: (t) => t.zonaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegistrosCampoTableAnnotationComposer(
            $db: $db,
            $table: $db.registrosCampo,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ZonasTerritorialesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ZonasTerritorialesTable,
          ZonasTerritoriale,
          $$ZonasTerritorialesTableFilterComposer,
          $$ZonasTerritorialesTableOrderingComposer,
          $$ZonasTerritorialesTableAnnotationComposer,
          $$ZonasTerritorialesTableCreateCompanionBuilder,
          $$ZonasTerritorialesTableUpdateCompanionBuilder,
          (ZonasTerritoriale, $$ZonasTerritorialesTableReferences),
          ZonasTerritoriale,
          PrefetchHooks Function({bool registrosCampoRefs})
        > {
  $$ZonasTerritorialesTableTableManager(
    _$AppDatabase db,
    $ZonasTerritorialesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ZonasTerritorialesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ZonasTerritorialesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ZonasTerritorialesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombreZona = const Value.absent(),
              }) => ZonasTerritorialesCompanion(id: id, nombreZona: nombreZona),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombreZona,
              }) => ZonasTerritorialesCompanion.insert(
                id: id,
                nombreZona: nombreZona,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ZonasTerritorialesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({registrosCampoRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (registrosCampoRefs) db.registrosCampo,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (registrosCampoRefs)
                    await $_getPrefetchedData<
                      ZonasTerritoriale,
                      $ZonasTerritorialesTable,
                      RegistrosCampoData
                    >(
                      currentTable: table,
                      referencedTable: $$ZonasTerritorialesTableReferences
                          ._registrosCampoRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ZonasTerritorialesTableReferences(
                            db,
                            table,
                            p0,
                          ).registrosCampoRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.zonaId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ZonasTerritorialesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ZonasTerritorialesTable,
      ZonasTerritoriale,
      $$ZonasTerritorialesTableFilterComposer,
      $$ZonasTerritorialesTableOrderingComposer,
      $$ZonasTerritorialesTableAnnotationComposer,
      $$ZonasTerritorialesTableCreateCompanionBuilder,
      $$ZonasTerritorialesTableUpdateCompanionBuilder,
      (ZonasTerritoriale, $$ZonasTerritorialesTableReferences),
      ZonasTerritoriale,
      PrefetchHooks Function({bool registrosCampoRefs})
    >;
typedef $$RegistrosCampoTableCreateCompanionBuilder =
    RegistrosCampoCompanion Function({
      Value<int> id,
      required int especieId,
      required int zonaId,
      required double latitud,
      required double longitud,
      required String fotografiaUrl,
      Value<DateTime> fechaRegistro,
    });
typedef $$RegistrosCampoTableUpdateCompanionBuilder =
    RegistrosCampoCompanion Function({
      Value<int> id,
      Value<int> especieId,
      Value<int> zonaId,
      Value<double> latitud,
      Value<double> longitud,
      Value<String> fotografiaUrl,
      Value<DateTime> fechaRegistro,
    });

final class $$RegistrosCampoTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RegistrosCampoTable,
          RegistrosCampoData
        > {
  $$RegistrosCampoTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EspeciesBotanicasTable _especieIdTable(_$AppDatabase db) => db
      .especiesBotanicas
      .createAlias('registros_campo__especie_id__especies_botanicas__id');

  $$EspeciesBotanicasTableProcessedTableManager get especieId {
    final $_column = $_itemColumn<int>('especie_id')!;

    final manager = $$EspeciesBotanicasTableTableManager(
      $_db,
      $_db.especiesBotanicas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_especieIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ZonasTerritorialesTable _zonaIdTable(_$AppDatabase db) => db
      .zonasTerritoriales
      .createAlias('registros_campo__zona_id__zonas_territoriales__id');

  $$ZonasTerritorialesTableProcessedTableManager get zonaId {
    final $_column = $_itemColumn<int>('zona_id')!;

    final manager = $$ZonasTerritorialesTableTableManager(
      $_db,
      $_db.zonasTerritoriales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_zonaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RegistrosCampoTableFilterComposer
    extends Composer<_$AppDatabase, $RegistrosCampoTable> {
  $$RegistrosCampoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitud => $composableBuilder(
    column: $table.latitud,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitud => $composableBuilder(
    column: $table.longitud,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fotografiaUrl => $composableBuilder(
    column: $table.fotografiaUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaRegistro => $composableBuilder(
    column: $table.fechaRegistro,
    builder: (column) => ColumnFilters(column),
  );

  $$EspeciesBotanicasTableFilterComposer get especieId {
    final $$EspeciesBotanicasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.especieId,
      referencedTable: $db.especiesBotanicas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EspeciesBotanicasTableFilterComposer(
            $db: $db,
            $table: $db.especiesBotanicas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ZonasTerritorialesTableFilterComposer get zonaId {
    final $$ZonasTerritorialesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.zonaId,
      referencedTable: $db.zonasTerritoriales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ZonasTerritorialesTableFilterComposer(
            $db: $db,
            $table: $db.zonasTerritoriales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosCampoTableOrderingComposer
    extends Composer<_$AppDatabase, $RegistrosCampoTable> {
  $$RegistrosCampoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitud => $composableBuilder(
    column: $table.latitud,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitud => $composableBuilder(
    column: $table.longitud,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fotografiaUrl => $composableBuilder(
    column: $table.fotografiaUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaRegistro => $composableBuilder(
    column: $table.fechaRegistro,
    builder: (column) => ColumnOrderings(column),
  );

  $$EspeciesBotanicasTableOrderingComposer get especieId {
    final $$EspeciesBotanicasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.especieId,
      referencedTable: $db.especiesBotanicas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EspeciesBotanicasTableOrderingComposer(
            $db: $db,
            $table: $db.especiesBotanicas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ZonasTerritorialesTableOrderingComposer get zonaId {
    final $$ZonasTerritorialesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.zonaId,
      referencedTable: $db.zonasTerritoriales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ZonasTerritorialesTableOrderingComposer(
            $db: $db,
            $table: $db.zonasTerritoriales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegistrosCampoTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegistrosCampoTable> {
  $$RegistrosCampoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get latitud =>
      $composableBuilder(column: $table.latitud, builder: (column) => column);

  GeneratedColumn<double> get longitud =>
      $composableBuilder(column: $table.longitud, builder: (column) => column);

  GeneratedColumn<String> get fotografiaUrl => $composableBuilder(
    column: $table.fotografiaUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaRegistro => $composableBuilder(
    column: $table.fechaRegistro,
    builder: (column) => column,
  );

  $$EspeciesBotanicasTableAnnotationComposer get especieId {
    final $$EspeciesBotanicasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.especieId,
          referencedTable: $db.especiesBotanicas,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EspeciesBotanicasTableAnnotationComposer(
                $db: $db,
                $table: $db.especiesBotanicas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ZonasTerritorialesTableAnnotationComposer get zonaId {
    final $$ZonasTerritorialesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.zonaId,
          referencedTable: $db.zonasTerritoriales,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ZonasTerritorialesTableAnnotationComposer(
                $db: $db,
                $table: $db.zonasTerritoriales,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RegistrosCampoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RegistrosCampoTable,
          RegistrosCampoData,
          $$RegistrosCampoTableFilterComposer,
          $$RegistrosCampoTableOrderingComposer,
          $$RegistrosCampoTableAnnotationComposer,
          $$RegistrosCampoTableCreateCompanionBuilder,
          $$RegistrosCampoTableUpdateCompanionBuilder,
          (RegistrosCampoData, $$RegistrosCampoTableReferences),
          RegistrosCampoData,
          PrefetchHooks Function({bool especieId, bool zonaId})
        > {
  $$RegistrosCampoTableTableManager(
    _$AppDatabase db,
    $RegistrosCampoTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RegistrosCampoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RegistrosCampoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RegistrosCampoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> especieId = const Value.absent(),
                Value<int> zonaId = const Value.absent(),
                Value<double> latitud = const Value.absent(),
                Value<double> longitud = const Value.absent(),
                Value<String> fotografiaUrl = const Value.absent(),
                Value<DateTime> fechaRegistro = const Value.absent(),
              }) => RegistrosCampoCompanion(
                id: id,
                especieId: especieId,
                zonaId: zonaId,
                latitud: latitud,
                longitud: longitud,
                fotografiaUrl: fotografiaUrl,
                fechaRegistro: fechaRegistro,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int especieId,
                required int zonaId,
                required double latitud,
                required double longitud,
                required String fotografiaUrl,
                Value<DateTime> fechaRegistro = const Value.absent(),
              }) => RegistrosCampoCompanion.insert(
                id: id,
                especieId: especieId,
                zonaId: zonaId,
                latitud: latitud,
                longitud: longitud,
                fotografiaUrl: fotografiaUrl,
                fechaRegistro: fechaRegistro,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RegistrosCampoTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({especieId = false, zonaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (especieId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.especieId,
                                referencedTable: $$RegistrosCampoTableReferences
                                    ._especieIdTable(db),
                                referencedColumn:
                                    $$RegistrosCampoTableReferences
                                        ._especieIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (zonaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.zonaId,
                                referencedTable: $$RegistrosCampoTableReferences
                                    ._zonaIdTable(db),
                                referencedColumn:
                                    $$RegistrosCampoTableReferences
                                        ._zonaIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RegistrosCampoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RegistrosCampoTable,
      RegistrosCampoData,
      $$RegistrosCampoTableFilterComposer,
      $$RegistrosCampoTableOrderingComposer,
      $$RegistrosCampoTableAnnotationComposer,
      $$RegistrosCampoTableCreateCompanionBuilder,
      $$RegistrosCampoTableUpdateCompanionBuilder,
      (RegistrosCampoData, $$RegistrosCampoTableReferences),
      RegistrosCampoData,
      PrefetchHooks Function({bool especieId, bool zonaId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EspeciesBotanicasTableTableManager get especiesBotanicas =>
      $$EspeciesBotanicasTableTableManager(_db, _db.especiesBotanicas);
  $$ZonasTerritorialesTableTableManager get zonasTerritoriales =>
      $$ZonasTerritorialesTableTableManager(_db, _db.zonasTerritoriales);
  $$RegistrosCampoTableTableManager get registrosCampo =>
      $$RegistrosCampoTableTableManager(_db, _db.registrosCampo);
}
