// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RegistrosCampoTable extends RegistrosCampo
    with TableInfo<$RegistrosCampoTable, RegistrosCampoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegistrosCampoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreEspecieMeta = const VerificationMeta(
    'nombreEspecie',
  );
  @override
  late final GeneratedColumn<String> nombreEspecie = GeneratedColumn<String>(
    'nombre_especie',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _sincronizadoMeta = const VerificationMeta(
    'sincronizado',
  );
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
    'sincronizado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sincronizado" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _marcadoEliminacionMeta =
      const VerificationMeta('marcadoEliminacion');
  @override
  late final GeneratedColumn<bool> marcadoEliminacion = GeneratedColumn<bool>(
    'marcado_eliminacion',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("marcado_eliminacion" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _ultimaActualizacionMeta =
      const VerificationMeta('ultimaActualizacion');
  @override
  late final GeneratedColumn<DateTime> ultimaActualizacion =
      GeneratedColumn<DateTime>(
        'ultima_actualizacion',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombreEspecie,
    latitud,
    longitud,
    fotografiaUrl,
    fechaRegistro,
    sincronizado,
    marcadoEliminacion,
    ultimaActualizacion,
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre_especie')) {
      context.handle(
        _nombreEspecieMeta,
        nombreEspecie.isAcceptableOrUnknown(
          data['nombre_especie']!,
          _nombreEspecieMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nombreEspecieMeta);
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
    if (data.containsKey('sincronizado')) {
      context.handle(
        _sincronizadoMeta,
        sincronizado.isAcceptableOrUnknown(
          data['sincronizado']!,
          _sincronizadoMeta,
        ),
      );
    }
    if (data.containsKey('marcado_eliminacion')) {
      context.handle(
        _marcadoEliminacionMeta,
        marcadoEliminacion.isAcceptableOrUnknown(
          data['marcado_eliminacion']!,
          _marcadoEliminacionMeta,
        ),
      );
    }
    if (data.containsKey('ultima_actualizacion')) {
      context.handle(
        _ultimaActualizacionMeta,
        ultimaActualizacion.isAcceptableOrUnknown(
          data['ultima_actualizacion']!,
          _ultimaActualizacionMeta,
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nombreEspecie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_especie'],
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
      sincronizado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sincronizado'],
      )!,
      marcadoEliminacion: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}marcado_eliminacion'],
      )!,
      ultimaActualizacion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ultima_actualizacion'],
      ),
    );
  }

  @override
  $RegistrosCampoTable createAlias(String alias) {
    return $RegistrosCampoTable(attachedDatabase, alias);
  }
}

class RegistrosCampoData extends DataClass
    implements Insertable<RegistrosCampoData> {
  final String id;
  final String nombreEspecie;
  final double latitud;
  final double longitud;
  final String fotografiaUrl;
  final DateTime fechaRegistro;
  final bool sincronizado;
  final bool marcadoEliminacion;
  final DateTime? ultimaActualizacion;
  const RegistrosCampoData({
    required this.id,
    required this.nombreEspecie,
    required this.latitud,
    required this.longitud,
    required this.fotografiaUrl,
    required this.fechaRegistro,
    required this.sincronizado,
    required this.marcadoEliminacion,
    this.ultimaActualizacion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre_especie'] = Variable<String>(nombreEspecie);
    map['latitud'] = Variable<double>(latitud);
    map['longitud'] = Variable<double>(longitud);
    map['fotografia_url'] = Variable<String>(fotografiaUrl);
    map['fecha_registro'] = Variable<DateTime>(fechaRegistro);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['marcado_eliminacion'] = Variable<bool>(marcadoEliminacion);
    if (!nullToAbsent || ultimaActualizacion != null) {
      map['ultima_actualizacion'] = Variable<DateTime>(ultimaActualizacion);
    }
    return map;
  }

  RegistrosCampoCompanion toCompanion(bool nullToAbsent) {
    return RegistrosCampoCompanion(
      id: Value(id),
      nombreEspecie: Value(nombreEspecie),
      latitud: Value(latitud),
      longitud: Value(longitud),
      fotografiaUrl: Value(fotografiaUrl),
      fechaRegistro: Value(fechaRegistro),
      sincronizado: Value(sincronizado),
      marcadoEliminacion: Value(marcadoEliminacion),
      ultimaActualizacion: ultimaActualizacion == null && nullToAbsent
          ? const Value.absent()
          : Value(ultimaActualizacion),
    );
  }

  factory RegistrosCampoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegistrosCampoData(
      id: serializer.fromJson<String>(json['id']),
      nombreEspecie: serializer.fromJson<String>(json['nombreEspecie']),
      latitud: serializer.fromJson<double>(json['latitud']),
      longitud: serializer.fromJson<double>(json['longitud']),
      fotografiaUrl: serializer.fromJson<String>(json['fotografiaUrl']),
      fechaRegistro: serializer.fromJson<DateTime>(json['fechaRegistro']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      marcadoEliminacion: serializer.fromJson<bool>(json['marcadoEliminacion']),
      ultimaActualizacion: serializer.fromJson<DateTime?>(
        json['ultimaActualizacion'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombreEspecie': serializer.toJson<String>(nombreEspecie),
      'latitud': serializer.toJson<double>(latitud),
      'longitud': serializer.toJson<double>(longitud),
      'fotografiaUrl': serializer.toJson<String>(fotografiaUrl),
      'fechaRegistro': serializer.toJson<DateTime>(fechaRegistro),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'marcadoEliminacion': serializer.toJson<bool>(marcadoEliminacion),
      'ultimaActualizacion': serializer.toJson<DateTime?>(ultimaActualizacion),
    };
  }

  RegistrosCampoData copyWith({
    String? id,
    String? nombreEspecie,
    double? latitud,
    double? longitud,
    String? fotografiaUrl,
    DateTime? fechaRegistro,
    bool? sincronizado,
    bool? marcadoEliminacion,
    Value<DateTime?> ultimaActualizacion = const Value.absent(),
  }) => RegistrosCampoData(
    id: id ?? this.id,
    nombreEspecie: nombreEspecie ?? this.nombreEspecie,
    latitud: latitud ?? this.latitud,
    longitud: longitud ?? this.longitud,
    fotografiaUrl: fotografiaUrl ?? this.fotografiaUrl,
    fechaRegistro: fechaRegistro ?? this.fechaRegistro,
    sincronizado: sincronizado ?? this.sincronizado,
    marcadoEliminacion: marcadoEliminacion ?? this.marcadoEliminacion,
    ultimaActualizacion: ultimaActualizacion.present
        ? ultimaActualizacion.value
        : this.ultimaActualizacion,
  );
  RegistrosCampoData copyWithCompanion(RegistrosCampoCompanion data) {
    return RegistrosCampoData(
      id: data.id.present ? data.id.value : this.id,
      nombreEspecie: data.nombreEspecie.present
          ? data.nombreEspecie.value
          : this.nombreEspecie,
      latitud: data.latitud.present ? data.latitud.value : this.latitud,
      longitud: data.longitud.present ? data.longitud.value : this.longitud,
      fotografiaUrl: data.fotografiaUrl.present
          ? data.fotografiaUrl.value
          : this.fotografiaUrl,
      fechaRegistro: data.fechaRegistro.present
          ? data.fechaRegistro.value
          : this.fechaRegistro,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      marcadoEliminacion: data.marcadoEliminacion.present
          ? data.marcadoEliminacion.value
          : this.marcadoEliminacion,
      ultimaActualizacion: data.ultimaActualizacion.present
          ? data.ultimaActualizacion.value
          : this.ultimaActualizacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegistrosCampoData(')
          ..write('id: $id, ')
          ..write('nombreEspecie: $nombreEspecie, ')
          ..write('latitud: $latitud, ')
          ..write('longitud: $longitud, ')
          ..write('fotografiaUrl: $fotografiaUrl, ')
          ..write('fechaRegistro: $fechaRegistro, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('marcadoEliminacion: $marcadoEliminacion, ')
          ..write('ultimaActualizacion: $ultimaActualizacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombreEspecie,
    latitud,
    longitud,
    fotografiaUrl,
    fechaRegistro,
    sincronizado,
    marcadoEliminacion,
    ultimaActualizacion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegistrosCampoData &&
          other.id == this.id &&
          other.nombreEspecie == this.nombreEspecie &&
          other.latitud == this.latitud &&
          other.longitud == this.longitud &&
          other.fotografiaUrl == this.fotografiaUrl &&
          other.fechaRegistro == this.fechaRegistro &&
          other.sincronizado == this.sincronizado &&
          other.marcadoEliminacion == this.marcadoEliminacion &&
          other.ultimaActualizacion == this.ultimaActualizacion);
}

class RegistrosCampoCompanion extends UpdateCompanion<RegistrosCampoData> {
  final Value<String> id;
  final Value<String> nombreEspecie;
  final Value<double> latitud;
  final Value<double> longitud;
  final Value<String> fotografiaUrl;
  final Value<DateTime> fechaRegistro;
  final Value<bool> sincronizado;
  final Value<bool> marcadoEliminacion;
  final Value<DateTime?> ultimaActualizacion;
  final Value<int> rowid;
  const RegistrosCampoCompanion({
    this.id = const Value.absent(),
    this.nombreEspecie = const Value.absent(),
    this.latitud = const Value.absent(),
    this.longitud = const Value.absent(),
    this.fotografiaUrl = const Value.absent(),
    this.fechaRegistro = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.marcadoEliminacion = const Value.absent(),
    this.ultimaActualizacion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RegistrosCampoCompanion.insert({
    required String id,
    required String nombreEspecie,
    required double latitud,
    required double longitud,
    required String fotografiaUrl,
    this.fechaRegistro = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.marcadoEliminacion = const Value.absent(),
    this.ultimaActualizacion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombreEspecie = Value(nombreEspecie),
       latitud = Value(latitud),
       longitud = Value(longitud),
       fotografiaUrl = Value(fotografiaUrl);
  static Insertable<RegistrosCampoData> custom({
    Expression<String>? id,
    Expression<String>? nombreEspecie,
    Expression<double>? latitud,
    Expression<double>? longitud,
    Expression<String>? fotografiaUrl,
    Expression<DateTime>? fechaRegistro,
    Expression<bool>? sincronizado,
    Expression<bool>? marcadoEliminacion,
    Expression<DateTime>? ultimaActualizacion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombreEspecie != null) 'nombre_especie': nombreEspecie,
      if (latitud != null) 'latitud': latitud,
      if (longitud != null) 'longitud': longitud,
      if (fotografiaUrl != null) 'fotografia_url': fotografiaUrl,
      if (fechaRegistro != null) 'fecha_registro': fechaRegistro,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (marcadoEliminacion != null) 'marcado_eliminacion': marcadoEliminacion,
      if (ultimaActualizacion != null)
        'ultima_actualizacion': ultimaActualizacion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RegistrosCampoCompanion copyWith({
    Value<String>? id,
    Value<String>? nombreEspecie,
    Value<double>? latitud,
    Value<double>? longitud,
    Value<String>? fotografiaUrl,
    Value<DateTime>? fechaRegistro,
    Value<bool>? sincronizado,
    Value<bool>? marcadoEliminacion,
    Value<DateTime?>? ultimaActualizacion,
    Value<int>? rowid,
  }) {
    return RegistrosCampoCompanion(
      id: id ?? this.id,
      nombreEspecie: nombreEspecie ?? this.nombreEspecie,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      fotografiaUrl: fotografiaUrl ?? this.fotografiaUrl,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
      sincronizado: sincronizado ?? this.sincronizado,
      marcadoEliminacion: marcadoEliminacion ?? this.marcadoEliminacion,
      ultimaActualizacion: ultimaActualizacion ?? this.ultimaActualizacion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombreEspecie.present) {
      map['nombre_especie'] = Variable<String>(nombreEspecie.value);
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
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (marcadoEliminacion.present) {
      map['marcado_eliminacion'] = Variable<bool>(marcadoEliminacion.value);
    }
    if (ultimaActualizacion.present) {
      map['ultima_actualizacion'] = Variable<DateTime>(
        ultimaActualizacion.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegistrosCampoCompanion(')
          ..write('id: $id, ')
          ..write('nombreEspecie: $nombreEspecie, ')
          ..write('latitud: $latitud, ')
          ..write('longitud: $longitud, ')
          ..write('fotografiaUrl: $fotografiaUrl, ')
          ..write('fechaRegistro: $fechaRegistro, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('marcadoEliminacion: $marcadoEliminacion, ')
          ..write('ultimaActualizacion: $ultimaActualizacion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OperacionesPendientesTable extends OperacionesPendientes
    with TableInfo<$OperacionesPendientesTable, OperacionesPendiente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OperacionesPendientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idOperacionMeta = const VerificationMeta(
    'idOperacion',
  );
  @override
  late final GeneratedColumn<String> idOperacion = GeneratedColumn<String>(
    'id_operacion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoOperacionMeta = const VerificationMeta(
    'tipoOperacion',
  );
  @override
  late final GeneratedColumn<String> tipoOperacion = GeneratedColumn<String>(
    'tipo_operacion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intentosReenvioMeta = const VerificationMeta(
    'intentosReenvio',
  );
  @override
  late final GeneratedColumn<int> intentosReenvio = GeneratedColumn<int>(
    'intentos_reenvio',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fechaEncoladoMeta = const VerificationMeta(
    'fechaEncolado',
  );
  @override
  late final GeneratedColumn<DateTime> fechaEncolado =
      GeneratedColumn<DateTime>(
        'fecha_encolado',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    idOperacion,
    tipoOperacion,
    payloadJson,
    intentosReenvio,
    fechaEncolado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'operaciones_pendientes';
  @override
  VerificationContext validateIntegrity(
    Insertable<OperacionesPendiente> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_operacion')) {
      context.handle(
        _idOperacionMeta,
        idOperacion.isAcceptableOrUnknown(
          data['id_operacion']!,
          _idOperacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idOperacionMeta);
    }
    if (data.containsKey('tipo_operacion')) {
      context.handle(
        _tipoOperacionMeta,
        tipoOperacion.isAcceptableOrUnknown(
          data['tipo_operacion']!,
          _tipoOperacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoOperacionMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('intentos_reenvio')) {
      context.handle(
        _intentosReenvioMeta,
        intentosReenvio.isAcceptableOrUnknown(
          data['intentos_reenvio']!,
          _intentosReenvioMeta,
        ),
      );
    }
    if (data.containsKey('fecha_encolado')) {
      context.handle(
        _fechaEncoladoMeta,
        fechaEncolado.isAcceptableOrUnknown(
          data['fecha_encolado']!,
          _fechaEncoladoMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idOperacion};
  @override
  OperacionesPendiente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OperacionesPendiente(
      idOperacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_operacion'],
      )!,
      tipoOperacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_operacion'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      intentosReenvio: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intentos_reenvio'],
      )!,
      fechaEncolado: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_encolado'],
      )!,
    );
  }

  @override
  $OperacionesPendientesTable createAlias(String alias) {
    return $OperacionesPendientesTable(attachedDatabase, alias);
  }
}

class OperacionesPendiente extends DataClass
    implements Insertable<OperacionesPendiente> {
  final String idOperacion;
  final String tipoOperacion;
  final String payloadJson;
  final int intentosReenvio;
  final DateTime fechaEncolado;
  const OperacionesPendiente({
    required this.idOperacion,
    required this.tipoOperacion,
    required this.payloadJson,
    required this.intentosReenvio,
    required this.fechaEncolado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_operacion'] = Variable<String>(idOperacion);
    map['tipo_operacion'] = Variable<String>(tipoOperacion);
    map['payload_json'] = Variable<String>(payloadJson);
    map['intentos_reenvio'] = Variable<int>(intentosReenvio);
    map['fecha_encolado'] = Variable<DateTime>(fechaEncolado);
    return map;
  }

  OperacionesPendientesCompanion toCompanion(bool nullToAbsent) {
    return OperacionesPendientesCompanion(
      idOperacion: Value(idOperacion),
      tipoOperacion: Value(tipoOperacion),
      payloadJson: Value(payloadJson),
      intentosReenvio: Value(intentosReenvio),
      fechaEncolado: Value(fechaEncolado),
    );
  }

  factory OperacionesPendiente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OperacionesPendiente(
      idOperacion: serializer.fromJson<String>(json['idOperacion']),
      tipoOperacion: serializer.fromJson<String>(json['tipoOperacion']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      intentosReenvio: serializer.fromJson<int>(json['intentosReenvio']),
      fechaEncolado: serializer.fromJson<DateTime>(json['fechaEncolado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idOperacion': serializer.toJson<String>(idOperacion),
      'tipoOperacion': serializer.toJson<String>(tipoOperacion),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'intentosReenvio': serializer.toJson<int>(intentosReenvio),
      'fechaEncolado': serializer.toJson<DateTime>(fechaEncolado),
    };
  }

  OperacionesPendiente copyWith({
    String? idOperacion,
    String? tipoOperacion,
    String? payloadJson,
    int? intentosReenvio,
    DateTime? fechaEncolado,
  }) => OperacionesPendiente(
    idOperacion: idOperacion ?? this.idOperacion,
    tipoOperacion: tipoOperacion ?? this.tipoOperacion,
    payloadJson: payloadJson ?? this.payloadJson,
    intentosReenvio: intentosReenvio ?? this.intentosReenvio,
    fechaEncolado: fechaEncolado ?? this.fechaEncolado,
  );
  OperacionesPendiente copyWithCompanion(OperacionesPendientesCompanion data) {
    return OperacionesPendiente(
      idOperacion: data.idOperacion.present
          ? data.idOperacion.value
          : this.idOperacion,
      tipoOperacion: data.tipoOperacion.present
          ? data.tipoOperacion.value
          : this.tipoOperacion,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      intentosReenvio: data.intentosReenvio.present
          ? data.intentosReenvio.value
          : this.intentosReenvio,
      fechaEncolado: data.fechaEncolado.present
          ? data.fechaEncolado.value
          : this.fechaEncolado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OperacionesPendiente(')
          ..write('idOperacion: $idOperacion, ')
          ..write('tipoOperacion: $tipoOperacion, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('intentosReenvio: $intentosReenvio, ')
          ..write('fechaEncolado: $fechaEncolado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idOperacion,
    tipoOperacion,
    payloadJson,
    intentosReenvio,
    fechaEncolado,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OperacionesPendiente &&
          other.idOperacion == this.idOperacion &&
          other.tipoOperacion == this.tipoOperacion &&
          other.payloadJson == this.payloadJson &&
          other.intentosReenvio == this.intentosReenvio &&
          other.fechaEncolado == this.fechaEncolado);
}

class OperacionesPendientesCompanion
    extends UpdateCompanion<OperacionesPendiente> {
  final Value<String> idOperacion;
  final Value<String> tipoOperacion;
  final Value<String> payloadJson;
  final Value<int> intentosReenvio;
  final Value<DateTime> fechaEncolado;
  final Value<int> rowid;
  const OperacionesPendientesCompanion({
    this.idOperacion = const Value.absent(),
    this.tipoOperacion = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.intentosReenvio = const Value.absent(),
    this.fechaEncolado = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OperacionesPendientesCompanion.insert({
    required String idOperacion,
    required String tipoOperacion,
    required String payloadJson,
    this.intentosReenvio = const Value.absent(),
    this.fechaEncolado = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : idOperacion = Value(idOperacion),
       tipoOperacion = Value(tipoOperacion),
       payloadJson = Value(payloadJson);
  static Insertable<OperacionesPendiente> custom({
    Expression<String>? idOperacion,
    Expression<String>? tipoOperacion,
    Expression<String>? payloadJson,
    Expression<int>? intentosReenvio,
    Expression<DateTime>? fechaEncolado,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idOperacion != null) 'id_operacion': idOperacion,
      if (tipoOperacion != null) 'tipo_operacion': tipoOperacion,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (intentosReenvio != null) 'intentos_reenvio': intentosReenvio,
      if (fechaEncolado != null) 'fecha_encolado': fechaEncolado,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OperacionesPendientesCompanion copyWith({
    Value<String>? idOperacion,
    Value<String>? tipoOperacion,
    Value<String>? payloadJson,
    Value<int>? intentosReenvio,
    Value<DateTime>? fechaEncolado,
    Value<int>? rowid,
  }) {
    return OperacionesPendientesCompanion(
      idOperacion: idOperacion ?? this.idOperacion,
      tipoOperacion: tipoOperacion ?? this.tipoOperacion,
      payloadJson: payloadJson ?? this.payloadJson,
      intentosReenvio: intentosReenvio ?? this.intentosReenvio,
      fechaEncolado: fechaEncolado ?? this.fechaEncolado,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idOperacion.present) {
      map['id_operacion'] = Variable<String>(idOperacion.value);
    }
    if (tipoOperacion.present) {
      map['tipo_operacion'] = Variable<String>(tipoOperacion.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (intentosReenvio.present) {
      map['intentos_reenvio'] = Variable<int>(intentosReenvio.value);
    }
    if (fechaEncolado.present) {
      map['fecha_encolado'] = Variable<DateTime>(fechaEncolado.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OperacionesPendientesCompanion(')
          ..write('idOperacion: $idOperacion, ')
          ..write('tipoOperacion: $tipoOperacion, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('intentosReenvio: $intentosReenvio, ')
          ..write('fechaEncolado: $fechaEncolado, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RegistrosCampoTable registrosCampo = $RegistrosCampoTable(this);
  late final $OperacionesPendientesTable operacionesPendientes =
      $OperacionesPendientesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    registrosCampo,
    operacionesPendientes,
  ];
}

typedef $$RegistrosCampoTableCreateCompanionBuilder =
    RegistrosCampoCompanion Function({
      required String id,
      required String nombreEspecie,
      required double latitud,
      required double longitud,
      required String fotografiaUrl,
      Value<DateTime> fechaRegistro,
      Value<bool> sincronizado,
      Value<bool> marcadoEliminacion,
      Value<DateTime?> ultimaActualizacion,
      Value<int> rowid,
    });
typedef $$RegistrosCampoTableUpdateCompanionBuilder =
    RegistrosCampoCompanion Function({
      Value<String> id,
      Value<String> nombreEspecie,
      Value<double> latitud,
      Value<double> longitud,
      Value<String> fotografiaUrl,
      Value<DateTime> fechaRegistro,
      Value<bool> sincronizado,
      Value<bool> marcadoEliminacion,
      Value<DateTime?> ultimaActualizacion,
      Value<int> rowid,
    });

class $$RegistrosCampoTableFilterComposer
    extends Composer<_$AppDatabase, $RegistrosCampoTable> {
  $$RegistrosCampoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreEspecie => $composableBuilder(
    column: $table.nombreEspecie,
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

  ColumnFilters<bool> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get marcadoEliminacion => $composableBuilder(
    column: $table.marcadoEliminacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ultimaActualizacion => $composableBuilder(
    column: $table.ultimaActualizacion,
    builder: (column) => ColumnFilters(column),
  );
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreEspecie => $composableBuilder(
    column: $table.nombreEspecie,
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

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get marcadoEliminacion => $composableBuilder(
    column: $table.marcadoEliminacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ultimaActualizacion => $composableBuilder(
    column: $table.ultimaActualizacion,
    builder: (column) => ColumnOrderings(column),
  );
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombreEspecie => $composableBuilder(
    column: $table.nombreEspecie,
    builder: (column) => column,
  );

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

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get marcadoEliminacion => $composableBuilder(
    column: $table.marcadoEliminacion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get ultimaActualizacion => $composableBuilder(
    column: $table.ultimaActualizacion,
    builder: (column) => column,
  );
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
          (
            RegistrosCampoData,
            BaseReferences<
              _$AppDatabase,
              $RegistrosCampoTable,
              RegistrosCampoData
            >,
          ),
          RegistrosCampoData,
          PrefetchHooks Function()
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
                Value<String> id = const Value.absent(),
                Value<String> nombreEspecie = const Value.absent(),
                Value<double> latitud = const Value.absent(),
                Value<double> longitud = const Value.absent(),
                Value<String> fotografiaUrl = const Value.absent(),
                Value<DateTime> fechaRegistro = const Value.absent(),
                Value<bool> sincronizado = const Value.absent(),
                Value<bool> marcadoEliminacion = const Value.absent(),
                Value<DateTime?> ultimaActualizacion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RegistrosCampoCompanion(
                id: id,
                nombreEspecie: nombreEspecie,
                latitud: latitud,
                longitud: longitud,
                fotografiaUrl: fotografiaUrl,
                fechaRegistro: fechaRegistro,
                sincronizado: sincronizado,
                marcadoEliminacion: marcadoEliminacion,
                ultimaActualizacion: ultimaActualizacion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombreEspecie,
                required double latitud,
                required double longitud,
                required String fotografiaUrl,
                Value<DateTime> fechaRegistro = const Value.absent(),
                Value<bool> sincronizado = const Value.absent(),
                Value<bool> marcadoEliminacion = const Value.absent(),
                Value<DateTime?> ultimaActualizacion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RegistrosCampoCompanion.insert(
                id: id,
                nombreEspecie: nombreEspecie,
                latitud: latitud,
                longitud: longitud,
                fotografiaUrl: fotografiaUrl,
                fechaRegistro: fechaRegistro,
                sincronizado: sincronizado,
                marcadoEliminacion: marcadoEliminacion,
                ultimaActualizacion: ultimaActualizacion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (
        RegistrosCampoData,
        BaseReferences<_$AppDatabase, $RegistrosCampoTable, RegistrosCampoData>,
      ),
      RegistrosCampoData,
      PrefetchHooks Function()
    >;
typedef $$OperacionesPendientesTableCreateCompanionBuilder =
    OperacionesPendientesCompanion Function({
      required String idOperacion,
      required String tipoOperacion,
      required String payloadJson,
      Value<int> intentosReenvio,
      Value<DateTime> fechaEncolado,
      Value<int> rowid,
    });
typedef $$OperacionesPendientesTableUpdateCompanionBuilder =
    OperacionesPendientesCompanion Function({
      Value<String> idOperacion,
      Value<String> tipoOperacion,
      Value<String> payloadJson,
      Value<int> intentosReenvio,
      Value<DateTime> fechaEncolado,
      Value<int> rowid,
    });

class $$OperacionesPendientesTableFilterComposer
    extends Composer<_$AppDatabase, $OperacionesPendientesTable> {
  $$OperacionesPendientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idOperacion => $composableBuilder(
    column: $table.idOperacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoOperacion => $composableBuilder(
    column: $table.tipoOperacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intentosReenvio => $composableBuilder(
    column: $table.intentosReenvio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaEncolado => $composableBuilder(
    column: $table.fechaEncolado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OperacionesPendientesTableOrderingComposer
    extends Composer<_$AppDatabase, $OperacionesPendientesTable> {
  $$OperacionesPendientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idOperacion => $composableBuilder(
    column: $table.idOperacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoOperacion => $composableBuilder(
    column: $table.tipoOperacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intentosReenvio => $composableBuilder(
    column: $table.intentosReenvio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaEncolado => $composableBuilder(
    column: $table.fechaEncolado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OperacionesPendientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OperacionesPendientesTable> {
  $$OperacionesPendientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idOperacion => $composableBuilder(
    column: $table.idOperacion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipoOperacion => $composableBuilder(
    column: $table.tipoOperacion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intentosReenvio => $composableBuilder(
    column: $table.intentosReenvio,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaEncolado => $composableBuilder(
    column: $table.fechaEncolado,
    builder: (column) => column,
  );
}

class $$OperacionesPendientesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OperacionesPendientesTable,
          OperacionesPendiente,
          $$OperacionesPendientesTableFilterComposer,
          $$OperacionesPendientesTableOrderingComposer,
          $$OperacionesPendientesTableAnnotationComposer,
          $$OperacionesPendientesTableCreateCompanionBuilder,
          $$OperacionesPendientesTableUpdateCompanionBuilder,
          (
            OperacionesPendiente,
            BaseReferences<
              _$AppDatabase,
              $OperacionesPendientesTable,
              OperacionesPendiente
            >,
          ),
          OperacionesPendiente,
          PrefetchHooks Function()
        > {
  $$OperacionesPendientesTableTableManager(
    _$AppDatabase db,
    $OperacionesPendientesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OperacionesPendientesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$OperacionesPendientesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$OperacionesPendientesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> idOperacion = const Value.absent(),
                Value<String> tipoOperacion = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> intentosReenvio = const Value.absent(),
                Value<DateTime> fechaEncolado = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OperacionesPendientesCompanion(
                idOperacion: idOperacion,
                tipoOperacion: tipoOperacion,
                payloadJson: payloadJson,
                intentosReenvio: intentosReenvio,
                fechaEncolado: fechaEncolado,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String idOperacion,
                required String tipoOperacion,
                required String payloadJson,
                Value<int> intentosReenvio = const Value.absent(),
                Value<DateTime> fechaEncolado = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OperacionesPendientesCompanion.insert(
                idOperacion: idOperacion,
                tipoOperacion: tipoOperacion,
                payloadJson: payloadJson,
                intentosReenvio: intentosReenvio,
                fechaEncolado: fechaEncolado,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OperacionesPendientesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OperacionesPendientesTable,
      OperacionesPendiente,
      $$OperacionesPendientesTableFilterComposer,
      $$OperacionesPendientesTableOrderingComposer,
      $$OperacionesPendientesTableAnnotationComposer,
      $$OperacionesPendientesTableCreateCompanionBuilder,
      $$OperacionesPendientesTableUpdateCompanionBuilder,
      (
        OperacionesPendiente,
        BaseReferences<
          _$AppDatabase,
          $OperacionesPendientesTable,
          OperacionesPendiente
        >,
      ),
      OperacionesPendiente,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RegistrosCampoTableTableManager get registrosCampo =>
      $$RegistrosCampoTableTableManager(_db, _db.registrosCampo);
  $$OperacionesPendientesTableTableManager get operacionesPendientes =>
      $$OperacionesPendientesTableTableManager(_db, _db.operacionesPendientes);
}
