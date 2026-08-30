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

abstract class ContentReport
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ContentReport._({
    this.id,
    required this.reporterId,
    required this.contentType,
    required this.contentId,
    required this.reason,
    this.details,
    required this.status,
    required this.createdAt,
    this.resolvedAt,
  });

  factory ContentReport({
    int? id,
    required int reporterId,
    required String contentType,
    required int contentId,
    required String reason,
    String? details,
    required String status,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _ContentReportImpl;

  factory ContentReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContentReport(
      id: jsonSerialization['id'] as int?,
      reporterId: jsonSerialization['reporterId'] as int,
      contentType: jsonSerialization['contentType'] as String,
      contentId: jsonSerialization['contentId'] as int,
      reason: jsonSerialization['reason'] as String,
      details: jsonSerialization['details'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = ContentReportTable();

  static const db = ContentReportRepository._();

  @override
  int? id;

  int reporterId;

  String contentType;

  int contentId;

  String reason;

  String? details;

  String status;

  DateTime createdAt;

  DateTime? resolvedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ContentReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ContentReport copyWith({
    int? id,
    int? reporterId,
    String? contentType,
    int? contentId,
    String? reason,
    String? details,
    String? status,
    DateTime? createdAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContentReport',
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'contentType': contentType,
      'contentId': contentId,
      'reason': reason,
      if (details != null) 'details': details,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ContentReport',
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'contentType': contentType,
      'contentId': contentId,
      'reason': reason,
      if (details != null) 'details': details,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  static ContentReportInclude include() {
    return ContentReportInclude._();
  }

  static ContentReportIncludeList includeList({
    _i1.WhereExpressionBuilder<ContentReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ContentReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ContentReportTable>? orderByList,
    ContentReportInclude? include,
  }) {
    return ContentReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ContentReport.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ContentReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContentReportImpl extends ContentReport {
  _ContentReportImpl({
    int? id,
    required int reporterId,
    required String contentType,
    required int contentId,
    required String reason,
    String? details,
    required String status,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         reporterId: reporterId,
         contentType: contentType,
         contentId: contentId,
         reason: reason,
         details: details,
         status: status,
         createdAt: createdAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [ContentReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ContentReport copyWith({
    Object? id = _Undefined,
    int? reporterId,
    String? contentType,
    int? contentId,
    String? reason,
    Object? details = _Undefined,
    String? status,
    DateTime? createdAt,
    Object? resolvedAt = _Undefined,
  }) {
    return ContentReport(
      id: id is int? ? id : this.id,
      reporterId: reporterId ?? this.reporterId,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      reason: reason ?? this.reason,
      details: details is String? ? details : this.details,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}

class ContentReportUpdateTable extends _i1.UpdateTable<ContentReportTable> {
  ContentReportUpdateTable(super.table);

  _i1.ColumnValue<int, int> reporterId(int value) => _i1.ColumnValue(
    table.reporterId,
    value,
  );

  _i1.ColumnValue<String, String> contentType(String value) => _i1.ColumnValue(
    table.contentType,
    value,
  );

  _i1.ColumnValue<int, int> contentId(int value) => _i1.ColumnValue(
    table.contentId,
    value,
  );

  _i1.ColumnValue<String, String> reason(String value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<String, String> details(String? value) => _i1.ColumnValue(
    table.details,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.resolvedAt,
        value,
      );
}

class ContentReportTable extends _i1.Table<int?> {
  ContentReportTable({super.tableRelation})
    : super(tableName: 'content_reports') {
    updateTable = ContentReportUpdateTable(this);
    reporterId = _i1.ColumnInt(
      'reporterId',
      this,
    );
    contentType = _i1.ColumnString(
      'contentType',
      this,
    );
    contentId = _i1.ColumnInt(
      'contentId',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    details = _i1.ColumnString(
      'details',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
  }

  late final ContentReportUpdateTable updateTable;

  late final _i1.ColumnInt reporterId;

  late final _i1.ColumnString contentType;

  late final _i1.ColumnInt contentId;

  late final _i1.ColumnString reason;

  late final _i1.ColumnString details;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime resolvedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    reporterId,
    contentType,
    contentId,
    reason,
    details,
    status,
    createdAt,
    resolvedAt,
  ];
}

class ContentReportInclude extends _i1.IncludeObject {
  ContentReportInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ContentReport.t;
}

class ContentReportIncludeList extends _i1.IncludeList {
  ContentReportIncludeList._({
    _i1.WhereExpressionBuilder<ContentReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ContentReport.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ContentReport.t;
}

class ContentReportRepository {
  const ContentReportRepository._();

  /// Returns a list of [ContentReport]s matching the given query parameters.
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
  Future<List<ContentReport>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ContentReportTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ContentReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ContentReportTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ContentReport>(
      where: where?.call(ContentReport.t),
      orderBy: orderBy?.call(ContentReport.t),
      orderByList: orderByList?.call(ContentReport.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ContentReport] matching the given query parameters.
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
  Future<ContentReport?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ContentReportTable>? where,
    int? offset,
    _i1.OrderByBuilder<ContentReportTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ContentReportTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ContentReport>(
      where: where?.call(ContentReport.t),
      orderBy: orderBy?.call(ContentReport.t),
      orderByList: orderByList?.call(ContentReport.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ContentReport] by its [id] or null if no such row exists.
  Future<ContentReport?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ContentReport>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ContentReport]s in the list and returns the inserted rows.
  ///
  /// The returned [ContentReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ContentReport>> insert(
    _i1.DatabaseSession session,
    List<ContentReport> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ContentReport>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ContentReport] and returns the inserted row.
  ///
  /// The returned [ContentReport] will have its `id` field set.
  Future<ContentReport> insertRow(
    _i1.DatabaseSession session,
    ContentReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ContentReport>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ContentReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ContentReport>> update(
    _i1.DatabaseSession session,
    List<ContentReport> rows, {
    _i1.ColumnSelections<ContentReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ContentReport>(
      rows,
      columns: columns?.call(ContentReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ContentReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ContentReport> updateRow(
    _i1.DatabaseSession session,
    ContentReport row, {
    _i1.ColumnSelections<ContentReportTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ContentReport>(
      row,
      columns: columns?.call(ContentReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ContentReport] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ContentReport?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ContentReportUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ContentReport>(
      id,
      columnValues: columnValues(ContentReport.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ContentReport]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ContentReport>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ContentReportUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ContentReportTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ContentReportTable>? orderBy,
    _i1.OrderByListBuilder<ContentReportTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ContentReport>(
      columnValues: columnValues(ContentReport.t.updateTable),
      where: where(ContentReport.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ContentReport.t),
      orderByList: orderByList?.call(ContentReport.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ContentReport]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ContentReport>> delete(
    _i1.DatabaseSession session,
    List<ContentReport> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ContentReport>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ContentReport].
  Future<ContentReport> deleteRow(
    _i1.DatabaseSession session,
    ContentReport row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ContentReport>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ContentReport>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ContentReportTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ContentReport>(
      where: where(ContentReport.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ContentReportTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ContentReport>(
      where: where?.call(ContentReport.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ContentReport] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ContentReportTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ContentReport>(
      where: where(ContentReport.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
