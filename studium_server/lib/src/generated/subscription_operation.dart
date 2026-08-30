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

abstract class SubscriptionOperation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SubscriptionOperation._({
    this.id,
    required this.userId,
    required this.gateway,
    required this.idempotencyKey,
    required this.status,
    this.subscriptionId,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionOperation({
    int? id,
    required int userId,
    required String gateway,
    required String idempotencyKey,
    required String status,
    int? subscriptionId,
    String? errorMessage,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SubscriptionOperationImpl;

  factory SubscriptionOperation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubscriptionOperation(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      gateway: jsonSerialization['gateway'] as String,
      idempotencyKey: jsonSerialization['idempotencyKey'] as String,
      status: jsonSerialization['status'] as String,
      subscriptionId: jsonSerialization['subscriptionId'] as int?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = SubscriptionOperationTable();

  static const db = SubscriptionOperationRepository._();

  @override
  int? id;

  int userId;

  String gateway;

  String idempotencyKey;

  String status;

  int? subscriptionId;

  String? errorMessage;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubscriptionOperation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubscriptionOperation copyWith({
    int? id,
    int? userId,
    String? gateway,
    String? idempotencyKey,
    String? status,
    int? subscriptionId,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubscriptionOperation',
      if (id != null) 'id': id,
      'userId': userId,
      'gateway': gateway,
      'idempotencyKey': idempotencyKey,
      'status': status,
      if (subscriptionId != null) 'subscriptionId': subscriptionId,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubscriptionOperation',
      if (id != null) 'id': id,
      'userId': userId,
      'gateway': gateway,
      'idempotencyKey': idempotencyKey,
      'status': status,
      if (subscriptionId != null) 'subscriptionId': subscriptionId,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SubscriptionOperationInclude include() {
    return SubscriptionOperationInclude._();
  }

  static SubscriptionOperationIncludeList includeList({
    _i1.WhereExpressionBuilder<SubscriptionOperationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionOperationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionOperationTable>? orderByList,
    SubscriptionOperationInclude? include,
  }) {
    return SubscriptionOperationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubscriptionOperation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SubscriptionOperation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubscriptionOperationImpl extends SubscriptionOperation {
  _SubscriptionOperationImpl({
    int? id,
    required int userId,
    required String gateway,
    required String idempotencyKey,
    required String status,
    int? subscriptionId,
    String? errorMessage,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          gateway: gateway,
          idempotencyKey: idempotencyKey,
          status: status,
          subscriptionId: subscriptionId,
          errorMessage: errorMessage,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [SubscriptionOperation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubscriptionOperation copyWith({
    Object? id = _Undefined,
    int? userId,
    String? gateway,
    String? idempotencyKey,
    String? status,
    Object? subscriptionId = _Undefined,
    Object? errorMessage = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubscriptionOperation(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      gateway: gateway ?? this.gateway,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      status: status ?? this.status,
      subscriptionId:
          subscriptionId is int? ? subscriptionId : this.subscriptionId,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubscriptionOperationUpdateTable
    extends _i1.UpdateTable<SubscriptionOperationTable> {
  SubscriptionOperationUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> gateway(String value) => _i1.ColumnValue(
        table.gateway,
        value,
      );

  _i1.ColumnValue<String, String> idempotencyKey(String value) =>
      _i1.ColumnValue(
        table.idempotencyKey,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
        table.status,
        value,
      );

  _i1.ColumnValue<int, int> subscriptionId(int? value) => _i1.ColumnValue(
        table.subscriptionId,
        value,
      );

  _i1.ColumnValue<String, String> errorMessage(String? value) =>
      _i1.ColumnValue(
        table.errorMessage,
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

class SubscriptionOperationTable extends _i1.Table<int?> {
  SubscriptionOperationTable({super.tableRelation})
      : super(tableName: 'subscription_operations') {
    updateTable = SubscriptionOperationUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    gateway = _i1.ColumnString(
      'gateway',
      this,
    );
    idempotencyKey = _i1.ColumnString(
      'idempotencyKey',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    subscriptionId = _i1.ColumnInt(
      'subscriptionId',
      this,
    );
    errorMessage = _i1.ColumnString(
      'errorMessage',
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

  late final SubscriptionOperationUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString gateway;

  late final _i1.ColumnString idempotencyKey;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt subscriptionId;

  late final _i1.ColumnString errorMessage;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        gateway,
        idempotencyKey,
        status,
        subscriptionId,
        errorMessage,
        createdAt,
        updatedAt,
      ];
}

class SubscriptionOperationInclude extends _i1.IncludeObject {
  SubscriptionOperationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SubscriptionOperation.t;
}

class SubscriptionOperationIncludeList extends _i1.IncludeList {
  SubscriptionOperationIncludeList._({
    _i1.WhereExpressionBuilder<SubscriptionOperationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubscriptionOperation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SubscriptionOperation.t;
}

class SubscriptionOperationRepository {
  const SubscriptionOperationRepository._();

  /// Returns a list of [SubscriptionOperation]s matching the given query parameters.
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
  Future<List<SubscriptionOperation>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubscriptionOperationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionOperationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionOperationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubscriptionOperation>(
      where: where?.call(SubscriptionOperation.t),
      orderBy: orderBy?.call(SubscriptionOperation.t),
      orderByList: orderByList?.call(SubscriptionOperation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubscriptionOperation] matching the given query parameters.
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
  Future<SubscriptionOperation?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubscriptionOperationTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubscriptionOperationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionOperationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubscriptionOperation>(
      where: where?.call(SubscriptionOperation.t),
      orderBy: orderBy?.call(SubscriptionOperation.t),
      orderByList: orderByList?.call(SubscriptionOperation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubscriptionOperation] by its [id] or null if no such row exists.
  Future<SubscriptionOperation?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubscriptionOperation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubscriptionOperation]s in the list and returns the inserted rows.
  ///
  /// The returned [SubscriptionOperation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SubscriptionOperation>> insert(
    _i1.DatabaseSession session,
    List<SubscriptionOperation> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SubscriptionOperation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SubscriptionOperation] and returns the inserted row.
  ///
  /// The returned [SubscriptionOperation] will have its `id` field set.
  Future<SubscriptionOperation> insertRow(
    _i1.DatabaseSession session,
    SubscriptionOperation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubscriptionOperation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SubscriptionOperation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SubscriptionOperation>> update(
    _i1.DatabaseSession session,
    List<SubscriptionOperation> rows, {
    _i1.ColumnSelections<SubscriptionOperationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SubscriptionOperation>(
      rows,
      columns: columns?.call(SubscriptionOperation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubscriptionOperation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubscriptionOperation> updateRow(
    _i1.DatabaseSession session,
    SubscriptionOperation row, {
    _i1.ColumnSelections<SubscriptionOperationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubscriptionOperation>(
      row,
      columns: columns?.call(SubscriptionOperation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubscriptionOperation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubscriptionOperation?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubscriptionOperationUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SubscriptionOperation>(
      id,
      columnValues: columnValues(SubscriptionOperation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubscriptionOperation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SubscriptionOperation>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubscriptionOperationUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<SubscriptionOperationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionOperationTable>? orderBy,
    _i1.OrderByListBuilder<SubscriptionOperationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SubscriptionOperation>(
      columnValues: columnValues(SubscriptionOperation.t.updateTable),
      where: where(SubscriptionOperation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubscriptionOperation.t),
      orderByList: orderByList?.call(SubscriptionOperation.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SubscriptionOperation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SubscriptionOperation>> delete(
    _i1.DatabaseSession session,
    List<SubscriptionOperation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SubscriptionOperation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SubscriptionOperation].
  Future<SubscriptionOperation> deleteRow(
    _i1.DatabaseSession session,
    SubscriptionOperation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubscriptionOperation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SubscriptionOperation>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubscriptionOperationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SubscriptionOperation>(
      where: where(SubscriptionOperation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubscriptionOperationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SubscriptionOperation>(
      where: where?.call(SubscriptionOperation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubscriptionOperation] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubscriptionOperationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubscriptionOperation>(
      where: where(SubscriptionOperation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
