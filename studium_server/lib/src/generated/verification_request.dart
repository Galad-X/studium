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

abstract class VerificationRequest
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  VerificationRequest._({
    this.id,
    required this.membershipId,
    required this.method,
    this.evidenceUrl,
    required this.status,
    this.reviewerId,
    required this.createdAt,
    this.reviewedAt,
  });

  factory VerificationRequest({
    int? id,
    required int membershipId,
    required String method,
    String? evidenceUrl,
    required String status,
    int? reviewerId,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) = _VerificationRequestImpl;

  factory VerificationRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return VerificationRequest(
      id: jsonSerialization['id'] as int?,
      membershipId: jsonSerialization['membershipId'] as int,
      method: jsonSerialization['method'] as String,
      evidenceUrl: jsonSerialization['evidenceUrl'] as String?,
      status: jsonSerialization['status'] as String,
      reviewerId: jsonSerialization['reviewerId'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
    );
  }

  static final t = VerificationRequestTable();

  static const db = VerificationRequestRepository._();

  @override
  int? id;

  int membershipId;

  String method;

  String? evidenceUrl;

  String status;

  int? reviewerId;

  DateTime createdAt;

  DateTime? reviewedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [VerificationRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VerificationRequest copyWith({
    int? id,
    int? membershipId,
    String? method,
    String? evidenceUrl,
    String? status,
    int? reviewerId,
    DateTime? createdAt,
    DateTime? reviewedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VerificationRequest',
      if (id != null) 'id': id,
      'membershipId': membershipId,
      'method': method,
      if (evidenceUrl != null) 'evidenceUrl': evidenceUrl,
      'status': status,
      if (reviewerId != null) 'reviewerId': reviewerId,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VerificationRequest',
      if (id != null) 'id': id,
      'membershipId': membershipId,
      'method': method,
      if (evidenceUrl != null) 'evidenceUrl': evidenceUrl,
      'status': status,
      if (reviewerId != null) 'reviewerId': reviewerId,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  static VerificationRequestInclude include() {
    return VerificationRequestInclude._();
  }

  static VerificationRequestIncludeList includeList({
    _i1.WhereExpressionBuilder<VerificationRequestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VerificationRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VerificationRequestTable>? orderByList,
    VerificationRequestInclude? include,
  }) {
    return VerificationRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VerificationRequest.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(VerificationRequest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VerificationRequestImpl extends VerificationRequest {
  _VerificationRequestImpl({
    int? id,
    required int membershipId,
    required String method,
    String? evidenceUrl,
    required String status,
    int? reviewerId,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) : super._(
         id: id,
         membershipId: membershipId,
         method: method,
         evidenceUrl: evidenceUrl,
         status: status,
         reviewerId: reviewerId,
         createdAt: createdAt,
         reviewedAt: reviewedAt,
       );

  /// Returns a shallow copy of this [VerificationRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VerificationRequest copyWith({
    Object? id = _Undefined,
    int? membershipId,
    String? method,
    Object? evidenceUrl = _Undefined,
    String? status,
    Object? reviewerId = _Undefined,
    DateTime? createdAt,
    Object? reviewedAt = _Undefined,
  }) {
    return VerificationRequest(
      id: id is int? ? id : this.id,
      membershipId: membershipId ?? this.membershipId,
      method: method ?? this.method,
      evidenceUrl: evidenceUrl is String? ? evidenceUrl : this.evidenceUrl,
      status: status ?? this.status,
      reviewerId: reviewerId is int? ? reviewerId : this.reviewerId,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
    );
  }
}

class VerificationRequestUpdateTable
    extends _i1.UpdateTable<VerificationRequestTable> {
  VerificationRequestUpdateTable(super.table);

  _i1.ColumnValue<int, int> membershipId(int value) => _i1.ColumnValue(
    table.membershipId,
    value,
  );

  _i1.ColumnValue<String, String> method(String value) => _i1.ColumnValue(
    table.method,
    value,
  );

  _i1.ColumnValue<String, String> evidenceUrl(String? value) => _i1.ColumnValue(
    table.evidenceUrl,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> reviewerId(int? value) => _i1.ColumnValue(
    table.reviewerId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> reviewedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.reviewedAt,
        value,
      );
}

class VerificationRequestTable extends _i1.Table<int?> {
  VerificationRequestTable({super.tableRelation})
    : super(tableName: 'verification_requests') {
    updateTable = VerificationRequestUpdateTable(this);
    membershipId = _i1.ColumnInt(
      'membershipId',
      this,
    );
    method = _i1.ColumnString(
      'method',
      this,
    );
    evidenceUrl = _i1.ColumnString(
      'evidenceUrl',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    reviewerId = _i1.ColumnInt(
      'reviewerId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    reviewedAt = _i1.ColumnDateTime(
      'reviewedAt',
      this,
    );
  }

  late final VerificationRequestUpdateTable updateTable;

  late final _i1.ColumnInt membershipId;

  late final _i1.ColumnString method;

  late final _i1.ColumnString evidenceUrl;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt reviewerId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime reviewedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    membershipId,
    method,
    evidenceUrl,
    status,
    reviewerId,
    createdAt,
    reviewedAt,
  ];
}

class VerificationRequestInclude extends _i1.IncludeObject {
  VerificationRequestInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => VerificationRequest.t;
}

class VerificationRequestIncludeList extends _i1.IncludeList {
  VerificationRequestIncludeList._({
    _i1.WhereExpressionBuilder<VerificationRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VerificationRequest.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => VerificationRequest.t;
}

class VerificationRequestRepository {
  const VerificationRequestRepository._();

  /// Returns a list of [VerificationRequest]s matching the given query parameters.
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
  Future<List<VerificationRequest>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VerificationRequestTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VerificationRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VerificationRequestTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VerificationRequest>(
      where: where?.call(VerificationRequest.t),
      orderBy: orderBy?.call(VerificationRequest.t),
      orderByList: orderByList?.call(VerificationRequest.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VerificationRequest] matching the given query parameters.
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
  Future<VerificationRequest?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VerificationRequestTable>? where,
    int? offset,
    _i1.OrderByBuilder<VerificationRequestTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VerificationRequestTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VerificationRequest>(
      where: where?.call(VerificationRequest.t),
      orderBy: orderBy?.call(VerificationRequest.t),
      orderByList: orderByList?.call(VerificationRequest.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VerificationRequest] by its [id] or null if no such row exists.
  Future<VerificationRequest?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VerificationRequest>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VerificationRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [VerificationRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<VerificationRequest>> insert(
    _i1.DatabaseSession session,
    List<VerificationRequest> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<VerificationRequest>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [VerificationRequest] and returns the inserted row.
  ///
  /// The returned [VerificationRequest] will have its `id` field set.
  Future<VerificationRequest> insertRow(
    _i1.DatabaseSession session,
    VerificationRequest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<VerificationRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [VerificationRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<VerificationRequest>> update(
    _i1.DatabaseSession session,
    List<VerificationRequest> rows, {
    _i1.ColumnSelections<VerificationRequestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<VerificationRequest>(
      rows,
      columns: columns?.call(VerificationRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VerificationRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VerificationRequest> updateRow(
    _i1.DatabaseSession session,
    VerificationRequest row, {
    _i1.ColumnSelections<VerificationRequestTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<VerificationRequest>(
      row,
      columns: columns?.call(VerificationRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VerificationRequest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VerificationRequest?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<VerificationRequestUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<VerificationRequest>(
      id,
      columnValues: columnValues(VerificationRequest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VerificationRequest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<VerificationRequest>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<VerificationRequestUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<VerificationRequestTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VerificationRequestTable>? orderBy,
    _i1.OrderByListBuilder<VerificationRequestTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<VerificationRequest>(
      columnValues: columnValues(VerificationRequest.t.updateTable),
      where: where(VerificationRequest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VerificationRequest.t),
      orderByList: orderByList?.call(VerificationRequest.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [VerificationRequest]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<VerificationRequest>> delete(
    _i1.DatabaseSession session,
    List<VerificationRequest> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<VerificationRequest>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [VerificationRequest].
  Future<VerificationRequest> deleteRow(
    _i1.DatabaseSession session,
    VerificationRequest row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VerificationRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<VerificationRequest>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VerificationRequestTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<VerificationRequest>(
      where: where(VerificationRequest.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VerificationRequestTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<VerificationRequest>(
      where: where?.call(VerificationRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VerificationRequest] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VerificationRequestTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VerificationRequest>(
      where: where(VerificationRequest.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
