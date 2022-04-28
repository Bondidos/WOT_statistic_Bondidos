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
  final String images;
  final bool isPremium;
  final bool isPremiumIgr;
  final String name;
  final String nation;
  final String type;
  final int tankId;
  VehicleTTCTableData(
      {required this.description,
      required this.images,
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
      images: const StringType()
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
    map['images'] = Variable<String>(images);
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
      images: Value(images),
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
      images: serializer.fromJson<String>(json['images']),
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
      'images': serializer.toJson<String>(images),
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
        images: images ?? this.images,
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

  @override
  int get hashCode => Object.hash(
      description, images, isPremium, isPremiumIgr, name, nation, type, tankId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleTTCTableData &&
          other.description == this.description &&
          other.images == this.images &&
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

class AchievementsTableData extends DataClass
    implements Insertable<AchievementsTableData> {
  final String name;
  final String section;
  final int sectionOrder;
  final String? imageBig;
  final String? image;
  final String? condition;
  final String? description;
  final String? nameI18n;
  final String? options;
  AchievementsTableData(
      {required this.name,
      required this.section,
      required this.sectionOrder,
      this.imageBig,
      this.image,
      this.condition,
      this.description,
      this.nameI18n,
      this.options});
  factory AchievementsTableData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AchievementsTableData(
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      section: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}section'])!,
      sectionOrder: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}section_order'])!,
      imageBig: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_big']),
      image: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image']),
      condition: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}condition']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      nameI18n: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name_i18n']),
      options: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}options']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['section'] = Variable<String>(section);
    map['section_order'] = Variable<int>(sectionOrder);
    if (!nullToAbsent || imageBig != null) {
      map['image_big'] = Variable<String?>(imageBig);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String?>(image);
    }
    if (!nullToAbsent || condition != null) {
      map['condition'] = Variable<String?>(condition);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    if (!nullToAbsent || nameI18n != null) {
      map['name_i18n'] = Variable<String?>(nameI18n);
    }
    if (!nullToAbsent || options != null) {
      map['options'] = Variable<String?>(options);
    }
    return map;
  }

  AchievementsTableCompanion toCompanion(bool nullToAbsent) {
    return AchievementsTableCompanion(
      name: Value(name),
      section: Value(section),
      sectionOrder: Value(sectionOrder),
      imageBig: imageBig == null && nullToAbsent
          ? const Value.absent()
          : Value(imageBig),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      condition: condition == null && nullToAbsent
          ? const Value.absent()
          : Value(condition),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      nameI18n: nameI18n == null && nullToAbsent
          ? const Value.absent()
          : Value(nameI18n),
      options: options == null && nullToAbsent
          ? const Value.absent()
          : Value(options),
    );
  }

  factory AchievementsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementsTableData(
      name: serializer.fromJson<String>(json['name']),
      section: serializer.fromJson<String>(json['section']),
      sectionOrder: serializer.fromJson<int>(json['sectionOrder']),
      imageBig: serializer.fromJson<String?>(json['imageBig']),
      image: serializer.fromJson<String?>(json['image']),
      condition: serializer.fromJson<String?>(json['condition']),
      description: serializer.fromJson<String?>(json['description']),
      nameI18n: serializer.fromJson<String?>(json['nameI18n']),
      options: serializer.fromJson<String?>(json['options']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'section': serializer.toJson<String>(section),
      'sectionOrder': serializer.toJson<int>(sectionOrder),
      'imageBig': serializer.toJson<String?>(imageBig),
      'image': serializer.toJson<String?>(image),
      'condition': serializer.toJson<String?>(condition),
      'description': serializer.toJson<String?>(description),
      'nameI18n': serializer.toJson<String?>(nameI18n),
      'options': serializer.toJson<String?>(options),
    };
  }

  AchievementsTableData copyWith(
          {String? name,
          String? section,
          int? sectionOrder,
          String? imageBig,
          String? image,
          String? condition,
          String? description,
          String? nameI18n,
          String? options}) =>
      AchievementsTableData(
        name: name ?? this.name,
        section: section ?? this.section,
        sectionOrder: sectionOrder ?? this.sectionOrder,
        imageBig: imageBig ?? this.imageBig,
        image: image ?? this.image,
        condition: condition ?? this.condition,
        description: description ?? this.description,
        nameI18n: nameI18n ?? this.nameI18n,
        options: options ?? this.options,
      );
  @override
  String toString() {
    return (StringBuffer('AchievementsTableData(')
          ..write('name: $name, ')
          ..write('section: $section, ')
          ..write('sectionOrder: $sectionOrder, ')
          ..write('imageBig: $imageBig, ')
          ..write('image: $image, ')
          ..write('condition: $condition, ')
          ..write('description: $description, ')
          ..write('nameI18n: $nameI18n, ')
          ..write('options: $options')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, section, sectionOrder, imageBig, image,
      condition, description, nameI18n, options);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementsTableData &&
          other.name == this.name &&
          other.section == this.section &&
          other.sectionOrder == this.sectionOrder &&
          other.imageBig == this.imageBig &&
          other.image == this.image &&
          other.condition == this.condition &&
          other.description == this.description &&
          other.nameI18n == this.nameI18n &&
          other.options == this.options);
}

class AchievementsTableCompanion
    extends UpdateCompanion<AchievementsTableData> {
  final Value<String> name;
  final Value<String> section;
  final Value<int> sectionOrder;
  final Value<String?> imageBig;
  final Value<String?> image;
  final Value<String?> condition;
  final Value<String?> description;
  final Value<String?> nameI18n;
  final Value<String?> options;
  const AchievementsTableCompanion({
    this.name = const Value.absent(),
    this.section = const Value.absent(),
    this.sectionOrder = const Value.absent(),
    this.imageBig = const Value.absent(),
    this.image = const Value.absent(),
    this.condition = const Value.absent(),
    this.description = const Value.absent(),
    this.nameI18n = const Value.absent(),
    this.options = const Value.absent(),
  });
  AchievementsTableCompanion.insert({
    required String name,
    required String section,
    required int sectionOrder,
    this.imageBig = const Value.absent(),
    this.image = const Value.absent(),
    this.condition = const Value.absent(),
    this.description = const Value.absent(),
    this.nameI18n = const Value.absent(),
    this.options = const Value.absent(),
  })  : name = Value(name),
        section = Value(section),
        sectionOrder = Value(sectionOrder);
  static Insertable<AchievementsTableData> custom({
    Expression<String>? name,
    Expression<String>? section,
    Expression<int>? sectionOrder,
    Expression<String?>? imageBig,
    Expression<String?>? image,
    Expression<String?>? condition,
    Expression<String?>? description,
    Expression<String?>? nameI18n,
    Expression<String?>? options,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (section != null) 'section': section,
      if (sectionOrder != null) 'section_order': sectionOrder,
      if (imageBig != null) 'image_big': imageBig,
      if (image != null) 'image': image,
      if (condition != null) 'condition': condition,
      if (description != null) 'description': description,
      if (nameI18n != null) 'name_i18n': nameI18n,
      if (options != null) 'options': options,
    });
  }

  AchievementsTableCompanion copyWith(
      {Value<String>? name,
      Value<String>? section,
      Value<int>? sectionOrder,
      Value<String?>? imageBig,
      Value<String?>? image,
      Value<String?>? condition,
      Value<String?>? description,
      Value<String?>? nameI18n,
      Value<String?>? options}) {
    return AchievementsTableCompanion(
      name: name ?? this.name,
      section: section ?? this.section,
      sectionOrder: sectionOrder ?? this.sectionOrder,
      imageBig: imageBig ?? this.imageBig,
      image: image ?? this.image,
      condition: condition ?? this.condition,
      description: description ?? this.description,
      nameI18n: nameI18n ?? this.nameI18n,
      options: options ?? this.options,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (sectionOrder.present) {
      map['section_order'] = Variable<int>(sectionOrder.value);
    }
    if (imageBig.present) {
      map['image_big'] = Variable<String?>(imageBig.value);
    }
    if (image.present) {
      map['image'] = Variable<String?>(image.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String?>(condition.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (nameI18n.present) {
      map['name_i18n'] = Variable<String?>(nameI18n.value);
    }
    if (options.present) {
      map['options'] = Variable<String?>(options.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsTableCompanion(')
          ..write('name: $name, ')
          ..write('section: $section, ')
          ..write('sectionOrder: $sectionOrder, ')
          ..write('imageBig: $imageBig, ')
          ..write('image: $image, ')
          ..write('condition: $condition, ')
          ..write('description: $description, ')
          ..write('nameI18n: $nameI18n, ')
          ..write('options: $options')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTableTable extends AchievementsTable
    with TableInfo<$AchievementsTableTable, AchievementsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTableTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _sectionMeta = const VerificationMeta('section');
  @override
  late final GeneratedColumn<String?> section = GeneratedColumn<String?>(
      'section', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _sectionOrderMeta =
      const VerificationMeta('sectionOrder');
  @override
  late final GeneratedColumn<int?> sectionOrder = GeneratedColumn<int?>(
      'section_order', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _imageBigMeta = const VerificationMeta('imageBig');
  @override
  late final GeneratedColumn<String?> imageBig = GeneratedColumn<String?>(
      'image_big', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String?> image = GeneratedColumn<String?>(
      'image', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _conditionMeta = const VerificationMeta('condition');
  @override
  late final GeneratedColumn<String?> condition = GeneratedColumn<String?>(
      'condition', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _nameI18nMeta = const VerificationMeta('nameI18n');
  @override
  late final GeneratedColumn<String?> nameI18n = GeneratedColumn<String?>(
      'name_i18n', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _optionsMeta = const VerificationMeta('options');
  @override
  late final GeneratedColumn<String?> options = GeneratedColumn<String?>(
      'options', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        name,
        section,
        sectionOrder,
        imageBig,
        image,
        condition,
        description,
        nameI18n,
        options
      ];
  @override
  String get aliasedName => _alias ?? 'achievements_table';
  @override
  String get actualTableName => 'achievements_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AchievementsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('section')) {
      context.handle(_sectionMeta,
          section.isAcceptableOrUnknown(data['section']!, _sectionMeta));
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    if (data.containsKey('section_order')) {
      context.handle(
          _sectionOrderMeta,
          sectionOrder.isAcceptableOrUnknown(
              data['section_order']!, _sectionOrderMeta));
    } else if (isInserting) {
      context.missing(_sectionOrderMeta);
    }
    if (data.containsKey('image_big')) {
      context.handle(_imageBigMeta,
          imageBig.isAcceptableOrUnknown(data['image_big']!, _imageBigMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('condition')) {
      context.handle(_conditionMeta,
          condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('name_i18n')) {
      context.handle(_nameI18nMeta,
          nameI18n.isAcceptableOrUnknown(data['name_i18n']!, _nameI18nMeta));
    }
    if (data.containsKey('options')) {
      context.handle(_optionsMeta,
          options.isAcceptableOrUnknown(data['options']!, _optionsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  AchievementsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AchievementsTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AchievementsTableTable createAlias(String alias) {
    return $AchievementsTableTable(attachedDatabase, alias);
  }
}

abstract class _$WotStatDatabase extends GeneratedDatabase {
  _$WotStatDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $VehicleTTCTableTable vehicleTTCTable =
      $VehicleTTCTableTable(this);
  late final $AchievementsTableTable achievementsTable =
      $AchievementsTableTable(this);
  late final WotStatDao wotStatDao = WotStatDao(this as WotStatDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [userTable, vehicleTTCTable, achievementsTable];
}
