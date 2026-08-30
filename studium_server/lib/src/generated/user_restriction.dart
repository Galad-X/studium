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

abstract class UserRestriction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserRestriction._({
    this.id,
    required this.userId,
    required this.restrictionType,
    required this.reason,
    this.expiresAt,
    required this.active,
    required this.createdAt,
  });

  factory UserRestriction({
    int? id,
    required int userId,
    required String restrictionType,
    required String reason,
    DateTime? expiresAt,
    required bool active,
    required DateTime createdAt,
  }) = _UserRestrictionImpl;

  factory UserRestriction.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRestriction(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      restrictionType: jsonSerialization['restrictionType'] as String,
      reason: jsonSerialization['reason'] as String,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      active: _i1.BoolJsonExtension.fromJson(jsonSerialization['active']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = UserRestrictionTable();

  static const db = UserRestrictionRepository._();

  @override
  int? id;

  int userId;

  String restrictionType;

  String reason;

  DateTime? expiresAt;

  bool active;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserRestriction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserRestriction copyWith({
    int? id,
    int? userId,
    String? restrictionType,
    String? reason,
    DateTime? expiresAt,
    bool? active,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRestriction',
      if (id != null) 'id': id,
      'userId': userId,
      'restrictionType': restrictionType,
      'reason': reason,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'active': active,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserRestriction',
      if (id != null) 'id': id,
      'userId': userId,
      'restrictionType': restrictionType,
      'reason': reason,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'active': active,
      'createdAt': createdAt.toJson(),
    };
  }

  static UserRestrictionInclude include() {
    return UserRestrictionInclude._();
  }

  static UserRestrictionIncludeList includeList({
    _i1.WhereExpressionBuilder<UserRestrictionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRestrictionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRestrictionTable>? orderByList,
    UserRestrictionInclude? include,
  }) {
    return UserRestrictionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRestriction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserRestriction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRestrictionImpl extends UserRestriction {
  _UserRestrictionImpl({
    int? id,
    required int userId,
    required String restrictionType,
    required String reason,
    DateTime? expiresAt,
    required bool active,
    required DateTime createdAt,
  }) : super._(
          id: id,
          userId: userId,
          restrictionType: restrictionType,
          reason: reason,
          expiresAt: expiresAt,
          active: active,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [UserRestriction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserRestriction copyWith({
    Object? id = _Undefined,
    int? userId,
    String? restrictionType,
    String? reason,
    Object? expiresAt = _Undefined,
    bool? active,
    DateTime? createdAt,
  }) {
    return UserRestriction(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      restrictionType: restrictionType ?? this.restrictionType,
      reason: reason ?? this.reason,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class UserRestrictionUpdateTable extends _i1.UpdateTable<UserRestrictionTable> {
  UserRestrictionUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> restrictionType(String value) =>
      _i1.ColumnValue(
        table.restrictionType,
        value,
      );

  _i1.ColumnValue<String, String> reason(String value) => _i1.ColumnValue(
        table.reason,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<bool, bool> active(bool value) => _i1.ColumnValue(
        table.active,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class UserRestrictionTable extends _i1.Table<int?> {
  UserRestrictionTable({super.tableRelation})
      : super(tableName: 'user_restrictions') {
    updateTable = UserRestrictionUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    restrictionType = _i1.ColumnString(
      'restrictionType',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    active = _i1.ColumnBool(
      'active',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final UserRestrictionUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString restrictionType;

  late final _i1.ColumnString reason;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnBool active;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        restrictionType,
        reason,
        expiresAt,
        active,
        createdAt,
      ];
}

class UserRestrictionInclude extends _i1.IncludeObject {
  UserRestrictionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserRestriction.t;
}

class UserRestrictionIncludeList extends _i1.IncludeList {
  UserRestrictionIncludeList._({
    _i1.WhereExpressionBuilder<UserRestrictionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserRestriction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserRestriction.t;
}

class UserRestrictionRepository {
  const UserRestrictionRepository._();

  /// Returns a list of [UserRestriction]s matching the given query parameters.
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
  Future<List<UserRestriction>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserRestrictionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRestrictionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRestrictionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserRestriction>(
      where: where?.call(UserRestriction.t),
      orderBy: orderBy?.call(UserRestriction.t),
      orderByList: orderByList?.call(UserRestriction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserRestriction] matching the given query parameters.
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
  Future<UserRestriction?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserRestrictionTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserRestrictionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRestrictionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserRestriction>(
      where: where?.call(UserRestriction.t),
      orderBy: orderBy?.call(UserRestriction.t),
      orderByList: orderByList?.call(UserRestriction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserRestriction] by its [id] or null if no such row exists.
  Future<UserRestriction?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserRestriction>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserRestriction]s in the list and returns the inserted rows.
  ///
  /// The returned [UserRestriction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserRestriction>> insert(
    _i1.DatabaseSession session,
    List<UserRestriction> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserRestriction>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserRestriction] and returns the inserted row.
  ///
  /// The returned [UserRestriction] will have its `id` field set.
  Future<UserRestriction> insertRow(
    _i1.DatabaseSession session,
    UserRestriction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserRestriction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserRestriction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserRestriction>> update(
    _i1.DatabaseSession session,
    List<UserRestriction> rows, {
    _i1.ColumnSelections<UserRestrictionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserRestriction>(
      rows,
      columns: columns?.call(UserRestriction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRestriction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserRestriction> updateRow(
    _i1.DatabaseSession session,
    UserRestriction row, {
    _i1.ColumnSelections<UserRestrictionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserRestriction>(
      row,
      columns: columns?.call(UserRestriction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRestriction] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserRestriction?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserRestrictionUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserRestriction>(
      id,
      columnValues: columnValues(UserRestriction.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserRestriction]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserRestriction>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserRestrictionUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<UserRestrictionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRestrictionTable>? orderBy,
    _i1.OrderByListBuilder<UserRestrictionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserRestriction>(
      columnValues: columnValues(UserRestriction.t.updateTable),
      where: where(UserRestriction.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRestriction.t),
      orderByList: orderByList?.call(UserRestriction.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserRestriction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserRestriction>> delete(
    _i1.DatabaseSession session,
    List<UserRestriction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserRestriction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserRestriction].
  Future<UserRestriction> deleteRow(
    _i1.DatabaseSession session,
    UserRestriction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserRestriction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserRestriction>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserRestrictionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserRestriction>(
      where: where(UserRestriction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserRestrictionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserRestriction>(
      where: where?.call(UserRestriction.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserRestriction] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserRestrictionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserRestriction>(
      where: where(UserRestriction.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
