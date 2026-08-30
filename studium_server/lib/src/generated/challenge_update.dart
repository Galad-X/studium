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

abstract class ChallengeProgressUpdate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ChallengeProgressUpdate._({
    this.id,
    required this.teamId,
    required this.authorId,
    required this.body,
    required this.status,
    required this.createdAt,
  });

  factory ChallengeProgressUpdate({
    int? id,
    required int teamId,
    required int authorId,
    required String body,
    required String status,
    required DateTime createdAt,
  }) = _ChallengeProgressUpdateImpl;

  factory ChallengeProgressUpdate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ChallengeProgressUpdate(
      id: jsonSerialization['id'] as int?,
      teamId: jsonSerialization['teamId'] as int,
      authorId: jsonSerialization['authorId'] as int,
      body: jsonSerialization['body'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ChallengeProgressUpdateTable();

  static const db = ChallengeProgressUpdateRepository._();

  @override
  int? id;

  int teamId;

  int authorId;

  String body;

  String status;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChallengeProgressUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChallengeProgressUpdate copyWith({
    int? id,
    int? teamId,
    int? authorId,
    String? body,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeProgressUpdate',
      if (id != null) 'id': id,
      'teamId': teamId,
      'authorId': authorId,
      'body': body,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChallengeProgressUpdate',
      if (id != null) 'id': id,
      'teamId': teamId,
      'authorId': authorId,
      'body': body,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static ChallengeProgressUpdateInclude include() {
    return ChallengeProgressUpdateInclude._();
  }

  static ChallengeProgressUpdateIncludeList includeList({
    _i1.WhereExpressionBuilder<ChallengeProgressUpdateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeProgressUpdateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeProgressUpdateTable>? orderByList,
    ChallengeProgressUpdateInclude? include,
  }) {
    return ChallengeProgressUpdateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeProgressUpdate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChallengeProgressUpdate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeProgressUpdateImpl extends ChallengeProgressUpdate {
  _ChallengeProgressUpdateImpl({
    int? id,
    required int teamId,
    required int authorId,
    required String body,
    required String status,
    required DateTime createdAt,
  }) : super._(
          id: id,
          teamId: teamId,
          authorId: authorId,
          body: body,
          status: status,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ChallengeProgressUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChallengeProgressUpdate copyWith({
    Object? id = _Undefined,
    int? teamId,
    int? authorId,
    String? body,
    String? status,
    DateTime? createdAt,
  }) {
    return ChallengeProgressUpdate(
      id: id is int? ? id : this.id,
      teamId: teamId ?? this.teamId,
      authorId: authorId ?? this.authorId,
      body: body ?? this.body,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ChallengeProgressUpdateUpdateTable
    extends _i1.UpdateTable<ChallengeProgressUpdateTable> {
  ChallengeProgressUpdateUpdateTable(super.table);

  _i1.ColumnValue<int, int> teamId(int value) => _i1.ColumnValue(
        table.teamId,
        value,
      );

  _i1.ColumnValue<int, int> authorId(int value) => _i1.ColumnValue(
        table.authorId,
        value,
      );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
        table.body,
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
}

class ChallengeProgressUpdateTable extends _i1.Table<int?> {
  ChallengeProgressUpdateTable({super.tableRelation})
      : super(tableName: 'challenge_updates') {
    updateTable = ChallengeProgressUpdateUpdateTable(this);
    teamId = _i1.ColumnInt(
      'teamId',
      this,
    );
    authorId = _i1.ColumnInt(
      'authorId',
      this,
    );
    body = _i1.ColumnString(
      'body',
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
  }

  late final ChallengeProgressUpdateUpdateTable updateTable;

  late final _i1.ColumnInt teamId;

  late final _i1.ColumnInt authorId;

  late final _i1.ColumnString body;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        teamId,
        authorId,
        body,
        status,
        createdAt,
      ];
}

class ChallengeProgressUpdateInclude extends _i1.IncludeObject {
  ChallengeProgressUpdateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ChallengeProgressUpdate.t;
}

class ChallengeProgressUpdateIncludeList extends _i1.IncludeList {
  ChallengeProgressUpdateIncludeList._({
    _i1.WhereExpressionBuilder<ChallengeProgressUpdateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChallengeProgressUpdate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChallengeProgressUpdate.t;
}

class ChallengeProgressUpdateRepository {
  const ChallengeProgressUpdateRepository._();

  /// Returns a list of [ChallengeProgressUpdate]s matching the given query parameters.
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
  Future<List<ChallengeProgressUpdate>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeProgressUpdateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeProgressUpdateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeProgressUpdateTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChallengeProgressUpdate>(
      where: where?.call(ChallengeProgressUpdate.t),
      orderBy: orderBy?.call(ChallengeProgressUpdate.t),
      orderByList: orderByList?.call(ChallengeProgressUpdate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChallengeProgressUpdate] matching the given query parameters.
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
  Future<ChallengeProgressUpdate?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeProgressUpdateTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChallengeProgressUpdateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeProgressUpdateTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChallengeProgressUpdate>(
      where: where?.call(ChallengeProgressUpdate.t),
      orderBy: orderBy?.call(ChallengeProgressUpdate.t),
      orderByList: orderByList?.call(ChallengeProgressUpdate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChallengeProgressUpdate] by its [id] or null if no such row exists.
  Future<ChallengeProgressUpdate?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChallengeProgressUpdate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChallengeProgressUpdate]s in the list and returns the inserted rows.
  ///
  /// The returned [ChallengeProgressUpdate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ChallengeProgressUpdate>> insert(
    _i1.DatabaseSession session,
    List<ChallengeProgressUpdate> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ChallengeProgressUpdate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ChallengeProgressUpdate] and returns the inserted row.
  ///
  /// The returned [ChallengeProgressUpdate] will have its `id` field set.
  Future<ChallengeProgressUpdate> insertRow(
    _i1.DatabaseSession session,
    ChallengeProgressUpdate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChallengeProgressUpdate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeProgressUpdate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChallengeProgressUpdate>> update(
    _i1.DatabaseSession session,
    List<ChallengeProgressUpdate> rows, {
    _i1.ColumnSelections<ChallengeProgressUpdateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChallengeProgressUpdate>(
      rows,
      columns: columns?.call(ChallengeProgressUpdate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeProgressUpdate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChallengeProgressUpdate> updateRow(
    _i1.DatabaseSession session,
    ChallengeProgressUpdate row, {
    _i1.ColumnSelections<ChallengeProgressUpdateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChallengeProgressUpdate>(
      row,
      columns: columns?.call(ChallengeProgressUpdate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeProgressUpdate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChallengeProgressUpdate?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ChallengeProgressUpdateUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ChallengeProgressUpdate>(
      id,
      columnValues: columnValues(ChallengeProgressUpdate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeProgressUpdate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ChallengeProgressUpdate>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ChallengeProgressUpdateUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<ChallengeProgressUpdateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeProgressUpdateTable>? orderBy,
    _i1.OrderByListBuilder<ChallengeProgressUpdateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ChallengeProgressUpdate>(
      columnValues: columnValues(ChallengeProgressUpdate.t.updateTable),
      where: where(ChallengeProgressUpdate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeProgressUpdate.t),
      orderByList: orderByList?.call(ChallengeProgressUpdate.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ChallengeProgressUpdate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChallengeProgressUpdate>> delete(
    _i1.DatabaseSession session,
    List<ChallengeProgressUpdate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChallengeProgressUpdate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChallengeProgressUpdate].
  Future<ChallengeProgressUpdate> deleteRow(
    _i1.DatabaseSession session,
    ChallengeProgressUpdate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChallengeProgressUpdate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChallengeProgressUpdate>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeProgressUpdateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChallengeProgressUpdate>(
      where: where(ChallengeProgressUpdate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeProgressUpdateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChallengeProgressUpdate>(
      where: where?.call(ChallengeProgressUpdate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChallengeProgressUpdate] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeProgressUpdateTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChallengeProgressUpdate>(
      where: where(ChallengeProgressUpdate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
