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

abstract class Subscription
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Subscription._({
    this.id,
    required this.userId,
    required this.gateway,
    required this.subscriptionId,
    this.gatewayToken,
    required this.status,
    required this.startDate,
    this.endDate,
  });

  factory Subscription({
    int? id,
    required int userId,
    required String gateway,
    required String subscriptionId,
    String? gatewayToken,
    required String status,
    required DateTime startDate,
    DateTime? endDate,
  }) = _SubscriptionImpl;

  factory Subscription.fromJson(Map<String, dynamic> jsonSerialization) {
    return Subscription(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      gateway: jsonSerialization['gateway'] as String,
      subscriptionId: jsonSerialization['subscriptionId'] as String,
      gatewayToken: jsonSerialization['gatewayToken'] as String?,
      status: jsonSerialization['status'] as String,
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
    );
  }

  static final t = SubscriptionTable();

  static const db = SubscriptionRepository._();

  @override
  int? id;

  int userId;

  String gateway;

  String subscriptionId;

  String? gatewayToken;

  String status;

  DateTime startDate;

  DateTime? endDate;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Subscription]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Subscription copyWith({
    int? id,
    int? userId,
    String? gateway,
    String? subscriptionId,
    String? gatewayToken,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Subscription',
      if (id != null) 'id': id,
      'userId': userId,
      'gateway': gateway,
      'subscriptionId': subscriptionId,
      if (gatewayToken != null) 'gatewayToken': gatewayToken,
      'status': status,
      'startDate': startDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Subscription',
      if (id != null) 'id': id,
      'userId': userId,
      'gateway': gateway,
      'subscriptionId': subscriptionId,
      if (gatewayToken != null) 'gatewayToken': gatewayToken,
      'status': status,
      'startDate': startDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
    };
  }

  static SubscriptionInclude include() {
    return SubscriptionInclude._();
  }

  static SubscriptionIncludeList includeList({
    _i1.WhereExpressionBuilder<SubscriptionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionTable>? orderByList,
    SubscriptionInclude? include,
  }) {
    return SubscriptionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subscription.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Subscription.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubscriptionImpl extends Subscription {
  _SubscriptionImpl({
    int? id,
    required int userId,
    required String gateway,
    required String subscriptionId,
    String? gatewayToken,
    required String status,
    required DateTime startDate,
    DateTime? endDate,
  }) : super._(
         id: id,
         userId: userId,
         gateway: gateway,
         subscriptionId: subscriptionId,
         gatewayToken: gatewayToken,
         status: status,
         startDate: startDate,
         endDate: endDate,
       );

  /// Returns a shallow copy of this [Subscription]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Subscription copyWith({
    Object? id = _Undefined,
    int? userId,
    String? gateway,
    String? subscriptionId,
    Object? gatewayToken = _Undefined,
    String? status,
    DateTime? startDate,
    Object? endDate = _Undefined,
  }) {
    return Subscription(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      gateway: gateway ?? this.gateway,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      gatewayToken: gatewayToken is String? ? gatewayToken : this.gatewayToken,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
    );
  }
}

class SubscriptionUpdateTable extends _i1.UpdateTable<SubscriptionTable> {
  SubscriptionUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> gateway(String value) => _i1.ColumnValue(
    table.gateway,
    value,
  );

  _i1.ColumnValue<String, String> subscriptionId(String value) =>
      _i1.ColumnValue(
        table.subscriptionId,
        value,
      );

  _i1.ColumnValue<String, String> gatewayToken(String? value) =>
      _i1.ColumnValue(
        table.gatewayToken,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startDate(DateTime value) =>
      _i1.ColumnValue(
        table.startDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endDate(DateTime? value) =>
      _i1.ColumnValue(
        table.endDate,
        value,
      );
}

class SubscriptionTable extends _i1.Table<int?> {
  SubscriptionTable({super.tableRelation}) : super(tableName: 'subscriptions') {
    updateTable = SubscriptionUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    gateway = _i1.ColumnString(
      'gateway',
      this,
    );
    subscriptionId = _i1.ColumnString(
      'subscriptionId',
      this,
    );
    gatewayToken = _i1.ColumnString(
      'gatewayToken',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    startDate = _i1.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _i1.ColumnDateTime(
      'endDate',
      this,
    );
  }

  late final SubscriptionUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString gateway;

  late final _i1.ColumnString subscriptionId;

  late final _i1.ColumnString gatewayToken;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime startDate;

  late final _i1.ColumnDateTime endDate;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    gateway,
    subscriptionId,
    gatewayToken,
    status,
    startDate,
    endDate,
  ];
}

class SubscriptionInclude extends _i1.IncludeObject {
  SubscriptionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Subscription.t;
}

class SubscriptionIncludeList extends _i1.IncludeList {
  SubscriptionIncludeList._({
    _i1.WhereExpressionBuilder<SubscriptionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Subscription.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Subscription.t;
}

class SubscriptionRepository {
  const SubscriptionRepository._();

  /// Returns a list of [Subscription]s matching the given query parameters.
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
  Future<List<Subscription>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubscriptionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Subscription>(
      where: where?.call(Subscription.t),
      orderBy: orderBy?.call(Subscription.t),
      orderByList: orderByList?.call(Subscription.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Subscription] matching the given query parameters.
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
  Future<Subscription?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubscriptionTable>? where,
    int? offset,
    _i1.OrderByBuilder<SubscriptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SubscriptionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Subscription>(
      where: where?.call(Subscription.t),
      orderBy: orderBy?.call(Subscription.t),
      orderByList: orderByList?.call(Subscription.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Subscription] by its [id] or null if no such row exists.
  Future<Subscription?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Subscription>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Subscription]s in the list and returns the inserted rows.
  ///
  /// The returned [Subscription]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Subscription>> insert(
    _i1.DatabaseSession session,
    List<Subscription> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Subscription>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Subscription] and returns the inserted row.
  ///
  /// The returned [Subscription] will have its `id` field set.
  Future<Subscription> insertRow(
    _i1.DatabaseSession session,
    Subscription row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Subscription>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Subscription]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Subscription>> update(
    _i1.DatabaseSession session,
    List<Subscription> rows, {
    _i1.ColumnSelections<SubscriptionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Subscription>(
      rows,
      columns: columns?.call(Subscription.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subscription]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Subscription> updateRow(
    _i1.DatabaseSession session,
    Subscription row, {
    _i1.ColumnSelections<SubscriptionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Subscription>(
      row,
      columns: columns?.call(Subscription.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Subscription] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Subscription?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SubscriptionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Subscription>(
      id,
      columnValues: columnValues(Subscription.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Subscription]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Subscription>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SubscriptionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SubscriptionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SubscriptionTable>? orderBy,
    _i1.OrderByListBuilder<SubscriptionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Subscription>(
      columnValues: columnValues(Subscription.t.updateTable),
      where: where(Subscription.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Subscription.t),
      orderByList: orderByList?.call(Subscription.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Subscription]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Subscription>> delete(
    _i1.DatabaseSession session,
    List<Subscription> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Subscription>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Subscription].
  Future<Subscription> deleteRow(
    _i1.DatabaseSession session,
    Subscription row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Subscription>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Subscription>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubscriptionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Subscription>(
      where: where(Subscription.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SubscriptionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Subscription>(
      where: where?.call(Subscription.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Subscription] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SubscriptionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Subscription>(
      where: where(Subscription.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
