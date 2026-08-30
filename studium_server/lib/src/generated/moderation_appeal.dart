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

abstract class ModerationAppeal
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ModerationAppeal._({
    this.id,
    required this.reportId,
    required this.appellantId,
    required this.reason,
    required this.status,
    this.reviewerId,
    this.reviewNotes,
    required this.createdAt,
    this.reviewedAt,
  });

  factory ModerationAppeal({
    int? id,
    required int reportId,
    required int appellantId,
    required String reason,
    required String status,
    int? reviewerId,
    String? reviewNotes,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) = _ModerationAppealImpl;

  factory ModerationAppeal.fromJson(Map<String, dynamic> jsonSerialization) {
    return ModerationAppeal(
      id: jsonSerialization['id'] as int?,
      reportId: jsonSerialization['reportId'] as int,
      appellantId: jsonSerialization['appellantId'] as int,
      reason: jsonSerialization['reason'] as String,
      status: jsonSerialization['status'] as String,
      reviewerId: jsonSerialization['reviewerId'] as int?,
      reviewNotes: jsonSerialization['reviewNotes'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
    );
  }

  static final t = ModerationAppealTable();

  static const db = ModerationAppealRepository._();

  @override
  int? id;

  int reportId;

  int appellantId;

  String reason;

  String status;

  int? reviewerId;

  String? reviewNotes;

  DateTime createdAt;

  DateTime? reviewedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ModerationAppeal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ModerationAppeal copyWith({
    int? id,
    int? reportId,
    int? appellantId,
    String? reason,
    String? status,
    int? reviewerId,
    String? reviewNotes,
    DateTime? createdAt,
    DateTime? reviewedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ModerationAppeal',
      if (id != null) 'id': id,
      'reportId': reportId,
      'appellantId': appellantId,
      'reason': reason,
      'status': status,
      if (reviewerId != null) 'reviewerId': reviewerId,
      if (reviewNotes != null) 'reviewNotes': reviewNotes,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ModerationAppeal',
      if (id != null) 'id': id,
      'reportId': reportId,
      'appellantId': appellantId,
      'reason': reason,
      'status': status,
      if (reviewerId != null) 'reviewerId': reviewerId,
      if (reviewNotes != null) 'reviewNotes': reviewNotes,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  static ModerationAppealInclude include() {
    return ModerationAppealInclude._();
  }

  static ModerationAppealIncludeList includeList({
    _i1.WhereExpressionBuilder<ModerationAppealTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModerationAppealTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModerationAppealTable>? orderByList,
    ModerationAppealInclude? include,
  }) {
    return ModerationAppealIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ModerationAppeal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ModerationAppeal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ModerationAppealImpl extends ModerationAppeal {
  _ModerationAppealImpl({
    int? id,
    required int reportId,
    required int appellantId,
    required String reason,
    required String status,
    int? reviewerId,
    String? reviewNotes,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) : super._(
         id: id,
         reportId: reportId,
         appellantId: appellantId,
         reason: reason,
         status: status,
         reviewerId: reviewerId,
         reviewNotes: reviewNotes,
         createdAt: createdAt,
         reviewedAt: reviewedAt,
       );

  /// Returns a shallow copy of this [ModerationAppeal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ModerationAppeal copyWith({
    Object? id = _Undefined,
    int? reportId,
    int? appellantId,
    String? reason,
    String? status,
    Object? reviewerId = _Undefined,
    Object? reviewNotes = _Undefined,
    DateTime? createdAt,
    Object? reviewedAt = _Undefined,
  }) {
    return ModerationAppeal(
      id: id is int? ? id : this.id,
      reportId: reportId ?? this.reportId,
      appellantId: appellantId ?? this.appellantId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      reviewerId: reviewerId is int? ? reviewerId : this.reviewerId,
      reviewNotes: reviewNotes is String? ? reviewNotes : this.reviewNotes,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
    );
  }
}

class ModerationAppealUpdateTable
    extends _i1.UpdateTable<ModerationAppealTable> {
  ModerationAppealUpdateTable(super.table);

  _i1.ColumnValue<int, int> reportId(int value) => _i1.ColumnValue(
    table.reportId,
    value,
  );

  _i1.ColumnValue<int, int> appellantId(int value) => _i1.ColumnValue(
    table.appellantId,
    value,
  );

  _i1.ColumnValue<String, String> reason(String value) => _i1.ColumnValue(
    table.reason,
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

  _i1.ColumnValue<String, String> reviewNotes(String? value) => _i1.ColumnValue(
    table.reviewNotes,
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

class ModerationAppealTable extends _i1.Table<int?> {
  ModerationAppealTable({super.tableRelation})
    : super(tableName: 'moderation_appeals') {
    updateTable = ModerationAppealUpdateTable(this);
    reportId = _i1.ColumnInt(
      'reportId',
      this,
    );
    appellantId = _i1.ColumnInt(
      'appellantId',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
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
    reviewNotes = _i1.ColumnString(
      'reviewNotes',
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

  late final ModerationAppealUpdateTable updateTable;

  late final _i1.ColumnInt reportId;

  late final _i1.ColumnInt appellantId;

  late final _i1.ColumnString reason;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt reviewerId;

  late final _i1.ColumnString reviewNotes;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime reviewedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    reportId,
    appellantId,
    reason,
    status,
    reviewerId,
    reviewNotes,
    createdAt,
    reviewedAt,
  ];
}

class ModerationAppealInclude extends _i1.IncludeObject {
  ModerationAppealInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ModerationAppeal.t;
}

class ModerationAppealIncludeList extends _i1.IncludeList {
  ModerationAppealIncludeList._({
    _i1.WhereExpressionBuilder<ModerationAppealTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ModerationAppeal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ModerationAppeal.t;
}

class ModerationAppealRepository {
  const ModerationAppealRepository._();

  /// Returns a list of [ModerationAppeal]s matching the given query parameters.
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
  Future<List<ModerationAppeal>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ModerationAppealTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModerationAppealTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModerationAppealTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ModerationAppeal>(
      where: where?.call(ModerationAppeal.t),
      orderBy: orderBy?.call(ModerationAppeal.t),
      orderByList: orderByList?.call(ModerationAppeal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ModerationAppeal] matching the given query parameters.
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
  Future<ModerationAppeal?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ModerationAppealTable>? where,
    int? offset,
    _i1.OrderByBuilder<ModerationAppealTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModerationAppealTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ModerationAppeal>(
      where: where?.call(ModerationAppeal.t),
      orderBy: orderBy?.call(ModerationAppeal.t),
      orderByList: orderByList?.call(ModerationAppeal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ModerationAppeal] by its [id] or null if no such row exists.
  Future<ModerationAppeal?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ModerationAppeal>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ModerationAppeal]s in the list and returns the inserted rows.
  ///
  /// The returned [ModerationAppeal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ModerationAppeal>> insert(
    _i1.DatabaseSession session,
    List<ModerationAppeal> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ModerationAppeal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ModerationAppeal] and returns the inserted row.
  ///
  /// The returned [ModerationAppeal] will have its `id` field set.
  Future<ModerationAppeal> insertRow(
    _i1.DatabaseSession session,
    ModerationAppeal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ModerationAppeal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ModerationAppeal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ModerationAppeal>> update(
    _i1.DatabaseSession session,
    List<ModerationAppeal> rows, {
    _i1.ColumnSelections<ModerationAppealTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ModerationAppeal>(
      rows,
      columns: columns?.call(ModerationAppeal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ModerationAppeal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ModerationAppeal> updateRow(
    _i1.DatabaseSession session,
    ModerationAppeal row, {
    _i1.ColumnSelections<ModerationAppealTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ModerationAppeal>(
      row,
      columns: columns?.call(ModerationAppeal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ModerationAppeal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ModerationAppeal?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ModerationAppealUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ModerationAppeal>(
      id,
      columnValues: columnValues(ModerationAppeal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ModerationAppeal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ModerationAppeal>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ModerationAppealUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ModerationAppealTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModerationAppealTable>? orderBy,
    _i1.OrderByListBuilder<ModerationAppealTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ModerationAppeal>(
      columnValues: columnValues(ModerationAppeal.t.updateTable),
      where: where(ModerationAppeal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ModerationAppeal.t),
      orderByList: orderByList?.call(ModerationAppeal.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ModerationAppeal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ModerationAppeal>> delete(
    _i1.DatabaseSession session,
    List<ModerationAppeal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ModerationAppeal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ModerationAppeal].
  Future<ModerationAppeal> deleteRow(
    _i1.DatabaseSession session,
    ModerationAppeal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ModerationAppeal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ModerationAppeal>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ModerationAppealTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ModerationAppeal>(
      where: where(ModerationAppeal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ModerationAppealTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ModerationAppeal>(
      where: where?.call(ModerationAppeal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ModerationAppeal] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ModerationAppealTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ModerationAppeal>(
      where: where(ModerationAppeal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
