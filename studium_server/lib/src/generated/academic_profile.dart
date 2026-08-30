/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:studium_server/src/generated/protocol.dart' as _i2;

abstract class AcademicProfile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AcademicProfile._({
    this.id,
    required this.userId,
    required this.institutionId,
    this.department,
    this.programme,
    this.level,
    required this.subjects,
    required this.interests,
    required this.languages,
    this.availability,
    required this.updatedAt,
  });

  factory AcademicProfile({
    int? id,
    required int userId,
    required int institutionId,
    String? department,
    String? programme,
    String? level,
    required List<String> subjects,
    required List<String> interests,
    required List<String> languages,
    String? availability,
    required DateTime updatedAt,
  }) = _AcademicProfileImpl;

  factory AcademicProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcademicProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      institutionId: jsonSerialization['institutionId'] as int,
      department: jsonSerialization['department'] as String?,
      programme: jsonSerialization['programme'] as String?,
      level: jsonSerialization['level'] as String?,
      subjects: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['subjects'],
      ),
      interests: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['interests'],
      ),
      languages: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['languages'],
      ),
      availability: jsonSerialization['availability'] as String?,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = AcademicProfileTable();

  static const db = AcademicProfileRepository._();

  @override
  int? id;

  int userId;

  int institutionId;

  String? department;

  String? programme;

  String? level;

  List<String> subjects;

  List<String> interests;

  List<String> languages;

  String? availability;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AcademicProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AcademicProfile copyWith({
    int? id,
    int? userId,
    int? institutionId,
    String? department,
    String? programme,
    String? level,
    List<String>? subjects,
    List<String>? interests,
    List<String>? languages,
    String? availability,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AcademicProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'institutionId': institutionId,
      if (department != null) 'department': department,
      if (programme != null) 'programme': programme,
      if (level != null) 'level': level,
      'subjects': subjects.toJson(),
      'interests': interests.toJson(),
      'languages': languages.toJson(),
      if (availability != null) 'availability': availability,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AcademicProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'institutionId': institutionId,
      if (department != null) 'department': department,
      if (programme != null) 'programme': programme,
      if (level != null) 'level': level,
      'subjects': subjects.toJson(),
      'interests': interests.toJson(),
      'languages': languages.toJson(),
      if (availability != null) 'availability': availability,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AcademicProfileInclude include() {
    return AcademicProfileInclude._();
  }

  static AcademicProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<AcademicProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AcademicProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AcademicProfileTable>? orderByList,
    AcademicProfileInclude? include,
  }) {
    return AcademicProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AcademicProfile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AcademicProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AcademicProfileImpl extends AcademicProfile {
  _AcademicProfileImpl({
    int? id,
    required int userId,
    required int institutionId,
    String? department,
    String? programme,
    String? level,
    required List<String> subjects,
    required List<String> interests,
    required List<String> languages,
    String? availability,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          institutionId: institutionId,
          department: department,
          programme: programme,
          level: level,
          subjects: subjects,
          interests: interests,
          languages: languages,
          availability: availability,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [AcademicProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AcademicProfile copyWith({
    Object? id = _Undefined,
    int? userId,
    int? institutionId,
    Object? department = _Undefined,
    Object? programme = _Undefined,
    Object? level = _Undefined,
    List<String>? subjects,
    List<String>? interests,
    List<String>? languages,
    Object? availability = _Undefined,
    DateTime? updatedAt,
  }) {
    return AcademicProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      institutionId: institutionId ?? this.institutionId,
      department: department is String? ? department : this.department,
      programme: programme is String? ? programme : this.programme,
      level: level is String? ? level : this.level,
      subjects: subjects ?? this.subjects.map((e0) => e0).toList(),
      interests: interests ?? this.interests.map((e0) => e0).toList(),
      languages: languages ?? this.languages.map((e0) => e0).toList(),
      availability: availability is String? ? availability : this.availability,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AcademicProfileUpdateTable extends _i1.UpdateTable<AcademicProfileTable> {
  AcademicProfileUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<int, int> institutionId(int value) => _i1.ColumnValue(
        table.institutionId,
        value,
      );

  _i1.ColumnValue<String, String> department(String? value) => _i1.ColumnValue(
        table.department,
        value,
      );

  _i1.ColumnValue<String, String> programme(String? value) => _i1.ColumnValue(
        table.programme,
        value,
      );

  _i1.ColumnValue<String, String> level(String? value) => _i1.ColumnValue(
        table.level,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> subjects(List<String> value) =>
      _i1.ColumnValue(
        table.subjects,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> interests(List<String> value) =>
      _i1.ColumnValue(
        table.interests,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> languages(List<String> value) =>
      _i1.ColumnValue(
        table.languages,
        value,
      );

  _i1.ColumnValue<String, String> availability(String? value) =>
      _i1.ColumnValue(
        table.availability,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class AcademicProfileTable extends _i1.Table<int?> {
  AcademicProfileTable({super.tableRelation})
      : super(tableName: 'academic_profiles') {
    updateTable = AcademicProfileUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    institutionId = _i1.ColumnInt(
      'institutionId',
      this,
    );
    department = _i1.ColumnString(
      'department',
      this,
    );
    programme = _i1.ColumnString(
      'programme',
      this,
    );
    level = _i1.ColumnString(
      'level',
      this,
    );
    subjects = _i1.ColumnSerializable<List<String>>(
      'subjects',
      this,
    );
    interests = _i1.ColumnSerializable<List<String>>(
      'interests',
      this,
    );
    languages = _i1.ColumnSerializable<List<String>>(
      'languages',
      this,
    );
    availability = _i1.ColumnString(
      'availability',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final AcademicProfileUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt institutionId;

  late final _i1.ColumnString department;

  late final _i1.ColumnString programme;

  late final _i1.ColumnString level;

  late final _i1.ColumnSerializable<List<String>> subjects;

  late final _i1.ColumnSerializable<List<String>> interests;

  late final _i1.ColumnSerializable<List<String>> languages;

  late final _i1.ColumnString availability;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        institutionId,
        department,
        programme,
        level,
        subjects,
        interests,
        languages,
        availability,
        updatedAt,
      ];
}

class AcademicProfileInclude extends _i1.IncludeObject {
  AcademicProfileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AcademicProfile.t;
}

class AcademicProfileIncludeList extends _i1.IncludeList {
  AcademicProfileIncludeList._({
    _i1.WhereExpressionBuilder<AcademicProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AcademicProfile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AcademicProfile.t;
}

class AcademicProfileRepository {
  const AcademicProfileRepository._();

  /// Returns a list of [AcademicProfile]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<AcademicProfile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AcademicProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AcademicProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AcademicProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AcademicProfile>(
      where: where?.call(AcademicProfile.t),
      orderBy: orderBy?.call(AcademicProfile.t),
      orderByList: orderByList?.call(AcademicProfile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AcademicProfile] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<AcademicProfile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AcademicProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<AcademicProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AcademicProfileTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AcademicProfile>(
      where: where?.call(AcademicProfile.t),
      orderBy: orderBy?.call(AcademicProfile.t),
      orderByList: orderByList?.call(AcademicProfile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AcademicProfile] by its [id] or null if no such row exists.
  Future<AcademicProfile?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AcademicProfile>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AcademicProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [AcademicProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AcademicProfile>> insert(
    _i1.DatabaseSession session,
    List<AcademicProfile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AcademicProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AcademicProfile] and returns the inserted row.
  ///
  /// The returned [AcademicProfile] will have its `id` field set.
  Future<AcademicProfile> insertRow(
    _i1.DatabaseSession session,
    AcademicProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AcademicProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AcademicProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AcademicProfile>> update(
    _i1.DatabaseSession session,
    List<AcademicProfile> rows, {
    _i1.ColumnSelections<AcademicProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AcademicProfile>(
      rows,
      columns: columns?.call(AcademicProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AcademicProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AcademicProfile> updateRow(
    _i1.DatabaseSession session,
    AcademicProfile row, {
    _i1.ColumnSelections<AcademicProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AcademicProfile>(
      row,
      columns: columns?.call(AcademicProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AcademicProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AcademicProfile?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AcademicProfileUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AcademicProfile>(
      id,
      columnValues: columnValues(AcademicProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AcademicProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AcademicProfile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AcademicProfileUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<AcademicProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AcademicProfileTable>? orderBy,
    _i1.OrderByListBuilder<AcademicProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AcademicProfile>(
      columnValues: columnValues(AcademicProfile.t.updateTable),
      where: where(AcademicProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AcademicProfile.t),
      orderByList: orderByList?.call(AcademicProfile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AcademicProfile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AcademicProfile>> delete(
    _i1.DatabaseSession session,
    List<AcademicProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AcademicProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AcademicProfile].
  Future<AcademicProfile> deleteRow(
    _i1.DatabaseSession session,
    AcademicProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AcademicProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AcademicProfile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AcademicProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AcademicProfile>(
      where: where(AcademicProfile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AcademicProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AcademicProfile>(
      where: where?.call(AcademicProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AcademicProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AcademicProfileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AcademicProfile>(
      where: where(AcademicProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
