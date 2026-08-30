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

abstract class UserSafetyRelationship
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserSafetyRelationship._({
    this.id,
    required this.userId,
    required this.targetUserId,
    required this.relationshipType,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserSafetyRelationship({
    int? id,
    required int userId,
    required int targetUserId,
    required String relationshipType,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserSafetyRelationshipImpl;

  factory UserSafetyRelationship.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UserSafetyRelationship(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      targetUserId: jsonSerialization['targetUserId'] as int,
      relationshipType: jsonSerialization['relationshipType'] as String,
      active: _i1.BoolJsonExtension.fromJson(jsonSerialization['active']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = UserSafetyRelationshipTable();

  static const db = UserSafetyRelationshipRepository._();

  @override
  int? id;

  int userId;

  int targetUserId;

  String relationshipType;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserSafetyRelationship]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserSafetyRelationship copyWith({
    int? id,
    int? userId,
    int? targetUserId,
    String? relationshipType,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserSafetyRelationship',
      if (id != null) 'id': id,
      'userId': userId,
      'targetUserId': targetUserId,
      'relationshipType': relationshipType,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserSafetyRelationship',
      if (id != null) 'id': id,
      'userId': userId,
      'targetUserId': targetUserId,
      'relationshipType': relationshipType,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserSafetyRelationshipInclude include() {
    return UserSafetyRelationshipInclude._();
  }

  static UserSafetyRelationshipIncludeList includeList({
    _i1.WhereExpressionBuilder<UserSafetyRelationshipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserSafetyRelationshipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserSafetyRelationshipTable>? orderByList,
    UserSafetyRelationshipInclude? include,
  }) {
    return UserSafetyRelationshipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserSafetyRelationship.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserSafetyRelationship.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserSafetyRelationshipImpl extends UserSafetyRelationship {
  _UserSafetyRelationshipImpl({
    int? id,
    required int userId,
    required int targetUserId,
    required String relationshipType,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          targetUserId: targetUserId,
          relationshipType: relationshipType,
          active: active,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [UserSafetyRelationship]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserSafetyRelationship copyWith({
    Object? id = _Undefined,
    int? userId,
    int? targetUserId,
    String? relationshipType,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserSafetyRelationship(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      targetUserId: targetUserId ?? this.targetUserId,
      relationshipType: relationshipType ?? this.relationshipType,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserSafetyRelationshipUpdateTable
    extends _i1.UpdateTable<UserSafetyRelationshipTable> {
  UserSafetyRelationshipUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<int, int> targetUserId(int value) => _i1.ColumnValue(
        table.targetUserId,
        value,
      );

  _i1.ColumnValue<String, String> relationshipType(String value) =>
      _i1.ColumnValue(
        table.relationshipType,
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

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class UserSafetyRelationshipTable extends _i1.Table<int?> {
  UserSafetyRelationshipTable({super.tableRelation})
      : super(tableName: 'user_safety_relationships') {
    updateTable = UserSafetyRelationshipUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    targetUserId = _i1.ColumnInt(
      'targetUserId',
      this,
    );
    relationshipType = _i1.ColumnString(
      'relationshipType',
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
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final UserSafetyRelationshipUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt targetUserId;

  late final _i1.ColumnString relationshipType;

  late final _i1.ColumnBool active;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        targetUserId,
        relationshipType,
        active,
        createdAt,
        updatedAt,
      ];
}

class UserSafetyRelationshipInclude extends _i1.IncludeObject {
  UserSafetyRelationshipInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserSafetyRelationship.t;
}

class UserSafetyRelationshipIncludeList extends _i1.IncludeList {
  UserSafetyRelationshipIncludeList._({
    _i1.WhereExpressionBuilder<UserSafetyRelationshipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserSafetyRelationship.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserSafetyRelationship.t;
}

class UserSafetyRelationshipRepository {
  const UserSafetyRelationshipRepository._();

  /// Returns a list of [UserSafetyRelationship]s matching the given query parameters.
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
  Future<List<UserSafetyRelationship>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserSafetyRelationshipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserSafetyRelationshipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserSafetyRelationshipTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserSafetyRelationship>(
      where: where?.call(UserSafetyRelationship.t),
      orderBy: orderBy?.call(UserSafetyRelationship.t),
      orderByList: orderByList?.call(UserSafetyRelationship.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserSafetyRelationship] matching the given query parameters.
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
  Future<UserSafetyRelationship?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserSafetyRelationshipTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserSafetyRelationshipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserSafetyRelationshipTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserSafetyRelationship>(
      where: where?.call(UserSafetyRelationship.t),
      orderBy: orderBy?.call(UserSafetyRelationship.t),
      orderByList: orderByList?.call(UserSafetyRelationship.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserSafetyRelationship] by its [id] or null if no such row exists.
  Future<UserSafetyRelationship?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserSafetyRelationship>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserSafetyRelationship]s in the list and returns the inserted rows.
  ///
  /// The returned [UserSafetyRelationship]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserSafetyRelationship>> insert(
    _i1.DatabaseSession session,
    List<UserSafetyRelationship> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserSafetyRelationship>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserSafetyRelationship] and returns the inserted row.
  ///
  /// The returned [UserSafetyRelationship] will have its `id` field set.
  Future<UserSafetyRelationship> insertRow(
    _i1.DatabaseSession session,
    UserSafetyRelationship row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserSafetyRelationship>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserSafetyRelationship]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserSafetyRelationship>> update(
    _i1.DatabaseSession session,
    List<UserSafetyRelationship> rows, {
    _i1.ColumnSelections<UserSafetyRelationshipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserSafetyRelationship>(
      rows,
      columns: columns?.call(UserSafetyRelationship.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserSafetyRelationship]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserSafetyRelationship> updateRow(
    _i1.DatabaseSession session,
    UserSafetyRelationship row, {
    _i1.ColumnSelections<UserSafetyRelationshipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserSafetyRelationship>(
      row,
      columns: columns?.call(UserSafetyRelationship.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserSafetyRelationship] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserSafetyRelationship?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserSafetyRelationshipUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserSafetyRelationship>(
      id,
      columnValues: columnValues(UserSafetyRelationship.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserSafetyRelationship]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserSafetyRelationship>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserSafetyRelationshipUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<UserSafetyRelationshipTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserSafetyRelationshipTable>? orderBy,
    _i1.OrderByListBuilder<UserSafetyRelationshipTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserSafetyRelationship>(
      columnValues: columnValues(UserSafetyRelationship.t.updateTable),
      where: where(UserSafetyRelationship.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserSafetyRelationship.t),
      orderByList: orderByList?.call(UserSafetyRelationship.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserSafetyRelationship]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserSafetyRelationship>> delete(
    _i1.DatabaseSession session,
    List<UserSafetyRelationship> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserSafetyRelationship>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserSafetyRelationship].
  Future<UserSafetyRelationship> deleteRow(
    _i1.DatabaseSession session,
    UserSafetyRelationship row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserSafetyRelationship>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserSafetyRelationship>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserSafetyRelationshipTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserSafetyRelationship>(
      where: where(UserSafetyRelationship.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserSafetyRelationshipTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserSafetyRelationship>(
      where: where?.call(UserSafetyRelationship.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserSafetyRelationship] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserSafetyRelationshipTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserSafetyRelationship>(
      where: where(UserSafetyRelationship.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
