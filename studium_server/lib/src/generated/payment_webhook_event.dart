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

abstract class PaymentWebhookEvent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PaymentWebhookEvent._({
    this.id,
    required this.gateway,
    required this.eventId,
    required this.eventType,
    required this.payload,
    required this.status,
    this.errorMessage,
    required this.receivedAt,
    this.processedAt,
  });

  factory PaymentWebhookEvent({
    int? id,
    required String gateway,
    required String eventId,
    required String eventType,
    required String payload,
    required String status,
    String? errorMessage,
    required DateTime receivedAt,
    DateTime? processedAt,
  }) = _PaymentWebhookEventImpl;

  factory PaymentWebhookEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return PaymentWebhookEvent(
      id: jsonSerialization['id'] as int?,
      gateway: jsonSerialization['gateway'] as String,
      eventId: jsonSerialization['eventId'] as String,
      eventType: jsonSerialization['eventType'] as String,
      payload: jsonSerialization['payload'] as String,
      status: jsonSerialization['status'] as String,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      receivedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
      processedAt: jsonSerialization['processedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['processedAt'],
            ),
    );
  }

  static final t = PaymentWebhookEventTable();

  static const db = PaymentWebhookEventRepository._();

  @override
  int? id;

  String gateway;

  String eventId;

  String eventType;

  String payload;

  String status;

  String? errorMessage;

  DateTime receivedAt;

  DateTime? processedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PaymentWebhookEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PaymentWebhookEvent copyWith({
    int? id,
    String? gateway,
    String? eventId,
    String? eventType,
    String? payload,
    String? status,
    String? errorMessage,
    DateTime? receivedAt,
    DateTime? processedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PaymentWebhookEvent',
      if (id != null) 'id': id,
      'gateway': gateway,
      'eventId': eventId,
      'eventType': eventType,
      'payload': payload,
      'status': status,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'receivedAt': receivedAt.toJson(),
      if (processedAt != null) 'processedAt': processedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PaymentWebhookEvent',
      if (id != null) 'id': id,
      'gateway': gateway,
      'eventId': eventId,
      'eventType': eventType,
      'payload': payload,
      'status': status,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'receivedAt': receivedAt.toJson(),
      if (processedAt != null) 'processedAt': processedAt?.toJson(),
    };
  }

  static PaymentWebhookEventInclude include() {
    return PaymentWebhookEventInclude._();
  }

  static PaymentWebhookEventIncludeList includeList({
    _i1.WhereExpressionBuilder<PaymentWebhookEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentWebhookEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentWebhookEventTable>? orderByList,
    PaymentWebhookEventInclude? include,
  }) {
    return PaymentWebhookEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PaymentWebhookEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PaymentWebhookEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentWebhookEventImpl extends PaymentWebhookEvent {
  _PaymentWebhookEventImpl({
    int? id,
    required String gateway,
    required String eventId,
    required String eventType,
    required String payload,
    required String status,
    String? errorMessage,
    required DateTime receivedAt,
    DateTime? processedAt,
  }) : super._(
         id: id,
         gateway: gateway,
         eventId: eventId,
         eventType: eventType,
         payload: payload,
         status: status,
         errorMessage: errorMessage,
         receivedAt: receivedAt,
         processedAt: processedAt,
       );

  /// Returns a shallow copy of this [PaymentWebhookEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PaymentWebhookEvent copyWith({
    Object? id = _Undefined,
    String? gateway,
    String? eventId,
    String? eventType,
    String? payload,
    String? status,
    Object? errorMessage = _Undefined,
    DateTime? receivedAt,
    Object? processedAt = _Undefined,
  }) {
    return PaymentWebhookEvent(
      id: id is int? ? id : this.id,
      gateway: gateway ?? this.gateway,
      eventId: eventId ?? this.eventId,
      eventType: eventType ?? this.eventType,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      receivedAt: receivedAt ?? this.receivedAt,
      processedAt: processedAt is DateTime? ? processedAt : this.processedAt,
    );
  }
}

class PaymentWebhookEventUpdateTable
    extends _i1.UpdateTable<PaymentWebhookEventTable> {
  PaymentWebhookEventUpdateTable(super.table);

  _i1.ColumnValue<String, String> gateway(String value) => _i1.ColumnValue(
    table.gateway,
    value,
  );

  _i1.ColumnValue<String, String> eventId(String value) => _i1.ColumnValue(
    table.eventId,
    value,
  );

  _i1.ColumnValue<String, String> eventType(String value) => _i1.ColumnValue(
    table.eventType,
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

  _i1.ColumnValue<String, String> errorMessage(String? value) =>
      _i1.ColumnValue(
        table.errorMessage,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> receivedAt(DateTime value) =>
      _i1.ColumnValue(
        table.receivedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> processedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.processedAt,
        value,
      );
}

class PaymentWebhookEventTable extends _i1.Table<int?> {
  PaymentWebhookEventTable({super.tableRelation})
    : super(tableName: 'payment_webhook_events') {
    updateTable = PaymentWebhookEventUpdateTable(this);
    gateway = _i1.ColumnString(
      'gateway',
      this,
    );
    eventId = _i1.ColumnString(
      'eventId',
      this,
    );
    eventType = _i1.ColumnString(
      'eventType',
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
    errorMessage = _i1.ColumnString(
      'errorMessage',
      this,
    );
    receivedAt = _i1.ColumnDateTime(
      'receivedAt',
      this,
    );
    processedAt = _i1.ColumnDateTime(
      'processedAt',
      this,
    );
  }

  late final PaymentWebhookEventUpdateTable updateTable;

  late final _i1.ColumnString gateway;

  late final _i1.ColumnString eventId;

  late final _i1.ColumnString eventType;

  late final _i1.ColumnString payload;

  late final _i1.ColumnString status;

  late final _i1.ColumnString errorMessage;

  late final _i1.ColumnDateTime receivedAt;

  late final _i1.ColumnDateTime processedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    gateway,
    eventId,
    eventType,
    payload,
    status,
    errorMessage,
    receivedAt,
    processedAt,
  ];
}

class PaymentWebhookEventInclude extends _i1.IncludeObject {
  PaymentWebhookEventInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PaymentWebhookEvent.t;
}

class PaymentWebhookEventIncludeList extends _i1.IncludeList {
  PaymentWebhookEventIncludeList._({
    _i1.WhereExpressionBuilder<PaymentWebhookEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PaymentWebhookEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PaymentWebhookEvent.t;
}

class PaymentWebhookEventRepository {
  const PaymentWebhookEventRepository._();

  /// Returns a list of [PaymentWebhookEvent]s matching the given query parameters.
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
  Future<List<PaymentWebhookEvent>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PaymentWebhookEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentWebhookEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentWebhookEventTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PaymentWebhookEvent>(
      where: where?.call(PaymentWebhookEvent.t),
      orderBy: orderBy?.call(PaymentWebhookEvent.t),
      orderByList: orderByList?.call(PaymentWebhookEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PaymentWebhookEvent] matching the given query parameters.
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
  Future<PaymentWebhookEvent?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PaymentWebhookEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<PaymentWebhookEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentWebhookEventTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PaymentWebhookEvent>(
      where: where?.call(PaymentWebhookEvent.t),
      orderBy: orderBy?.call(PaymentWebhookEvent.t),
      orderByList: orderByList?.call(PaymentWebhookEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PaymentWebhookEvent] by its [id] or null if no such row exists.
  Future<PaymentWebhookEvent?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PaymentWebhookEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PaymentWebhookEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [PaymentWebhookEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PaymentWebhookEvent>> insert(
    _i1.DatabaseSession session,
    List<PaymentWebhookEvent> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PaymentWebhookEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PaymentWebhookEvent] and returns the inserted row.
  ///
  /// The returned [PaymentWebhookEvent] will have its `id` field set.
  Future<PaymentWebhookEvent> insertRow(
    _i1.DatabaseSession session,
    PaymentWebhookEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PaymentWebhookEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PaymentWebhookEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PaymentWebhookEvent>> update(
    _i1.DatabaseSession session,
    List<PaymentWebhookEvent> rows, {
    _i1.ColumnSelections<PaymentWebhookEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PaymentWebhookEvent>(
      rows,
      columns: columns?.call(PaymentWebhookEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PaymentWebhookEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PaymentWebhookEvent> updateRow(
    _i1.DatabaseSession session,
    PaymentWebhookEvent row, {
    _i1.ColumnSelections<PaymentWebhookEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PaymentWebhookEvent>(
      row,
      columns: columns?.call(PaymentWebhookEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PaymentWebhookEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PaymentWebhookEvent?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PaymentWebhookEventUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PaymentWebhookEvent>(
      id,
      columnValues: columnValues(PaymentWebhookEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PaymentWebhookEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PaymentWebhookEvent>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PaymentWebhookEventUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PaymentWebhookEventTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentWebhookEventTable>? orderBy,
    _i1.OrderByListBuilder<PaymentWebhookEventTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PaymentWebhookEvent>(
      columnValues: columnValues(PaymentWebhookEvent.t.updateTable),
      where: where(PaymentWebhookEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PaymentWebhookEvent.t),
      orderByList: orderByList?.call(PaymentWebhookEvent.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PaymentWebhookEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PaymentWebhookEvent>> delete(
    _i1.DatabaseSession session,
    List<PaymentWebhookEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PaymentWebhookEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PaymentWebhookEvent].
  Future<PaymentWebhookEvent> deleteRow(
    _i1.DatabaseSession session,
    PaymentWebhookEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PaymentWebhookEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PaymentWebhookEvent>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PaymentWebhookEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PaymentWebhookEvent>(
      where: where(PaymentWebhookEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PaymentWebhookEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PaymentWebhookEvent>(
      where: where?.call(PaymentWebhookEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PaymentWebhookEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PaymentWebhookEventTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PaymentWebhookEvent>(
      where: where(PaymentWebhookEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
