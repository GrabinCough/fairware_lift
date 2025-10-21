// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionDateTimeMeta =
      const VerificationMeta('sessionDateTime');
  @override
  late final GeneratedColumn<DateTime> sessionDateTime =
      GeneratedColumn<DateTime>('date_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _totalDurationSecondsMeta =
      const VerificationMeta('totalDurationSeconds');
  @override
  late final GeneratedColumn<int> totalDurationSeconds = GeneratedColumn<int>(
      'total_duration_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalActivitySecondsMeta =
      const VerificationMeta('totalActivitySeconds');
  @override
  late final GeneratedColumn<int> totalActivitySeconds = GeneratedColumn<int>(
      'total_activity_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalRestSecondsMeta =
      const VerificationMeta('totalRestSeconds');
  @override
  late final GeneratedColumn<int> totalRestSeconds = GeneratedColumn<int>(
      'total_rest_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionDateTime,
        totalDurationSeconds,
        totalActivitySeconds,
        totalRestSeconds,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(Insertable<Session> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date_time')) {
      context.handle(
          _sessionDateTimeMeta,
          sessionDateTime.isAcceptableOrUnknown(
              data['date_time']!, _sessionDateTimeMeta));
    } else if (isInserting) {
      context.missing(_sessionDateTimeMeta);
    }
    if (data.containsKey('total_duration_seconds')) {
      context.handle(
          _totalDurationSecondsMeta,
          totalDurationSeconds.isAcceptableOrUnknown(
              data['total_duration_seconds']!, _totalDurationSecondsMeta));
    }
    if (data.containsKey('total_activity_seconds')) {
      context.handle(
          _totalActivitySecondsMeta,
          totalActivitySeconds.isAcceptableOrUnknown(
              data['total_activity_seconds']!, _totalActivitySecondsMeta));
    }
    if (data.containsKey('total_rest_seconds')) {
      context.handle(
          _totalRestSecondsMeta,
          totalRestSeconds.isAcceptableOrUnknown(
              data['total_rest_seconds']!, _totalRestSecondsMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionDateTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_time'])!,
      totalDurationSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_duration_seconds']),
      totalActivitySeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_activity_seconds']),
      totalRestSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_rest_seconds']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String id;
  final DateTime sessionDateTime;
  final int? totalDurationSeconds;
  final int? totalActivitySeconds;
  final int? totalRestSeconds;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Session(
      {required this.id,
      required this.sessionDateTime,
      this.totalDurationSeconds,
      this.totalActivitySeconds,
      this.totalRestSeconds,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date_time'] = Variable<DateTime>(sessionDateTime);
    if (!nullToAbsent || totalDurationSeconds != null) {
      map['total_duration_seconds'] = Variable<int>(totalDurationSeconds);
    }
    if (!nullToAbsent || totalActivitySeconds != null) {
      map['total_activity_seconds'] = Variable<int>(totalActivitySeconds);
    }
    if (!nullToAbsent || totalRestSeconds != null) {
      map['total_rest_seconds'] = Variable<int>(totalRestSeconds);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      sessionDateTime: Value(sessionDateTime),
      totalDurationSeconds: totalDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(totalDurationSeconds),
      totalActivitySeconds: totalActivitySeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(totalActivitySeconds),
      totalRestSeconds: totalRestSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(totalRestSeconds),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Session.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<String>(json['id']),
      sessionDateTime: serializer.fromJson<DateTime>(json['sessionDateTime']),
      totalDurationSeconds:
          serializer.fromJson<int?>(json['totalDurationSeconds']),
      totalActivitySeconds:
          serializer.fromJson<int?>(json['totalActivitySeconds']),
      totalRestSeconds: serializer.fromJson<int?>(json['totalRestSeconds']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionDateTime': serializer.toJson<DateTime>(sessionDateTime),
      'totalDurationSeconds': serializer.toJson<int?>(totalDurationSeconds),
      'totalActivitySeconds': serializer.toJson<int?>(totalActivitySeconds),
      'totalRestSeconds': serializer.toJson<int?>(totalRestSeconds),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Session copyWith(
          {String? id,
          DateTime? sessionDateTime,
          Value<int?> totalDurationSeconds = const Value.absent(),
          Value<int?> totalActivitySeconds = const Value.absent(),
          Value<int?> totalRestSeconds = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Session(
        id: id ?? this.id,
        sessionDateTime: sessionDateTime ?? this.sessionDateTime,
        totalDurationSeconds: totalDurationSeconds.present
            ? totalDurationSeconds.value
            : this.totalDurationSeconds,
        totalActivitySeconds: totalActivitySeconds.present
            ? totalActivitySeconds.value
            : this.totalActivitySeconds,
        totalRestSeconds: totalRestSeconds.present
            ? totalRestSeconds.value
            : this.totalRestSeconds,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      sessionDateTime: data.sessionDateTime.present
          ? data.sessionDateTime.value
          : this.sessionDateTime,
      totalDurationSeconds: data.totalDurationSeconds.present
          ? data.totalDurationSeconds.value
          : this.totalDurationSeconds,
      totalActivitySeconds: data.totalActivitySeconds.present
          ? data.totalActivitySeconds.value
          : this.totalActivitySeconds,
      totalRestSeconds: data.totalRestSeconds.present
          ? data.totalRestSeconds.value
          : this.totalRestSeconds,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('sessionDateTime: $sessionDateTime, ')
          ..write('totalDurationSeconds: $totalDurationSeconds, ')
          ..write('totalActivitySeconds: $totalActivitySeconds, ')
          ..write('totalRestSeconds: $totalRestSeconds, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionDateTime, totalDurationSeconds,
      totalActivitySeconds, totalRestSeconds, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.sessionDateTime == this.sessionDateTime &&
          other.totalDurationSeconds == this.totalDurationSeconds &&
          other.totalActivitySeconds == this.totalActivitySeconds &&
          other.totalRestSeconds == this.totalRestSeconds &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> id;
  final Value<DateTime> sessionDateTime;
  final Value<int?> totalDurationSeconds;
  final Value<int?> totalActivitySeconds;
  final Value<int?> totalRestSeconds;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.sessionDateTime = const Value.absent(),
    this.totalDurationSeconds = const Value.absent(),
    this.totalActivitySeconds = const Value.absent(),
    this.totalRestSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String id,
    required DateTime sessionDateTime,
    this.totalDurationSeconds = const Value.absent(),
    this.totalActivitySeconds = const Value.absent(),
    this.totalRestSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionDateTime = Value(sessionDateTime),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Session> custom({
    Expression<String>? id,
    Expression<DateTime>? sessionDateTime,
    Expression<int>? totalDurationSeconds,
    Expression<int>? totalActivitySeconds,
    Expression<int>? totalRestSeconds,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionDateTime != null) 'date_time': sessionDateTime,
      if (totalDurationSeconds != null)
        'total_duration_seconds': totalDurationSeconds,
      if (totalActivitySeconds != null)
        'total_activity_seconds': totalActivitySeconds,
      if (totalRestSeconds != null) 'total_rest_seconds': totalRestSeconds,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? sessionDateTime,
      Value<int?>? totalDurationSeconds,
      Value<int?>? totalActivitySeconds,
      Value<int?>? totalRestSeconds,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SessionsCompanion(
      id: id ?? this.id,
      sessionDateTime: sessionDateTime ?? this.sessionDateTime,
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
      totalActivitySeconds: totalActivitySeconds ?? this.totalActivitySeconds,
      totalRestSeconds: totalRestSeconds ?? this.totalRestSeconds,
      notes: notes ?? this.notes,
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
    if (sessionDateTime.present) {
      map['date_time'] = Variable<DateTime>(sessionDateTime.value);
    }
    if (totalDurationSeconds.present) {
      map['total_duration_seconds'] = Variable<int>(totalDurationSeconds.value);
    }
    if (totalActivitySeconds.present) {
      map['total_activity_seconds'] = Variable<int>(totalActivitySeconds.value);
    }
    if (totalRestSeconds.present) {
      map['total_rest_seconds'] = Variable<int>(totalRestSeconds.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('sessionDateTime: $sessionDateTime, ')
          ..write('totalDurationSeconds: $totalDurationSeconds, ')
          ..write('totalActivitySeconds: $totalActivitySeconds, ')
          ..write('totalRestSeconds: $totalRestSeconds, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseInstancesTable extends ExerciseInstances
    with TableInfo<$ExerciseInstancesTable, ExerciseInstance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseInstancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _familyIdMeta =
      const VerificationMeta('familyId');
  @override
  late final GeneratedColumn<String> familyId = GeneratedColumn<String>(
      'family_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      discriminators = GeneratedColumn<String>(
              'discriminators', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $ExerciseInstancesTable.$converterdiscriminators);
  static const VerificationMeta _firstSeenAtMeta =
      const VerificationMeta('firstSeenAt');
  @override
  late final GeneratedColumn<DateTime> firstSeenAt = GeneratedColumn<DateTime>(
      'first_seen_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [slug, familyId, displayName, discriminators, firstSeenAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_instances';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseInstance> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('family_id')) {
      context.handle(_familyIdMeta,
          familyId.isAcceptableOrUnknown(data['family_id']!, _familyIdMeta));
    } else if (isInserting) {
      context.missing(_familyIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('first_seen_at')) {
      context.handle(
          _firstSeenAtMeta,
          firstSeenAt.isAcceptableOrUnknown(
              data['first_seen_at']!, _firstSeenAtMeta));
    } else if (isInserting) {
      context.missing(_firstSeenAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slug};
  @override
  ExerciseInstance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseInstance(
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      familyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}family_id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      discriminators: $ExerciseInstancesTable.$converterdiscriminators.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}discriminators'])!),
      firstSeenAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}first_seen_at'])!,
    );
  }

  @override
  $ExerciseInstancesTable createAlias(String alias) {
    return $ExerciseInstancesTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, String>, String> $converterdiscriminators =
      const DiscriminatorsConverter();
}

class ExerciseInstance extends DataClass
    implements Insertable<ExerciseInstance> {
  final String slug;
  final String familyId;
  final String displayName;
  final Map<String, String> discriminators;
  final DateTime firstSeenAt;
  const ExerciseInstance(
      {required this.slug,
      required this.familyId,
      required this.displayName,
      required this.discriminators,
      required this.firstSeenAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slug'] = Variable<String>(slug);
    map['family_id'] = Variable<String>(familyId);
    map['display_name'] = Variable<String>(displayName);
    {
      map['discriminators'] = Variable<String>($ExerciseInstancesTable
          .$converterdiscriminators
          .toSql(discriminators));
    }
    map['first_seen_at'] = Variable<DateTime>(firstSeenAt);
    return map;
  }

  ExerciseInstancesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseInstancesCompanion(
      slug: Value(slug),
      familyId: Value(familyId),
      displayName: Value(displayName),
      discriminators: Value(discriminators),
      firstSeenAt: Value(firstSeenAt),
    );
  }

  factory ExerciseInstance.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseInstance(
      slug: serializer.fromJson<String>(json['slug']),
      familyId: serializer.fromJson<String>(json['familyId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      discriminators:
          serializer.fromJson<Map<String, String>>(json['discriminators']),
      firstSeenAt: serializer.fromJson<DateTime>(json['firstSeenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slug': serializer.toJson<String>(slug),
      'familyId': serializer.toJson<String>(familyId),
      'displayName': serializer.toJson<String>(displayName),
      'discriminators': serializer.toJson<Map<String, String>>(discriminators),
      'firstSeenAt': serializer.toJson<DateTime>(firstSeenAt),
    };
  }

  ExerciseInstance copyWith(
          {String? slug,
          String? familyId,
          String? displayName,
          Map<String, String>? discriminators,
          DateTime? firstSeenAt}) =>
      ExerciseInstance(
        slug: slug ?? this.slug,
        familyId: familyId ?? this.familyId,
        displayName: displayName ?? this.displayName,
        discriminators: discriminators ?? this.discriminators,
        firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      );
  ExerciseInstance copyWithCompanion(ExerciseInstancesCompanion data) {
    return ExerciseInstance(
      slug: data.slug.present ? data.slug.value : this.slug,
      familyId: data.familyId.present ? data.familyId.value : this.familyId,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      discriminators: data.discriminators.present
          ? data.discriminators.value
          : this.discriminators,
      firstSeenAt:
          data.firstSeenAt.present ? data.firstSeenAt.value : this.firstSeenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseInstance(')
          ..write('slug: $slug, ')
          ..write('familyId: $familyId, ')
          ..write('displayName: $displayName, ')
          ..write('discriminators: $discriminators, ')
          ..write('firstSeenAt: $firstSeenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(slug, familyId, displayName, discriminators, firstSeenAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseInstance &&
          other.slug == this.slug &&
          other.familyId == this.familyId &&
          other.displayName == this.displayName &&
          other.discriminators == this.discriminators &&
          other.firstSeenAt == this.firstSeenAt);
}

class ExerciseInstancesCompanion extends UpdateCompanion<ExerciseInstance> {
  final Value<String> slug;
  final Value<String> familyId;
  final Value<String> displayName;
  final Value<Map<String, String>> discriminators;
  final Value<DateTime> firstSeenAt;
  final Value<int> rowid;
  const ExerciseInstancesCompanion({
    this.slug = const Value.absent(),
    this.familyId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.discriminators = const Value.absent(),
    this.firstSeenAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseInstancesCompanion.insert({
    required String slug,
    required String familyId,
    required String displayName,
    required Map<String, String> discriminators,
    required DateTime firstSeenAt,
    this.rowid = const Value.absent(),
  })  : slug = Value(slug),
        familyId = Value(familyId),
        displayName = Value(displayName),
        discriminators = Value(discriminators),
        firstSeenAt = Value(firstSeenAt);
  static Insertable<ExerciseInstance> custom({
    Expression<String>? slug,
    Expression<String>? familyId,
    Expression<String>? displayName,
    Expression<String>? discriminators,
    Expression<DateTime>? firstSeenAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (slug != null) 'slug': slug,
      if (familyId != null) 'family_id': familyId,
      if (displayName != null) 'display_name': displayName,
      if (discriminators != null) 'discriminators': discriminators,
      if (firstSeenAt != null) 'first_seen_at': firstSeenAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseInstancesCompanion copyWith(
      {Value<String>? slug,
      Value<String>? familyId,
      Value<String>? displayName,
      Value<Map<String, String>>? discriminators,
      Value<DateTime>? firstSeenAt,
      Value<int>? rowid}) {
    return ExerciseInstancesCompanion(
      slug: slug ?? this.slug,
      familyId: familyId ?? this.familyId,
      displayName: displayName ?? this.displayName,
      discriminators: discriminators ?? this.discriminators,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (familyId.present) {
      map['family_id'] = Variable<String>(familyId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (discriminators.present) {
      map['discriminators'] = Variable<String>($ExerciseInstancesTable
          .$converterdiscriminators
          .toSql(discriminators.value));
    }
    if (firstSeenAt.present) {
      map['first_seen_at'] = Variable<DateTime>(firstSeenAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseInstancesCompanion(')
          ..write('slug: $slug, ')
          ..write('familyId: $familyId, ')
          ..write('displayName: $displayName, ')
          ..write('discriminators: $discriminators, ')
          ..write('firstSeenAt: $firstSeenAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetEntriesTable extends SetEntries
    with TableInfo<$SetEntriesTable, SetEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sessions (id)'));
  static const VerificationMeta _exerciseSlugMeta =
      const VerificationMeta('exerciseSlug');
  @override
  late final GeneratedColumn<String> exerciseSlug = GeneratedColumn<String>(
      'exercise_slug', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES exercise_instances (slug)'));
  static const VerificationMeta _setOrderMeta =
      const VerificationMeta('setOrder');
  @override
  late final GeneratedColumn<int> setOrder = GeneratedColumn<int>(
      'set_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _setTypeMeta =
      const VerificationMeta('setType');
  @override
  late final GeneratedColumn<String> setType = GeneratedColumn<String>(
      'set_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _distanceMMeta =
      const VerificationMeta('distanceM');
  @override
  late final GeneratedColumn<int> distanceM = GeneratedColumn<int>(
      'distance_m', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
      'calories', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
      'rpe', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _metricsJsonMeta =
      const VerificationMeta('metricsJson');
  @override
  late final GeneratedColumn<String> metricsJson = GeneratedColumn<String>(
      'metrics_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _prescriptionJsonMeta =
      const VerificationMeta('prescriptionJson');
  @override
  late final GeneratedColumn<String> prescriptionJson = GeneratedColumn<String>(
      'prescription_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionId,
        exerciseSlug,
        setOrder,
        weight,
        reps,
        setType,
        durationSeconds,
        distanceM,
        calories,
        rpe,
        metricsJson,
        prescriptionJson,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'set_entries';
  @override
  VerificationContext validateIntegrity(Insertable<SetEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_slug')) {
      context.handle(
          _exerciseSlugMeta,
          exerciseSlug.isAcceptableOrUnknown(
              data['exercise_slug']!, _exerciseSlugMeta));
    } else if (isInserting) {
      context.missing(_exerciseSlugMeta);
    }
    if (data.containsKey('set_order')) {
      context.handle(_setOrderMeta,
          setOrder.isAcceptableOrUnknown(data['set_order']!, _setOrderMeta));
    } else if (isInserting) {
      context.missing(_setOrderMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('set_type')) {
      context.handle(_setTypeMeta,
          setType.isAcceptableOrUnknown(data['set_type']!, _setTypeMeta));
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    }
    if (data.containsKey('distance_m')) {
      context.handle(_distanceMMeta,
          distanceM.isAcceptableOrUnknown(data['distance_m']!, _distanceMMeta));
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    }
    if (data.containsKey('rpe')) {
      context.handle(
          _rpeMeta, rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta));
    }
    if (data.containsKey('metrics_json')) {
      context.handle(
          _metricsJsonMeta,
          metricsJson.isAcceptableOrUnknown(
              data['metrics_json']!, _metricsJsonMeta));
    }
    if (data.containsKey('prescription_json')) {
      context.handle(
          _prescriptionJsonMeta,
          prescriptionJson.isAcceptableOrUnknown(
              data['prescription_json']!, _prescriptionJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      exerciseSlug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_slug'])!,
      setOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_order'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
      setType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}set_type']),
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds']),
      distanceM: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}distance_m']),
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calories']),
      rpe: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rpe']),
      metricsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metrics_json']),
      prescriptionJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}prescription_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SetEntriesTable createAlias(String alias) {
    return $SetEntriesTable(attachedDatabase, alias);
  }
}

class SetEntry extends DataClass implements Insertable<SetEntry> {
  final String id;
  final String sessionId;
  final String exerciseSlug;
  final int setOrder;
  final double weight;
  final int reps;
  final String? setType;
  final int? durationSeconds;
  final int? distanceM;
  final int? calories;
  final double? rpe;
  final String? metricsJson;
  final String? prescriptionJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SetEntry(
      {required this.id,
      required this.sessionId,
      required this.exerciseSlug,
      required this.setOrder,
      required this.weight,
      required this.reps,
      this.setType,
      this.durationSeconds,
      this.distanceM,
      this.calories,
      this.rpe,
      this.metricsJson,
      this.prescriptionJson,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['exercise_slug'] = Variable<String>(exerciseSlug);
    map['set_order'] = Variable<int>(setOrder);
    map['weight'] = Variable<double>(weight);
    map['reps'] = Variable<int>(reps);
    if (!nullToAbsent || setType != null) {
      map['set_type'] = Variable<String>(setType);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || distanceM != null) {
      map['distance_m'] = Variable<int>(distanceM);
    }
    if (!nullToAbsent || calories != null) {
      map['calories'] = Variable<int>(calories);
    }
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<double>(rpe);
    }
    if (!nullToAbsent || metricsJson != null) {
      map['metrics_json'] = Variable<String>(metricsJson);
    }
    if (!nullToAbsent || prescriptionJson != null) {
      map['prescription_json'] = Variable<String>(prescriptionJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SetEntriesCompanion toCompanion(bool nullToAbsent) {
    return SetEntriesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseSlug: Value(exerciseSlug),
      setOrder: Value(setOrder),
      weight: Value(weight),
      reps: Value(reps),
      setType: setType == null && nullToAbsent
          ? const Value.absent()
          : Value(setType),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      distanceM: distanceM == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceM),
      calories: calories == null && nullToAbsent
          ? const Value.absent()
          : Value(calories),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
      metricsJson: metricsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metricsJson),
      prescriptionJson: prescriptionJson == null && nullToAbsent
          ? const Value.absent()
          : Value(prescriptionJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SetEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetEntry(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      exerciseSlug: serializer.fromJson<String>(json['exerciseSlug']),
      setOrder: serializer.fromJson<int>(json['setOrder']),
      weight: serializer.fromJson<double>(json['weight']),
      reps: serializer.fromJson<int>(json['reps']),
      setType: serializer.fromJson<String?>(json['setType']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      distanceM: serializer.fromJson<int?>(json['distanceM']),
      calories: serializer.fromJson<int?>(json['calories']),
      rpe: serializer.fromJson<double?>(json['rpe']),
      metricsJson: serializer.fromJson<String?>(json['metricsJson']),
      prescriptionJson: serializer.fromJson<String?>(json['prescriptionJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'exerciseSlug': serializer.toJson<String>(exerciseSlug),
      'setOrder': serializer.toJson<int>(setOrder),
      'weight': serializer.toJson<double>(weight),
      'reps': serializer.toJson<int>(reps),
      'setType': serializer.toJson<String?>(setType),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'distanceM': serializer.toJson<int?>(distanceM),
      'calories': serializer.toJson<int?>(calories),
      'rpe': serializer.toJson<double?>(rpe),
      'metricsJson': serializer.toJson<String?>(metricsJson),
      'prescriptionJson': serializer.toJson<String?>(prescriptionJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SetEntry copyWith(
          {String? id,
          String? sessionId,
          String? exerciseSlug,
          int? setOrder,
          double? weight,
          int? reps,
          Value<String?> setType = const Value.absent(),
          Value<int?> durationSeconds = const Value.absent(),
          Value<int?> distanceM = const Value.absent(),
          Value<int?> calories = const Value.absent(),
          Value<double?> rpe = const Value.absent(),
          Value<String?> metricsJson = const Value.absent(),
          Value<String?> prescriptionJson = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      SetEntry(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        exerciseSlug: exerciseSlug ?? this.exerciseSlug,
        setOrder: setOrder ?? this.setOrder,
        weight: weight ?? this.weight,
        reps: reps ?? this.reps,
        setType: setType.present ? setType.value : this.setType,
        durationSeconds: durationSeconds.present
            ? durationSeconds.value
            : this.durationSeconds,
        distanceM: distanceM.present ? distanceM.value : this.distanceM,
        calories: calories.present ? calories.value : this.calories,
        rpe: rpe.present ? rpe.value : this.rpe,
        metricsJson: metricsJson.present ? metricsJson.value : this.metricsJson,
        prescriptionJson: prescriptionJson.present
            ? prescriptionJson.value
            : this.prescriptionJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SetEntry copyWithCompanion(SetEntriesCompanion data) {
    return SetEntry(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseSlug: data.exerciseSlug.present
          ? data.exerciseSlug.value
          : this.exerciseSlug,
      setOrder: data.setOrder.present ? data.setOrder.value : this.setOrder,
      weight: data.weight.present ? data.weight.value : this.weight,
      reps: data.reps.present ? data.reps.value : this.reps,
      setType: data.setType.present ? data.setType.value : this.setType,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      distanceM: data.distanceM.present ? data.distanceM.value : this.distanceM,
      calories: data.calories.present ? data.calories.value : this.calories,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
      metricsJson:
          data.metricsJson.present ? data.metricsJson.value : this.metricsJson,
      prescriptionJson: data.prescriptionJson.present
          ? data.prescriptionJson.value
          : this.prescriptionJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetEntry(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseSlug: $exerciseSlug, ')
          ..write('setOrder: $setOrder, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps, ')
          ..write('setType: $setType, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('distanceM: $distanceM, ')
          ..write('calories: $calories, ')
          ..write('rpe: $rpe, ')
          ..write('metricsJson: $metricsJson, ')
          ..write('prescriptionJson: $prescriptionJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      sessionId,
      exerciseSlug,
      setOrder,
      weight,
      reps,
      setType,
      durationSeconds,
      distanceM,
      calories,
      rpe,
      metricsJson,
      prescriptionJson,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetEntry &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseSlug == this.exerciseSlug &&
          other.setOrder == this.setOrder &&
          other.weight == this.weight &&
          other.reps == this.reps &&
          other.setType == this.setType &&
          other.durationSeconds == this.durationSeconds &&
          other.distanceM == this.distanceM &&
          other.calories == this.calories &&
          other.rpe == this.rpe &&
          other.metricsJson == this.metricsJson &&
          other.prescriptionJson == this.prescriptionJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SetEntriesCompanion extends UpdateCompanion<SetEntry> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> exerciseSlug;
  final Value<int> setOrder;
  final Value<double> weight;
  final Value<int> reps;
  final Value<String?> setType;
  final Value<int?> durationSeconds;
  final Value<int?> distanceM;
  final Value<int?> calories;
  final Value<double?> rpe;
  final Value<String?> metricsJson;
  final Value<String?> prescriptionJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SetEntriesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseSlug = const Value.absent(),
    this.setOrder = const Value.absent(),
    this.weight = const Value.absent(),
    this.reps = const Value.absent(),
    this.setType = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.calories = const Value.absent(),
    this.rpe = const Value.absent(),
    this.metricsJson = const Value.absent(),
    this.prescriptionJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetEntriesCompanion.insert({
    required String id,
    required String sessionId,
    required String exerciseSlug,
    required int setOrder,
    required double weight,
    required int reps,
    this.setType = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.distanceM = const Value.absent(),
    this.calories = const Value.absent(),
    this.rpe = const Value.absent(),
    this.metricsJson = const Value.absent(),
    this.prescriptionJson = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        exerciseSlug = Value(exerciseSlug),
        setOrder = Value(setOrder),
        weight = Value(weight),
        reps = Value(reps),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SetEntry> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? exerciseSlug,
    Expression<int>? setOrder,
    Expression<double>? weight,
    Expression<int>? reps,
    Expression<String>? setType,
    Expression<int>? durationSeconds,
    Expression<int>? distanceM,
    Expression<int>? calories,
    Expression<double>? rpe,
    Expression<String>? metricsJson,
    Expression<String>? prescriptionJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseSlug != null) 'exercise_slug': exerciseSlug,
      if (setOrder != null) 'set_order': setOrder,
      if (weight != null) 'weight': weight,
      if (reps != null) 'reps': reps,
      if (setType != null) 'set_type': setType,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (distanceM != null) 'distance_m': distanceM,
      if (calories != null) 'calories': calories,
      if (rpe != null) 'rpe': rpe,
      if (metricsJson != null) 'metrics_json': metricsJson,
      if (prescriptionJson != null) 'prescription_json': prescriptionJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String>? exerciseSlug,
      Value<int>? setOrder,
      Value<double>? weight,
      Value<int>? reps,
      Value<String?>? setType,
      Value<int?>? durationSeconds,
      Value<int?>? distanceM,
      Value<int?>? calories,
      Value<double?>? rpe,
      Value<String?>? metricsJson,
      Value<String?>? prescriptionJson,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SetEntriesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseSlug: exerciseSlug ?? this.exerciseSlug,
      setOrder: setOrder ?? this.setOrder,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      setType: setType ?? this.setType,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      distanceM: distanceM ?? this.distanceM,
      calories: calories ?? this.calories,
      rpe: rpe ?? this.rpe,
      metricsJson: metricsJson ?? this.metricsJson,
      prescriptionJson: prescriptionJson ?? this.prescriptionJson,
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
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (exerciseSlug.present) {
      map['exercise_slug'] = Variable<String>(exerciseSlug.value);
    }
    if (setOrder.present) {
      map['set_order'] = Variable<int>(setOrder.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (setType.present) {
      map['set_type'] = Variable<String>(setType.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (distanceM.present) {
      map['distance_m'] = Variable<int>(distanceM.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (rpe.present) {
      map['rpe'] = Variable<double>(rpe.value);
    }
    if (metricsJson.present) {
      map['metrics_json'] = Variable<String>(metricsJson.value);
    }
    if (prescriptionJson.present) {
      map['prescription_json'] = Variable<String>(prescriptionJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetEntriesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseSlug: $exerciseSlug, ')
          ..write('setOrder: $setOrder, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps, ')
          ..write('setType: $setType, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('distanceM: $distanceM, ')
          ..write('calories: $calories, ')
          ..write('rpe: $rpe, ')
          ..write('metricsJson: $metricsJson, ')
          ..write('prescriptionJson: $prescriptionJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedWarmupsTable extends SavedWarmups
    with TableInfo<$SavedWarmupsTable, SavedWarmup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedWarmupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
      'session_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sessions (id)'));
  static const VerificationMeta _warmupIdMeta =
      const VerificationMeta('warmupId');
  @override
  late final GeneratedColumn<String> warmupId = GeneratedColumn<String>(
      'warmup_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
      parameters = GeneratedColumn<String>('parameters', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Map<String, String>>(
              $SavedWarmupsTable.$converterparameters);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sessionId, warmupId, displayName, parameters, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_warmups';
  @override
  VerificationContext validateIntegrity(Insertable<SavedWarmup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('warmup_id')) {
      context.handle(_warmupIdMeta,
          warmupId.isAcceptableOrUnknown(data['warmup_id']!, _warmupIdMeta));
    } else if (isInserting) {
      context.missing(_warmupIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedWarmup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedWarmup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_id'])!,
      warmupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warmup_id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      parameters: $SavedWarmupsTable.$converterparameters.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}parameters'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SavedWarmupsTable createAlias(String alias) {
    return $SavedWarmupsTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, String>, String> $converterparameters =
      const DiscriminatorsConverter();
}

class SavedWarmup extends DataClass implements Insertable<SavedWarmup> {
  final String id;
  final String sessionId;
  final String warmupId;
  final String displayName;
  final Map<String, String> parameters;
  final DateTime createdAt;
  const SavedWarmup(
      {required this.id,
      required this.sessionId,
      required this.warmupId,
      required this.displayName,
      required this.parameters,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['warmup_id'] = Variable<String>(warmupId);
    map['display_name'] = Variable<String>(displayName);
    {
      map['parameters'] = Variable<String>(
          $SavedWarmupsTable.$converterparameters.toSql(parameters));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SavedWarmupsCompanion toCompanion(bool nullToAbsent) {
    return SavedWarmupsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      warmupId: Value(warmupId),
      displayName: Value(displayName),
      parameters: Value(parameters),
      createdAt: Value(createdAt),
    );
  }

  factory SavedWarmup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedWarmup(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      warmupId: serializer.fromJson<String>(json['warmupId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      parameters: serializer.fromJson<Map<String, String>>(json['parameters']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'warmupId': serializer.toJson<String>(warmupId),
      'displayName': serializer.toJson<String>(displayName),
      'parameters': serializer.toJson<Map<String, String>>(parameters),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SavedWarmup copyWith(
          {String? id,
          String? sessionId,
          String? warmupId,
          String? displayName,
          Map<String, String>? parameters,
          DateTime? createdAt}) =>
      SavedWarmup(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        warmupId: warmupId ?? this.warmupId,
        displayName: displayName ?? this.displayName,
        parameters: parameters ?? this.parameters,
        createdAt: createdAt ?? this.createdAt,
      );
  SavedWarmup copyWithCompanion(SavedWarmupsCompanion data) {
    return SavedWarmup(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      warmupId: data.warmupId.present ? data.warmupId.value : this.warmupId,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      parameters:
          data.parameters.present ? data.parameters.value : this.parameters,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedWarmup(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('warmupId: $warmupId, ')
          ..write('displayName: $displayName, ')
          ..write('parameters: $parameters, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, warmupId, displayName, parameters, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedWarmup &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.warmupId == this.warmupId &&
          other.displayName == this.displayName &&
          other.parameters == this.parameters &&
          other.createdAt == this.createdAt);
}

class SavedWarmupsCompanion extends UpdateCompanion<SavedWarmup> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> warmupId;
  final Value<String> displayName;
  final Value<Map<String, String>> parameters;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SavedWarmupsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.warmupId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.parameters = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedWarmupsCompanion.insert({
    required String id,
    required String sessionId,
    required String warmupId,
    required String displayName,
    required Map<String, String> parameters,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sessionId = Value(sessionId),
        warmupId = Value(warmupId),
        displayName = Value(displayName),
        parameters = Value(parameters),
        createdAt = Value(createdAt);
  static Insertable<SavedWarmup> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? warmupId,
    Expression<String>? displayName,
    Expression<String>? parameters,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (warmupId != null) 'warmup_id': warmupId,
      if (displayName != null) 'display_name': displayName,
      if (parameters != null) 'parameters': parameters,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedWarmupsCompanion copyWith(
      {Value<String>? id,
      Value<String>? sessionId,
      Value<String>? warmupId,
      Value<String>? displayName,
      Value<Map<String, String>>? parameters,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SavedWarmupsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      warmupId: warmupId ?? this.warmupId,
      displayName: displayName ?? this.displayName,
      parameters: parameters ?? this.parameters,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (warmupId.present) {
      map['warmup_id'] = Variable<String>(warmupId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (parameters.present) {
      map['parameters'] = Variable<String>(
          $SavedWarmupsTable.$converterparameters.toSql(parameters.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedWarmupsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('warmupId: $warmupId, ')
          ..write('displayName: $displayName, ')
          ..write('parameters: $parameters, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $ExerciseInstancesTable exerciseInstances =
      $ExerciseInstancesTable(this);
  late final $SetEntriesTable setEntries = $SetEntriesTable(this);
  late final $SavedWarmupsTable savedWarmups = $SavedWarmupsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [sessions, exerciseInstances, setEntries, savedWarmups];
}

typedef $$SessionsTableCreateCompanionBuilder = SessionsCompanion Function({
  required String id,
  required DateTime sessionDateTime,
  Value<int?> totalDurationSeconds,
  Value<int?> totalActivitySeconds,
  Value<int?> totalRestSeconds,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SessionsTableUpdateCompanionBuilder = SessionsCompanion Function({
  Value<String> id,
  Value<DateTime> sessionDateTime,
  Value<int?> totalDurationSeconds,
  Value<int?> totalActivitySeconds,
  Value<int?> totalRestSeconds,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SetEntriesTable, List<SetEntry>>
      _setEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.setEntries,
          aliasName:
              $_aliasNameGenerator(db.sessions.id, db.setEntries.sessionId));

  $$SetEntriesTableProcessedTableManager get setEntriesRefs {
    final manager = $$SetEntriesTableTableManager($_db, $_db.setEntries)
        .filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_setEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SavedWarmupsTable, List<SavedWarmup>>
      _savedWarmupsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.savedWarmups,
          aliasName:
              $_aliasNameGenerator(db.sessions.id, db.savedWarmups.sessionId));

  $$SavedWarmupsTableProcessedTableManager get savedWarmupsRefs {
    final manager = $$SavedWarmupsTableTableManager($_db, $_db.savedWarmups)
        .filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_savedWarmupsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sessionDateTime => $composableBuilder(
      column: $table.sessionDateTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalDurationSeconds => $composableBuilder(
      column: $table.totalDurationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalActivitySeconds => $composableBuilder(
      column: $table.totalActivitySeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalRestSeconds => $composableBuilder(
      column: $table.totalRestSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> setEntriesRefs(
      Expression<bool> Function($$SetEntriesTableFilterComposer f) f) {
    final $$SetEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.setEntries,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetEntriesTableFilterComposer(
              $db: $db,
              $table: $db.setEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> savedWarmupsRefs(
      Expression<bool> Function($$SavedWarmupsTableFilterComposer f) f) {
    final $$SavedWarmupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savedWarmups,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedWarmupsTableFilterComposer(
              $db: $db,
              $table: $db.savedWarmups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sessionDateTime => $composableBuilder(
      column: $table.sessionDateTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalDurationSeconds => $composableBuilder(
      column: $table.totalDurationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalActivitySeconds => $composableBuilder(
      column: $table.totalActivitySeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalRestSeconds => $composableBuilder(
      column: $table.totalRestSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get sessionDateTime => $composableBuilder(
      column: $table.sessionDateTime, builder: (column) => column);

  GeneratedColumn<int> get totalDurationSeconds => $composableBuilder(
      column: $table.totalDurationSeconds, builder: (column) => column);

  GeneratedColumn<int> get totalActivitySeconds => $composableBuilder(
      column: $table.totalActivitySeconds, builder: (column) => column);

  GeneratedColumn<int> get totalRestSeconds => $composableBuilder(
      column: $table.totalRestSeconds, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> setEntriesRefs<T extends Object>(
      Expression<T> Function($$SetEntriesTableAnnotationComposer a) f) {
    final $$SetEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.setEntries,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.setEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> savedWarmupsRefs<T extends Object>(
      Expression<T> Function($$SavedWarmupsTableAnnotationComposer a) f) {
    final $$SavedWarmupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.savedWarmups,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SavedWarmupsTableAnnotationComposer(
              $db: $db,
              $table: $db.savedWarmups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SessionsTable,
    Session,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableAnnotationComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder,
    (Session, $$SessionsTableReferences),
    Session,
    PrefetchHooks Function({bool setEntriesRefs, bool savedWarmupsRefs})> {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> sessionDateTime = const Value.absent(),
            Value<int?> totalDurationSeconds = const Value.absent(),
            Value<int?> totalActivitySeconds = const Value.absent(),
            Value<int?> totalRestSeconds = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionsCompanion(
            id: id,
            sessionDateTime: sessionDateTime,
            totalDurationSeconds: totalDurationSeconds,
            totalActivitySeconds: totalActivitySeconds,
            totalRestSeconds: totalRestSeconds,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime sessionDateTime,
            Value<int?> totalDurationSeconds = const Value.absent(),
            Value<int?> totalActivitySeconds = const Value.absent(),
            Value<int?> totalRestSeconds = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionsCompanion.insert(
            id: id,
            sessionDateTime: sessionDateTime,
            totalDurationSeconds: totalDurationSeconds,
            totalActivitySeconds: totalActivitySeconds,
            totalRestSeconds: totalRestSeconds,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SessionsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {setEntriesRefs = false, savedWarmupsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (setEntriesRefs) db.setEntries,
                if (savedWarmupsRefs) db.savedWarmups
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (setEntriesRefs)
                    await $_getPrefetchedData<Session, $SessionsTable,
                            SetEntry>(
                        currentTable: table,
                        referencedTable:
                            $$SessionsTableReferences._setEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SessionsTableReferences(db, table, p0)
                                .setEntriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sessionId == item.id),
                        typedResults: items),
                  if (savedWarmupsRefs)
                    await $_getPrefetchedData<Session, $SessionsTable,
                            SavedWarmup>(
                        currentTable: table,
                        referencedTable: $$SessionsTableReferences
                            ._savedWarmupsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SessionsTableReferences(db, table, p0)
                                .savedWarmupsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SessionsTable,
    Session,
    $$SessionsTableFilterComposer,
    $$SessionsTableOrderingComposer,
    $$SessionsTableAnnotationComposer,
    $$SessionsTableCreateCompanionBuilder,
    $$SessionsTableUpdateCompanionBuilder,
    (Session, $$SessionsTableReferences),
    Session,
    PrefetchHooks Function({bool setEntriesRefs, bool savedWarmupsRefs})>;
typedef $$ExerciseInstancesTableCreateCompanionBuilder
    = ExerciseInstancesCompanion Function({
  required String slug,
  required String familyId,
  required String displayName,
  required Map<String, String> discriminators,
  required DateTime firstSeenAt,
  Value<int> rowid,
});
typedef $$ExerciseInstancesTableUpdateCompanionBuilder
    = ExerciseInstancesCompanion Function({
  Value<String> slug,
  Value<String> familyId,
  Value<String> displayName,
  Value<Map<String, String>> discriminators,
  Value<DateTime> firstSeenAt,
  Value<int> rowid,
});

final class $$ExerciseInstancesTableReferences extends BaseReferences<
    _$AppDatabase, $ExerciseInstancesTable, ExerciseInstance> {
  $$ExerciseInstancesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SetEntriesTable, List<SetEntry>>
      _setEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.setEntries,
              aliasName: $_aliasNameGenerator(
                  db.exerciseInstances.slug, db.setEntries.exerciseSlug));

  $$SetEntriesTableProcessedTableManager get setEntriesRefs {
    final manager = $$SetEntriesTableTableManager($_db, $_db.setEntries).filter(
        (f) => f.exerciseSlug.slug.sqlEquals($_itemColumn<String>('slug')!));

    final cache = $_typedResult.readTableOrNull(_setEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExerciseInstancesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseInstancesTable> {
  $$ExerciseInstancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get familyId => $composableBuilder(
      column: $table.familyId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get discriminators => $composableBuilder(
          column: $table.discriminators,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get firstSeenAt => $composableBuilder(
      column: $table.firstSeenAt, builder: (column) => ColumnFilters(column));

  Expression<bool> setEntriesRefs(
      Expression<bool> Function($$SetEntriesTableFilterComposer f) f) {
    final $$SetEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.slug,
        referencedTable: $db.setEntries,
        getReferencedColumn: (t) => t.exerciseSlug,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetEntriesTableFilterComposer(
              $db: $db,
              $table: $db.setEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExerciseInstancesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseInstancesTable> {
  $$ExerciseInstancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get familyId => $composableBuilder(
      column: $table.familyId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get discriminators => $composableBuilder(
      column: $table.discriminators,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get firstSeenAt => $composableBuilder(
      column: $table.firstSeenAt, builder: (column) => ColumnOrderings(column));
}

class $$ExerciseInstancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseInstancesTable> {
  $$ExerciseInstancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get familyId =>
      $composableBuilder(column: $table.familyId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
      get discriminators => $composableBuilder(
          column: $table.discriminators, builder: (column) => column);

  GeneratedColumn<DateTime> get firstSeenAt => $composableBuilder(
      column: $table.firstSeenAt, builder: (column) => column);

  Expression<T> setEntriesRefs<T extends Object>(
      Expression<T> Function($$SetEntriesTableAnnotationComposer a) f) {
    final $$SetEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.slug,
        referencedTable: $db.setEntries,
        getReferencedColumn: (t) => t.exerciseSlug,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SetEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.setEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExerciseInstancesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseInstancesTable,
    ExerciseInstance,
    $$ExerciseInstancesTableFilterComposer,
    $$ExerciseInstancesTableOrderingComposer,
    $$ExerciseInstancesTableAnnotationComposer,
    $$ExerciseInstancesTableCreateCompanionBuilder,
    $$ExerciseInstancesTableUpdateCompanionBuilder,
    (ExerciseInstance, $$ExerciseInstancesTableReferences),
    ExerciseInstance,
    PrefetchHooks Function({bool setEntriesRefs})> {
  $$ExerciseInstancesTableTableManager(
      _$AppDatabase db, $ExerciseInstancesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseInstancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseInstancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseInstancesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> slug = const Value.absent(),
            Value<String> familyId = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<Map<String, String>> discriminators = const Value.absent(),
            Value<DateTime> firstSeenAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExerciseInstancesCompanion(
            slug: slug,
            familyId: familyId,
            displayName: displayName,
            discriminators: discriminators,
            firstSeenAt: firstSeenAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String slug,
            required String familyId,
            required String displayName,
            required Map<String, String> discriminators,
            required DateTime firstSeenAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExerciseInstancesCompanion.insert(
            slug: slug,
            familyId: familyId,
            displayName: displayName,
            discriminators: discriminators,
            firstSeenAt: firstSeenAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExerciseInstancesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({setEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (setEntriesRefs) db.setEntries],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (setEntriesRefs)
                    await $_getPrefetchedData<ExerciseInstance,
                            $ExerciseInstancesTable, SetEntry>(
                        currentTable: table,
                        referencedTable: $$ExerciseInstancesTableReferences
                            ._setEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExerciseInstancesTableReferences(db, table, p0)
                                .setEntriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.exerciseSlug == item.slug),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExerciseInstancesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExerciseInstancesTable,
    ExerciseInstance,
    $$ExerciseInstancesTableFilterComposer,
    $$ExerciseInstancesTableOrderingComposer,
    $$ExerciseInstancesTableAnnotationComposer,
    $$ExerciseInstancesTableCreateCompanionBuilder,
    $$ExerciseInstancesTableUpdateCompanionBuilder,
    (ExerciseInstance, $$ExerciseInstancesTableReferences),
    ExerciseInstance,
    PrefetchHooks Function({bool setEntriesRefs})>;
typedef $$SetEntriesTableCreateCompanionBuilder = SetEntriesCompanion Function({
  required String id,
  required String sessionId,
  required String exerciseSlug,
  required int setOrder,
  required double weight,
  required int reps,
  Value<String?> setType,
  Value<int?> durationSeconds,
  Value<int?> distanceM,
  Value<int?> calories,
  Value<double?> rpe,
  Value<String?> metricsJson,
  Value<String?> prescriptionJson,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SetEntriesTableUpdateCompanionBuilder = SetEntriesCompanion Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> exerciseSlug,
  Value<int> setOrder,
  Value<double> weight,
  Value<int> reps,
  Value<String?> setType,
  Value<int?> durationSeconds,
  Value<int?> distanceM,
  Value<int?> calories,
  Value<double?> rpe,
  Value<String?> metricsJson,
  Value<String?> prescriptionJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$SetEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $SetEntriesTable, SetEntry> {
  $$SetEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
          $_aliasNameGenerator(db.setEntries.sessionId, db.sessions.id));

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager($_db, $_db.sessions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ExerciseInstancesTable _exerciseSlugTable(_$AppDatabase db) =>
      db.exerciseInstances.createAlias($_aliasNameGenerator(
          db.setEntries.exerciseSlug, db.exerciseInstances.slug));

  $$ExerciseInstancesTableProcessedTableManager get exerciseSlug {
    final $_column = $_itemColumn<String>('exercise_slug')!;

    final manager =
        $$ExerciseInstancesTableTableManager($_db, $_db.exerciseInstances)
            .filter((f) => f.slug.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseSlugTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SetEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SetEntriesTable> {
  $$SetEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get setOrder => $composableBuilder(
      column: $table.setOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get setType => $composableBuilder(
      column: $table.setType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get distanceM => $composableBuilder(
      column: $table.distanceM, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rpe => $composableBuilder(
      column: $table.rpe, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metricsJson => $composableBuilder(
      column: $table.metricsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prescriptionJson => $composableBuilder(
      column: $table.prescriptionJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableFilterComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExerciseInstancesTableFilterComposer get exerciseSlug {
    final $$ExerciseInstancesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseSlug,
        referencedTable: $db.exerciseInstances,
        getReferencedColumn: (t) => t.slug,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseInstancesTableFilterComposer(
              $db: $db,
              $table: $db.exerciseInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SetEntriesTable> {
  $$SetEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setOrder => $composableBuilder(
      column: $table.setOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get setType => $composableBuilder(
      column: $table.setType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get distanceM => $composableBuilder(
      column: $table.distanceM, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rpe => $composableBuilder(
      column: $table.rpe, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metricsJson => $composableBuilder(
      column: $table.metricsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prescriptionJson => $composableBuilder(
      column: $table.prescriptionJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableOrderingComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExerciseInstancesTableOrderingComposer get exerciseSlug {
    final $$ExerciseInstancesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseSlug,
        referencedTable: $db.exerciseInstances,
        getReferencedColumn: (t) => t.slug,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExerciseInstancesTableOrderingComposer(
              $db: $db,
              $table: $db.exerciseInstances,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SetEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetEntriesTable> {
  $$SetEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get setOrder =>
      $composableBuilder(column: $table.setOrder, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<String> get setType =>
      $composableBuilder(column: $table.setType, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<int> get distanceM =>
      $composableBuilder(column: $table.distanceM, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);

  GeneratedColumn<String> get metricsJson => $composableBuilder(
      column: $table.metricsJson, builder: (column) => column);

  GeneratedColumn<String> get prescriptionJson => $composableBuilder(
      column: $table.prescriptionJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ExerciseInstancesTableAnnotationComposer get exerciseSlug {
    final $$ExerciseInstancesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.exerciseSlug,
            referencedTable: $db.exerciseInstances,
            getReferencedColumn: (t) => t.slug,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ExerciseInstancesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.exerciseInstances,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$SetEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SetEntriesTable,
    SetEntry,
    $$SetEntriesTableFilterComposer,
    $$SetEntriesTableOrderingComposer,
    $$SetEntriesTableAnnotationComposer,
    $$SetEntriesTableCreateCompanionBuilder,
    $$SetEntriesTableUpdateCompanionBuilder,
    (SetEntry, $$SetEntriesTableReferences),
    SetEntry,
    PrefetchHooks Function({bool sessionId, bool exerciseSlug})> {
  $$SetEntriesTableTableManager(_$AppDatabase db, $SetEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<String> exerciseSlug = const Value.absent(),
            Value<int> setOrder = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<String?> setType = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<int?> distanceM = const Value.absent(),
            Value<int?> calories = const Value.absent(),
            Value<double?> rpe = const Value.absent(),
            Value<String?> metricsJson = const Value.absent(),
            Value<String?> prescriptionJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SetEntriesCompanion(
            id: id,
            sessionId: sessionId,
            exerciseSlug: exerciseSlug,
            setOrder: setOrder,
            weight: weight,
            reps: reps,
            setType: setType,
            durationSeconds: durationSeconds,
            distanceM: distanceM,
            calories: calories,
            rpe: rpe,
            metricsJson: metricsJson,
            prescriptionJson: prescriptionJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            required String exerciseSlug,
            required int setOrder,
            required double weight,
            required int reps,
            Value<String?> setType = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<int?> distanceM = const Value.absent(),
            Value<int?> calories = const Value.absent(),
            Value<double?> rpe = const Value.absent(),
            Value<String?> metricsJson = const Value.absent(),
            Value<String?> prescriptionJson = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SetEntriesCompanion.insert(
            id: id,
            sessionId: sessionId,
            exerciseSlug: exerciseSlug,
            setOrder: setOrder,
            weight: weight,
            reps: reps,
            setType: setType,
            durationSeconds: durationSeconds,
            distanceM: distanceM,
            calories: calories,
            rpe: rpe,
            metricsJson: metricsJson,
            prescriptionJson: prescriptionJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SetEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sessionId = false, exerciseSlug = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (sessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sessionId,
                    referencedTable:
                        $$SetEntriesTableReferences._sessionIdTable(db),
                    referencedColumn:
                        $$SetEntriesTableReferences._sessionIdTable(db).id,
                  ) as T;
                }
                if (exerciseSlug) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.exerciseSlug,
                    referencedTable:
                        $$SetEntriesTableReferences._exerciseSlugTable(db),
                    referencedColumn:
                        $$SetEntriesTableReferences._exerciseSlugTable(db).slug,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SetEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SetEntriesTable,
    SetEntry,
    $$SetEntriesTableFilterComposer,
    $$SetEntriesTableOrderingComposer,
    $$SetEntriesTableAnnotationComposer,
    $$SetEntriesTableCreateCompanionBuilder,
    $$SetEntriesTableUpdateCompanionBuilder,
    (SetEntry, $$SetEntriesTableReferences),
    SetEntry,
    PrefetchHooks Function({bool sessionId, bool exerciseSlug})>;
typedef $$SavedWarmupsTableCreateCompanionBuilder = SavedWarmupsCompanion
    Function({
  required String id,
  required String sessionId,
  required String warmupId,
  required String displayName,
  required Map<String, String> parameters,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SavedWarmupsTableUpdateCompanionBuilder = SavedWarmupsCompanion
    Function({
  Value<String> id,
  Value<String> sessionId,
  Value<String> warmupId,
  Value<String> displayName,
  Value<Map<String, String>> parameters,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$SavedWarmupsTableReferences
    extends BaseReferences<_$AppDatabase, $SavedWarmupsTable, SavedWarmup> {
  $$SavedWarmupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
          $_aliasNameGenerator(db.savedWarmups.sessionId, db.sessions.id));

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager($_db, $_db.sessions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SavedWarmupsTableFilterComposer
    extends Composer<_$AppDatabase, $SavedWarmupsTable> {
  $$SavedWarmupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warmupId => $composableBuilder(
      column: $table.warmupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Map<String, String>, Map<String, String>,
          String>
      get parameters => $composableBuilder(
          column: $table.parameters,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableFilterComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedWarmupsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedWarmupsTable> {
  $$SavedWarmupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warmupId => $composableBuilder(
      column: $table.warmupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parameters => $composableBuilder(
      column: $table.parameters, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableOrderingComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedWarmupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedWarmupsTable> {
  $$SavedWarmupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get warmupId =>
      $composableBuilder(column: $table.warmupId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String>
      get parameters => $composableBuilder(
          column: $table.parameters, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.sessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SessionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SavedWarmupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavedWarmupsTable,
    SavedWarmup,
    $$SavedWarmupsTableFilterComposer,
    $$SavedWarmupsTableOrderingComposer,
    $$SavedWarmupsTableAnnotationComposer,
    $$SavedWarmupsTableCreateCompanionBuilder,
    $$SavedWarmupsTableUpdateCompanionBuilder,
    (SavedWarmup, $$SavedWarmupsTableReferences),
    SavedWarmup,
    PrefetchHooks Function({bool sessionId})> {
  $$SavedWarmupsTableTableManager(_$AppDatabase db, $SavedWarmupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedWarmupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedWarmupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedWarmupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sessionId = const Value.absent(),
            Value<String> warmupId = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<Map<String, String>> parameters = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SavedWarmupsCompanion(
            id: id,
            sessionId: sessionId,
            warmupId: warmupId,
            displayName: displayName,
            parameters: parameters,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sessionId,
            required String warmupId,
            required String displayName,
            required Map<String, String> parameters,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SavedWarmupsCompanion.insert(
            id: id,
            sessionId: sessionId,
            warmupId: warmupId,
            displayName: displayName,
            parameters: parameters,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SavedWarmupsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (sessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sessionId,
                    referencedTable:
                        $$SavedWarmupsTableReferences._sessionIdTable(db),
                    referencedColumn:
                        $$SavedWarmupsTableReferences._sessionIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SavedWarmupsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavedWarmupsTable,
    SavedWarmup,
    $$SavedWarmupsTableFilterComposer,
    $$SavedWarmupsTableOrderingComposer,
    $$SavedWarmupsTableAnnotationComposer,
    $$SavedWarmupsTableCreateCompanionBuilder,
    $$SavedWarmupsTableUpdateCompanionBuilder,
    (SavedWarmup, $$SavedWarmupsTableReferences),
    SavedWarmup,
    PrefetchHooks Function({bool sessionId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$ExerciseInstancesTableTableManager get exerciseInstances =>
      $$ExerciseInstancesTableTableManager(_db, _db.exerciseInstances);
  $$SetEntriesTableTableManager get setEntries =>
      $$SetEntriesTableTableManager(_db, _db.setEntries);
  $$SavedWarmupsTableTableManager get savedWarmups =>
      $$SavedWarmupsTableTableManager(_db, _db.savedWarmups);
}
