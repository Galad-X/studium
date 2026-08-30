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

abstract class CollaborationPresence
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CollaborationPresence._({
    this.id,
    required this.userId,
    required this.scopeType,
    required this.scopeId,
    required this.state,
    required this.lastSeenAt,
  });

  factory CollaborationPresence({
    int? id,
    required int userId,
    required String scopeType,
    required int scopeId,
    required String state,
    required DateTime lastSeenAt,
  }) = _CollaborationPresenceImpl;

  factory CollaborationPresence.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CollaborationPresence(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      scopeType: jsonSerialization['scopeType'] as String,
      scopeId: jsonSerialization['scopeId'] as int,
      state: jsonSerialization['state'] as String,
      lastSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
    );
  }

  static final t = CollaborationPresenceTable();

  static const db = CollaborationPresenceRepository._();

  @override
  int? id;

  int userId;

  String scopeType;

  int scopeId;

  String state;

  DateTime lastSeenAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CollaborationPresence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CollaborationPresence copyWith({
    int? id,
    int? userId,
    String? scopeType,
    int? scopeId,
    String? state,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CollaborationPresence',
      if (id != null) 'id': id,
      'userId': userId,
      'scopeType': scopeType,
      'scopeId': scopeId,
      'state': state,
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CollaborationPresence',
      if (id != null) 'id': id,
      'userId': userId,
      'scopeType': scopeType,
      'scopeId': scopeId,
      'state': state,
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  static CollaborationPresenceInclude include() {
    return CollaborationPresenceInclude._();
  }

  static CollaborationPresenceIncludeList includeList({
    _i1.WhereExpressionBuilder<CollaborationPresenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CollaborationPresenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CollaborationPresenceTable>? orderByList,
    CollaborationPresenceInclude? include,
  }) {
    return CollaborationPresenceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CollaborationPresence.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CollaborationPresence.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CollaborationPresenceImpl extends CollaborationPresence {
  _CollaborationPresenceImpl({
    int? id,
    required int userId,
    required String scopeType,
    required int scopeId,
    required String state,
    required DateTime lastSeenAt,
  }) : super._(
         id: id,
         userId: userId,
         scopeType: scopeType,
         scopeId: scopeId,
         state: state,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [CollaborationPresence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CollaborationPresence copyWith({
    Object? id = _Undefined,
    int? userId,
    String? scopeType,
    int? scopeId,
    String? state,
    DateTime? lastSeenAt,
  }) {
    return CollaborationPresence(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      scopeType: scopeType ?? this.scopeType,
      scopeId: scopeId ?? this.scopeId,
      state: state ?? this.state,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}

class CollaborationPresenceUpdateTable
    extends _i1.UpdateTable<CollaborationPresenceTable> {
  CollaborationPresenceUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> scopeType(String value) => _i1.ColumnValue(
    table.scopeType,
    value,
  );

  _i1.ColumnValue<int, int> scopeId(int value) => _i1.ColumnValue(
    table.scopeId,
    value,
  );

  _i1.ColumnValue<String, String> state(String value) => _i1.ColumnValue(
    table.state,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime value) =>
      _i1.ColumnValue(
        table.lastSeenAt,
        value,
      );
}

class CollaborationPresenceTable extends _i1.Table<int?> {
  CollaborationPresenceTable({super.tableRelation})
    : super(tableName: 'collaboration_presence') {
    updateTable = CollaborationPresenceUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    scopeType = _i1.ColumnString(
      'scopeType',
      this,
    );
    scopeId = _i1.ColumnInt(
      'scopeId',
      this,
    );
    state = _i1.ColumnString(
      'state',
      this,
    );
    lastSeenAt = _i1.ColumnDateTime(
      'lastSeenAt',
      this,
    );
  }

  late final CollaborationPresenceUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString scopeType;

  late final _i1.ColumnInt scopeId;

  late final _i1.ColumnString state;

  late final _i1.ColumnDateTime lastSeenAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    scopeType,
    scopeId,
    state,
    lastSeenAt,
  ];
}

class CollaborationPresenceInclude extends _i1.IncludeObject {
  CollaborationPresenceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CollaborationPresence.t;
}

class CollaborationPresenceIncludeList extends _i1.IncludeList {
  CollaborationPresenceIncludeList._({
    _i1.WhereExpressionBuilder<CollaborationPresenceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CollaborationPresence.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CollaborationPresence.t;
}

class CollaborationPresenceRepository {
  const CollaborationPresenceRepository._();

  /// Returns a list of [CollaborationPresence]s matching the given query parameters.
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
  Future<List<CollaborationPresence>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CollaborationPresenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CollaborationPresenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CollaborationPresenceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CollaborationPresence>(
      where: where?.call(CollaborationPresence.t),
      orderBy: orderBy?.call(CollaborationPresence.t),
      orderByList: orderByList?.call(CollaborationPresence.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CollaborationPresence] matching the given query parameters.
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
  Future<CollaborationPresence?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CollaborationPresenceTable>? where,
    int? offset,
    _i1.OrderByBuilder<CollaborationPresenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CollaborationPresenceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CollaborationPresence>(
      where: where?.call(CollaborationPresence.t),
      orderBy: orderBy?.call(CollaborationPresence.t),
      orderByList: orderByList?.call(CollaborationPresence.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CollaborationPresence] by its [id] or null if no such row exists.
  Future<CollaborationPresence?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CollaborationPresence>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CollaborationPresence]s in the list and returns the inserted rows.
  ///
  /// The returned [CollaborationPresence]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CollaborationPresence>> insert(
    _i1.DatabaseSession session,
    List<CollaborationPresence> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CollaborationPresence>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CollaborationPresence] and returns the inserted row.
  ///
  /// The returned [CollaborationPresence] will have its `id` field set.
  Future<CollaborationPresence> insertRow(
    _i1.DatabaseSession session,
    CollaborationPresence row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CollaborationPresence>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CollaborationPresence]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CollaborationPresence>> update(
    _i1.DatabaseSession session,
    List<CollaborationPresence> rows, {
    _i1.ColumnSelections<CollaborationPresenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CollaborationPresence>(
      rows,
      columns: columns?.call(CollaborationPresence.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CollaborationPresence]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CollaborationPresence> updateRow(
    _i1.DatabaseSession session,
    CollaborationPresence row, {
    _i1.ColumnSelections<CollaborationPresenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CollaborationPresence>(
      row,
      columns: columns?.call(CollaborationPresence.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CollaborationPresence] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CollaborationPresence?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CollaborationPresenceUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CollaborationPresence>(
      id,
      columnValues: columnValues(CollaborationPresence.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CollaborationPresence]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CollaborationPresence>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CollaborationPresenceUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CollaborationPresenceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CollaborationPresenceTable>? orderBy,
    _i1.OrderByListBuilder<CollaborationPresenceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CollaborationPresence>(
      columnValues: columnValues(CollaborationPresence.t.updateTable),
      where: where(CollaborationPresence.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CollaborationPresence.t),
      orderByList: orderByList?.call(CollaborationPresence.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CollaborationPresence]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CollaborationPresence>> delete(
    _i1.DatabaseSession session,
    List<CollaborationPresence> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CollaborationPresence>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CollaborationPresence].
  Future<CollaborationPresence> deleteRow(
    _i1.DatabaseSession session,
    CollaborationPresence row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CollaborationPresence>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CollaborationPresence>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CollaborationPresenceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CollaborationPresence>(
      where: where(CollaborationPresence.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CollaborationPresenceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CollaborationPresence>(
      where: where?.call(CollaborationPresence.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CollaborationPresence] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CollaborationPresenceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CollaborationPresence>(
      where: where(CollaborationPresence.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
