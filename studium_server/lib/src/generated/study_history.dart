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
import 'package:studium_server/src/generated/protocol.dart' as _i2;

abstract class StudyHistory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StudyHistory._({
    this.id,
    required this.userId,
    required this.materialIds,
    required this.questionIds,
    required this.summaryIds,
    required this.writingIds,
    this.progress,
    required this.lastUpdated,
  });

  factory StudyHistory({
    int? id,
    required int userId,
    required List<int> materialIds,
    required List<int> questionIds,
    required List<int> summaryIds,
    required List<int> writingIds,
    double? progress,
    required DateTime lastUpdated,
  }) = _StudyHistoryImpl;

  factory StudyHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyHistory(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      materialIds: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['materialIds'],
      ),
      questionIds: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['questionIds'],
      ),
      summaryIds: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['summaryIds'],
      ),
      writingIds: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['writingIds'],
      ),
      progress: (jsonSerialization['progress'] as num?)?.toDouble(),
      lastUpdated: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastUpdated'],
      ),
    );
  }

  static final t = StudyHistoryTable();

  static const db = StudyHistoryRepository._();

  @override
  int? id;

  int userId;

  List<int> materialIds;

  List<int> questionIds;

  List<int> summaryIds;

  List<int> writingIds;

  double? progress;

  DateTime lastUpdated;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudyHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudyHistory copyWith({
    int? id,
    int? userId,
    List<int>? materialIds,
    List<int>? questionIds,
    List<int>? summaryIds,
    List<int>? writingIds,
    double? progress,
    DateTime? lastUpdated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyHistory',
      if (id != null) 'id': id,
      'userId': userId,
      'materialIds': materialIds.toJson(),
      'questionIds': questionIds.toJson(),
      'summaryIds': summaryIds.toJson(),
      'writingIds': writingIds.toJson(),
      if (progress != null) 'progress': progress,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyHistory',
      if (id != null) 'id': id,
      'userId': userId,
      'materialIds': materialIds.toJson(),
      'questionIds': questionIds.toJson(),
      'summaryIds': summaryIds.toJson(),
      'writingIds': writingIds.toJson(),
      if (progress != null) 'progress': progress,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  static StudyHistoryInclude include() {
    return StudyHistoryInclude._();
  }

  static StudyHistoryIncludeList includeList({
    _i1.WhereExpressionBuilder<StudyHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudyHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudyHistoryTable>? orderByList,
    StudyHistoryInclude? include,
  }) {
    return StudyHistoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyHistory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StudyHistory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyHistoryImpl extends StudyHistory {
  _StudyHistoryImpl({
    int? id,
    required int userId,
    required List<int> materialIds,
    required List<int> questionIds,
    required List<int> summaryIds,
    required List<int> writingIds,
    double? progress,
    required DateTime lastUpdated,
  }) : super._(
         id: id,
         userId: userId,
         materialIds: materialIds,
         questionIds: questionIds,
         summaryIds: summaryIds,
         writingIds: writingIds,
         progress: progress,
         lastUpdated: lastUpdated,
       );

  /// Returns a shallow copy of this [StudyHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudyHistory copyWith({
    Object? id = _Undefined,
    int? userId,
    List<int>? materialIds,
    List<int>? questionIds,
    List<int>? summaryIds,
    List<int>? writingIds,
    Object? progress = _Undefined,
    DateTime? lastUpdated,
  }) {
    return StudyHistory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      materialIds: materialIds ?? this.materialIds.map((e0) => e0).toList(),
      questionIds: questionIds ?? this.questionIds.map((e0) => e0).toList(),
      summaryIds: summaryIds ?? this.summaryIds.map((e0) => e0).toList(),
      writingIds: writingIds ?? this.writingIds.map((e0) => e0).toList(),
      progress: progress is double? ? progress : this.progress,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class StudyHistoryUpdateTable extends _i1.UpdateTable<StudyHistoryTable> {
  StudyHistoryUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<List<int>, List<int>> materialIds(List<int> value) =>
      _i1.ColumnValue(
        table.materialIds,
        value,
      );

  _i1.ColumnValue<List<int>, List<int>> questionIds(List<int> value) =>
      _i1.ColumnValue(
        table.questionIds,
        value,
      );

  _i1.ColumnValue<List<int>, List<int>> summaryIds(List<int> value) =>
      _i1.ColumnValue(
        table.summaryIds,
        value,
      );

  _i1.ColumnValue<List<int>, List<int>> writingIds(List<int> value) =>
      _i1.ColumnValue(
        table.writingIds,
        value,
      );

  _i1.ColumnValue<double, double> progress(double? value) => _i1.ColumnValue(
    table.progress,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastUpdated(DateTime value) =>
      _i1.ColumnValue(
        table.lastUpdated,
        value,
      );
}

class StudyHistoryTable extends _i1.Table<int?> {
  StudyHistoryTable({super.tableRelation}) : super(tableName: 'study_history') {
    updateTable = StudyHistoryUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    materialIds = _i1.ColumnSerializable<List<int>>(
      'materialIds',
      this,
    );
    questionIds = _i1.ColumnSerializable<List<int>>(
      'questionIds',
      this,
    );
    summaryIds = _i1.ColumnSerializable<List<int>>(
      'summaryIds',
      this,
    );
    writingIds = _i1.ColumnSerializable<List<int>>(
      'writingIds',
      this,
    );
    progress = _i1.ColumnDouble(
      'progress',
      this,
    );
    lastUpdated = _i1.ColumnDateTime(
      'lastUpdated',
      this,
    );
  }

  late final StudyHistoryUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnSerializable<List<int>> materialIds;

  late final _i1.ColumnSerializable<List<int>> questionIds;

  late final _i1.ColumnSerializable<List<int>> summaryIds;

  late final _i1.ColumnSerializable<List<int>> writingIds;

  late final _i1.ColumnDouble progress;

  late final _i1.ColumnDateTime lastUpdated;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    materialIds,
    questionIds,
    summaryIds,
    writingIds,
    progress,
    lastUpdated,
  ];
}

class StudyHistoryInclude extends _i1.IncludeObject {
  StudyHistoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StudyHistory.t;
}

class StudyHistoryIncludeList extends _i1.IncludeList {
  StudyHistoryIncludeList._({
    _i1.WhereExpressionBuilder<StudyHistoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudyHistory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StudyHistory.t;
}

class StudyHistoryRepository {
  const StudyHistoryRepository._();

  /// Returns a list of [StudyHistory]s matching the given query parameters.
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
  Future<List<StudyHistory>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudyHistoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudyHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudyHistoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudyHistory>(
      where: where?.call(StudyHistory.t),
      orderBy: orderBy?.call(StudyHistory.t),
      orderByList: orderByList?.call(StudyHistory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudyHistory] matching the given query parameters.
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
  Future<StudyHistory?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudyHistoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<StudyHistoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudyHistoryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudyHistory>(
      where: where?.call(StudyHistory.t),
      orderBy: orderBy?.call(StudyHistory.t),
      orderByList: orderByList?.call(StudyHistory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudyHistory] by its [id] or null if no such row exists.
  Future<StudyHistory?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudyHistory>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudyHistory]s in the list and returns the inserted rows.
  ///
  /// The returned [StudyHistory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StudyHistory>> insert(
    _i1.DatabaseSession session,
    List<StudyHistory> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StudyHistory>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StudyHistory] and returns the inserted row.
  ///
  /// The returned [StudyHistory] will have its `id` field set.
  Future<StudyHistory> insertRow(
    _i1.DatabaseSession session,
    StudyHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudyHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StudyHistory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StudyHistory>> update(
    _i1.DatabaseSession session,
    List<StudyHistory> rows, {
    _i1.ColumnSelections<StudyHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StudyHistory>(
      rows,
      columns: columns?.call(StudyHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudyHistory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudyHistory> updateRow(
    _i1.DatabaseSession session,
    StudyHistory row, {
    _i1.ColumnSelections<StudyHistoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudyHistory>(
      row,
      columns: columns?.call(StudyHistory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudyHistory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudyHistory?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<StudyHistoryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StudyHistory>(
      id,
      columnValues: columnValues(StudyHistory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudyHistory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StudyHistory>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StudyHistoryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StudyHistoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudyHistoryTable>? orderBy,
    _i1.OrderByListBuilder<StudyHistoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StudyHistory>(
      columnValues: columnValues(StudyHistory.t.updateTable),
      where: where(StudyHistory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyHistory.t),
      orderByList: orderByList?.call(StudyHistory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StudyHistory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StudyHistory>> delete(
    _i1.DatabaseSession session,
    List<StudyHistory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StudyHistory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StudyHistory].
  Future<StudyHistory> deleteRow(
    _i1.DatabaseSession session,
    StudyHistory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudyHistory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StudyHistory>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudyHistoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StudyHistory>(
      where: where(StudyHistory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudyHistoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StudyHistory>(
      where: where?.call(StudyHistory.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudyHistory] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudyHistoryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudyHistory>(
      where: where(StudyHistory.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
