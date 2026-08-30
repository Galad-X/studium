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

abstract class StudySessionParticipant
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StudySessionParticipant._({
    this.id,
    required this.sessionId,
    required this.userId,
    required this.status,
    required this.joinedAt,
  });

  factory StudySessionParticipant({
    int? id,
    required int sessionId,
    required int userId,
    required String status,
    required DateTime joinedAt,
  }) = _StudySessionParticipantImpl;

  factory StudySessionParticipant.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StudySessionParticipant(
      id: jsonSerialization['id'] as int?,
      sessionId: jsonSerialization['sessionId'] as int,
      userId: jsonSerialization['userId'] as int,
      status: jsonSerialization['status'] as String,
      joinedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  static final t = StudySessionParticipantTable();

  static const db = StudySessionParticipantRepository._();

  @override
  int? id;

  int sessionId;

  int userId;

  String status;

  DateTime joinedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudySessionParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudySessionParticipant copyWith({
    int? id,
    int? sessionId,
    int? userId,
    String? status,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudySessionParticipant',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'userId': userId,
      'status': status,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudySessionParticipant',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'userId': userId,
      'status': status,
      'joinedAt': joinedAt.toJson(),
    };
  }

  static StudySessionParticipantInclude include() {
    return StudySessionParticipantInclude._();
  }

  static StudySessionParticipantIncludeList includeList({
    _i1.WhereExpressionBuilder<StudySessionParticipantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudySessionParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudySessionParticipantTable>? orderByList,
    StudySessionParticipantInclude? include,
  }) {
    return StudySessionParticipantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudySessionParticipant.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StudySessionParticipant.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudySessionParticipantImpl extends StudySessionParticipant {
  _StudySessionParticipantImpl({
    int? id,
    required int sessionId,
    required int userId,
    required String status,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         sessionId: sessionId,
         userId: userId,
         status: status,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [StudySessionParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudySessionParticipant copyWith({
    Object? id = _Undefined,
    int? sessionId,
    int? userId,
    String? status,
    DateTime? joinedAt,
  }) {
    return StudySessionParticipant(
      id: id is int? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class StudySessionParticipantUpdateTable
    extends _i1.UpdateTable<StudySessionParticipantTable> {
  StudySessionParticipantUpdateTable(super.table);

  _i1.ColumnValue<int, int> sessionId(int value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _i1.ColumnValue(
        table.joinedAt,
        value,
      );
}

class StudySessionParticipantTable extends _i1.Table<int?> {
  StudySessionParticipantTable({super.tableRelation})
    : super(tableName: 'study_session_participants') {
    updateTable = StudySessionParticipantUpdateTable(this);
    sessionId = _i1.ColumnInt(
      'sessionId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    joinedAt = _i1.ColumnDateTime(
      'joinedAt',
      this,
    );
  }

  late final StudySessionParticipantUpdateTable updateTable;

  late final _i1.ColumnInt sessionId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime joinedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    sessionId,
    userId,
    status,
    joinedAt,
  ];
}

class StudySessionParticipantInclude extends _i1.IncludeObject {
  StudySessionParticipantInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StudySessionParticipant.t;
}

class StudySessionParticipantIncludeList extends _i1.IncludeList {
  StudySessionParticipantIncludeList._({
    _i1.WhereExpressionBuilder<StudySessionParticipantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudySessionParticipant.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StudySessionParticipant.t;
}

class StudySessionParticipantRepository {
  const StudySessionParticipantRepository._();

  /// Returns a list of [StudySessionParticipant]s matching the given query parameters.
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
  Future<List<StudySessionParticipant>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudySessionParticipantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudySessionParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudySessionParticipantTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudySessionParticipant>(
      where: where?.call(StudySessionParticipant.t),
      orderBy: orderBy?.call(StudySessionParticipant.t),
      orderByList: orderByList?.call(StudySessionParticipant.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudySessionParticipant] matching the given query parameters.
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
  Future<StudySessionParticipant?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudySessionParticipantTable>? where,
    int? offset,
    _i1.OrderByBuilder<StudySessionParticipantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudySessionParticipantTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudySessionParticipant>(
      where: where?.call(StudySessionParticipant.t),
      orderBy: orderBy?.call(StudySessionParticipant.t),
      orderByList: orderByList?.call(StudySessionParticipant.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudySessionParticipant] by its [id] or null if no such row exists.
  Future<StudySessionParticipant?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudySessionParticipant>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudySessionParticipant]s in the list and returns the inserted rows.
  ///
  /// The returned [StudySessionParticipant]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StudySessionParticipant>> insert(
    _i1.DatabaseSession session,
    List<StudySessionParticipant> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StudySessionParticipant>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StudySessionParticipant] and returns the inserted row.
  ///
  /// The returned [StudySessionParticipant] will have its `id` field set.
  Future<StudySessionParticipant> insertRow(
    _i1.DatabaseSession session,
    StudySessionParticipant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudySessionParticipant>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StudySessionParticipant]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StudySessionParticipant>> update(
    _i1.DatabaseSession session,
    List<StudySessionParticipant> rows, {
    _i1.ColumnSelections<StudySessionParticipantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StudySessionParticipant>(
      rows,
      columns: columns?.call(StudySessionParticipant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudySessionParticipant]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudySessionParticipant> updateRow(
    _i1.DatabaseSession session,
    StudySessionParticipant row, {
    _i1.ColumnSelections<StudySessionParticipantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudySessionParticipant>(
      row,
      columns: columns?.call(StudySessionParticipant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudySessionParticipant] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudySessionParticipant?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<StudySessionParticipantUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StudySessionParticipant>(
      id,
      columnValues: columnValues(StudySessionParticipant.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudySessionParticipant]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StudySessionParticipant>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StudySessionParticipantUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<StudySessionParticipantTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudySessionParticipantTable>? orderBy,
    _i1.OrderByListBuilder<StudySessionParticipantTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StudySessionParticipant>(
      columnValues: columnValues(StudySessionParticipant.t.updateTable),
      where: where(StudySessionParticipant.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudySessionParticipant.t),
      orderByList: orderByList?.call(StudySessionParticipant.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StudySessionParticipant]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StudySessionParticipant>> delete(
    _i1.DatabaseSession session,
    List<StudySessionParticipant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StudySessionParticipant>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StudySessionParticipant].
  Future<StudySessionParticipant> deleteRow(
    _i1.DatabaseSession session,
    StudySessionParticipant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudySessionParticipant>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StudySessionParticipant>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudySessionParticipantTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StudySessionParticipant>(
      where: where(StudySessionParticipant.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudySessionParticipantTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StudySessionParticipant>(
      where: where?.call(StudySessionParticipant.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudySessionParticipant] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudySessionParticipantTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudySessionParticipant>(
      where: where(StudySessionParticipant.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
