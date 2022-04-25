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

class VehicleTTCTableData extends DataClass
    implements Insertable<VehicleTTCTableData> {
  final String description;
  final String image;
  final bool isPremium;
  final bool isPremiumIgr;
  final String name;
  final String nation;
  final String type;
  final int tankId;
  VehicleTTCTableData(
      {required this.description,
      required this.image,
      required this.isPremium,
      required this.isPremiumIgr,
      required this.name,
      required this.nation,
      required this.type,
      required this.tankId});
  factory VehicleTTCTableData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return VehicleTTCTableData(
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}images'])!,
      isPremium: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_premium'])!,
      isPremiumIgr: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_premium_igr'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      nation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nation'])!,
      type: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      tankId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tank_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['description'] = Variable<String>(description);
    map['images'] = Variable<String>(image);
    map['is_premium'] = Variable<bool>(isPremium);
    map['is_premium_igr'] = Variable<bool>(isPremiumIgr);
    map['name'] = Variable<String>(name);
    map['nation'] = Variable<String>(nation);
    map['type'] = Variable<String>(type);
    map['tank_id'] = Variable<int>(tankId);
    return map;
  }

  VehicleTTCTableCompanion toCompanion(bool nullToAbsent) {
    return VehicleTTCTableCompanion(
      description: Value(description),
      images: Value(image),
      isPremium: Value(isPremium),
      isPremiumIgr: Value(isPremiumIgr),
      name: Value(name),
      nation: Value(nation),
      type: Value(type),
      tankId: Value(tankId),
    );
  }

  factory VehicleTTCTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleTTCTableData(
      description: serializer.fromJson<String>(json['description']),
      image: serializer.fromJson<String>(json['images']),
      isPremium: serializer.fromJson<bool>(json['isPremium']),
      isPremiumIgr: serializer.fromJson<bool>(json['isPremiumIgr']),
      name: serializer.fromJson<String>(json['name']),
      nation: serializer.fromJson<String>(json['nation']),
      type: serializer.fromJson<String>(json['type']),
      tankId: serializer.fromJson<int>(json['tankId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'description': serializer.toJson<String>(description),
      'images': serializer.toJson<String>(image),
      'isPremium': serializer.toJson<bool>(isPremium),
      'isPremiumIgr': serializer.toJson<bool>(isPremiumIgr),
      'name': serializer.toJson<String>(name),
      'nation': serializer.toJson<String>(nation),
      'type': serializer.toJson<String>(type),
      'tankId': serializer.toJson<int>(tankId),
    };
  }

  VehicleTTCTableData copyWith(
          {String? description,
          String? images,
          bool? isPremium,
          bool? isPremiumIgr,
          String? name,
          String? nation,
          String? type,
          int? tankId}) =>
      VehicleTTCTableData(
        description: description ?? this.description,
        image: images ?? this.image,
        isPremium: isPremium ?? this.isPremium,
        isPremiumIgr: isPremiumIgr ?? this.isPremiumIgr,
        name: name ?? this.name,
        nation: nation ?? this.nation,
        type: type ?? this.type,
        tankId: tankId ?? this.tankId,
      );
  @override
  String toString() {
    return (StringBuffer('VehicleTTCTableData(')
          ..write('description: $description, ')
          ..write('images: $image, ')
          ..write('isPremium: $isPremium, ')
          ..write('isPremiumIgr: $isPremiumIgr, ')
          ..write('name: $name, ')
          ..write('nation: $nation, ')
          ..write('type: $type, ')
          ..write('tankId: $tankId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      description, image, isPremium, isPremiumIgr, name, nation, type, tankId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleTTCTableData &&
          other.description == this.description &&
          other.image == this.image &&
          other.isPremium == this.isPremium &&
          other.isPremiumIgr == this.isPremiumIgr &&
          other.name == this.name &&
          other.nation == this.nation &&
          other.type == this.type &&
          other.tankId == this.tankId);
}

class VehicleTTCTableCompanion extends UpdateCompanion<VehicleTTCTableData> {
  final Value<String> description;
  final Value<String> images;
  final Value<bool> isPremium;
  final Value<bool> isPremiumIgr;
  final Value<String> name;
  final Value<String> nation;
  final Value<String> type;
  final Value<int> tankId;
  const VehicleTTCTableCompanion({
    this.description = const Value.absent(),
    this.images = const Value.absent(),
    this.isPremium = const Value.absent(),
    this.isPremiumIgr = const Value.absent(),
    this.name = const Value.absent(),
    this.nation = const Value.absent(),
    this.type = const Value.absent(),
    this.tankId = const Value.absent(),
  });
  VehicleTTCTableCompanion.insert({
    required String description,
    required String images,
    required bool isPremium,
    required bool isPremiumIgr,
    required String name,
    required String nation,
    required String type,
    this.tankId = const Value.absent(),
  })  : description = Value(description),
        images = Value(images),
        isPremium = Value(isPremium),
        isPremiumIgr = Value(isPremiumIgr),
        name = Value(name),
        nation = Value(nation),
        type = Value(type);
  static Insertable<VehicleTTCTableData> custom({
    Expression<String>? description,
    Expression<String>? images,
    Expression<bool>? isPremium,
    Expression<bool>? isPremiumIgr,
    Expression<String>? name,
    Expression<String>? nation,
    Expression<String>? type,
    Expression<int>? tankId,
  }) {
    return RawValuesInsertable({
      if (description != null) 'description': description,
      if (images != null) 'images': images,
      if (isPremium != null) 'is_premium': isPremium,
      if (isPremiumIgr != null) 'is_premium_igr': isPremiumIgr,
      if (name != null) 'name': name,
      if (nation != null) 'nation': nation,
      if (type != null) 'type': type,
      if (tankId != null) 'tank_id': tankId,
    });
  }

  VehicleTTCTableCompanion copyWith(
      {Value<String>? description,
      Value<String>? images,
      Value<bool>? isPremium,
      Value<bool>? isPremiumIgr,
      Value<String>? name,
      Value<String>? nation,
      Value<String>? type,
      Value<int>? tankId}) {
    return VehicleTTCTableCompanion(
      description: description ?? this.description,
      images: images ?? this.images,
      isPremium: isPremium ?? this.isPremium,
      isPremiumIgr: isPremiumIgr ?? this.isPremiumIgr,
      name: name ?? this.name,
      nation: nation ?? this.nation,
      type: type ?? this.type,
      tankId: tankId ?? this.tankId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (images.present) {
      map['images'] = Variable<String>(images.value);
    }
    if (isPremium.present) {
      map['is_premium'] = Variable<bool>(isPremium.value);
    }
    if (isPremiumIgr.present) {
      map['is_premium_igr'] = Variable<bool>(isPremiumIgr.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nation.present) {
      map['nation'] = Variable<String>(nation.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (tankId.present) {
      map['tank_id'] = Variable<int>(tankId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleTTCTableCompanion(')
          ..write('description: $description, ')
          ..write('images: $images, ')
          ..write('isPremium: $isPremium, ')
          ..write('isPremiumIgr: $isPremiumIgr, ')
          ..write('name: $name, ')
          ..write('nation: $nation, ')
          ..write('type: $type, ')
          ..write('tankId: $tankId')
          ..write(')'))
        .toString();
  }
}

class $VehicleTTCTableTable extends VehicleTTCTable
    with TableInfo<$VehicleTTCTableTable, VehicleTTCTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleTTCTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _imagesMeta = const VerificationMeta('images');
  @override
  late final GeneratedColumn<String?> images = GeneratedColumn<String?>(
      'images', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isPremiumMeta = const VerificationMeta('isPremium');
  @override
  late final GeneratedColumn<bool?> isPremium = GeneratedColumn<bool?>(
      'is_premium', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_premium IN (0, 1))');
  final VerificationMeta _isPremiumIgrMeta =
      const VerificationMeta('isPremiumIgr');
  @override
  late final GeneratedColumn<bool?> isPremiumIgr = GeneratedColumn<bool?>(
      'is_premium_igr', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_premium_igr IN (0, 1))');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nationMeta = const VerificationMeta('nation');
  @override
  late final GeneratedColumn<String?> nation = GeneratedColumn<String?>(
      'nation', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String?> type = GeneratedColumn<String?>(
      'type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tankIdMeta = const VerificationMeta('tankId');
  @override
  late final GeneratedColumn<int?> tankId = GeneratedColumn<int?>(
      'tank_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        description,
        images,
        isPremium,
        isPremiumIgr,
        name,
        nation,
        type,
        tankId
      ];
  @override
  String get aliasedName => _alias ?? 'vehicle_t_t_c_table';
  @override
  String get actualTableName => 'vehicle_t_t_c_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<VehicleTTCTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('images')) {
      context.handle(_imagesMeta,
          images.isAcceptableOrUnknown(data['images']!, _imagesMeta));
    } else if (isInserting) {
      context.missing(_imagesMeta);
    }
    if (data.containsKey('is_premium')) {
      context.handle(_isPremiumMeta,
          isPremium.isAcceptableOrUnknown(data['is_premium']!, _isPremiumMeta));
    } else if (isInserting) {
      context.missing(_isPremiumMeta);
    }
    if (data.containsKey('is_premium_igr')) {
      context.handle(
          _isPremiumIgrMeta,
          isPremiumIgr.isAcceptableOrUnknown(
              data['is_premium_igr']!, _isPremiumIgrMeta));
    } else if (isInserting) {
      context.missing(_isPremiumIgrMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('nation')) {
      context.handle(_nationMeta,
          nation.isAcceptableOrUnknown(data['nation']!, _nationMeta));
    } else if (isInserting) {
      context.missing(_nationMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('tank_id')) {
      context.handle(_tankIdMeta,
          tankId.isAcceptableOrUnknown(data['tank_id']!, _tankIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tankId};
  @override
  VehicleTTCTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return VehicleTTCTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VehicleTTCTableTable createAlias(String alias) {
    return $VehicleTTCTableTable(attachedDatabase, alias);
  }
}

abstract class _$WotStatDatabase extends GeneratedDatabase {
  _$WotStatDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $VehicleTTCTableTable vehicleTTCTable =
      $VehicleTTCTableTable(this);
  late final WotStatDao wotStatDao = WotStatDao(this as WotStatDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [userTable, vehicleTTCTable];
}
