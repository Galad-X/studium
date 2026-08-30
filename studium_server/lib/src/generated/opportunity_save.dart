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

abstract class OpportunitySave
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OpportunitySave._({
    this.id,
    required this.opportunityId,
    required this.userId,
    required this.alertEnabled,
    required this.savedAt,
  });

  factory OpportunitySave({
    int? id,
    required int opportunityId,
    required int userId,
    required bool alertEnabled,
    required DateTime savedAt,
  }) = _OpportunitySaveImpl;

  factory OpportunitySave.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpportunitySave(
      id: jsonSerialization['id'] as int?,
      opportunityId: jsonSerialization['opportunityId'] as int,
      userId: jsonSerialization['userId'] as int,
      alertEnabled: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['alertEnabled'],
      ),
      savedAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['savedAt']),
    );
  }

  static final t = OpportunitySaveTable();

  static const db = OpportunitySaveRepository._();

  @override
  int? id;

  int opportunityId;

  int userId;

  bool alertEnabled;

  DateTime savedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OpportunitySave]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OpportunitySave copyWith({
    int? id,
    int? opportunityId,
    int? userId,
    bool? alertEnabled,
    DateTime? savedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpportunitySave',
      if (id != null) 'id': id,
      'opportunityId': opportunityId,
      'userId': userId,
      'alertEnabled': alertEnabled,
      'savedAt': savedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OpportunitySave',
      if (id != null) 'id': id,
      'opportunityId': opportunityId,
      'userId': userId,
      'alertEnabled': alertEnabled,
      'savedAt': savedAt.toJson(),
    };
  }

  static OpportunitySaveInclude include() {
    return OpportunitySaveInclude._();
  }

  static OpportunitySaveIncludeList includeList({
    _i1.WhereExpressionBuilder<OpportunitySaveTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunitySaveTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunitySaveTable>? orderByList,
    OpportunitySaveInclude? include,
  }) {
    return OpportunitySaveIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OpportunitySave.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OpportunitySave.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OpportunitySaveImpl extends OpportunitySave {
  _OpportunitySaveImpl({
    int? id,
    required int opportunityId,
    required int userId,
    required bool alertEnabled,
    required DateTime savedAt,
  }) : super._(
          id: id,
          opportunityId: opportunityId,
          userId: userId,
          alertEnabled: alertEnabled,
          savedAt: savedAt,
        );

  /// Returns a shallow copy of this [OpportunitySave]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OpportunitySave copyWith({
    Object? id = _Undefined,
    int? opportunityId,
    int? userId,
    bool? alertEnabled,
    DateTime? savedAt,
  }) {
    return OpportunitySave(
      id: id is int? ? id : this.id,
      opportunityId: opportunityId ?? this.opportunityId,
      userId: userId ?? this.userId,
      alertEnabled: alertEnabled ?? this.alertEnabled,
      savedAt: savedAt ?? this.savedAt,
    );
  }
}

class OpportunitySaveUpdateTable extends _i1.UpdateTable<OpportunitySaveTable> {
  OpportunitySaveUpdateTable(super.table);

  _i1.ColumnValue<int, int> opportunityId(int value) => _i1.ColumnValue(
        table.opportunityId,
        value,
      );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<bool, bool> alertEnabled(bool value) => _i1.ColumnValue(
        table.alertEnabled,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> savedAt(DateTime value) =>
      _i1.ColumnValue(
        table.savedAt,
        value,
      );
}

class OpportunitySaveTable extends _i1.Table<int?> {
  OpportunitySaveTable({super.tableRelation})
      : super(tableName: 'opportunity_saves') {
    updateTable = OpportunitySaveUpdateTable(this);
    opportunityId = _i1.ColumnInt(
      'opportunityId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    alertEnabled = _i1.ColumnBool(
      'alertEnabled',
      this,
    );
    savedAt = _i1.ColumnDateTime(
      'savedAt',
      this,
    );
  }

  late final OpportunitySaveUpdateTable updateTable;

  late final _i1.ColumnInt opportunityId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnBool alertEnabled;

  late final _i1.ColumnDateTime savedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        opportunityId,
        userId,
        alertEnabled,
        savedAt,
      ];
}

class OpportunitySaveInclude extends _i1.IncludeObject {
  OpportunitySaveInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OpportunitySave.t;
}

class OpportunitySaveIncludeList extends _i1.IncludeList {
  OpportunitySaveIncludeList._({
    _i1.WhereExpressionBuilder<OpportunitySaveTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OpportunitySave.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OpportunitySave.t;
}

class OpportunitySaveRepository {
  const OpportunitySaveRepository._();

  /// Returns a list of [OpportunitySave]s matching the given query parameters.
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
  Future<List<OpportunitySave>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunitySaveTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunitySaveTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunitySaveTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OpportunitySave>(
      where: where?.call(OpportunitySave.t),
      orderBy: orderBy?.call(OpportunitySave.t),
      orderByList: orderByList?.call(OpportunitySave.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OpportunitySave] matching the given query parameters.
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
  Future<OpportunitySave?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunitySaveTable>? where,
    int? offset,
    _i1.OrderByBuilder<OpportunitySaveTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunitySaveTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OpportunitySave>(
      where: where?.call(OpportunitySave.t),
      orderBy: orderBy?.call(OpportunitySave.t),
      orderByList: orderByList?.call(OpportunitySave.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OpportunitySave] by its [id] or null if no such row exists.
  Future<OpportunitySave?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OpportunitySave>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OpportunitySave]s in the list and returns the inserted rows.
  ///
  /// The returned [OpportunitySave]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OpportunitySave>> insert(
    _i1.DatabaseSession session,
    List<OpportunitySave> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OpportunitySave>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OpportunitySave] and returns the inserted row.
  ///
  /// The returned [OpportunitySave] will have its `id` field set.
  Future<OpportunitySave> insertRow(
    _i1.DatabaseSession session,
    OpportunitySave row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OpportunitySave>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OpportunitySave]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OpportunitySave>> update(
    _i1.DatabaseSession session,
    List<OpportunitySave> rows, {
    _i1.ColumnSelections<OpportunitySaveTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OpportunitySave>(
      rows,
      columns: columns?.call(OpportunitySave.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OpportunitySave]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OpportunitySave> updateRow(
    _i1.DatabaseSession session,
    OpportunitySave row, {
    _i1.ColumnSelections<OpportunitySaveTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OpportunitySave>(
      row,
      columns: columns?.call(OpportunitySave.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OpportunitySave] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OpportunitySave?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OpportunitySaveUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OpportunitySave>(
      id,
      columnValues: columnValues(OpportunitySave.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OpportunitySave]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OpportunitySave>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OpportunitySaveUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<OpportunitySaveTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunitySaveTable>? orderBy,
    _i1.OrderByListBuilder<OpportunitySaveTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OpportunitySave>(
      columnValues: columnValues(OpportunitySave.t.updateTable),
      where: where(OpportunitySave.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OpportunitySave.t),
      orderByList: orderByList?.call(OpportunitySave.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OpportunitySave]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OpportunitySave>> delete(
    _i1.DatabaseSession session,
    List<OpportunitySave> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OpportunitySave>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OpportunitySave].
  Future<OpportunitySave> deleteRow(
    _i1.DatabaseSession session,
    OpportunitySave row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OpportunitySave>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OpportunitySave>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OpportunitySaveTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OpportunitySave>(
      where: where(OpportunitySave.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunitySaveTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OpportunitySave>(
      where: where?.call(OpportunitySave.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OpportunitySave] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OpportunitySaveTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OpportunitySave>(
      where: where(OpportunitySave.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
