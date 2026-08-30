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

abstract class ApiRateLimitBucket
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ApiRateLimitBucket._({
    this.id,
    required this.scopeKey,
    required this.windowStart,
    required this.requestCount,
    required this.updatedAt,
  });

  factory ApiRateLimitBucket({
    int? id,
    required String scopeKey,
    required DateTime windowStart,
    required int requestCount,
    required DateTime updatedAt,
  }) = _ApiRateLimitBucketImpl;

  factory ApiRateLimitBucket.fromJson(Map<String, dynamic> jsonSerialization) {
    return ApiRateLimitBucket(
      id: jsonSerialization['id'] as int?,
      scopeKey: jsonSerialization['scopeKey'] as String,
      windowStart: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['windowStart'],
      ),
      requestCount: jsonSerialization['requestCount'] as int,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ApiRateLimitBucketTable();

  static const db = ApiRateLimitBucketRepository._();

  @override
  int? id;

  String scopeKey;

  DateTime windowStart;

  int requestCount;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ApiRateLimitBucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ApiRateLimitBucket copyWith({
    int? id,
    String? scopeKey,
    DateTime? windowStart,
    int? requestCount,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ApiRateLimitBucket',
      if (id != null) 'id': id,
      'scopeKey': scopeKey,
      'windowStart': windowStart.toJson(),
      'requestCount': requestCount,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ApiRateLimitBucket',
      if (id != null) 'id': id,
      'scopeKey': scopeKey,
      'windowStart': windowStart.toJson(),
      'requestCount': requestCount,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ApiRateLimitBucketInclude include() {
    return ApiRateLimitBucketInclude._();
  }

  static ApiRateLimitBucketIncludeList includeList({
    _i1.WhereExpressionBuilder<ApiRateLimitBucketTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ApiRateLimitBucketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ApiRateLimitBucketTable>? orderByList,
    ApiRateLimitBucketInclude? include,
  }) {
    return ApiRateLimitBucketIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ApiRateLimitBucket.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ApiRateLimitBucket.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ApiRateLimitBucketImpl extends ApiRateLimitBucket {
  _ApiRateLimitBucketImpl({
    int? id,
    required String scopeKey,
    required DateTime windowStart,
    required int requestCount,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         scopeKey: scopeKey,
         windowStart: windowStart,
         requestCount: requestCount,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ApiRateLimitBucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ApiRateLimitBucket copyWith({
    Object? id = _Undefined,
    String? scopeKey,
    DateTime? windowStart,
    int? requestCount,
    DateTime? updatedAt,
  }) {
    return ApiRateLimitBucket(
      id: id is int? ? id : this.id,
      scopeKey: scopeKey ?? this.scopeKey,
      windowStart: windowStart ?? this.windowStart,
      requestCount: requestCount ?? this.requestCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ApiRateLimitBucketUpdateTable
    extends _i1.UpdateTable<ApiRateLimitBucketTable> {
  ApiRateLimitBucketUpdateTable(super.table);

  _i1.ColumnValue<String, String> scopeKey(String value) => _i1.ColumnValue(
    table.scopeKey,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> windowStart(DateTime value) =>
      _i1.ColumnValue(
        table.windowStart,
        value,
      );

  _i1.ColumnValue<int, int> requestCount(int value) => _i1.ColumnValue(
    table.requestCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ApiRateLimitBucketTable extends _i1.Table<int?> {
  ApiRateLimitBucketTable({super.tableRelation})
    : super(tableName: 'api_rate_limit_buckets') {
    updateTable = ApiRateLimitBucketUpdateTable(this);
    scopeKey = _i1.ColumnString(
      'scopeKey',
      this,
    );
    windowStart = _i1.ColumnDateTime(
      'windowStart',
      this,
    );
    requestCount = _i1.ColumnInt(
      'requestCount',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ApiRateLimitBucketUpdateTable updateTable;

  late final _i1.ColumnString scopeKey;

  late final _i1.ColumnDateTime windowStart;

  late final _i1.ColumnInt requestCount;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    scopeKey,
    windowStart,
    requestCount,
    updatedAt,
  ];
}

class ApiRateLimitBucketInclude extends _i1.IncludeObject {
  ApiRateLimitBucketInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ApiRateLimitBucket.t;
}

class ApiRateLimitBucketIncludeList extends _i1.IncludeList {
  ApiRateLimitBucketIncludeList._({
    _i1.WhereExpressionBuilder<ApiRateLimitBucketTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ApiRateLimitBucket.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ApiRateLimitBucket.t;
}

class ApiRateLimitBucketRepository {
  const ApiRateLimitBucketRepository._();

  /// Returns a list of [ApiRateLimitBucket]s matching the given query parameters.
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
  Future<List<ApiRateLimitBucket>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ApiRateLimitBucketTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ApiRateLimitBucketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ApiRateLimitBucketTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ApiRateLimitBucket>(
      where: where?.call(ApiRateLimitBucket.t),
      orderBy: orderBy?.call(ApiRateLimitBucket.t),
      orderByList: orderByList?.call(ApiRateLimitBucket.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ApiRateLimitBucket] matching the given query parameters.
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
  Future<ApiRateLimitBucket?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ApiRateLimitBucketTable>? where,
    int? offset,
    _i1.OrderByBuilder<ApiRateLimitBucketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ApiRateLimitBucketTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ApiRateLimitBucket>(
      where: where?.call(ApiRateLimitBucket.t),
      orderBy: orderBy?.call(ApiRateLimitBucket.t),
      orderByList: orderByList?.call(ApiRateLimitBucket.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ApiRateLimitBucket] by its [id] or null if no such row exists.
  Future<ApiRateLimitBucket?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ApiRateLimitBucket>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ApiRateLimitBucket]s in the list and returns the inserted rows.
  ///
  /// The returned [ApiRateLimitBucket]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ApiRateLimitBucket>> insert(
    _i1.DatabaseSession session,
    List<ApiRateLimitBucket> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ApiRateLimitBucket>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ApiRateLimitBucket] and returns the inserted row.
  ///
  /// The returned [ApiRateLimitBucket] will have its `id` field set.
  Future<ApiRateLimitBucket> insertRow(
    _i1.DatabaseSession session,
    ApiRateLimitBucket row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ApiRateLimitBucket>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ApiRateLimitBucket]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ApiRateLimitBucket>> update(
    _i1.DatabaseSession session,
    List<ApiRateLimitBucket> rows, {
    _i1.ColumnSelections<ApiRateLimitBucketTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ApiRateLimitBucket>(
      rows,
      columns: columns?.call(ApiRateLimitBucket.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ApiRateLimitBucket]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ApiRateLimitBucket> updateRow(
    _i1.DatabaseSession session,
    ApiRateLimitBucket row, {
    _i1.ColumnSelections<ApiRateLimitBucketTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ApiRateLimitBucket>(
      row,
      columns: columns?.call(ApiRateLimitBucket.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ApiRateLimitBucket] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ApiRateLimitBucket?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ApiRateLimitBucketUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ApiRateLimitBucket>(
      id,
      columnValues: columnValues(ApiRateLimitBucket.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ApiRateLimitBucket]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ApiRateLimitBucket>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ApiRateLimitBucketUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ApiRateLimitBucketTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ApiRateLimitBucketTable>? orderBy,
    _i1.OrderByListBuilder<ApiRateLimitBucketTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ApiRateLimitBucket>(
      columnValues: columnValues(ApiRateLimitBucket.t.updateTable),
      where: where(ApiRateLimitBucket.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ApiRateLimitBucket.t),
      orderByList: orderByList?.call(ApiRateLimitBucket.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ApiRateLimitBucket]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ApiRateLimitBucket>> delete(
    _i1.DatabaseSession session,
    List<ApiRateLimitBucket> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ApiRateLimitBucket>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ApiRateLimitBucket].
  Future<ApiRateLimitBucket> deleteRow(
    _i1.DatabaseSession session,
    ApiRateLimitBucket row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ApiRateLimitBucket>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ApiRateLimitBucket>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ApiRateLimitBucketTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ApiRateLimitBucket>(
      where: where(ApiRateLimitBucket.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ApiRateLimitBucketTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ApiRateLimitBucket>(
      where: where?.call(ApiRateLimitBucket.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ApiRateLimitBucket] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ApiRateLimitBucketTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ApiRateLimitBucket>(
      where: where(ApiRateLimitBucket.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
