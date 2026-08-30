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

abstract class UserAnalytics
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserAnalytics._({
    this.id,
    required this.userId,
    required this.action,
    required this.timestamp,
    this.metadata,
  });

  factory UserAnalytics({
    int? id,
    required int userId,
    required String action,
    required DateTime timestamp,
    String? metadata,
  }) = _UserAnalyticsImpl;

  factory UserAnalytics.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserAnalytics(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      action: jsonSerialization['action'] as String,
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      metadata: jsonSerialization['metadata'] as String?,
    );
  }

  static final t = UserAnalyticsTable();

  static const db = UserAnalyticsRepository._();

  @override
  int? id;

  int userId;

  String action;

  DateTime timestamp;

  String? metadata;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserAnalytics copyWith({
    int? id,
    int? userId,
    String? action,
    DateTime? timestamp,
    String? metadata,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserAnalytics',
      if (id != null) 'id': id,
      'userId': userId,
      'action': action,
      'timestamp': timestamp.toJson(),
      if (metadata != null) 'metadata': metadata,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserAnalytics',
      if (id != null) 'id': id,
      'userId': userId,
      'action': action,
      'timestamp': timestamp.toJson(),
      if (metadata != null) 'metadata': metadata,
    };
  }

  static UserAnalyticsInclude include() {
    return UserAnalyticsInclude._();
  }

  static UserAnalyticsIncludeList includeList({
    _i1.WhereExpressionBuilder<UserAnalyticsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserAnalyticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserAnalyticsTable>? orderByList,
    UserAnalyticsInclude? include,
  }) {
    return UserAnalyticsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserAnalytics.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserAnalytics.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserAnalyticsImpl extends UserAnalytics {
  _UserAnalyticsImpl({
    int? id,
    required int userId,
    required String action,
    required DateTime timestamp,
    String? metadata,
  }) : super._(
         id: id,
         userId: userId,
         action: action,
         timestamp: timestamp,
         metadata: metadata,
       );

  /// Returns a shallow copy of this [UserAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserAnalytics copyWith({
    Object? id = _Undefined,
    int? userId,
    String? action,
    DateTime? timestamp,
    Object? metadata = _Undefined,
  }) {
    return UserAnalytics(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata is String? ? metadata : this.metadata,
    );
  }
}

class UserAnalyticsUpdateTable extends _i1.UpdateTable<UserAnalyticsTable> {
  UserAnalyticsUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
    table.action,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _i1.ColumnValue(
        table.timestamp,
        value,
      );

  _i1.ColumnValue<String, String> metadata(String? value) => _i1.ColumnValue(
    table.metadata,
    value,
  );
}

class UserAnalyticsTable extends _i1.Table<int?> {
  UserAnalyticsTable({super.tableRelation})
    : super(tableName: 'user_analytics') {
    updateTable = UserAnalyticsUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
    metadata = _i1.ColumnString(
      'metadata',
      this,
    );
  }

  late final UserAnalyticsUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString action;

  late final _i1.ColumnDateTime timestamp;

  late final _i1.ColumnString metadata;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    action,
    timestamp,
    metadata,
  ];
}

class UserAnalyticsInclude extends _i1.IncludeObject {
  UserAnalyticsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserAnalytics.t;
}

class UserAnalyticsIncludeList extends _i1.IncludeList {
  UserAnalyticsIncludeList._({
    _i1.WhereExpressionBuilder<UserAnalyticsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserAnalytics.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserAnalytics.t;
}

class UserAnalyticsRepository {
  const UserAnalyticsRepository._();

  /// Returns a list of [UserAnalytics]s matching the given query parameters.
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
  Future<List<UserAnalytics>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserAnalyticsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserAnalyticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserAnalyticsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserAnalytics>(
      where: where?.call(UserAnalytics.t),
      orderBy: orderBy?.call(UserAnalytics.t),
      orderByList: orderByList?.call(UserAnalytics.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserAnalytics] matching the given query parameters.
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
  Future<UserAnalytics?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserAnalyticsTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserAnalyticsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserAnalyticsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserAnalytics>(
      where: where?.call(UserAnalytics.t),
      orderBy: orderBy?.call(UserAnalytics.t),
      orderByList: orderByList?.call(UserAnalytics.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserAnalytics] by its [id] or null if no such row exists.
  Future<UserAnalytics?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserAnalytics>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserAnalytics]s in the list and returns the inserted rows.
  ///
  /// The returned [UserAnalytics]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserAnalytics>> insert(
    _i1.DatabaseSession session,
    List<UserAnalytics> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserAnalytics>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserAnalytics] and returns the inserted row.
  ///
  /// The returned [UserAnalytics] will have its `id` field set.
  Future<UserAnalytics> insertRow(
    _i1.DatabaseSession session,
    UserAnalytics row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserAnalytics>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserAnalytics]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserAnalytics>> update(
    _i1.DatabaseSession session,
    List<UserAnalytics> rows, {
    _i1.ColumnSelections<UserAnalyticsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserAnalytics>(
      rows,
      columns: columns?.call(UserAnalytics.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserAnalytics]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserAnalytics> updateRow(
    _i1.DatabaseSession session,
    UserAnalytics row, {
    _i1.ColumnSelections<UserAnalyticsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserAnalytics>(
      row,
      columns: columns?.call(UserAnalytics.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserAnalytics] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserAnalytics?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserAnalyticsUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserAnalytics>(
      id,
      columnValues: columnValues(UserAnalytics.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserAnalytics]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserAnalytics>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserAnalyticsUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserAnalyticsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserAnalyticsTable>? orderBy,
    _i1.OrderByListBuilder<UserAnalyticsTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserAnalytics>(
      columnValues: columnValues(UserAnalytics.t.updateTable),
      where: where(UserAnalytics.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserAnalytics.t),
      orderByList: orderByList?.call(UserAnalytics.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserAnalytics]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserAnalytics>> delete(
    _i1.DatabaseSession session,
    List<UserAnalytics> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserAnalytics>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserAnalytics].
  Future<UserAnalytics> deleteRow(
    _i1.DatabaseSession session,
    UserAnalytics row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserAnalytics>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserAnalytics>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserAnalyticsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserAnalytics>(
      where: where(UserAnalytics.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserAnalyticsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserAnalytics>(
      where: where?.call(UserAnalytics.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserAnalytics] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserAnalyticsTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserAnalytics>(
      where: where(UserAnalytics.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
