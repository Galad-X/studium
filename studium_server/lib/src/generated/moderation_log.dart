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

abstract class ModerationLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ModerationLog._({
    this.id,
    required this.reportId,
    required this.moderatorId,
    required this.action,
    required this.targetType,
    required this.targetId,
    this.note,
    required this.createdAt,
  });

  factory ModerationLog({
    int? id,
    required int reportId,
    required int moderatorId,
    required String action,
    required String targetType,
    required int targetId,
    String? note,
    required DateTime createdAt,
  }) = _ModerationLogImpl;

  factory ModerationLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ModerationLog(
      id: jsonSerialization['id'] as int?,
      reportId: jsonSerialization['reportId'] as int,
      moderatorId: jsonSerialization['moderatorId'] as int,
      action: jsonSerialization['action'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      note: jsonSerialization['note'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ModerationLogTable();

  static const db = ModerationLogRepository._();

  @override
  int? id;

  int reportId;

  int moderatorId;

  String action;

  String targetType;

  int targetId;

  String? note;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ModerationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ModerationLog copyWith({
    int? id,
    int? reportId,
    int? moderatorId,
    String? action,
    String? targetType,
    int? targetId,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ModerationLog',
      if (id != null) 'id': id,
      'reportId': reportId,
      'moderatorId': moderatorId,
      'action': action,
      'targetType': targetType,
      'targetId': targetId,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ModerationLog',
      if (id != null) 'id': id,
      'reportId': reportId,
      'moderatorId': moderatorId,
      'action': action,
      'targetType': targetType,
      'targetId': targetId,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  static ModerationLogInclude include() {
    return ModerationLogInclude._();
  }

  static ModerationLogIncludeList includeList({
    _i1.WhereExpressionBuilder<ModerationLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModerationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModerationLogTable>? orderByList,
    ModerationLogInclude? include,
  }) {
    return ModerationLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ModerationLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ModerationLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ModerationLogImpl extends ModerationLog {
  _ModerationLogImpl({
    int? id,
    required int reportId,
    required int moderatorId,
    required String action,
    required String targetType,
    required int targetId,
    String? note,
    required DateTime createdAt,
  }) : super._(
          id: id,
          reportId: reportId,
          moderatorId: moderatorId,
          action: action,
          targetType: targetType,
          targetId: targetId,
          note: note,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ModerationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ModerationLog copyWith({
    Object? id = _Undefined,
    int? reportId,
    int? moderatorId,
    String? action,
    String? targetType,
    int? targetId,
    Object? note = _Undefined,
    DateTime? createdAt,
  }) {
    return ModerationLog(
      id: id is int? ? id : this.id,
      reportId: reportId ?? this.reportId,
      moderatorId: moderatorId ?? this.moderatorId,
      action: action ?? this.action,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ModerationLogUpdateTable extends _i1.UpdateTable<ModerationLogTable> {
  ModerationLogUpdateTable(super.table);

  _i1.ColumnValue<int, int> reportId(int value) => _i1.ColumnValue(
        table.reportId,
        value,
      );

  _i1.ColumnValue<int, int> moderatorId(int value) => _i1.ColumnValue(
        table.moderatorId,
        value,
      );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
        table.action,
        value,
      );

  _i1.ColumnValue<String, String> targetType(String value) => _i1.ColumnValue(
        table.targetType,
        value,
      );

  _i1.ColumnValue<int, int> targetId(int value) => _i1.ColumnValue(
        table.targetId,
        value,
      );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
        table.note,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ModerationLogTable extends _i1.Table<int?> {
  ModerationLogTable({super.tableRelation})
      : super(tableName: 'moderation_logs') {
    updateTable = ModerationLogUpdateTable(this);
    reportId = _i1.ColumnInt(
      'reportId',
      this,
    );
    moderatorId = _i1.ColumnInt(
      'moderatorId',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    targetType = _i1.ColumnString(
      'targetType',
      this,
    );
    targetId = _i1.ColumnInt(
      'targetId',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ModerationLogUpdateTable updateTable;

  late final _i1.ColumnInt reportId;

  late final _i1.ColumnInt moderatorId;

  late final _i1.ColumnString action;

  late final _i1.ColumnString targetType;

  late final _i1.ColumnInt targetId;

  late final _i1.ColumnString note;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        reportId,
        moderatorId,
        action,
        targetType,
        targetId,
        note,
        createdAt,
      ];
}

class ModerationLogInclude extends _i1.IncludeObject {
  ModerationLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ModerationLog.t;
}

class ModerationLogIncludeList extends _i1.IncludeList {
  ModerationLogIncludeList._({
    _i1.WhereExpressionBuilder<ModerationLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ModerationLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ModerationLog.t;
}

class ModerationLogRepository {
  const ModerationLogRepository._();

  /// Returns a list of [ModerationLog]s matching the given query parameters.
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
  Future<List<ModerationLog>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ModerationLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModerationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModerationLogTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ModerationLog>(
      where: where?.call(ModerationLog.t),
      orderBy: orderBy?.call(ModerationLog.t),
      orderByList: orderByList?.call(ModerationLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ModerationLog] matching the given query parameters.
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
  Future<ModerationLog?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ModerationLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<ModerationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModerationLogTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ModerationLog>(
      where: where?.call(ModerationLog.t),
      orderBy: orderBy?.call(ModerationLog.t),
      orderByList: orderByList?.call(ModerationLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ModerationLog] by its [id] or null if no such row exists.
  Future<ModerationLog?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ModerationLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ModerationLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ModerationLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ModerationLog>> insert(
    _i1.DatabaseSession session,
    List<ModerationLog> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ModerationLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ModerationLog] and returns the inserted row.
  ///
  /// The returned [ModerationLog] will have its `id` field set.
  Future<ModerationLog> insertRow(
    _i1.DatabaseSession session,
    ModerationLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ModerationLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ModerationLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ModerationLog>> update(
    _i1.DatabaseSession session,
    List<ModerationLog> rows, {
    _i1.ColumnSelections<ModerationLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ModerationLog>(
      rows,
      columns: columns?.call(ModerationLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ModerationLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ModerationLog> updateRow(
    _i1.DatabaseSession session,
    ModerationLog row, {
    _i1.ColumnSelections<ModerationLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ModerationLog>(
      row,
      columns: columns?.call(ModerationLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ModerationLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ModerationLog?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ModerationLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ModerationLog>(
      id,
      columnValues: columnValues(ModerationLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ModerationLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ModerationLog>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ModerationLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ModerationLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModerationLogTable>? orderBy,
    _i1.OrderByListBuilder<ModerationLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ModerationLog>(
      columnValues: columnValues(ModerationLog.t.updateTable),
      where: where(ModerationLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ModerationLog.t),
      orderByList: orderByList?.call(ModerationLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ModerationLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ModerationLog>> delete(
    _i1.DatabaseSession session,
    List<ModerationLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ModerationLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ModerationLog].
  Future<ModerationLog> deleteRow(
    _i1.DatabaseSession session,
    ModerationLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ModerationLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ModerationLog>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ModerationLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ModerationLog>(
      where: where(ModerationLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ModerationLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ModerationLog>(
      where: where?.call(ModerationLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ModerationLog] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ModerationLogTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ModerationLog>(
      where: where(ModerationLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
