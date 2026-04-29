// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Muscle extends Table with TableInfo<Muscle, MuscleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Muscle(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Muscle';
  @override
  VerificationContext validateIntegrity(
    Insertable<MuscleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MuscleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MuscleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
    );
  }

  @override
  Muscle createAlias(String alias) {
    return Muscle(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class MuscleData extends DataClass implements Insertable<MuscleData> {
  final String id;
  const MuscleData({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    return map;
  }

  MuscleCompanion toCompanion(bool nullToAbsent) {
    return MuscleCompanion(id: Value(id));
  }

  factory MuscleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MuscleData(id: serializer.fromJson<String>(json['id']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'id': serializer.toJson<String>(id)};
  }

  MuscleData copyWith({String? id}) => MuscleData(id: id ?? this.id);
  MuscleData copyWithCompanion(MuscleCompanion data) {
    return MuscleData(id: data.id.present ? data.id.value : this.id);
  }

  @override
  String toString() {
    return (StringBuffer('MuscleData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is MuscleData && other.id == this.id);
}

class MuscleCompanion extends UpdateCompanion<MuscleData> {
  final Value<String> id;
  final Value<int> rowid;
  const MuscleCompanion({
    this.id = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MuscleCompanion.insert({
    required String id,
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<MuscleData> custom({
    Expression<String>? id,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MuscleCompanion copyWith({Value<String>? id, Value<int>? rowid}) {
    return MuscleCompanion(id: id ?? this.id, rowid: rowid ?? this.rowid);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MuscleCompanion(')
          ..write('id: $id, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Equipment extends Table with TableInfo<Equipment, EquipmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Equipment(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT CURRENT_TIMESTAMP',
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT CURRENT_TIMESTAMP',
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Equipment';
  @override
  VerificationContext validateIntegrity(
    Insertable<EquipmentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquipmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  Equipment createAlias(String alias) {
    return Equipment(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class EquipmentData extends DataClass implements Insertable<EquipmentData> {
  final String id;
  final String? createdAt;
  final String? updatedAt;
  const EquipmentData({required this.id, this.createdAt, this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  EquipmentCompanion toCompanion(bool nullToAbsent) {
    return EquipmentCompanion(
      id: Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory EquipmentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<String?>(json['created_at']),
      updatedAt: serializer.fromJson<String?>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'created_at': serializer.toJson<String?>(createdAt),
      'updated_at': serializer.toJson<String?>(updatedAt),
    };
  }

  EquipmentData copyWith({
    String? id,
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
  }) => EquipmentData(
    id: id ?? this.id,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  EquipmentData copyWithCompanion(EquipmentCompanion data) {
    return EquipmentData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EquipmentCompanion extends UpdateCompanion<EquipmentData> {
  final Value<String> id;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<int> rowid;
  const EquipmentCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EquipmentCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<EquipmentData> custom({
    Expression<String>? id,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EquipmentCompanion copyWith({
    Value<String>? id,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
    Value<int>? rowid,
  }) {
    return EquipmentCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Exercises extends Table with TableInfo<Exercises, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Exercises(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _muscleMeta = const VerificationMeta('muscle');
  late final GeneratedColumn<String> muscle = GeneratedColumn<String>(
    'muscle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES Muscle(id)',
  );
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES Equipment(id)',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT CURRENT_TIMESTAMP',
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT CURRENT_TIMESTAMP',
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    muscle,
    equipment,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('muscle')) {
      context.handle(
        _muscleMeta,
        muscle.isAcceptableOrUnknown(data['muscle']!, _muscleMeta),
      );
    } else if (isInserting) {
      context.missing(_muscleMeta);
    }
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      muscle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle'],
      )!,
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  Exercises createAlias(String alias) {
    return Exercises(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final String id;
  final String muscle;
  final String? equipment;
  final String? createdAt;
  final String? updatedAt;
  const Exercise({
    required this.id,
    required this.muscle,
    this.equipment,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['muscle'] = Variable<String>(muscle);
    if (!nullToAbsent || equipment != null) {
      map['equipment'] = Variable<String>(equipment);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      muscle: Value(muscle),
      equipment: equipment == null && nullToAbsent
          ? const Value.absent()
          : Value(equipment),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Exercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<String>(json['id']),
      muscle: serializer.fromJson<String>(json['muscle']),
      equipment: serializer.fromJson<String?>(json['equipment']),
      createdAt: serializer.fromJson<String?>(json['created_at']),
      updatedAt: serializer.fromJson<String?>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'muscle': serializer.toJson<String>(muscle),
      'equipment': serializer.toJson<String?>(equipment),
      'created_at': serializer.toJson<String?>(createdAt),
      'updated_at': serializer.toJson<String?>(updatedAt),
    };
  }

  Exercise copyWith({
    String? id,
    String? muscle,
    Value<String?> equipment = const Value.absent(),
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
  }) => Exercise(
    id: id ?? this.id,
    muscle: muscle ?? this.muscle,
    equipment: equipment.present ? equipment.value : this.equipment,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      muscle: data.muscle.present ? data.muscle.value : this.muscle,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('muscle: $muscle, ')
          ..write('equipment: $equipment, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, muscle, equipment, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.muscle == this.muscle &&
          other.equipment == this.equipment &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<String> id;
  final Value<String> muscle;
  final Value<String?> equipment;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.muscle = const Value.absent(),
    this.equipment = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String muscle,
    this.equipment = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       muscle = Value(muscle);
  static Insertable<Exercise> custom({
    Expression<String>? id,
    Expression<String>? muscle,
    Expression<String>? equipment,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (muscle != null) 'muscle': muscle,
      if (equipment != null) 'equipment': equipment,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? muscle,
    Value<String?>? equipment,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
    Value<int>? rowid,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      muscle: muscle ?? this.muscle,
      equipment: equipment ?? this.equipment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (muscle.present) {
      map['muscle'] = Variable<String>(muscle.value);
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('muscle: $muscle, ')
          ..write('equipment: $equipment, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Workouts extends Table with TableInfo<Workouts, Workout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Workouts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  late final GeneratedColumn<int> startTime = GeneratedColumn<int>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  late final GeneratedColumn<int> endTime = GeneratedColumn<int>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT CURRENT_TIMESTAMP',
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT CURRENT_TIMESTAMP',
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    startTime,
    endTime,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Workouts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Workout> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_time'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  Workouts createAlias(String alias) {
    return Workouts(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['CHECK(start_time <= end_time)'];
  @override
  bool get dontWriteConstraints => true;
}

class Workout extends DataClass implements Insertable<Workout> {
  final int id;
  final String title;
  final int startTime;
  final int endTime;
  final String? createdAt;
  final String? updatedAt;
  const Workout({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['start_time'] = Variable<int>(startTime);
    map['end_time'] = Variable<int>(endTime);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: Value(id),
      title: Value(title),
      startTime: Value(startTime),
      endTime: Value(endTime),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Workout.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workout(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      startTime: serializer.fromJson<int>(json['start_time']),
      endTime: serializer.fromJson<int>(json['end_time']),
      createdAt: serializer.fromJson<String?>(json['created_at']),
      updatedAt: serializer.fromJson<String?>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'start_time': serializer.toJson<int>(startTime),
      'end_time': serializer.toJson<int>(endTime),
      'created_at': serializer.toJson<String?>(createdAt),
      'updated_at': serializer.toJson<String?>(updatedAt),
    };
  }

  Workout copyWith({
    int? id,
    String? title,
    int? startTime,
    int? endTime,
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
  }) => Workout(
    id: id ?? this.id,
    title: title ?? this.title,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Workout copyWithCompanion(WorkoutsCompanion data) {
    return Workout(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workout(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, startTime, endTime, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workout &&
          other.id == this.id &&
          other.title == this.title &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> startTime;
  final Value<int> endTime;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int startTime,
    required int endTime,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title),
       startTime = Value(startTime),
       endTime = Value(endTime);
  static Insertable<Workout> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? startTime,
    Expression<int>? endTime,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WorkoutsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? startTime,
    Value<int>? endTime,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
  }) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<int>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<int>(endTime.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class Lift extends Table with TableInfo<Lift, LiftData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Lift(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exerciseMeta = const VerificationMeta(
    'exercise',
  );
  late final GeneratedColumn<String> exercise = GeneratedColumn<String>(
    'exercise',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES Exercises(id)',
  );
  static const VerificationMeta _setOfSetsMeta = const VerificationMeta(
    'setOfSets',
  );
  late final GeneratedColumn<int> setOfSets = GeneratedColumn<int>(
    'set_of_sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _setIndexMeta = const VerificationMeta(
    'setIndex',
  );
  late final GeneratedColumn<int> setIndex = GeneratedColumn<int>(
    'set_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _workoutMeta = const VerificationMeta(
    'workout',
  );
  late final GeneratedColumn<int> workout = GeneratedColumn<int>(
    'workout',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES Workouts(id)',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT CURRENT_TIMESTAMP',
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT CURRENT_TIMESTAMP',
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    exercise,
    setOfSets,
    setIndex,
    reps,
    weightKg,
    workout,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Lift';
  @override
  VerificationContext validateIntegrity(
    Insertable<LiftData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise')) {
      context.handle(
        _exerciseMeta,
        exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    if (data.containsKey('set_of_sets')) {
      context.handle(
        _setOfSetsMeta,
        setOfSets.isAcceptableOrUnknown(data['set_of_sets']!, _setOfSetsMeta),
      );
    } else if (isInserting) {
      context.missing(_setOfSetsMeta);
    }
    if (data.containsKey('set_index')) {
      context.handle(
        _setIndexMeta,
        setIndex.isAcceptableOrUnknown(data['set_index']!, _setIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_setIndexMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('workout')) {
      context.handle(
        _workoutMeta,
        workout.isAcceptableOrUnknown(data['workout']!, _workoutMeta),
      );
    } else if (isInserting) {
      context.missing(_workoutMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    workout,
    exercise,
    setOfSets,
    setIndex,
  };
  @override
  LiftData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LiftData(
      exercise: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise'],
      )!,
      setOfSets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_of_sets'],
      )!,
      setIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_index'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      workout: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workout'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  Lift createAlias(String alias) {
    return Lift(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workout, exercise, set_of_sets, set_index)',
    'CHECK(reps > 0)',
    'CHECK(set_index >= 0)',
    'CHECK(set_of_sets > 0)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class LiftData extends DataClass implements Insertable<LiftData> {
  final String exercise;
  final int setOfSets;

  /// you can do benchpress at start and end of workout for example
  final int setIndex;
  final int reps;
  final double? weightKg;
  final int workout;
  final String? createdAt;
  final String? updatedAt;
  const LiftData({
    required this.exercise,
    required this.setOfSets,
    required this.setIndex,
    required this.reps,
    this.weightKg,
    required this.workout,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exercise'] = Variable<String>(exercise);
    map['set_of_sets'] = Variable<int>(setOfSets);
    map['set_index'] = Variable<int>(setIndex);
    map['reps'] = Variable<int>(reps);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    map['workout'] = Variable<int>(workout);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  LiftCompanion toCompanion(bool nullToAbsent) {
    return LiftCompanion(
      exercise: Value(exercise),
      setOfSets: Value(setOfSets),
      setIndex: Value(setIndex),
      reps: Value(reps),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      workout: Value(workout),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory LiftData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LiftData(
      exercise: serializer.fromJson<String>(json['exercise']),
      setOfSets: serializer.fromJson<int>(json['set_of_sets']),
      setIndex: serializer.fromJson<int>(json['set_index']),
      reps: serializer.fromJson<int>(json['reps']),
      weightKg: serializer.fromJson<double?>(json['weight_kg']),
      workout: serializer.fromJson<int>(json['workout']),
      createdAt: serializer.fromJson<String?>(json['created_at']),
      updatedAt: serializer.fromJson<String?>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exercise': serializer.toJson<String>(exercise),
      'set_of_sets': serializer.toJson<int>(setOfSets),
      'set_index': serializer.toJson<int>(setIndex),
      'reps': serializer.toJson<int>(reps),
      'weight_kg': serializer.toJson<double?>(weightKg),
      'workout': serializer.toJson<int>(workout),
      'created_at': serializer.toJson<String?>(createdAt),
      'updated_at': serializer.toJson<String?>(updatedAt),
    };
  }

  LiftData copyWith({
    String? exercise,
    int? setOfSets,
    int? setIndex,
    int? reps,
    Value<double?> weightKg = const Value.absent(),
    int? workout,
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
  }) => LiftData(
    exercise: exercise ?? this.exercise,
    setOfSets: setOfSets ?? this.setOfSets,
    setIndex: setIndex ?? this.setIndex,
    reps: reps ?? this.reps,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    workout: workout ?? this.workout,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  LiftData copyWithCompanion(LiftCompanion data) {
    return LiftData(
      exercise: data.exercise.present ? data.exercise.value : this.exercise,
      setOfSets: data.setOfSets.present ? data.setOfSets.value : this.setOfSets,
      setIndex: data.setIndex.present ? data.setIndex.value : this.setIndex,
      reps: data.reps.present ? data.reps.value : this.reps,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      workout: data.workout.present ? data.workout.value : this.workout,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LiftData(')
          ..write('exercise: $exercise, ')
          ..write('setOfSets: $setOfSets, ')
          ..write('setIndex: $setIndex, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('workout: $workout, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    exercise,
    setOfSets,
    setIndex,
    reps,
    weightKg,
    workout,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LiftData &&
          other.exercise == this.exercise &&
          other.setOfSets == this.setOfSets &&
          other.setIndex == this.setIndex &&
          other.reps == this.reps &&
          other.weightKg == this.weightKg &&
          other.workout == this.workout &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LiftCompanion extends UpdateCompanion<LiftData> {
  final Value<String> exercise;
  final Value<int> setOfSets;
  final Value<int> setIndex;
  final Value<int> reps;
  final Value<double?> weightKg;
  final Value<int> workout;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<int> rowid;
  const LiftCompanion({
    this.exercise = const Value.absent(),
    this.setOfSets = const Value.absent(),
    this.setIndex = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.workout = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LiftCompanion.insert({
    required String exercise,
    required int setOfSets,
    required int setIndex,
    required int reps,
    this.weightKg = const Value.absent(),
    required int workout,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : exercise = Value(exercise),
       setOfSets = Value(setOfSets),
       setIndex = Value(setIndex),
       reps = Value(reps),
       workout = Value(workout);
  static Insertable<LiftData> custom({
    Expression<String>? exercise,
    Expression<int>? setOfSets,
    Expression<int>? setIndex,
    Expression<int>? reps,
    Expression<double>? weightKg,
    Expression<int>? workout,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (exercise != null) 'exercise': exercise,
      if (setOfSets != null) 'set_of_sets': setOfSets,
      if (setIndex != null) 'set_index': setIndex,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (workout != null) 'workout': workout,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LiftCompanion copyWith({
    Value<String>? exercise,
    Value<int>? setOfSets,
    Value<int>? setIndex,
    Value<int>? reps,
    Value<double?>? weightKg,
    Value<int>? workout,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
    Value<int>? rowid,
  }) {
    return LiftCompanion(
      exercise: exercise ?? this.exercise,
      setOfSets: setOfSets ?? this.setOfSets,
      setIndex: setIndex ?? this.setIndex,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      workout: workout ?? this.workout,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exercise.present) {
      map['exercise'] = Variable<String>(exercise.value);
    }
    if (setOfSets.present) {
      map['set_of_sets'] = Variable<int>(setOfSets.value);
    }
    if (setIndex.present) {
      map['set_index'] = Variable<int>(setIndex.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (workout.present) {
      map['workout'] = Variable<int>(workout.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LiftCompanion(')
          ..write('exercise: $exercise, ')
          ..write('setOfSets: $setOfSets, ')
          ..write('setIndex: $setIndex, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('workout: $workout, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Cardio extends Table with TableInfo<Cardio, CardioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Cardio(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exerciseMeta = const VerificationMeta(
    'exercise',
  );
  late final GeneratedColumn<String> exercise = GeneratedColumn<String>(
    'exercise',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES Exercises(id)',
  );
  static const VerificationMeta _lapMeta = const VerificationMeta('lap');
  late final GeneratedColumn<int> lap = GeneratedColumn<int>(
    'lap',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _distanceMMeta = const VerificationMeta(
    'distanceM',
  );
  late final GeneratedColumn<double> distanceM = GeneratedColumn<double>(
    'distance_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _durationSMeta = const VerificationMeta(
    'durationS',
  );
  late final GeneratedColumn<double> durationS = GeneratedColumn<double>(
    'duration_s',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _workoutMeta = const VerificationMeta(
    'workout',
  );
  late final GeneratedColumn<int> workout = GeneratedColumn<int>(
    'workout',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES Workouts(id)',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT CURRENT_TIMESTAMP',
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'DEFAULT CURRENT_TIMESTAMP',
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    exercise,
    lap,
    distanceM,
    durationS,
    workout,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'Cardio';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardioData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise')) {
      context.handle(
        _exerciseMeta,
        exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    if (data.containsKey('lap')) {
      context.handle(
        _lapMeta,
        lap.isAcceptableOrUnknown(data['lap']!, _lapMeta),
      );
    } else if (isInserting) {
      context.missing(_lapMeta);
    }
    if (data.containsKey('distance_m')) {
      context.handle(
        _distanceMMeta,
        distanceM.isAcceptableOrUnknown(data['distance_m']!, _distanceMMeta),
      );
    }
    if (data.containsKey('duration_s')) {
      context.handle(
        _durationSMeta,
        durationS.isAcceptableOrUnknown(data['duration_s']!, _durationSMeta),
      );
    }
    if (data.containsKey('workout')) {
      context.handle(
        _workoutMeta,
        workout.isAcceptableOrUnknown(data['workout']!, _workoutMeta),
      );
    } else if (isInserting) {
      context.missing(_workoutMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workout, exercise, lap};
  @override
  CardioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardioData(
      exercise: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise'],
      )!,
      lap: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lap'],
      )!,
      distanceM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_m'],
      ),
      durationS: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}duration_s'],
      ),
      workout: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workout'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  Cardio createAlias(String alias) {
    return Cardio(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(workout, exercise, lap)',
    'CHECK(lap >= 0)',
    'CHECK((distance_m IS NULL AND duration_s IS NOT NULL)OR distance_m > 0)',
    'CHECK((duration_s IS NULL AND distance_m IS NOT NULL)OR duration_s > 0)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class CardioData extends DataClass implements Insertable<CardioData> {
  final String exercise;
  final int lap;

  ///TODO lap_of_laps
  final double? distanceM;
  final double? durationS;
  final int workout;
  final String? createdAt;
  final String? updatedAt;
  const CardioData({
    required this.exercise,
    required this.lap,
    this.distanceM,
    this.durationS,
    required this.workout,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exercise'] = Variable<String>(exercise);
    map['lap'] = Variable<int>(lap);
    if (!nullToAbsent || distanceM != null) {
      map['distance_m'] = Variable<double>(distanceM);
    }
    if (!nullToAbsent || durationS != null) {
      map['duration_s'] = Variable<double>(durationS);
    }
    map['workout'] = Variable<int>(workout);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  CardioCompanion toCompanion(bool nullToAbsent) {
    return CardioCompanion(
      exercise: Value(exercise),
      lap: Value(lap),
      distanceM: distanceM == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceM),
      durationS: durationS == null && nullToAbsent
          ? const Value.absent()
          : Value(durationS),
      workout: Value(workout),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory CardioData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardioData(
      exercise: serializer.fromJson<String>(json['exercise']),
      lap: serializer.fromJson<int>(json['lap']),
      distanceM: serializer.fromJson<double?>(json['distance_m']),
      durationS: serializer.fromJson<double?>(json['duration_s']),
      workout: serializer.fromJson<int>(json['workout']),
      createdAt: serializer.fromJson<String?>(json['created_at']),
      updatedAt: serializer.fromJson<String?>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exercise': serializer.toJson<String>(exercise),
      'lap': serializer.toJson<int>(lap),
      'distance_m': serializer.toJson<double?>(distanceM),
      'duration_s': serializer.toJson<double?>(durationS),
      'workout': serializer.toJson<int>(workout),
      'created_at': serializer.toJson<String?>(createdAt),
      'updated_at': serializer.toJson<String?>(updatedAt),
    };
  }

  CardioData copyWith({
    String? exercise,
    int? lap,
    Value<double?> distanceM = const Value.absent(),
    Value<double?> durationS = const Value.absent(),
    int? workout,
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
  }) => CardioData(
    exercise: exercise ?? this.exercise,
    lap: lap ?? this.lap,
    distanceM: distanceM.present ? distanceM.value : this.distanceM,
    durationS: durationS.present ? durationS.value : this.durationS,
    workout: workout ?? this.workout,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  CardioData copyWithCompanion(CardioCompanion data) {
    return CardioData(
      exercise: data.exercise.present ? data.exercise.value : this.exercise,
      lap: data.lap.present ? data.lap.value : this.lap,
      distanceM: data.distanceM.present ? data.distanceM.value : this.distanceM,
      durationS: data.durationS.present ? data.durationS.value : this.durationS,
      workout: data.workout.present ? data.workout.value : this.workout,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardioData(')
          ..write('exercise: $exercise, ')
          ..write('lap: $lap, ')
          ..write('distanceM: $distanceM, ')
          ..write('durationS: $durationS, ')
          ..write('workout: $workout, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    exercise,
    lap,
    distanceM,
    durationS,
    workout,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardioData &&
          other.exercise == this.exercise &&
          other.lap == this.lap &&
          other.distanceM == this.distanceM &&
          other.durationS == this.durationS &&
          other.workout == this.workout &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CardioCompanion extends UpdateCompanion<CardioData> {
  final Value<String> exercise;
  final Value<int> lap;
  final Value<double?> distanceM;
  final Value<double?> durationS;
  final Value<int> workout;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<int> rowid;
  const CardioCompanion({
    this.exercise = const Value.absent(),
    this.lap = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.durationS = const Value.absent(),
    this.workout = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardioCompanion.insert({
    required String exercise,
    required int lap,
    this.distanceM = const Value.absent(),
    this.durationS = const Value.absent(),
    required int workout,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : exercise = Value(exercise),
       lap = Value(lap),
       workout = Value(workout);
  static Insertable<CardioData> custom({
    Expression<String>? exercise,
    Expression<int>? lap,
    Expression<double>? distanceM,
    Expression<double>? durationS,
    Expression<int>? workout,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (exercise != null) 'exercise': exercise,
      if (lap != null) 'lap': lap,
      if (distanceM != null) 'distance_m': distanceM,
      if (durationS != null) 'duration_s': durationS,
      if (workout != null) 'workout': workout,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardioCompanion copyWith({
    Value<String>? exercise,
    Value<int>? lap,
    Value<double?>? distanceM,
    Value<double?>? durationS,
    Value<int>? workout,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
    Value<int>? rowid,
  }) {
    return CardioCompanion(
      exercise: exercise ?? this.exercise,
      lap: lap ?? this.lap,
      distanceM: distanceM ?? this.distanceM,
      durationS: durationS ?? this.durationS,
      workout: workout ?? this.workout,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exercise.present) {
      map['exercise'] = Variable<String>(exercise.value);
    }
    if (lap.present) {
      map['lap'] = Variable<int>(lap.value);
    }
    if (distanceM.present) {
      map['distance_m'] = Variable<double>(distanceM.value);
    }
    if (durationS.present) {
      map['duration_s'] = Variable<double>(durationS.value);
    }
    if (workout.present) {
      map['workout'] = Variable<int>(workout.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardioCompanion(')
          ..write('exercise: $exercise, ')
          ..write('lap: $lap, ')
          ..write('distanceM: $distanceM, ')
          ..write('durationS: $durationS, ')
          ..write('workout: $workout, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class StandardsWeight extends Table
    with TableInfo<StandardsWeight, StandardsWeightData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  StandardsWeight(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exerciseMeta = const VerificationMeta(
    'exercise',
  );
  late final GeneratedColumn<String> exercise = GeneratedColumn<String>(
    'exercise',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES Exercises(id)',
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _bodyweightMeta = const VerificationMeta(
    'bodyweight',
  );
  late final GeneratedColumn<double> bodyweight = GeneratedColumn<double>(
    'bodyweight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _beginnerMeta = const VerificationMeta(
    'beginner',
  );
  late final GeneratedColumn<double> beginner = GeneratedColumn<double>(
    'beginner',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _noviceMeta = const VerificationMeta('novice');
  late final GeneratedColumn<double> novice = GeneratedColumn<double>(
    'novice',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _intermediateMeta = const VerificationMeta(
    'intermediate',
  );
  late final GeneratedColumn<double> intermediate = GeneratedColumn<double>(
    'intermediate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _advancedMeta = const VerificationMeta(
    'advanced',
  );
  late final GeneratedColumn<double> advanced = GeneratedColumn<double>(
    'advanced',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _eliteMeta = const VerificationMeta('elite');
  late final GeneratedColumn<double> elite = GeneratedColumn<double>(
    'elite',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    exercise,
    sex,
    bodyweight,
    beginner,
    novice,
    intermediate,
    advanced,
    elite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'StandardsWeight';
  @override
  VerificationContext validateIntegrity(
    Insertable<StandardsWeightData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise')) {
      context.handle(
        _exerciseMeta,
        exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('bodyweight')) {
      context.handle(
        _bodyweightMeta,
        bodyweight.isAcceptableOrUnknown(data['bodyweight']!, _bodyweightMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyweightMeta);
    }
    if (data.containsKey('beginner')) {
      context.handle(
        _beginnerMeta,
        beginner.isAcceptableOrUnknown(data['beginner']!, _beginnerMeta),
      );
    } else if (isInserting) {
      context.missing(_beginnerMeta);
    }
    if (data.containsKey('novice')) {
      context.handle(
        _noviceMeta,
        novice.isAcceptableOrUnknown(data['novice']!, _noviceMeta),
      );
    } else if (isInserting) {
      context.missing(_noviceMeta);
    }
    if (data.containsKey('intermediate')) {
      context.handle(
        _intermediateMeta,
        intermediate.isAcceptableOrUnknown(
          data['intermediate']!,
          _intermediateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intermediateMeta);
    }
    if (data.containsKey('advanced')) {
      context.handle(
        _advancedMeta,
        advanced.isAcceptableOrUnknown(data['advanced']!, _advancedMeta),
      );
    } else if (isInserting) {
      context.missing(_advancedMeta);
    }
    if (data.containsKey('elite')) {
      context.handle(
        _eliteMeta,
        elite.isAcceptableOrUnknown(data['elite']!, _eliteMeta),
      );
    } else if (isInserting) {
      context.missing(_eliteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {exercise, sex, bodyweight};
  @override
  StandardsWeightData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StandardsWeightData(
      exercise: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      bodyweight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bodyweight'],
      )!,
      beginner: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}beginner'],
      )!,
      novice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}novice'],
      )!,
      intermediate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}intermediate'],
      )!,
      advanced: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}advanced'],
      )!,
      elite: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}elite'],
      )!,
    );
  }

  @override
  StandardsWeight createAlias(String alias) {
    return StandardsWeight(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(exercise, sex, bodyweight)',
    'CHECK(sex IN (\'male\', \'female\'))',
    'CHECK(beginner >= 0)',
    'CHECK(novice >= beginner)',
    'CHECK(intermediate >= novice)',
    'CHECK(advanced >= intermediate)',
    'CHECK(elite >= advanced)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class StandardsWeightData extends DataClass
    implements Insertable<StandardsWeightData> {
  final String exercise;
  final String sex;
  final double bodyweight;
  final double beginner;
  final double novice;
  final double intermediate;
  final double advanced;
  final double elite;
  const StandardsWeightData({
    required this.exercise,
    required this.sex,
    required this.bodyweight,
    required this.beginner,
    required this.novice,
    required this.intermediate,
    required this.advanced,
    required this.elite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exercise'] = Variable<String>(exercise);
    map['sex'] = Variable<String>(sex);
    map['bodyweight'] = Variable<double>(bodyweight);
    map['beginner'] = Variable<double>(beginner);
    map['novice'] = Variable<double>(novice);
    map['intermediate'] = Variable<double>(intermediate);
    map['advanced'] = Variable<double>(advanced);
    map['elite'] = Variable<double>(elite);
    return map;
  }

  StandardsWeightCompanion toCompanion(bool nullToAbsent) {
    return StandardsWeightCompanion(
      exercise: Value(exercise),
      sex: Value(sex),
      bodyweight: Value(bodyweight),
      beginner: Value(beginner),
      novice: Value(novice),
      intermediate: Value(intermediate),
      advanced: Value(advanced),
      elite: Value(elite),
    );
  }

  factory StandardsWeightData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StandardsWeightData(
      exercise: serializer.fromJson<String>(json['exercise']),
      sex: serializer.fromJson<String>(json['sex']),
      bodyweight: serializer.fromJson<double>(json['bodyweight']),
      beginner: serializer.fromJson<double>(json['beginner']),
      novice: serializer.fromJson<double>(json['novice']),
      intermediate: serializer.fromJson<double>(json['intermediate']),
      advanced: serializer.fromJson<double>(json['advanced']),
      elite: serializer.fromJson<double>(json['elite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exercise': serializer.toJson<String>(exercise),
      'sex': serializer.toJson<String>(sex),
      'bodyweight': serializer.toJson<double>(bodyweight),
      'beginner': serializer.toJson<double>(beginner),
      'novice': serializer.toJson<double>(novice),
      'intermediate': serializer.toJson<double>(intermediate),
      'advanced': serializer.toJson<double>(advanced),
      'elite': serializer.toJson<double>(elite),
    };
  }

  StandardsWeightData copyWith({
    String? exercise,
    String? sex,
    double? bodyweight,
    double? beginner,
    double? novice,
    double? intermediate,
    double? advanced,
    double? elite,
  }) => StandardsWeightData(
    exercise: exercise ?? this.exercise,
    sex: sex ?? this.sex,
    bodyweight: bodyweight ?? this.bodyweight,
    beginner: beginner ?? this.beginner,
    novice: novice ?? this.novice,
    intermediate: intermediate ?? this.intermediate,
    advanced: advanced ?? this.advanced,
    elite: elite ?? this.elite,
  );
  StandardsWeightData copyWithCompanion(StandardsWeightCompanion data) {
    return StandardsWeightData(
      exercise: data.exercise.present ? data.exercise.value : this.exercise,
      sex: data.sex.present ? data.sex.value : this.sex,
      bodyweight: data.bodyweight.present
          ? data.bodyweight.value
          : this.bodyweight,
      beginner: data.beginner.present ? data.beginner.value : this.beginner,
      novice: data.novice.present ? data.novice.value : this.novice,
      intermediate: data.intermediate.present
          ? data.intermediate.value
          : this.intermediate,
      advanced: data.advanced.present ? data.advanced.value : this.advanced,
      elite: data.elite.present ? data.elite.value : this.elite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StandardsWeightData(')
          ..write('exercise: $exercise, ')
          ..write('sex: $sex, ')
          ..write('bodyweight: $bodyweight, ')
          ..write('beginner: $beginner, ')
          ..write('novice: $novice, ')
          ..write('intermediate: $intermediate, ')
          ..write('advanced: $advanced, ')
          ..write('elite: $elite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    exercise,
    sex,
    bodyweight,
    beginner,
    novice,
    intermediate,
    advanced,
    elite,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StandardsWeightData &&
          other.exercise == this.exercise &&
          other.sex == this.sex &&
          other.bodyweight == this.bodyweight &&
          other.beginner == this.beginner &&
          other.novice == this.novice &&
          other.intermediate == this.intermediate &&
          other.advanced == this.advanced &&
          other.elite == this.elite);
}

class StandardsWeightCompanion extends UpdateCompanion<StandardsWeightData> {
  final Value<String> exercise;
  final Value<String> sex;
  final Value<double> bodyweight;
  final Value<double> beginner;
  final Value<double> novice;
  final Value<double> intermediate;
  final Value<double> advanced;
  final Value<double> elite;
  final Value<int> rowid;
  const StandardsWeightCompanion({
    this.exercise = const Value.absent(),
    this.sex = const Value.absent(),
    this.bodyweight = const Value.absent(),
    this.beginner = const Value.absent(),
    this.novice = const Value.absent(),
    this.intermediate = const Value.absent(),
    this.advanced = const Value.absent(),
    this.elite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StandardsWeightCompanion.insert({
    required String exercise,
    required String sex,
    required double bodyweight,
    required double beginner,
    required double novice,
    required double intermediate,
    required double advanced,
    required double elite,
    this.rowid = const Value.absent(),
  }) : exercise = Value(exercise),
       sex = Value(sex),
       bodyweight = Value(bodyweight),
       beginner = Value(beginner),
       novice = Value(novice),
       intermediate = Value(intermediate),
       advanced = Value(advanced),
       elite = Value(elite);
  static Insertable<StandardsWeightData> custom({
    Expression<String>? exercise,
    Expression<String>? sex,
    Expression<double>? bodyweight,
    Expression<double>? beginner,
    Expression<double>? novice,
    Expression<double>? intermediate,
    Expression<double>? advanced,
    Expression<double>? elite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (exercise != null) 'exercise': exercise,
      if (sex != null) 'sex': sex,
      if (bodyweight != null) 'bodyweight': bodyweight,
      if (beginner != null) 'beginner': beginner,
      if (novice != null) 'novice': novice,
      if (intermediate != null) 'intermediate': intermediate,
      if (advanced != null) 'advanced': advanced,
      if (elite != null) 'elite': elite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StandardsWeightCompanion copyWith({
    Value<String>? exercise,
    Value<String>? sex,
    Value<double>? bodyweight,
    Value<double>? beginner,
    Value<double>? novice,
    Value<double>? intermediate,
    Value<double>? advanced,
    Value<double>? elite,
    Value<int>? rowid,
  }) {
    return StandardsWeightCompanion(
      exercise: exercise ?? this.exercise,
      sex: sex ?? this.sex,
      bodyweight: bodyweight ?? this.bodyweight,
      beginner: beginner ?? this.beginner,
      novice: novice ?? this.novice,
      intermediate: intermediate ?? this.intermediate,
      advanced: advanced ?? this.advanced,
      elite: elite ?? this.elite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exercise.present) {
      map['exercise'] = Variable<String>(exercise.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (bodyweight.present) {
      map['bodyweight'] = Variable<double>(bodyweight.value);
    }
    if (beginner.present) {
      map['beginner'] = Variable<double>(beginner.value);
    }
    if (novice.present) {
      map['novice'] = Variable<double>(novice.value);
    }
    if (intermediate.present) {
      map['intermediate'] = Variable<double>(intermediate.value);
    }
    if (advanced.present) {
      map['advanced'] = Variable<double>(advanced.value);
    }
    if (elite.present) {
      map['elite'] = Variable<double>(elite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StandardsWeightCompanion(')
          ..write('exercise: $exercise, ')
          ..write('sex: $sex, ')
          ..write('bodyweight: $bodyweight, ')
          ..write('beginner: $beginner, ')
          ..write('novice: $novice, ')
          ..write('intermediate: $intermediate, ')
          ..write('advanced: $advanced, ')
          ..write('elite: $elite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class StandardsReps extends Table with TableInfo<StandardsReps, StandardsRep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  StandardsReps(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exerciseMeta = const VerificationMeta(
    'exercise',
  );
  late final GeneratedColumn<String> exercise = GeneratedColumn<String>(
    'exercise',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES Exercises(id)',
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _bodyweightMeta = const VerificationMeta(
    'bodyweight',
  );
  late final GeneratedColumn<double> bodyweight = GeneratedColumn<double>(
    'bodyweight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _beginnerMeta = const VerificationMeta(
    'beginner',
  );
  late final GeneratedColumn<int> beginner = GeneratedColumn<int>(
    'beginner',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _noviceMeta = const VerificationMeta('novice');
  late final GeneratedColumn<int> novice = GeneratedColumn<int>(
    'novice',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _intermediateMeta = const VerificationMeta(
    'intermediate',
  );
  late final GeneratedColumn<int> intermediate = GeneratedColumn<int>(
    'intermediate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _advancedMeta = const VerificationMeta(
    'advanced',
  );
  late final GeneratedColumn<int> advanced = GeneratedColumn<int>(
    'advanced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _eliteMeta = const VerificationMeta('elite');
  late final GeneratedColumn<int> elite = GeneratedColumn<int>(
    'elite',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    exercise,
    sex,
    bodyweight,
    beginner,
    novice,
    intermediate,
    advanced,
    elite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'StandardsReps';
  @override
  VerificationContext validateIntegrity(
    Insertable<StandardsRep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise')) {
      context.handle(
        _exerciseMeta,
        exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('bodyweight')) {
      context.handle(
        _bodyweightMeta,
        bodyweight.isAcceptableOrUnknown(data['bodyweight']!, _bodyweightMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyweightMeta);
    }
    if (data.containsKey('beginner')) {
      context.handle(
        _beginnerMeta,
        beginner.isAcceptableOrUnknown(data['beginner']!, _beginnerMeta),
      );
    } else if (isInserting) {
      context.missing(_beginnerMeta);
    }
    if (data.containsKey('novice')) {
      context.handle(
        _noviceMeta,
        novice.isAcceptableOrUnknown(data['novice']!, _noviceMeta),
      );
    } else if (isInserting) {
      context.missing(_noviceMeta);
    }
    if (data.containsKey('intermediate')) {
      context.handle(
        _intermediateMeta,
        intermediate.isAcceptableOrUnknown(
          data['intermediate']!,
          _intermediateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intermediateMeta);
    }
    if (data.containsKey('advanced')) {
      context.handle(
        _advancedMeta,
        advanced.isAcceptableOrUnknown(data['advanced']!, _advancedMeta),
      );
    } else if (isInserting) {
      context.missing(_advancedMeta);
    }
    if (data.containsKey('elite')) {
      context.handle(
        _eliteMeta,
        elite.isAcceptableOrUnknown(data['elite']!, _eliteMeta),
      );
    } else if (isInserting) {
      context.missing(_eliteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {exercise, sex, bodyweight};
  @override
  StandardsRep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StandardsRep(
      exercise: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      bodyweight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bodyweight'],
      )!,
      beginner: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}beginner'],
      )!,
      novice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}novice'],
      )!,
      intermediate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intermediate'],
      )!,
      advanced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}advanced'],
      )!,
      elite: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elite'],
      )!,
    );
  }

  @override
  StandardsReps createAlias(String alias) {
    return StandardsReps(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(exercise, sex, bodyweight)',
    'CHECK(sex IN (\'male\', \'female\'))',
    'CHECK(beginner >= 0)',
    'CHECK(novice >= beginner)',
    'CHECK(intermediate >= novice)',
    'CHECK(advanced >= intermediate)',
    'CHECK(elite >= advanced)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class StandardsRep extends DataClass implements Insertable<StandardsRep> {
  final String exercise;
  final String sex;
  final double bodyweight;
  final int beginner;
  final int novice;
  final int intermediate;
  final int advanced;
  final int elite;
  const StandardsRep({
    required this.exercise,
    required this.sex,
    required this.bodyweight,
    required this.beginner,
    required this.novice,
    required this.intermediate,
    required this.advanced,
    required this.elite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exercise'] = Variable<String>(exercise);
    map['sex'] = Variable<String>(sex);
    map['bodyweight'] = Variable<double>(bodyweight);
    map['beginner'] = Variable<int>(beginner);
    map['novice'] = Variable<int>(novice);
    map['intermediate'] = Variable<int>(intermediate);
    map['advanced'] = Variable<int>(advanced);
    map['elite'] = Variable<int>(elite);
    return map;
  }

  StandardsRepsCompanion toCompanion(bool nullToAbsent) {
    return StandardsRepsCompanion(
      exercise: Value(exercise),
      sex: Value(sex),
      bodyweight: Value(bodyweight),
      beginner: Value(beginner),
      novice: Value(novice),
      intermediate: Value(intermediate),
      advanced: Value(advanced),
      elite: Value(elite),
    );
  }

  factory StandardsRep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StandardsRep(
      exercise: serializer.fromJson<String>(json['exercise']),
      sex: serializer.fromJson<String>(json['sex']),
      bodyweight: serializer.fromJson<double>(json['bodyweight']),
      beginner: serializer.fromJson<int>(json['beginner']),
      novice: serializer.fromJson<int>(json['novice']),
      intermediate: serializer.fromJson<int>(json['intermediate']),
      advanced: serializer.fromJson<int>(json['advanced']),
      elite: serializer.fromJson<int>(json['elite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exercise': serializer.toJson<String>(exercise),
      'sex': serializer.toJson<String>(sex),
      'bodyweight': serializer.toJson<double>(bodyweight),
      'beginner': serializer.toJson<int>(beginner),
      'novice': serializer.toJson<int>(novice),
      'intermediate': serializer.toJson<int>(intermediate),
      'advanced': serializer.toJson<int>(advanced),
      'elite': serializer.toJson<int>(elite),
    };
  }

  StandardsRep copyWith({
    String? exercise,
    String? sex,
    double? bodyweight,
    int? beginner,
    int? novice,
    int? intermediate,
    int? advanced,
    int? elite,
  }) => StandardsRep(
    exercise: exercise ?? this.exercise,
    sex: sex ?? this.sex,
    bodyweight: bodyweight ?? this.bodyweight,
    beginner: beginner ?? this.beginner,
    novice: novice ?? this.novice,
    intermediate: intermediate ?? this.intermediate,
    advanced: advanced ?? this.advanced,
    elite: elite ?? this.elite,
  );
  StandardsRep copyWithCompanion(StandardsRepsCompanion data) {
    return StandardsRep(
      exercise: data.exercise.present ? data.exercise.value : this.exercise,
      sex: data.sex.present ? data.sex.value : this.sex,
      bodyweight: data.bodyweight.present
          ? data.bodyweight.value
          : this.bodyweight,
      beginner: data.beginner.present ? data.beginner.value : this.beginner,
      novice: data.novice.present ? data.novice.value : this.novice,
      intermediate: data.intermediate.present
          ? data.intermediate.value
          : this.intermediate,
      advanced: data.advanced.present ? data.advanced.value : this.advanced,
      elite: data.elite.present ? data.elite.value : this.elite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StandardsRep(')
          ..write('exercise: $exercise, ')
          ..write('sex: $sex, ')
          ..write('bodyweight: $bodyweight, ')
          ..write('beginner: $beginner, ')
          ..write('novice: $novice, ')
          ..write('intermediate: $intermediate, ')
          ..write('advanced: $advanced, ')
          ..write('elite: $elite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    exercise,
    sex,
    bodyweight,
    beginner,
    novice,
    intermediate,
    advanced,
    elite,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StandardsRep &&
          other.exercise == this.exercise &&
          other.sex == this.sex &&
          other.bodyweight == this.bodyweight &&
          other.beginner == this.beginner &&
          other.novice == this.novice &&
          other.intermediate == this.intermediate &&
          other.advanced == this.advanced &&
          other.elite == this.elite);
}

class StandardsRepsCompanion extends UpdateCompanion<StandardsRep> {
  final Value<String> exercise;
  final Value<String> sex;
  final Value<double> bodyweight;
  final Value<int> beginner;
  final Value<int> novice;
  final Value<int> intermediate;
  final Value<int> advanced;
  final Value<int> elite;
  final Value<int> rowid;
  const StandardsRepsCompanion({
    this.exercise = const Value.absent(),
    this.sex = const Value.absent(),
    this.bodyweight = const Value.absent(),
    this.beginner = const Value.absent(),
    this.novice = const Value.absent(),
    this.intermediate = const Value.absent(),
    this.advanced = const Value.absent(),
    this.elite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StandardsRepsCompanion.insert({
    required String exercise,
    required String sex,
    required double bodyweight,
    required int beginner,
    required int novice,
    required int intermediate,
    required int advanced,
    required int elite,
    this.rowid = const Value.absent(),
  }) : exercise = Value(exercise),
       sex = Value(sex),
       bodyweight = Value(bodyweight),
       beginner = Value(beginner),
       novice = Value(novice),
       intermediate = Value(intermediate),
       advanced = Value(advanced),
       elite = Value(elite);
  static Insertable<StandardsRep> custom({
    Expression<String>? exercise,
    Expression<String>? sex,
    Expression<double>? bodyweight,
    Expression<int>? beginner,
    Expression<int>? novice,
    Expression<int>? intermediate,
    Expression<int>? advanced,
    Expression<int>? elite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (exercise != null) 'exercise': exercise,
      if (sex != null) 'sex': sex,
      if (bodyweight != null) 'bodyweight': bodyweight,
      if (beginner != null) 'beginner': beginner,
      if (novice != null) 'novice': novice,
      if (intermediate != null) 'intermediate': intermediate,
      if (advanced != null) 'advanced': advanced,
      if (elite != null) 'elite': elite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StandardsRepsCompanion copyWith({
    Value<String>? exercise,
    Value<String>? sex,
    Value<double>? bodyweight,
    Value<int>? beginner,
    Value<int>? novice,
    Value<int>? intermediate,
    Value<int>? advanced,
    Value<int>? elite,
    Value<int>? rowid,
  }) {
    return StandardsRepsCompanion(
      exercise: exercise ?? this.exercise,
      sex: sex ?? this.sex,
      bodyweight: bodyweight ?? this.bodyweight,
      beginner: beginner ?? this.beginner,
      novice: novice ?? this.novice,
      intermediate: intermediate ?? this.intermediate,
      advanced: advanced ?? this.advanced,
      elite: elite ?? this.elite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exercise.present) {
      map['exercise'] = Variable<String>(exercise.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (bodyweight.present) {
      map['bodyweight'] = Variable<double>(bodyweight.value);
    }
    if (beginner.present) {
      map['beginner'] = Variable<int>(beginner.value);
    }
    if (novice.present) {
      map['novice'] = Variable<int>(novice.value);
    }
    if (intermediate.present) {
      map['intermediate'] = Variable<int>(intermediate.value);
    }
    if (advanced.present) {
      map['advanced'] = Variable<int>(advanced.value);
    }
    if (elite.present) {
      map['elite'] = Variable<int>(elite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StandardsRepsCompanion(')
          ..write('exercise: $exercise, ')
          ..write('sex: $sex, ')
          ..write('bodyweight: $bodyweight, ')
          ..write('beginner: $beginner, ')
          ..write('novice: $novice, ')
          ..write('intermediate: $intermediate, ')
          ..write('advanced: $advanced, ')
          ..write('elite: $elite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class StandardsCardio extends Table
    with TableInfo<StandardsCardio, StandardsCardioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  StandardsCardio(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exerciseMeta = const VerificationMeta(
    'exercise',
  );
  late final GeneratedColumn<String> exercise = GeneratedColumn<String>(
    'exercise',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES Exercises(id)',
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _distanceMMeta = const VerificationMeta(
    'distanceM',
  );
  late final GeneratedColumn<double> distanceM = GeneratedColumn<double>(
    'distance_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _beginnerMeta = const VerificationMeta(
    'beginner',
  );
  late final GeneratedColumn<double> beginner = GeneratedColumn<double>(
    'beginner',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _noviceMeta = const VerificationMeta('novice');
  late final GeneratedColumn<double> novice = GeneratedColumn<double>(
    'novice',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _intermediateMeta = const VerificationMeta(
    'intermediate',
  );
  late final GeneratedColumn<double> intermediate = GeneratedColumn<double>(
    'intermediate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _advancedMeta = const VerificationMeta(
    'advanced',
  );
  late final GeneratedColumn<double> advanced = GeneratedColumn<double>(
    'advanced',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _eliteMeta = const VerificationMeta('elite');
  late final GeneratedColumn<double> elite = GeneratedColumn<double>(
    'elite',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    exercise,
    sex,
    age,
    distanceM,
    beginner,
    novice,
    intermediate,
    advanced,
    elite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'StandardsCardio';
  @override
  VerificationContext validateIntegrity(
    Insertable<StandardsCardioData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise')) {
      context.handle(
        _exerciseMeta,
        exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('distance_m')) {
      context.handle(
        _distanceMMeta,
        distanceM.isAcceptableOrUnknown(data['distance_m']!, _distanceMMeta),
      );
    } else if (isInserting) {
      context.missing(_distanceMMeta);
    }
    if (data.containsKey('beginner')) {
      context.handle(
        _beginnerMeta,
        beginner.isAcceptableOrUnknown(data['beginner']!, _beginnerMeta),
      );
    } else if (isInserting) {
      context.missing(_beginnerMeta);
    }
    if (data.containsKey('novice')) {
      context.handle(
        _noviceMeta,
        novice.isAcceptableOrUnknown(data['novice']!, _noviceMeta),
      );
    } else if (isInserting) {
      context.missing(_noviceMeta);
    }
    if (data.containsKey('intermediate')) {
      context.handle(
        _intermediateMeta,
        intermediate.isAcceptableOrUnknown(
          data['intermediate']!,
          _intermediateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intermediateMeta);
    }
    if (data.containsKey('advanced')) {
      context.handle(
        _advancedMeta,
        advanced.isAcceptableOrUnknown(data['advanced']!, _advancedMeta),
      );
    } else if (isInserting) {
      context.missing(_advancedMeta);
    }
    if (data.containsKey('elite')) {
      context.handle(
        _eliteMeta,
        elite.isAcceptableOrUnknown(data['elite']!, _eliteMeta),
      );
    } else if (isInserting) {
      context.missing(_eliteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {exercise, sex, age};
  @override
  StandardsCardioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StandardsCardioData(
      exercise: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise'],
      )!,
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      distanceM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_m'],
      )!,
      beginner: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}beginner'],
      )!,
      novice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}novice'],
      )!,
      intermediate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}intermediate'],
      )!,
      advanced: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}advanced'],
      )!,
      elite: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}elite'],
      )!,
    );
  }

  @override
  StandardsCardio createAlias(String alias) {
    return StandardsCardio(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(exercise, sex, age)',
    'CHECK(sex IN (\'male\', \'female\'))',
    'CHECK(age >= 0)',
    'CHECK(beginner >= 0)',
    'CHECK(novice >= beginner)',
    'CHECK(intermediate >= novice)',
    'CHECK(advanced >= intermediate)',
    'CHECK(elite >= advanced)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class StandardsCardioData extends DataClass
    implements Insertable<StandardsCardioData> {
  final String exercise;
  final String sex;
  final int age;
  final double distanceM;
  final double beginner;
  final double novice;
  final double intermediate;
  final double advanced;
  final double elite;
  const StandardsCardioData({
    required this.exercise,
    required this.sex,
    required this.age,
    required this.distanceM,
    required this.beginner,
    required this.novice,
    required this.intermediate,
    required this.advanced,
    required this.elite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exercise'] = Variable<String>(exercise);
    map['sex'] = Variable<String>(sex);
    map['age'] = Variable<int>(age);
    map['distance_m'] = Variable<double>(distanceM);
    map['beginner'] = Variable<double>(beginner);
    map['novice'] = Variable<double>(novice);
    map['intermediate'] = Variable<double>(intermediate);
    map['advanced'] = Variable<double>(advanced);
    map['elite'] = Variable<double>(elite);
    return map;
  }

  StandardsCardioCompanion toCompanion(bool nullToAbsent) {
    return StandardsCardioCompanion(
      exercise: Value(exercise),
      sex: Value(sex),
      age: Value(age),
      distanceM: Value(distanceM),
      beginner: Value(beginner),
      novice: Value(novice),
      intermediate: Value(intermediate),
      advanced: Value(advanced),
      elite: Value(elite),
    );
  }

  factory StandardsCardioData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StandardsCardioData(
      exercise: serializer.fromJson<String>(json['exercise']),
      sex: serializer.fromJson<String>(json['sex']),
      age: serializer.fromJson<int>(json['age']),
      distanceM: serializer.fromJson<double>(json['distance_m']),
      beginner: serializer.fromJson<double>(json['beginner']),
      novice: serializer.fromJson<double>(json['novice']),
      intermediate: serializer.fromJson<double>(json['intermediate']),
      advanced: serializer.fromJson<double>(json['advanced']),
      elite: serializer.fromJson<double>(json['elite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exercise': serializer.toJson<String>(exercise),
      'sex': serializer.toJson<String>(sex),
      'age': serializer.toJson<int>(age),
      'distance_m': serializer.toJson<double>(distanceM),
      'beginner': serializer.toJson<double>(beginner),
      'novice': serializer.toJson<double>(novice),
      'intermediate': serializer.toJson<double>(intermediate),
      'advanced': serializer.toJson<double>(advanced),
      'elite': serializer.toJson<double>(elite),
    };
  }

  StandardsCardioData copyWith({
    String? exercise,
    String? sex,
    int? age,
    double? distanceM,
    double? beginner,
    double? novice,
    double? intermediate,
    double? advanced,
    double? elite,
  }) => StandardsCardioData(
    exercise: exercise ?? this.exercise,
    sex: sex ?? this.sex,
    age: age ?? this.age,
    distanceM: distanceM ?? this.distanceM,
    beginner: beginner ?? this.beginner,
    novice: novice ?? this.novice,
    intermediate: intermediate ?? this.intermediate,
    advanced: advanced ?? this.advanced,
    elite: elite ?? this.elite,
  );
  StandardsCardioData copyWithCompanion(StandardsCardioCompanion data) {
    return StandardsCardioData(
      exercise: data.exercise.present ? data.exercise.value : this.exercise,
      sex: data.sex.present ? data.sex.value : this.sex,
      age: data.age.present ? data.age.value : this.age,
      distanceM: data.distanceM.present ? data.distanceM.value : this.distanceM,
      beginner: data.beginner.present ? data.beginner.value : this.beginner,
      novice: data.novice.present ? data.novice.value : this.novice,
      intermediate: data.intermediate.present
          ? data.intermediate.value
          : this.intermediate,
      advanced: data.advanced.present ? data.advanced.value : this.advanced,
      elite: data.elite.present ? data.elite.value : this.elite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StandardsCardioData(')
          ..write('exercise: $exercise, ')
          ..write('sex: $sex, ')
          ..write('age: $age, ')
          ..write('distanceM: $distanceM, ')
          ..write('beginner: $beginner, ')
          ..write('novice: $novice, ')
          ..write('intermediate: $intermediate, ')
          ..write('advanced: $advanced, ')
          ..write('elite: $elite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    exercise,
    sex,
    age,
    distanceM,
    beginner,
    novice,
    intermediate,
    advanced,
    elite,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StandardsCardioData &&
          other.exercise == this.exercise &&
          other.sex == this.sex &&
          other.age == this.age &&
          other.distanceM == this.distanceM &&
          other.beginner == this.beginner &&
          other.novice == this.novice &&
          other.intermediate == this.intermediate &&
          other.advanced == this.advanced &&
          other.elite == this.elite);
}

class StandardsCardioCompanion extends UpdateCompanion<StandardsCardioData> {
  final Value<String> exercise;
  final Value<String> sex;
  final Value<int> age;
  final Value<double> distanceM;
  final Value<double> beginner;
  final Value<double> novice;
  final Value<double> intermediate;
  final Value<double> advanced;
  final Value<double> elite;
  final Value<int> rowid;
  const StandardsCardioCompanion({
    this.exercise = const Value.absent(),
    this.sex = const Value.absent(),
    this.age = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.beginner = const Value.absent(),
    this.novice = const Value.absent(),
    this.intermediate = const Value.absent(),
    this.advanced = const Value.absent(),
    this.elite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StandardsCardioCompanion.insert({
    required String exercise,
    required String sex,
    required int age,
    required double distanceM,
    required double beginner,
    required double novice,
    required double intermediate,
    required double advanced,
    required double elite,
    this.rowid = const Value.absent(),
  }) : exercise = Value(exercise),
       sex = Value(sex),
       age = Value(age),
       distanceM = Value(distanceM),
       beginner = Value(beginner),
       novice = Value(novice),
       intermediate = Value(intermediate),
       advanced = Value(advanced),
       elite = Value(elite);
  static Insertable<StandardsCardioData> custom({
    Expression<String>? exercise,
    Expression<String>? sex,
    Expression<int>? age,
    Expression<double>? distanceM,
    Expression<double>? beginner,
    Expression<double>? novice,
    Expression<double>? intermediate,
    Expression<double>? advanced,
    Expression<double>? elite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (exercise != null) 'exercise': exercise,
      if (sex != null) 'sex': sex,
      if (age != null) 'age': age,
      if (distanceM != null) 'distance_m': distanceM,
      if (beginner != null) 'beginner': beginner,
      if (novice != null) 'novice': novice,
      if (intermediate != null) 'intermediate': intermediate,
      if (advanced != null) 'advanced': advanced,
      if (elite != null) 'elite': elite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StandardsCardioCompanion copyWith({
    Value<String>? exercise,
    Value<String>? sex,
    Value<int>? age,
    Value<double>? distanceM,
    Value<double>? beginner,
    Value<double>? novice,
    Value<double>? intermediate,
    Value<double>? advanced,
    Value<double>? elite,
    Value<int>? rowid,
  }) {
    return StandardsCardioCompanion(
      exercise: exercise ?? this.exercise,
      sex: sex ?? this.sex,
      age: age ?? this.age,
      distanceM: distanceM ?? this.distanceM,
      beginner: beginner ?? this.beginner,
      novice: novice ?? this.novice,
      intermediate: intermediate ?? this.intermediate,
      advanced: advanced ?? this.advanced,
      elite: elite ?? this.elite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exercise.present) {
      map['exercise'] = Variable<String>(exercise.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (distanceM.present) {
      map['distance_m'] = Variable<double>(distanceM.value);
    }
    if (beginner.present) {
      map['beginner'] = Variable<double>(beginner.value);
    }
    if (novice.present) {
      map['novice'] = Variable<double>(novice.value);
    }
    if (intermediate.present) {
      map['intermediate'] = Variable<double>(intermediate.value);
    }
    if (advanced.present) {
      map['advanced'] = Variable<double>(advanced.value);
    }
    if (elite.present) {
      map['elite'] = Variable<double>(elite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StandardsCardioCompanion(')
          ..write('exercise: $exercise, ')
          ..write('sex: $sex, ')
          ..write('age: $age, ')
          ..write('distanceM: $distanceM, ')
          ..write('beginner: $beginner, ')
          ..write('novice: $novice, ')
          ..write('intermediate: $intermediate, ')
          ..write('advanced: $advanced, ')
          ..write('elite: $elite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  $AppDbManager get managers => $AppDbManager(this);
  late final Muscle muscle = Muscle(this);
  late final Equipment equipment = Equipment(this);
  late final Exercises exercises = Exercises(this);
  late final Workouts workouts = Workouts(this);
  late final Lift lift = Lift(this);
  late final Cardio cardio = Cardio(this);
  late final StandardsWeight standardsWeight = StandardsWeight(this);
  late final StandardsReps standardsReps = StandardsReps(this);
  late final StandardsCardio standardsCardio = StandardsCardio(this);
  Selectable<Exercise> get_exercises() {
    return customSelect(
      'SELECT * FROM Exercises',
      variables: [],
      readsFrom: {exercises},
    ).asyncMap(exercises.mapFromRow);
  }

  Selectable<MuscleData> get_muscles() {
    return customSelect(
      'SELECT * FROM Muscle',
      variables: [],
      readsFrom: {muscle},
    ).asyncMap(muscle.mapFromRow);
  }

  Selectable<Workout> get_workouts() {
    return customSelect(
      'SELECT * FROM Workouts',
      variables: [],
      readsFrom: {workouts},
    ).asyncMap(workouts.mapFromRow);
  }

  Selectable<LiftData> get_workout_lift(int var1) {
    return customSelect(
      'SELECT * FROM Lift WHERE workout = ?1',
      variables: [Variable<int>(var1)],
      readsFrom: {lift},
    ).asyncMap(lift.mapFromRow);
  }

  Selectable<CardioData> get_workout_cardio(int var1) {
    return customSelect(
      'SELECT * FROM Cardio WHERE workout = ?1',
      variables: [Variable<int>(var1)],
      readsFrom: {cardio},
    ).asyncMap(cardio.mapFromRow);
  }

  Selectable<String> get_names_weight() {
    return customSelect(
      'SELECT DISTINCT exercise FROM StandardsWeight',
      variables: [],
      readsFrom: {standardsWeight},
    ).map((QueryRow row) => row.read<String>('exercise'));
  }

  Selectable<String> get_names_reps() {
    return customSelect(
      'SELECT DISTINCT exercise FROM StandardsReps',
      variables: [],
      readsFrom: {standardsReps},
    ).map((QueryRow row) => row.read<String>('exercise'));
  }

  Selectable<StandardsWeightData> get_standard_weight(
    String var1,
    String var2,
  ) {
    return customSelect(
      'SELECT * FROM StandardsWeight WHERE sex = ?1 AND exercise = ?2 ORDER BY bodyweight ASC',
      variables: [Variable<String>(var1), Variable<String>(var2)],
      readsFrom: {standardsWeight},
    ).asyncMap(standardsWeight.mapFromRow);
  }

  Selectable<StandardsRep> get_standard_reps(String var1, String var2) {
    return customSelect(
      'SELECT * FROM StandardsReps WHERE sex = ?1 AND exercise = ?2 ORDER BY bodyweight ASC',
      variables: [Variable<String>(var1), Variable<String>(var2)],
      readsFrom: {standardsReps},
    ).asyncMap(standardsReps.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    muscle,
    equipment,
    exercises,
    workouts,
    lift,
    cardio,
    standardsWeight,
    standardsReps,
    standardsCardio,
  ];
}

typedef $MuscleCreateCompanionBuilder =
    MuscleCompanion Function({required String id, Value<int> rowid});
typedef $MuscleUpdateCompanionBuilder =
    MuscleCompanion Function({Value<String> id, Value<int> rowid});

final class $MuscleReferences
    extends BaseReferences<_$AppDb, Muscle, MuscleData> {
  $MuscleReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<Exercises, List<Exercise>> _exercisesRefsTable(
    _$AppDb db,
  ) => MultiTypedResultKey.fromTable(
    db.exercises,
    aliasName: $_aliasNameGenerator(db.muscle.id, db.exercises.muscle),
  );

  $ExercisesProcessedTableManager get exercisesRefs {
    final manager = $ExercisesTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.muscle.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_exercisesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $MuscleFilterComposer extends Composer<_$AppDb, Muscle> {
  $MuscleFilterComposer({
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

  Expression<bool> exercisesRefs(
    Expression<bool> Function($ExercisesFilterComposer f) f,
  ) {
    final $ExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.muscle,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $MuscleOrderingComposer extends Composer<_$AppDb, Muscle> {
  $MuscleOrderingComposer({
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
}

class $MuscleAnnotationComposer extends Composer<_$AppDb, Muscle> {
  $MuscleAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  Expression<T> exercisesRefs<T extends Object>(
    Expression<T> Function($ExercisesAnnotationComposer a) f,
  ) {
    final $ExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.muscle,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $MuscleTableManager
    extends
        RootTableManager<
          _$AppDb,
          Muscle,
          MuscleData,
          $MuscleFilterComposer,
          $MuscleOrderingComposer,
          $MuscleAnnotationComposer,
          $MuscleCreateCompanionBuilder,
          $MuscleUpdateCompanionBuilder,
          (MuscleData, $MuscleReferences),
          MuscleData,
          PrefetchHooks Function({bool exercisesRefs})
        > {
  $MuscleTableManager(_$AppDb db, Muscle table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $MuscleFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $MuscleOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $MuscleAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MuscleCompanion(id: id, rowid: rowid),
          createCompanionCallback:
              ({required String id, Value<int> rowid = const Value.absent()}) =>
                  MuscleCompanion.insert(id: id, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $MuscleReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({exercisesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (exercisesRefs) db.exercises],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exercisesRefs)
                    await $_getPrefetchedData<MuscleData, Muscle, Exercise>(
                      currentTable: table,
                      referencedTable: $MuscleReferences._exercisesRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $MuscleReferences(db, table, p0).exercisesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.muscle == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $MuscleProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      Muscle,
      MuscleData,
      $MuscleFilterComposer,
      $MuscleOrderingComposer,
      $MuscleAnnotationComposer,
      $MuscleCreateCompanionBuilder,
      $MuscleUpdateCompanionBuilder,
      (MuscleData, $MuscleReferences),
      MuscleData,
      PrefetchHooks Function({bool exercisesRefs})
    >;
typedef $EquipmentCreateCompanionBuilder =
    EquipmentCompanion Function({
      required String id,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });
typedef $EquipmentUpdateCompanionBuilder =
    EquipmentCompanion Function({
      Value<String> id,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });

final class $EquipmentReferences
    extends BaseReferences<_$AppDb, Equipment, EquipmentData> {
  $EquipmentReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<Exercises, List<Exercise>> _exercisesRefsTable(
    _$AppDb db,
  ) => MultiTypedResultKey.fromTable(
    db.exercises,
    aliasName: $_aliasNameGenerator(db.equipment.id, db.exercises.equipment),
  );

  $ExercisesProcessedTableManager get exercisesRefs {
    final manager = $ExercisesTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.equipment.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_exercisesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $EquipmentFilterComposer extends Composer<_$AppDb, Equipment> {
  $EquipmentFilterComposer({
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

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> exercisesRefs(
    Expression<bool> Function($ExercisesFilterComposer f) f,
  ) {
    final $ExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.equipment,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $EquipmentOrderingComposer extends Composer<_$AppDb, Equipment> {
  $EquipmentOrderingComposer({
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

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $EquipmentAnnotationComposer extends Composer<_$AppDb, Equipment> {
  $EquipmentAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> exercisesRefs<T extends Object>(
    Expression<T> Function($ExercisesAnnotationComposer a) f,
  ) {
    final $ExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.equipment,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $EquipmentTableManager
    extends
        RootTableManager<
          _$AppDb,
          Equipment,
          EquipmentData,
          $EquipmentFilterComposer,
          $EquipmentOrderingComposer,
          $EquipmentAnnotationComposer,
          $EquipmentCreateCompanionBuilder,
          $EquipmentUpdateCompanionBuilder,
          (EquipmentData, $EquipmentReferences),
          EquipmentData,
          PrefetchHooks Function({bool exercisesRefs})
        > {
  $EquipmentTableManager(_$AppDb db, Equipment table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $EquipmentFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $EquipmentOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $EquipmentAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EquipmentCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EquipmentCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), $EquipmentReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({exercisesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (exercisesRefs) db.exercises],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exercisesRefs)
                    await $_getPrefetchedData<
                      EquipmentData,
                      Equipment,
                      Exercise
                    >(
                      currentTable: table,
                      referencedTable: $EquipmentReferences._exercisesRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $EquipmentReferences(db, table, p0).exercisesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.equipment == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $EquipmentProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      Equipment,
      EquipmentData,
      $EquipmentFilterComposer,
      $EquipmentOrderingComposer,
      $EquipmentAnnotationComposer,
      $EquipmentCreateCompanionBuilder,
      $EquipmentUpdateCompanionBuilder,
      (EquipmentData, $EquipmentReferences),
      EquipmentData,
      PrefetchHooks Function({bool exercisesRefs})
    >;
typedef $ExercisesCreateCompanionBuilder =
    ExercisesCompanion Function({
      required String id,
      required String muscle,
      Value<String?> equipment,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });
typedef $ExercisesUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<String> id,
      Value<String> muscle,
      Value<String?> equipment,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });

final class $ExercisesReferences
    extends BaseReferences<_$AppDb, Exercises, Exercise> {
  $ExercisesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Muscle _muscleTable(_$AppDb db) => db.muscle.createAlias(
    $_aliasNameGenerator(db.exercises.muscle, db.muscle.id),
  );

  $MuscleProcessedTableManager get muscle {
    final $_column = $_itemColumn<String>('muscle')!;

    final manager = $MuscleTableManager(
      $_db,
      $_db.muscle,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_muscleTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Equipment _equipmentTable(_$AppDb db) => db.equipment.createAlias(
    $_aliasNameGenerator(db.exercises.equipment, db.equipment.id),
  );

  $EquipmentProcessedTableManager? get equipment {
    final $_column = $_itemColumn<String>('equipment');
    if ($_column == null) return null;
    final manager = $EquipmentTableManager(
      $_db,
      $_db.equipment,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_equipmentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<Lift, List<LiftData>> _liftRefsTable(_$AppDb db) =>
      MultiTypedResultKey.fromTable(
        db.lift,
        aliasName: $_aliasNameGenerator(db.exercises.id, db.lift.exercise),
      );

  $LiftProcessedTableManager get liftRefs {
    final manager = $LiftTableManager(
      $_db,
      $_db.lift,
    ).filter((f) => f.exercise.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_liftRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Cardio, List<CardioData>> _cardioRefsTable(
    _$AppDb db,
  ) => MultiTypedResultKey.fromTable(
    db.cardio,
    aliasName: $_aliasNameGenerator(db.exercises.id, db.cardio.exercise),
  );

  $CardioProcessedTableManager get cardioRefs {
    final manager = $CardioTableManager(
      $_db,
      $_db.cardio,
    ).filter((f) => f.exercise.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardioRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<StandardsWeight, List<StandardsWeightData>>
  _standardsWeightRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
    db.standardsWeight,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.standardsWeight.exercise,
    ),
  );

  $StandardsWeightProcessedTableManager get standardsWeightRefs {
    final manager = $StandardsWeightTableManager(
      $_db,
      $_db.standardsWeight,
    ).filter((f) => f.exercise.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _standardsWeightRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<StandardsReps, List<StandardsRep>>
  _standardsRepsRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
    db.standardsReps,
    aliasName: $_aliasNameGenerator(db.exercises.id, db.standardsReps.exercise),
  );

  $StandardsRepsProcessedTableManager get standardsRepsRefs {
    final manager = $StandardsRepsTableManager(
      $_db,
      $_db.standardsReps,
    ).filter((f) => f.exercise.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_standardsRepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<StandardsCardio, List<StandardsCardioData>>
  _standardsCardioRefsTable(_$AppDb db) => MultiTypedResultKey.fromTable(
    db.standardsCardio,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.standardsCardio.exercise,
    ),
  );

  $StandardsCardioProcessedTableManager get standardsCardioRefs {
    final manager = $StandardsCardioTableManager(
      $_db,
      $_db.standardsCardio,
    ).filter((f) => f.exercise.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _standardsCardioRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $ExercisesFilterComposer extends Composer<_$AppDb, Exercises> {
  $ExercisesFilterComposer({
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

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $MuscleFilterComposer get muscle {
    final $MuscleFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscle,
      referencedTable: $db.muscle,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $MuscleFilterComposer(
            $db: $db,
            $table: $db.muscle,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $EquipmentFilterComposer get equipment {
    final $EquipmentFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipment,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $EquipmentFilterComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> liftRefs(
    Expression<bool> Function($LiftFilterComposer f) f,
  ) {
    final $LiftFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lift,
      getReferencedColumn: (t) => t.exercise,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LiftFilterComposer(
            $db: $db,
            $table: $db.lift,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardioRefs(
    Expression<bool> Function($CardioFilterComposer f) f,
  ) {
    final $CardioFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardio,
      getReferencedColumn: (t) => t.exercise,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CardioFilterComposer(
            $db: $db,
            $table: $db.cardio,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> standardsWeightRefs(
    Expression<bool> Function($StandardsWeightFilterComposer f) f,
  ) {
    final $StandardsWeightFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.standardsWeight,
      getReferencedColumn: (t) => t.exercise,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $StandardsWeightFilterComposer(
            $db: $db,
            $table: $db.standardsWeight,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> standardsRepsRefs(
    Expression<bool> Function($StandardsRepsFilterComposer f) f,
  ) {
    final $StandardsRepsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.standardsReps,
      getReferencedColumn: (t) => t.exercise,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $StandardsRepsFilterComposer(
            $db: $db,
            $table: $db.standardsReps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> standardsCardioRefs(
    Expression<bool> Function($StandardsCardioFilterComposer f) f,
  ) {
    final $StandardsCardioFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.standardsCardio,
      getReferencedColumn: (t) => t.exercise,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $StandardsCardioFilterComposer(
            $db: $db,
            $table: $db.standardsCardio,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ExercisesOrderingComposer extends Composer<_$AppDb, Exercises> {
  $ExercisesOrderingComposer({
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

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $MuscleOrderingComposer get muscle {
    final $MuscleOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscle,
      referencedTable: $db.muscle,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $MuscleOrderingComposer(
            $db: $db,
            $table: $db.muscle,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $EquipmentOrderingComposer get equipment {
    final $EquipmentOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipment,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $EquipmentOrderingComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $ExercisesAnnotationComposer extends Composer<_$AppDb, Exercises> {
  $ExercisesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $MuscleAnnotationComposer get muscle {
    final $MuscleAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscle,
      referencedTable: $db.muscle,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $MuscleAnnotationComposer(
            $db: $db,
            $table: $db.muscle,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $EquipmentAnnotationComposer get equipment {
    final $EquipmentAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipment,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $EquipmentAnnotationComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> liftRefs<T extends Object>(
    Expression<T> Function($LiftAnnotationComposer a) f,
  ) {
    final $LiftAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lift,
      getReferencedColumn: (t) => t.exercise,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LiftAnnotationComposer(
            $db: $db,
            $table: $db.lift,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardioRefs<T extends Object>(
    Expression<T> Function($CardioAnnotationComposer a) f,
  ) {
    final $CardioAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardio,
      getReferencedColumn: (t) => t.exercise,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CardioAnnotationComposer(
            $db: $db,
            $table: $db.cardio,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> standardsWeightRefs<T extends Object>(
    Expression<T> Function($StandardsWeightAnnotationComposer a) f,
  ) {
    final $StandardsWeightAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.standardsWeight,
      getReferencedColumn: (t) => t.exercise,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $StandardsWeightAnnotationComposer(
            $db: $db,
            $table: $db.standardsWeight,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> standardsRepsRefs<T extends Object>(
    Expression<T> Function($StandardsRepsAnnotationComposer a) f,
  ) {
    final $StandardsRepsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.standardsReps,
      getReferencedColumn: (t) => t.exercise,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $StandardsRepsAnnotationComposer(
            $db: $db,
            $table: $db.standardsReps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> standardsCardioRefs<T extends Object>(
    Expression<T> Function($StandardsCardioAnnotationComposer a) f,
  ) {
    final $StandardsCardioAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.standardsCardio,
      getReferencedColumn: (t) => t.exercise,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $StandardsCardioAnnotationComposer(
            $db: $db,
            $table: $db.standardsCardio,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $ExercisesTableManager
    extends
        RootTableManager<
          _$AppDb,
          Exercises,
          Exercise,
          $ExercisesFilterComposer,
          $ExercisesOrderingComposer,
          $ExercisesAnnotationComposer,
          $ExercisesCreateCompanionBuilder,
          $ExercisesUpdateCompanionBuilder,
          (Exercise, $ExercisesReferences),
          Exercise,
          PrefetchHooks Function({
            bool muscle,
            bool equipment,
            bool liftRefs,
            bool cardioRefs,
            bool standardsWeightRefs,
            bool standardsRepsRefs,
            bool standardsCardioRefs,
          })
        > {
  $ExercisesTableManager(_$AppDb db, Exercises table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ExercisesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ExercisesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ExercisesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> muscle = const Value.absent(),
                Value<String?> equipment = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                muscle: muscle,
                equipment: equipment,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String muscle,
                Value<String?> equipment = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                muscle: muscle,
                equipment: equipment,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), $ExercisesReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                muscle = false,
                equipment = false,
                liftRefs = false,
                cardioRefs = false,
                standardsWeightRefs = false,
                standardsRepsRefs = false,
                standardsCardioRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (liftRefs) db.lift,
                    if (cardioRefs) db.cardio,
                    if (standardsWeightRefs) db.standardsWeight,
                    if (standardsRepsRefs) db.standardsReps,
                    if (standardsCardioRefs) db.standardsCardio,
                  ],
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
                        if (muscle) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.muscle,
                                    referencedTable: $ExercisesReferences
                                        ._muscleTable(db),
                                    referencedColumn: $ExercisesReferences
                                        ._muscleTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (equipment) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.equipment,
                                    referencedTable: $ExercisesReferences
                                        ._equipmentTable(db),
                                    referencedColumn: $ExercisesReferences
                                        ._equipmentTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (liftRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          Exercises,
                          LiftData
                        >(
                          currentTable: table,
                          referencedTable: $ExercisesReferences._liftRefsTable(
                            db,
                          ),
                          managerFromTypedResult: (p0) =>
                              $ExercisesReferences(db, table, p0).liftRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exercise == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cardioRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          Exercises,
                          CardioData
                        >(
                          currentTable: table,
                          referencedTable: $ExercisesReferences
                              ._cardioRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $ExercisesReferences(db, table, p0).cardioRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exercise == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (standardsWeightRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          Exercises,
                          StandardsWeightData
                        >(
                          currentTable: table,
                          referencedTable: $ExercisesReferences
                              ._standardsWeightRefsTable(db),
                          managerFromTypedResult: (p0) => $ExercisesReferences(
                            db,
                            table,
                            p0,
                          ).standardsWeightRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exercise == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (standardsRepsRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          Exercises,
                          StandardsRep
                        >(
                          currentTable: table,
                          referencedTable: $ExercisesReferences
                              ._standardsRepsRefsTable(db),
                          managerFromTypedResult: (p0) => $ExercisesReferences(
                            db,
                            table,
                            p0,
                          ).standardsRepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exercise == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (standardsCardioRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          Exercises,
                          StandardsCardioData
                        >(
                          currentTable: table,
                          referencedTable: $ExercisesReferences
                              ._standardsCardioRefsTable(db),
                          managerFromTypedResult: (p0) => $ExercisesReferences(
                            db,
                            table,
                            p0,
                          ).standardsCardioRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exercise == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $ExercisesProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      Exercises,
      Exercise,
      $ExercisesFilterComposer,
      $ExercisesOrderingComposer,
      $ExercisesAnnotationComposer,
      $ExercisesCreateCompanionBuilder,
      $ExercisesUpdateCompanionBuilder,
      (Exercise, $ExercisesReferences),
      Exercise,
      PrefetchHooks Function({
        bool muscle,
        bool equipment,
        bool liftRefs,
        bool cardioRefs,
        bool standardsWeightRefs,
        bool standardsRepsRefs,
        bool standardsCardioRefs,
      })
    >;
typedef $WorkoutsCreateCompanionBuilder =
    WorkoutsCompanion Function({
      Value<int> id,
      required String title,
      required int startTime,
      required int endTime,
      Value<String?> createdAt,
      Value<String?> updatedAt,
    });
typedef $WorkoutsUpdateCompanionBuilder =
    WorkoutsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> startTime,
      Value<int> endTime,
      Value<String?> createdAt,
      Value<String?> updatedAt,
    });

final class $WorkoutsReferences
    extends BaseReferences<_$AppDb, Workouts, Workout> {
  $WorkoutsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<Lift, List<LiftData>> _liftRefsTable(_$AppDb db) =>
      MultiTypedResultKey.fromTable(
        db.lift,
        aliasName: $_aliasNameGenerator(db.workouts.id, db.lift.workout),
      );

  $LiftProcessedTableManager get liftRefs {
    final manager = $LiftTableManager(
      $_db,
      $_db.lift,
    ).filter((f) => f.workout.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_liftRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<Cardio, List<CardioData>> _cardioRefsTable(
    _$AppDb db,
  ) => MultiTypedResultKey.fromTable(
    db.cardio,
    aliasName: $_aliasNameGenerator(db.workouts.id, db.cardio.workout),
  );

  $CardioProcessedTableManager get cardioRefs {
    final manager = $CardioTableManager(
      $_db,
      $_db.cardio,
    ).filter((f) => f.workout.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardioRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $WorkoutsFilterComposer extends Composer<_$AppDb, Workouts> {
  $WorkoutsFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> liftRefs(
    Expression<bool> Function($LiftFilterComposer f) f,
  ) {
    final $LiftFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lift,
      getReferencedColumn: (t) => t.workout,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LiftFilterComposer(
            $db: $db,
            $table: $db.lift,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardioRefs(
    Expression<bool> Function($CardioFilterComposer f) f,
  ) {
    final $CardioFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardio,
      getReferencedColumn: (t) => t.workout,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CardioFilterComposer(
            $db: $db,
            $table: $db.cardio,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $WorkoutsOrderingComposer extends Composer<_$AppDb, Workouts> {
  $WorkoutsOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $WorkoutsAnnotationComposer extends Composer<_$AppDb, Workouts> {
  $WorkoutsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<int> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> liftRefs<T extends Object>(
    Expression<T> Function($LiftAnnotationComposer a) f,
  ) {
    final $LiftAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lift,
      getReferencedColumn: (t) => t.workout,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $LiftAnnotationComposer(
            $db: $db,
            $table: $db.lift,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardioRefs<T extends Object>(
    Expression<T> Function($CardioAnnotationComposer a) f,
  ) {
    final $CardioAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardio,
      getReferencedColumn: (t) => t.workout,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $CardioAnnotationComposer(
            $db: $db,
            $table: $db.cardio,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $WorkoutsTableManager
    extends
        RootTableManager<
          _$AppDb,
          Workouts,
          Workout,
          $WorkoutsFilterComposer,
          $WorkoutsOrderingComposer,
          $WorkoutsAnnotationComposer,
          $WorkoutsCreateCompanionBuilder,
          $WorkoutsUpdateCompanionBuilder,
          (Workout, $WorkoutsReferences),
          Workout,
          PrefetchHooks Function({bool liftRefs, bool cardioRefs})
        > {
  $WorkoutsTableManager(_$AppDb db, Workouts table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $WorkoutsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $WorkoutsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $WorkoutsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> startTime = const Value.absent(),
                Value<int> endTime = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => WorkoutsCompanion(
                id: id,
                title: title,
                startTime: startTime,
                endTime: endTime,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int startTime,
                required int endTime,
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
              }) => WorkoutsCompanion.insert(
                id: id,
                title: title,
                startTime: startTime,
                endTime: endTime,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable(table), $WorkoutsReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({liftRefs = false, cardioRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (liftRefs) db.lift,
                if (cardioRefs) db.cardio,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (liftRefs)
                    await $_getPrefetchedData<Workout, Workouts, LiftData>(
                      currentTable: table,
                      referencedTable: $WorkoutsReferences._liftRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $WorkoutsReferences(db, table, p0).liftRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.workout == item.id),
                      typedResults: items,
                    ),
                  if (cardioRefs)
                    await $_getPrefetchedData<Workout, Workouts, CardioData>(
                      currentTable: table,
                      referencedTable: $WorkoutsReferences._cardioRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $WorkoutsReferences(db, table, p0).cardioRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.workout == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $WorkoutsProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      Workouts,
      Workout,
      $WorkoutsFilterComposer,
      $WorkoutsOrderingComposer,
      $WorkoutsAnnotationComposer,
      $WorkoutsCreateCompanionBuilder,
      $WorkoutsUpdateCompanionBuilder,
      (Workout, $WorkoutsReferences),
      Workout,
      PrefetchHooks Function({bool liftRefs, bool cardioRefs})
    >;
typedef $LiftCreateCompanionBuilder =
    LiftCompanion Function({
      required String exercise,
      required int setOfSets,
      required int setIndex,
      required int reps,
      Value<double?> weightKg,
      required int workout,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });
typedef $LiftUpdateCompanionBuilder =
    LiftCompanion Function({
      Value<String> exercise,
      Value<int> setOfSets,
      Value<int> setIndex,
      Value<int> reps,
      Value<double?> weightKg,
      Value<int> workout,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });

final class $LiftReferences extends BaseReferences<_$AppDb, Lift, LiftData> {
  $LiftReferences(super.$_db, super.$_table, super.$_typedResult);

  static Exercises _exerciseTable(_$AppDb db) => db.exercises.createAlias(
    $_aliasNameGenerator(db.lift.exercise, db.exercises.id),
  );

  $ExercisesProcessedTableManager get exercise {
    final $_column = $_itemColumn<String>('exercise')!;

    final manager = $ExercisesTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Workouts _workoutTable(_$AppDb db) => db.workouts.createAlias(
    $_aliasNameGenerator(db.lift.workout, db.workouts.id),
  );

  $WorkoutsProcessedTableManager get workout {
    final $_column = $_itemColumn<int>('workout')!;

    final manager = $WorkoutsTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $LiftFilterComposer extends Composer<_$AppDb, Lift> {
  $LiftFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get setOfSets => $composableBuilder(
    column: $table.setOfSets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setIndex => $composableBuilder(
    column: $table.setIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $ExercisesFilterComposer get exercise {
    final $ExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $WorkoutsFilterComposer get workout {
    final $WorkoutsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workout,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutsFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $LiftOrderingComposer extends Composer<_$AppDb, Lift> {
  $LiftOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get setOfSets => $composableBuilder(
    column: $table.setOfSets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setIndex => $composableBuilder(
    column: $table.setIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $ExercisesOrderingComposer get exercise {
    final $ExercisesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $WorkoutsOrderingComposer get workout {
    final $WorkoutsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workout,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutsOrderingComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $LiftAnnotationComposer extends Composer<_$AppDb, Lift> {
  $LiftAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get setOfSets =>
      $composableBuilder(column: $table.setOfSets, builder: (column) => column);

  GeneratedColumn<int> get setIndex =>
      $composableBuilder(column: $table.setIndex, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $ExercisesAnnotationComposer get exercise {
    final $ExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $WorkoutsAnnotationComposer get workout {
    final $WorkoutsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workout,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutsAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $LiftTableManager
    extends
        RootTableManager<
          _$AppDb,
          Lift,
          LiftData,
          $LiftFilterComposer,
          $LiftOrderingComposer,
          $LiftAnnotationComposer,
          $LiftCreateCompanionBuilder,
          $LiftUpdateCompanionBuilder,
          (LiftData, $LiftReferences),
          LiftData,
          PrefetchHooks Function({bool exercise, bool workout})
        > {
  $LiftTableManager(_$AppDb db, Lift table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $LiftFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $LiftOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $LiftAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> exercise = const Value.absent(),
                Value<int> setOfSets = const Value.absent(),
                Value<int> setIndex = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<int> workout = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LiftCompanion(
                exercise: exercise,
                setOfSets: setOfSets,
                setIndex: setIndex,
                reps: reps,
                weightKg: weightKg,
                workout: workout,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String exercise,
                required int setOfSets,
                required int setIndex,
                required int reps,
                Value<double?> weightKg = const Value.absent(),
                required int workout,
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LiftCompanion.insert(
                exercise: exercise,
                setOfSets: setOfSets,
                setIndex: setIndex,
                reps: reps,
                weightKg: weightKg,
                workout: workout,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $LiftReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({exercise = false, workout = false}) {
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
                    if (exercise) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exercise,
                                referencedTable: $LiftReferences._exerciseTable(
                                  db,
                                ),
                                referencedColumn: $LiftReferences
                                    ._exerciseTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (workout) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workout,
                                referencedTable: $LiftReferences._workoutTable(
                                  db,
                                ),
                                referencedColumn: $LiftReferences
                                    ._workoutTable(db)
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

typedef $LiftProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      Lift,
      LiftData,
      $LiftFilterComposer,
      $LiftOrderingComposer,
      $LiftAnnotationComposer,
      $LiftCreateCompanionBuilder,
      $LiftUpdateCompanionBuilder,
      (LiftData, $LiftReferences),
      LiftData,
      PrefetchHooks Function({bool exercise, bool workout})
    >;
typedef $CardioCreateCompanionBuilder =
    CardioCompanion Function({
      required String exercise,
      required int lap,
      Value<double?> distanceM,
      Value<double?> durationS,
      required int workout,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });
typedef $CardioUpdateCompanionBuilder =
    CardioCompanion Function({
      Value<String> exercise,
      Value<int> lap,
      Value<double?> distanceM,
      Value<double?> durationS,
      Value<int> workout,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });

final class $CardioReferences
    extends BaseReferences<_$AppDb, Cardio, CardioData> {
  $CardioReferences(super.$_db, super.$_table, super.$_typedResult);

  static Exercises _exerciseTable(_$AppDb db) => db.exercises.createAlias(
    $_aliasNameGenerator(db.cardio.exercise, db.exercises.id),
  );

  $ExercisesProcessedTableManager get exercise {
    final $_column = $_itemColumn<String>('exercise')!;

    final manager = $ExercisesTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static Workouts _workoutTable(_$AppDb db) => db.workouts.createAlias(
    $_aliasNameGenerator(db.cardio.workout, db.workouts.id),
  );

  $WorkoutsProcessedTableManager get workout {
    final $_column = $_itemColumn<int>('workout')!;

    final manager = $WorkoutsTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $CardioFilterComposer extends Composer<_$AppDb, Cardio> {
  $CardioFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get lap => $composableBuilder(
    column: $table.lap,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $ExercisesFilterComposer get exercise {
    final $ExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $WorkoutsFilterComposer get workout {
    final $WorkoutsFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workout,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutsFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CardioOrderingComposer extends Composer<_$AppDb, Cardio> {
  $CardioOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get lap => $composableBuilder(
    column: $table.lap,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $ExercisesOrderingComposer get exercise {
    final $ExercisesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $WorkoutsOrderingComposer get workout {
    final $WorkoutsOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workout,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutsOrderingComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CardioAnnotationComposer extends Composer<_$AppDb, Cardio> {
  $CardioAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get lap =>
      $composableBuilder(column: $table.lap, builder: (column) => column);

  GeneratedColumn<double> get distanceM =>
      $composableBuilder(column: $table.distanceM, builder: (column) => column);

  GeneratedColumn<double> get durationS =>
      $composableBuilder(column: $table.durationS, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $ExercisesAnnotationComposer get exercise {
    final $ExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $WorkoutsAnnotationComposer get workout {
    final $WorkoutsAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workout,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $WorkoutsAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $CardioTableManager
    extends
        RootTableManager<
          _$AppDb,
          Cardio,
          CardioData,
          $CardioFilterComposer,
          $CardioOrderingComposer,
          $CardioAnnotationComposer,
          $CardioCreateCompanionBuilder,
          $CardioUpdateCompanionBuilder,
          (CardioData, $CardioReferences),
          CardioData,
          PrefetchHooks Function({bool exercise, bool workout})
        > {
  $CardioTableManager(_$AppDb db, Cardio table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CardioFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CardioOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CardioAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> exercise = const Value.absent(),
                Value<int> lap = const Value.absent(),
                Value<double?> distanceM = const Value.absent(),
                Value<double?> durationS = const Value.absent(),
                Value<int> workout = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardioCompanion(
                exercise: exercise,
                lap: lap,
                distanceM: distanceM,
                durationS: durationS,
                workout: workout,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String exercise,
                required int lap,
                Value<double?> distanceM = const Value.absent(),
                Value<double?> durationS = const Value.absent(),
                required int workout,
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardioCompanion.insert(
                exercise: exercise,
                lap: lap,
                distanceM: distanceM,
                durationS: durationS,
                workout: workout,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $CardioReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({exercise = false, workout = false}) {
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
                    if (exercise) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exercise,
                                referencedTable: $CardioReferences
                                    ._exerciseTable(db),
                                referencedColumn: $CardioReferences
                                    ._exerciseTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (workout) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workout,
                                referencedTable: $CardioReferences
                                    ._workoutTable(db),
                                referencedColumn: $CardioReferences
                                    ._workoutTable(db)
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

typedef $CardioProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      Cardio,
      CardioData,
      $CardioFilterComposer,
      $CardioOrderingComposer,
      $CardioAnnotationComposer,
      $CardioCreateCompanionBuilder,
      $CardioUpdateCompanionBuilder,
      (CardioData, $CardioReferences),
      CardioData,
      PrefetchHooks Function({bool exercise, bool workout})
    >;
typedef $StandardsWeightCreateCompanionBuilder =
    StandardsWeightCompanion Function({
      required String exercise,
      required String sex,
      required double bodyweight,
      required double beginner,
      required double novice,
      required double intermediate,
      required double advanced,
      required double elite,
      Value<int> rowid,
    });
typedef $StandardsWeightUpdateCompanionBuilder =
    StandardsWeightCompanion Function({
      Value<String> exercise,
      Value<String> sex,
      Value<double> bodyweight,
      Value<double> beginner,
      Value<double> novice,
      Value<double> intermediate,
      Value<double> advanced,
      Value<double> elite,
      Value<int> rowid,
    });

final class $StandardsWeightReferences
    extends BaseReferences<_$AppDb, StandardsWeight, StandardsWeightData> {
  $StandardsWeightReferences(super.$_db, super.$_table, super.$_typedResult);

  static Exercises _exerciseTable(_$AppDb db) => db.exercises.createAlias(
    $_aliasNameGenerator(db.standardsWeight.exercise, db.exercises.id),
  );

  $ExercisesProcessedTableManager get exercise {
    final $_column = $_itemColumn<String>('exercise')!;

    final manager = $ExercisesTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $StandardsWeightFilterComposer
    extends Composer<_$AppDb, StandardsWeight> {
  $StandardsWeightFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyweight => $composableBuilder(
    column: $table.bodyweight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get beginner => $composableBuilder(
    column: $table.beginner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get novice => $composableBuilder(
    column: $table.novice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get intermediate => $composableBuilder(
    column: $table.intermediate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get advanced => $composableBuilder(
    column: $table.advanced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get elite => $composableBuilder(
    column: $table.elite,
    builder: (column) => ColumnFilters(column),
  );

  $ExercisesFilterComposer get exercise {
    final $ExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StandardsWeightOrderingComposer
    extends Composer<_$AppDb, StandardsWeight> {
  $StandardsWeightOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyweight => $composableBuilder(
    column: $table.bodyweight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get beginner => $composableBuilder(
    column: $table.beginner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get novice => $composableBuilder(
    column: $table.novice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get intermediate => $composableBuilder(
    column: $table.intermediate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get advanced => $composableBuilder(
    column: $table.advanced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get elite => $composableBuilder(
    column: $table.elite,
    builder: (column) => ColumnOrderings(column),
  );

  $ExercisesOrderingComposer get exercise {
    final $ExercisesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StandardsWeightAnnotationComposer
    extends Composer<_$AppDb, StandardsWeight> {
  $StandardsWeightAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<double> get bodyweight => $composableBuilder(
    column: $table.bodyweight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get beginner =>
      $composableBuilder(column: $table.beginner, builder: (column) => column);

  GeneratedColumn<double> get novice =>
      $composableBuilder(column: $table.novice, builder: (column) => column);

  GeneratedColumn<double> get intermediate => $composableBuilder(
    column: $table.intermediate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get advanced =>
      $composableBuilder(column: $table.advanced, builder: (column) => column);

  GeneratedColumn<double> get elite =>
      $composableBuilder(column: $table.elite, builder: (column) => column);

  $ExercisesAnnotationComposer get exercise {
    final $ExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StandardsWeightTableManager
    extends
        RootTableManager<
          _$AppDb,
          StandardsWeight,
          StandardsWeightData,
          $StandardsWeightFilterComposer,
          $StandardsWeightOrderingComposer,
          $StandardsWeightAnnotationComposer,
          $StandardsWeightCreateCompanionBuilder,
          $StandardsWeightUpdateCompanionBuilder,
          (StandardsWeightData, $StandardsWeightReferences),
          StandardsWeightData,
          PrefetchHooks Function({bool exercise})
        > {
  $StandardsWeightTableManager(_$AppDb db, StandardsWeight table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $StandardsWeightFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $StandardsWeightOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $StandardsWeightAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> exercise = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<double> bodyweight = const Value.absent(),
                Value<double> beginner = const Value.absent(),
                Value<double> novice = const Value.absent(),
                Value<double> intermediate = const Value.absent(),
                Value<double> advanced = const Value.absent(),
                Value<double> elite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StandardsWeightCompanion(
                exercise: exercise,
                sex: sex,
                bodyweight: bodyweight,
                beginner: beginner,
                novice: novice,
                intermediate: intermediate,
                advanced: advanced,
                elite: elite,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String exercise,
                required String sex,
                required double bodyweight,
                required double beginner,
                required double novice,
                required double intermediate,
                required double advanced,
                required double elite,
                Value<int> rowid = const Value.absent(),
              }) => StandardsWeightCompanion.insert(
                exercise: exercise,
                sex: sex,
                bodyweight: bodyweight,
                beginner: beginner,
                novice: novice,
                intermediate: intermediate,
                advanced: advanced,
                elite: elite,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $StandardsWeightReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exercise = false}) {
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
                    if (exercise) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exercise,
                                referencedTable: $StandardsWeightReferences
                                    ._exerciseTable(db),
                                referencedColumn: $StandardsWeightReferences
                                    ._exerciseTable(db)
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

typedef $StandardsWeightProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      StandardsWeight,
      StandardsWeightData,
      $StandardsWeightFilterComposer,
      $StandardsWeightOrderingComposer,
      $StandardsWeightAnnotationComposer,
      $StandardsWeightCreateCompanionBuilder,
      $StandardsWeightUpdateCompanionBuilder,
      (StandardsWeightData, $StandardsWeightReferences),
      StandardsWeightData,
      PrefetchHooks Function({bool exercise})
    >;
typedef $StandardsRepsCreateCompanionBuilder =
    StandardsRepsCompanion Function({
      required String exercise,
      required String sex,
      required double bodyweight,
      required int beginner,
      required int novice,
      required int intermediate,
      required int advanced,
      required int elite,
      Value<int> rowid,
    });
typedef $StandardsRepsUpdateCompanionBuilder =
    StandardsRepsCompanion Function({
      Value<String> exercise,
      Value<String> sex,
      Value<double> bodyweight,
      Value<int> beginner,
      Value<int> novice,
      Value<int> intermediate,
      Value<int> advanced,
      Value<int> elite,
      Value<int> rowid,
    });

final class $StandardsRepsReferences
    extends BaseReferences<_$AppDb, StandardsReps, StandardsRep> {
  $StandardsRepsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Exercises _exerciseTable(_$AppDb db) => db.exercises.createAlias(
    $_aliasNameGenerator(db.standardsReps.exercise, db.exercises.id),
  );

  $ExercisesProcessedTableManager get exercise {
    final $_column = $_itemColumn<String>('exercise')!;

    final manager = $ExercisesTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $StandardsRepsFilterComposer extends Composer<_$AppDb, StandardsReps> {
  $StandardsRepsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyweight => $composableBuilder(
    column: $table.bodyweight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get beginner => $composableBuilder(
    column: $table.beginner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get novice => $composableBuilder(
    column: $table.novice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intermediate => $composableBuilder(
    column: $table.intermediate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get advanced => $composableBuilder(
    column: $table.advanced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elite => $composableBuilder(
    column: $table.elite,
    builder: (column) => ColumnFilters(column),
  );

  $ExercisesFilterComposer get exercise {
    final $ExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StandardsRepsOrderingComposer extends Composer<_$AppDb, StandardsReps> {
  $StandardsRepsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyweight => $composableBuilder(
    column: $table.bodyweight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get beginner => $composableBuilder(
    column: $table.beginner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get novice => $composableBuilder(
    column: $table.novice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intermediate => $composableBuilder(
    column: $table.intermediate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get advanced => $composableBuilder(
    column: $table.advanced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elite => $composableBuilder(
    column: $table.elite,
    builder: (column) => ColumnOrderings(column),
  );

  $ExercisesOrderingComposer get exercise {
    final $ExercisesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StandardsRepsAnnotationComposer
    extends Composer<_$AppDb, StandardsReps> {
  $StandardsRepsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<double> get bodyweight => $composableBuilder(
    column: $table.bodyweight,
    builder: (column) => column,
  );

  GeneratedColumn<int> get beginner =>
      $composableBuilder(column: $table.beginner, builder: (column) => column);

  GeneratedColumn<int> get novice =>
      $composableBuilder(column: $table.novice, builder: (column) => column);

  GeneratedColumn<int> get intermediate => $composableBuilder(
    column: $table.intermediate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get advanced =>
      $composableBuilder(column: $table.advanced, builder: (column) => column);

  GeneratedColumn<int> get elite =>
      $composableBuilder(column: $table.elite, builder: (column) => column);

  $ExercisesAnnotationComposer get exercise {
    final $ExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StandardsRepsTableManager
    extends
        RootTableManager<
          _$AppDb,
          StandardsReps,
          StandardsRep,
          $StandardsRepsFilterComposer,
          $StandardsRepsOrderingComposer,
          $StandardsRepsAnnotationComposer,
          $StandardsRepsCreateCompanionBuilder,
          $StandardsRepsUpdateCompanionBuilder,
          (StandardsRep, $StandardsRepsReferences),
          StandardsRep,
          PrefetchHooks Function({bool exercise})
        > {
  $StandardsRepsTableManager(_$AppDb db, StandardsReps table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $StandardsRepsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $StandardsRepsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $StandardsRepsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> exercise = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<double> bodyweight = const Value.absent(),
                Value<int> beginner = const Value.absent(),
                Value<int> novice = const Value.absent(),
                Value<int> intermediate = const Value.absent(),
                Value<int> advanced = const Value.absent(),
                Value<int> elite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StandardsRepsCompanion(
                exercise: exercise,
                sex: sex,
                bodyweight: bodyweight,
                beginner: beginner,
                novice: novice,
                intermediate: intermediate,
                advanced: advanced,
                elite: elite,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String exercise,
                required String sex,
                required double bodyweight,
                required int beginner,
                required int novice,
                required int intermediate,
                required int advanced,
                required int elite,
                Value<int> rowid = const Value.absent(),
              }) => StandardsRepsCompanion.insert(
                exercise: exercise,
                sex: sex,
                bodyweight: bodyweight,
                beginner: beginner,
                novice: novice,
                intermediate: intermediate,
                advanced: advanced,
                elite: elite,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $StandardsRepsReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exercise = false}) {
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
                    if (exercise) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exercise,
                                referencedTable: $StandardsRepsReferences
                                    ._exerciseTable(db),
                                referencedColumn: $StandardsRepsReferences
                                    ._exerciseTable(db)
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

typedef $StandardsRepsProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      StandardsReps,
      StandardsRep,
      $StandardsRepsFilterComposer,
      $StandardsRepsOrderingComposer,
      $StandardsRepsAnnotationComposer,
      $StandardsRepsCreateCompanionBuilder,
      $StandardsRepsUpdateCompanionBuilder,
      (StandardsRep, $StandardsRepsReferences),
      StandardsRep,
      PrefetchHooks Function({bool exercise})
    >;
typedef $StandardsCardioCreateCompanionBuilder =
    StandardsCardioCompanion Function({
      required String exercise,
      required String sex,
      required int age,
      required double distanceM,
      required double beginner,
      required double novice,
      required double intermediate,
      required double advanced,
      required double elite,
      Value<int> rowid,
    });
typedef $StandardsCardioUpdateCompanionBuilder =
    StandardsCardioCompanion Function({
      Value<String> exercise,
      Value<String> sex,
      Value<int> age,
      Value<double> distanceM,
      Value<double> beginner,
      Value<double> novice,
      Value<double> intermediate,
      Value<double> advanced,
      Value<double> elite,
      Value<int> rowid,
    });

final class $StandardsCardioReferences
    extends BaseReferences<_$AppDb, StandardsCardio, StandardsCardioData> {
  $StandardsCardioReferences(super.$_db, super.$_table, super.$_typedResult);

  static Exercises _exerciseTable(_$AppDb db) => db.exercises.createAlias(
    $_aliasNameGenerator(db.standardsCardio.exercise, db.exercises.id),
  );

  $ExercisesProcessedTableManager get exercise {
    final $_column = $_itemColumn<String>('exercise')!;

    final manager = $ExercisesTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $StandardsCardioFilterComposer
    extends Composer<_$AppDb, StandardsCardio> {
  $StandardsCardioFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get beginner => $composableBuilder(
    column: $table.beginner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get novice => $composableBuilder(
    column: $table.novice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get intermediate => $composableBuilder(
    column: $table.intermediate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get advanced => $composableBuilder(
    column: $table.advanced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get elite => $composableBuilder(
    column: $table.elite,
    builder: (column) => ColumnFilters(column),
  );

  $ExercisesFilterComposer get exercise {
    final $ExercisesFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StandardsCardioOrderingComposer
    extends Composer<_$AppDb, StandardsCardio> {
  $StandardsCardioOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceM => $composableBuilder(
    column: $table.distanceM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get beginner => $composableBuilder(
    column: $table.beginner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get novice => $composableBuilder(
    column: $table.novice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get intermediate => $composableBuilder(
    column: $table.intermediate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get advanced => $composableBuilder(
    column: $table.advanced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get elite => $composableBuilder(
    column: $table.elite,
    builder: (column) => ColumnOrderings(column),
  );

  $ExercisesOrderingComposer get exercise {
    final $ExercisesOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StandardsCardioAnnotationComposer
    extends Composer<_$AppDb, StandardsCardio> {
  $StandardsCardioAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<double> get distanceM =>
      $composableBuilder(column: $table.distanceM, builder: (column) => column);

  GeneratedColumn<double> get beginner =>
      $composableBuilder(column: $table.beginner, builder: (column) => column);

  GeneratedColumn<double> get novice =>
      $composableBuilder(column: $table.novice, builder: (column) => column);

  GeneratedColumn<double> get intermediate => $composableBuilder(
    column: $table.intermediate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get advanced =>
      $composableBuilder(column: $table.advanced, builder: (column) => column);

  GeneratedColumn<double> get elite =>
      $composableBuilder(column: $table.elite, builder: (column) => column);

  $ExercisesAnnotationComposer get exercise {
    final $ExercisesAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exercise,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $ExercisesAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $StandardsCardioTableManager
    extends
        RootTableManager<
          _$AppDb,
          StandardsCardio,
          StandardsCardioData,
          $StandardsCardioFilterComposer,
          $StandardsCardioOrderingComposer,
          $StandardsCardioAnnotationComposer,
          $StandardsCardioCreateCompanionBuilder,
          $StandardsCardioUpdateCompanionBuilder,
          (StandardsCardioData, $StandardsCardioReferences),
          StandardsCardioData,
          PrefetchHooks Function({bool exercise})
        > {
  $StandardsCardioTableManager(_$AppDb db, StandardsCardio table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $StandardsCardioFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $StandardsCardioOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $StandardsCardioAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> exercise = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<double> distanceM = const Value.absent(),
                Value<double> beginner = const Value.absent(),
                Value<double> novice = const Value.absent(),
                Value<double> intermediate = const Value.absent(),
                Value<double> advanced = const Value.absent(),
                Value<double> elite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StandardsCardioCompanion(
                exercise: exercise,
                sex: sex,
                age: age,
                distanceM: distanceM,
                beginner: beginner,
                novice: novice,
                intermediate: intermediate,
                advanced: advanced,
                elite: elite,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String exercise,
                required String sex,
                required int age,
                required double distanceM,
                required double beginner,
                required double novice,
                required double intermediate,
                required double advanced,
                required double elite,
                Value<int> rowid = const Value.absent(),
              }) => StandardsCardioCompanion.insert(
                exercise: exercise,
                sex: sex,
                age: age,
                distanceM: distanceM,
                beginner: beginner,
                novice: novice,
                intermediate: intermediate,
                advanced: advanced,
                elite: elite,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $StandardsCardioReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exercise = false}) {
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
                    if (exercise) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exercise,
                                referencedTable: $StandardsCardioReferences
                                    ._exerciseTable(db),
                                referencedColumn: $StandardsCardioReferences
                                    ._exerciseTable(db)
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

typedef $StandardsCardioProcessedTableManager =
    ProcessedTableManager<
      _$AppDb,
      StandardsCardio,
      StandardsCardioData,
      $StandardsCardioFilterComposer,
      $StandardsCardioOrderingComposer,
      $StandardsCardioAnnotationComposer,
      $StandardsCardioCreateCompanionBuilder,
      $StandardsCardioUpdateCompanionBuilder,
      (StandardsCardioData, $StandardsCardioReferences),
      StandardsCardioData,
      PrefetchHooks Function({bool exercise})
    >;

class $AppDbManager {
  final _$AppDb _db;
  $AppDbManager(this._db);
  $MuscleTableManager get muscle => $MuscleTableManager(_db, _db.muscle);
  $EquipmentTableManager get equipment =>
      $EquipmentTableManager(_db, _db.equipment);
  $ExercisesTableManager get exercises =>
      $ExercisesTableManager(_db, _db.exercises);
  $WorkoutsTableManager get workouts =>
      $WorkoutsTableManager(_db, _db.workouts);
  $LiftTableManager get lift => $LiftTableManager(_db, _db.lift);
  $CardioTableManager get cardio => $CardioTableManager(_db, _db.cardio);
  $StandardsWeightTableManager get standardsWeight =>
      $StandardsWeightTableManager(_db, _db.standardsWeight);
  $StandardsRepsTableManager get standardsReps =>
      $StandardsRepsTableManager(_db, _db.standardsReps);
  $StandardsCardioTableManager get standardsCardio =>
      $StandardsCardioTableManager(_db, _db.standardsCardio);
}
