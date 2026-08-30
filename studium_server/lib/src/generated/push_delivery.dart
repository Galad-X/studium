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

abstract class PushDelivery
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PushDelivery._({
    this.id,
    required this.userId,
    required this.title,
    required this.message,
    this.type,
    this.relatedId,
    required this.status,
    required this.attempts,
    required this.maxAttempts,
    required this.availableAt,
    this.lockedAt,
    this.lockToken,
    this.lastError,
    this.sentAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PushDelivery({
    int? id,
    required int userId,
    required String title,
    required String message,
    String? type,
    int? relatedId,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PushDeliveryImpl;

  factory PushDelivery.fromJson(Map<String, dynamic> jsonSerialization) {
    return PushDelivery(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      message: jsonSerialization['message'] as String,
      type: jsonSerialization['type'] as String?,
      relatedId: jsonSerialization['relatedId'] as int?,
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
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = PushDeliveryTable();

  static const db = PushDeliveryRepository._();

  @override
  int? id;

  int userId;

  String title;

  String message;

  String? type;

  int? relatedId;

  String status;

  int attempts;

  int maxAttempts;

  DateTime availableAt;

  DateTime? lockedAt;

  String? lockToken;

  String? lastError;

  DateTime? sentAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PushDelivery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PushDelivery copyWith({
    int? id,
    int? userId,
    String? title,
    String? message,
    String? type,
    int? relatedId,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PushDelivery',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'message': message,
      if (type != null) 'type': type,
      if (relatedId != null) 'relatedId': relatedId,
      'status': status,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'availableAt': availableAt.toJson(),
      if (lockedAt != null) 'lockedAt': lockedAt?.toJson(),
      if (lockToken != null) 'lockToken': lockToken,
      if (lastError != null) 'lastError': lastError,
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PushDelivery',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'message': message,
      if (type != null) 'type': type,
      if (relatedId != null) 'relatedId': relatedId,
      'status': status,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'availableAt': availableAt.toJson(),
      if (lockedAt != null) 'lockedAt': lockedAt?.toJson(),
      if (lockToken != null) 'lockToken': lockToken,
      if (lastError != null) 'lastError': lastError,
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PushDeliveryInclude include() {
    return PushDeliveryInclude._();
  }

  static PushDeliveryIncludeList includeList({
    _i1.WhereExpressionBuilder<PushDeliveryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PushDeliveryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PushDeliveryTable>? orderByList,
    PushDeliveryInclude? include,
  }) {
    return PushDeliveryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PushDelivery.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PushDelivery.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PushDeliveryImpl extends PushDelivery {
  _PushDeliveryImpl({
    int? id,
    required int userId,
    required String title,
    required String message,
    String? type,
    int? relatedId,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         message: message,
         type: type,
         relatedId: relatedId,
         status: status,
         attempts: attempts,
         maxAttempts: maxAttempts,
         availableAt: availableAt,
         lockedAt: lockedAt,
         lockToken: lockToken,
         lastError: lastError,
         sentAt: sentAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PushDelivery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PushDelivery copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    String? message,
    Object? type = _Undefined,
    Object? relatedId = _Undefined,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    Object? lockedAt = _Undefined,
    Object? lockToken = _Undefined,
    Object? lastError = _Undefined,
    Object? sentAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PushDelivery(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type is String? ? type : this.type,
      relatedId: relatedId is int? ? relatedId : this.relatedId,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      availableAt: availableAt ?? this.availableAt,
      lockedAt: lockedAt is DateTime? ? lockedAt : this.lockedAt,
      lockToken: lockToken is String? ? lockToken : this.lockToken,
      lastError: lastError is String? ? lastError : this.lastError,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PushDeliveryUpdateTable extends _i1.UpdateTable<PushDeliveryTable> {
  PushDeliveryUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> message(String value) => _i1.ColumnValue(
    table.message,
    value,
  );

  _i1.ColumnValue<String, String> type(String? value) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<int, int> relatedId(int? value) => _i1.ColumnValue(
    table.relatedId,
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

  _i1.ColumnValue<DateTime, DateTime> sentAt(DateTime? value) =>
      _i1.ColumnValue(
        table.sentAt,
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

class PushDeliveryTable extends _i1.Table<int?> {
  PushDeliveryTable({super.tableRelation})
    : super(tableName: 'push_deliveries') {
    updateTable = PushDeliveryUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    message = _i1.ColumnString(
      'message',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    relatedId = _i1.ColumnInt(
      'relatedId',
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
    sentAt = _i1.ColumnDateTime(
      'sentAt',
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

  late final PushDeliveryUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString message;

  late final _i1.ColumnString type;

  late final _i1.ColumnInt relatedId;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt attempts;

  late final _i1.ColumnInt maxAttempts;

  late final _i1.ColumnDateTime availableAt;

  late final _i1.ColumnDateTime lockedAt;

  late final _i1.ColumnString lockToken;

  late final _i1.ColumnString lastError;

  late final _i1.ColumnDateTime sentAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    title,
    message,
    type,
    relatedId,
    status,
    attempts,
    maxAttempts,
    availableAt,
    lockedAt,
    lockToken,
    lastError,
    sentAt,
    createdAt,
    updatedAt,
  ];
}

class PushDeliveryInclude extends _i1.IncludeObject {
  PushDeliveryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PushDelivery.t;
}

class PushDeliveryIncludeList extends _i1.IncludeList {
  PushDeliveryIncludeList._({
    _i1.WhereExpressionBuilder<PushDeliveryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PushDelivery.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PushDelivery.t;
}

class PushDeliveryRepository {
  const PushDeliveryRepository._();

  /// Returns a list of [PushDelivery]s matching the given query parameters.
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
  Future<List<PushDelivery>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PushDeliveryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PushDeliveryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PushDeliveryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PushDelivery>(
      where: where?.call(PushDelivery.t),
      orderBy: orderBy?.call(PushDelivery.t),
      orderByList: orderByList?.call(PushDelivery.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PushDelivery] matching the given query parameters.
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
  Future<PushDelivery?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PushDeliveryTable>? where,
    int? offset,
    _i1.OrderByBuilder<PushDeliveryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PushDeliveryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PushDelivery>(
      where: where?.call(PushDelivery.t),
      orderBy: orderBy?.call(PushDelivery.t),
      orderByList: orderByList?.call(PushDelivery.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PushDelivery] by its [id] or null if no such row exists.
  Future<PushDelivery?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PushDelivery>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PushDelivery]s in the list and returns the inserted rows.
  ///
  /// The returned [PushDelivery]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PushDelivery>> insert(
    _i1.DatabaseSession session,
    List<PushDelivery> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PushDelivery>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PushDelivery] and returns the inserted row.
  ///
  /// The returned [PushDelivery] will have its `id` field set.
  Future<PushDelivery> insertRow(
    _i1.DatabaseSession session,
    PushDelivery row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PushDelivery>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PushDelivery]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PushDelivery>> update(
    _i1.DatabaseSession session,
    List<PushDelivery> rows, {
    _i1.ColumnSelections<PushDeliveryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PushDelivery>(
      rows,
      columns: columns?.call(PushDelivery.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PushDelivery]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PushDelivery> updateRow(
    _i1.DatabaseSession session,
    PushDelivery row, {
    _i1.ColumnSelections<PushDeliveryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PushDelivery>(
      row,
      columns: columns?.call(PushDelivery.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PushDelivery] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PushDelivery?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PushDeliveryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PushDelivery>(
      id,
      columnValues: columnValues(PushDelivery.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PushDelivery]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PushDelivery>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PushDeliveryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PushDeliveryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PushDeliveryTable>? orderBy,
    _i1.OrderByListBuilder<PushDeliveryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PushDelivery>(
      columnValues: columnValues(PushDelivery.t.updateTable),
      where: where(PushDelivery.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PushDelivery.t),
      orderByList: orderByList?.call(PushDelivery.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PushDelivery]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PushDelivery>> delete(
    _i1.DatabaseSession session,
    List<PushDelivery> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PushDelivery>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PushDelivery].
  Future<PushDelivery> deleteRow(
    _i1.DatabaseSession session,
    PushDelivery row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PushDelivery>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PushDelivery>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PushDeliveryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PushDelivery>(
      where: where(PushDelivery.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PushDeliveryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PushDelivery>(
      where: where?.call(PushDelivery.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PushDelivery] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PushDeliveryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PushDelivery>(
      where: where(PushDelivery.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
