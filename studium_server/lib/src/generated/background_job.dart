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

abstract class BackgroundJob
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BackgroundJob._({
    this.id,
    required this.jobType,
    required this.payload,
    required this.status,
    required this.attempts,
    required this.maxAttempts,
    required this.availableAt,
    this.lockedAt,
    this.lockToken,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BackgroundJob({
    int? id,
    required String jobType,
    required String payload,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BackgroundJobImpl;

  factory BackgroundJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return BackgroundJob(
      id: jsonSerialization['id'] as int?,
      jobType: jsonSerialization['jobType'] as String,
      payload: jsonSerialization['payload'] as String,
      status: jsonSerialization['status'] as String,
      attempts: jsonSerialization['attempts'] as int,
      maxAttempts: jsonSerialization['maxAttempts'] as int,
      availableAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['availableAt'],
      ),
      lockedAt: jsonSerialization['lockedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lockedAt']),
      lockToken: jsonSerialization['lockToken'] as String?,
      lastError: jsonSerialization['lastError'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = BackgroundJobTable();

  static const db = BackgroundJobRepository._();

  @override
  int? id;

  String jobType;

  String payload;

  String status;

  int attempts;

  int maxAttempts;

  DateTime availableAt;

  DateTime? lockedAt;

  String? lockToken;

  String? lastError;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BackgroundJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BackgroundJob copyWith({
    int? id,
    String? jobType,
    String? payload,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BackgroundJob',
      if (id != null) 'id': id,
      'jobType': jobType,
      'payload': payload,
      'status': status,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'availableAt': availableAt.toJson(),
      if (lockedAt != null) 'lockedAt': lockedAt?.toJson(),
      if (lockToken != null) 'lockToken': lockToken,
      if (lastError != null) 'lastError': lastError,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BackgroundJob',
      if (id != null) 'id': id,
      'jobType': jobType,
      'payload': payload,
      'status': status,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'availableAt': availableAt.toJson(),
      if (lockedAt != null) 'lockedAt': lockedAt?.toJson(),
      if (lockToken != null) 'lockToken': lockToken,
      if (lastError != null) 'lastError': lastError,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static BackgroundJobInclude include() {
    return BackgroundJobInclude._();
  }

  static BackgroundJobIncludeList includeList({
    _i1.WhereExpressionBuilder<BackgroundJobTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BackgroundJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BackgroundJobTable>? orderByList,
    BackgroundJobInclude? include,
  }) {
    return BackgroundJobIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BackgroundJob.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BackgroundJob.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BackgroundJobImpl extends BackgroundJob {
  _BackgroundJobImpl({
    int? id,
    required String jobType,
    required String payload,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         jobType: jobType,
         payload: payload,
         status: status,
         attempts: attempts,
         maxAttempts: maxAttempts,
         availableAt: availableAt,
         lockedAt: lockedAt,
         lockToken: lockToken,
         lastError: lastError,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BackgroundJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BackgroundJob copyWith({
    Object? id = _Undefined,
    String? jobType,
    String? payload,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    Object? lockedAt = _Undefined,
    Object? lockToken = _Undefined,
    Object? lastError = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BackgroundJob(
      id: id is int? ? id : this.id,
      jobType: jobType ?? this.jobType,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      availableAt: availableAt ?? this.availableAt,
      lockedAt: lockedAt is DateTime? ? lockedAt : this.lockedAt,
      lockToken: lockToken is String? ? lockToken : this.lockToken,
      lastError: lastError is String? ? lastError : this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BackgroundJobUpdateTable extends _i1.UpdateTable<BackgroundJobTable> {
  BackgroundJobUpdateTable(super.table);

  _i1.ColumnValue<String, String> jobType(String value) => _i1.ColumnValue(
    table.jobType,
    value,
  );

  _i1.ColumnValue<String, String> payload(String value) => _i1.ColumnValue(
    table.payload,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> attempts(int value) => _i1.ColumnValue(
    table.attempts,
    value,
  );

  _i1.ColumnValue<int, int> maxAttempts(int value) => _i1.ColumnValue(
    table.maxAttempts,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> availableAt(DateTime value) =>
      _i1.ColumnValue(
        table.availableAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lockedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lockedAt,
        value,
      );

  _i1.ColumnValue<String, String> lockToken(String? value) => _i1.ColumnValue(
    table.lockToken,
    value,
  );

  _i1.ColumnValue<String, String> lastError(String? value) => _i1.ColumnValue(
    table.lastError,
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

class BackgroundJobTable extends _i1.Table<int?> {
  BackgroundJobTable({super.tableRelation})
    : super(tableName: 'background_jobs') {
    updateTable = BackgroundJobUpdateTable(this);
    jobType = _i1.ColumnString(
      'jobType',
      this,
    );
    payload = _i1.ColumnString(
      'payload',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    attempts = _i1.ColumnInt(
      'attempts',
      this,
    );
    maxAttempts = _i1.ColumnInt(
      'maxAttempts',
      this,
    );
    availableAt = _i1.ColumnDateTime(
      'availableAt',
      this,
    );
    lockedAt = _i1.ColumnDateTime(
      'lockedAt',
      this,
    );
    lockToken = _i1.ColumnString(
      'lockToken',
      this,
    );
    lastError = _i1.ColumnString(
      'lastError',
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

  late final BackgroundJobUpdateTable updateTable;

  late final _i1.ColumnString jobType;

  late final _i1.ColumnString payload;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt attempts;

  late final _i1.ColumnInt maxAttempts;

  late final _i1.ColumnDateTime availableAt;

  late final _i1.ColumnDateTime lockedAt;

  late final _i1.ColumnString lockToken;

  late final _i1.ColumnString lastError;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    jobType,
    payload,
    status,
    attempts,
    maxAttempts,
    availableAt,
    lockedAt,
    lockToken,
    lastError,
    createdAt,
    updatedAt,
  ];
}

class BackgroundJobInclude extends _i1.IncludeObject {
  BackgroundJobInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BackgroundJob.t;
}

class BackgroundJobIncludeList extends _i1.IncludeList {
  BackgroundJobIncludeList._({
    _i1.WhereExpressionBuilder<BackgroundJobTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BackgroundJob.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BackgroundJob.t;
}

class BackgroundJobRepository {
  const BackgroundJobRepository._();

  /// Returns a list of [BackgroundJob]s matching the given query parameters.
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
  Future<List<BackgroundJob>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BackgroundJobTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BackgroundJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BackgroundJobTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BackgroundJob>(
      where: where?.call(BackgroundJob.t),
      orderBy: orderBy?.call(BackgroundJob.t),
      orderByList: orderByList?.call(BackgroundJob.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BackgroundJob] matching the given query parameters.
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
  Future<BackgroundJob?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BackgroundJobTable>? where,
    int? offset,
    _i1.OrderByBuilder<BackgroundJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BackgroundJobTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BackgroundJob>(
      where: where?.call(BackgroundJob.t),
      orderBy: orderBy?.call(BackgroundJob.t),
      orderByList: orderByList?.call(BackgroundJob.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BackgroundJob] by its [id] or null if no such row exists.
  Future<BackgroundJob?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BackgroundJob>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BackgroundJob]s in the list and returns the inserted rows.
  ///
  /// The returned [BackgroundJob]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BackgroundJob>> insert(
    _i1.DatabaseSession session,
    List<BackgroundJob> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BackgroundJob>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BackgroundJob] and returns the inserted row.
  ///
  /// The returned [BackgroundJob] will have its `id` field set.
  Future<BackgroundJob> insertRow(
    _i1.DatabaseSession session,
    BackgroundJob row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BackgroundJob>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BackgroundJob]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BackgroundJob>> update(
    _i1.DatabaseSession session,
    List<BackgroundJob> rows, {
    _i1.ColumnSelections<BackgroundJobTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BackgroundJob>(
      rows,
      columns: columns?.call(BackgroundJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BackgroundJob]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BackgroundJob> updateRow(
    _i1.DatabaseSession session,
    BackgroundJob row, {
    _i1.ColumnSelections<BackgroundJobTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BackgroundJob>(
      row,
      columns: columns?.call(BackgroundJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BackgroundJob] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BackgroundJob?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BackgroundJobUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BackgroundJob>(
      id,
      columnValues: columnValues(BackgroundJob.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BackgroundJob]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BackgroundJob>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BackgroundJobUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BackgroundJobTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BackgroundJobTable>? orderBy,
    _i1.OrderByListBuilder<BackgroundJobTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BackgroundJob>(
      columnValues: columnValues(BackgroundJob.t.updateTable),
      where: where(BackgroundJob.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BackgroundJob.t),
      orderByList: orderByList?.call(BackgroundJob.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BackgroundJob]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BackgroundJob>> delete(
    _i1.DatabaseSession session,
    List<BackgroundJob> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BackgroundJob>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BackgroundJob].
  Future<BackgroundJob> deleteRow(
    _i1.DatabaseSession session,
    BackgroundJob row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BackgroundJob>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BackgroundJob>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BackgroundJobTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BackgroundJob>(
      where: where(BackgroundJob.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BackgroundJobTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BackgroundJob>(
      where: where?.call(BackgroundJob.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BackgroundJob] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BackgroundJobTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BackgroundJob>(
      where: where(BackgroundJob.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
