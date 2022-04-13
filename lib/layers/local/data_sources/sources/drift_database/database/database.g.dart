// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class UserTableData extends DataClass implements Insertable<UserTableData> {
  final int id;
  final String nickname;
  final String token;
  final int expiresAt;
  final String realm;
  UserTableData(
      {required this.id,
      required this.nickname,
      required this.token,
      required this.expiresAt,
      required this.realm});
  factory UserTableData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserTableData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      nickname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nickname'])!,
      token: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}token'])!,
      expiresAt: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}expires_at'])!,
      realm: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}realm'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nickname'] = Variable<String>(nickname);
    map['token'] = Variable<String>(token);
    map['expires_at'] = Variable<int>(expiresAt);
    map['realm'] = Variable<String>(realm);
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      nickname: Value(nickname),
      token: Value(token),
      expiresAt: Value(expiresAt),
      realm: Value(realm),
    );
  }

  factory UserTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableData(
      id: serializer.fromJson<int>(json['id']),
      nickname: serializer.fromJson<String>(json['nickname']),
      token: serializer.fromJson<String>(json['token']),
      expiresAt: serializer.fromJson<int>(json['expiresAt']),
      realm: serializer.fromJson<String>(json['realm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nickname': serializer.toJson<String>(nickname),
      'token': serializer.toJson<String>(token),
      'expiresAt': serializer.toJson<int>(expiresAt),
      'realm': serializer.toJson<String>(realm),
    };
  }

  UserTableData copyWith(
          {int? id,
          String? nickname,
          String? token,
          int? expiresAt,
          String? realm}) =>
      UserTableData(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        token: token ?? this.token,
        expiresAt: expiresAt ?? this.expiresAt,
        realm: realm ?? this.realm,
      );
  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('token: $token, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('realm: $realm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nickname, token, expiresAt, realm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.nickname == this.nickname &&
          other.token == this.token &&
          other.expiresAt == this.expiresAt &&
          other.realm == this.realm);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<int> id;
  final Value<String> nickname;
  final Value<String> token;
  final Value<int> expiresAt;
  final Value<String> realm;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.nickname = const Value.absent(),
    this.token = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.realm = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    required String nickname,
    required String token,
    required int expiresAt,
    required String realm,
  })  : nickname = Value(nickname),
        token = Value(token),
        expiresAt = Value(expiresAt),
        realm = Value(realm);
  static Insertable<UserTableData> custom({
    Expression<int>? id,
    Expression<String>? nickname,
    Expression<String>? token,
    Expression<int>? expiresAt,
    Expression<String>? realm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nickname != null) 'nickname': nickname,
      if (token != null) 'token': token,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (realm != null) 'realm': realm,
    });
  }

  UserTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? nickname,
      Value<String>? token,
      Value<int>? expiresAt,
      Value<String>? realm}) {
    return UserTableCompanion(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
      realm: realm ?? this.realm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<int>(expiresAt.value);
    }
    if (realm.present) {
      map['realm'] = Variable<String>(realm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('token: $token, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('realm: $realm')
          ..write(')'))
        .toString();
  }
}

class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _nicknameMeta = const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String?> nickname = GeneratedColumn<String?>(
      'nickname', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String?> token = GeneratedColumn<String?>(
      'token', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _expiresAtMeta = const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<int?> expiresAt = GeneratedColumn<int?>(
      'expires_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _realmMeta = const VerificationMeta('realm');
  @override
  late final GeneratedColumn<String?> realm = GeneratedColumn<String?>(
      'realm', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nickname, token, expiresAt, realm];
  @override
  String get aliasedName => _alias ?? 'user_table';
  @override
  String get actualTableName => 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('realm')) {
      context.handle(
          _realmMeta, realm.isAcceptableOrUnknown(data['realm']!, _realmMeta));
    } else if (isInserting) {
      context.missing(_realmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return UserTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

abstract class _$WotStatDatabase extends GeneratedDatabase {
  _$WotStatDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final WotStatDao wotStatDao = WotStatDao(this as WotStatDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userTable];
}
