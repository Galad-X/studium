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

abstract class CollaborativeDocumentRevision
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CollaborativeDocumentRevision._({
    this.id,
    required this.documentId,
    required this.editorId,
    required this.version,
    required this.body,
    required this.createdAt,
  });

  factory CollaborativeDocumentRevision({
    int? id,
    required int documentId,
    required int editorId,
    required int version,
    required String body,
    required DateTime createdAt,
  }) = _CollaborativeDocumentRevisionImpl;

  factory CollaborativeDocumentRevision.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CollaborativeDocumentRevision(
      id: jsonSerialization['id'] as int?,
      documentId: jsonSerialization['documentId'] as int,
      editorId: jsonSerialization['editorId'] as int,
      version: jsonSerialization['version'] as int,
      body: jsonSerialization['body'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = CollaborativeDocumentRevisionTable();

  static const db = CollaborativeDocumentRevisionRepository._();

  @override
  int? id;

  int documentId;

  int editorId;

  int version;

  String body;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CollaborativeDocumentRevision]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CollaborativeDocumentRevision copyWith({
    int? id,
    int? documentId,
    int? editorId,
    int? version,
    String? body,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CollaborativeDocumentRevision',
      if (id != null) 'id': id,
      'documentId': documentId,
      'editorId': editorId,
      'version': version,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CollaborativeDocumentRevision',
      if (id != null) 'id': id,
      'documentId': documentId,
      'editorId': editorId,
      'version': version,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  static CollaborativeDocumentRevisionInclude include() {
    return CollaborativeDocumentRevisionInclude._();
  }

  static CollaborativeDocumentRevisionIncludeList includeList({
    _i1.WhereExpressionBuilder<CollaborativeDocumentRevisionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CollaborativeDocumentRevisionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CollaborativeDocumentRevisionTable>? orderByList,
    CollaborativeDocumentRevisionInclude? include,
  }) {
    return CollaborativeDocumentRevisionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CollaborativeDocumentRevision.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CollaborativeDocumentRevision.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CollaborativeDocumentRevisionImpl extends CollaborativeDocumentRevision {
  _CollaborativeDocumentRevisionImpl({
    int? id,
    required int documentId,
    required int editorId,
    required int version,
    required String body,
    required DateTime createdAt,
  }) : super._(
         id: id,
         documentId: documentId,
         editorId: editorId,
         version: version,
         body: body,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CollaborativeDocumentRevision]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CollaborativeDocumentRevision copyWith({
    Object? id = _Undefined,
    int? documentId,
    int? editorId,
    int? version,
    String? body,
    DateTime? createdAt,
  }) {
    return CollaborativeDocumentRevision(
      id: id is int? ? id : this.id,
      documentId: documentId ?? this.documentId,
      editorId: editorId ?? this.editorId,
      version: version ?? this.version,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CollaborativeDocumentRevisionUpdateTable
    extends _i1.UpdateTable<CollaborativeDocumentRevisionTable> {
  CollaborativeDocumentRevisionUpdateTable(super.table);

  _i1.ColumnValue<int, int> documentId(int value) => _i1.ColumnValue(
    table.documentId,
    value,
  );

  _i1.ColumnValue<int, int> editorId(int value) => _i1.ColumnValue(
    table.editorId,
    value,
  );

  _i1.ColumnValue<int, int> version(int value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
    table.body,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CollaborativeDocumentRevisionTable extends _i1.Table<int?> {
  CollaborativeDocumentRevisionTable({super.tableRelation})
    : super(tableName: 'collaborative_document_revisions') {
    updateTable = CollaborativeDocumentRevisionUpdateTable(this);
    documentId = _i1.ColumnInt(
      'documentId',
      this,
    );
    editorId = _i1.ColumnInt(
      'editorId',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CollaborativeDocumentRevisionUpdateTable updateTable;

  late final _i1.ColumnInt documentId;

  late final _i1.ColumnInt editorId;

  late final _i1.ColumnInt version;

  late final _i1.ColumnString body;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    documentId,
    editorId,
    version,
    body,
    createdAt,
  ];
}

class CollaborativeDocumentRevisionInclude extends _i1.IncludeObject {
  CollaborativeDocumentRevisionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CollaborativeDocumentRevision.t;
}

class CollaborativeDocumentRevisionIncludeList extends _i1.IncludeList {
  CollaborativeDocumentRevisionIncludeList._({
    _i1.WhereExpressionBuilder<CollaborativeDocumentRevisionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CollaborativeDocumentRevision.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CollaborativeDocumentRevision.t;
}

class CollaborativeDocumentRevisionRepository {
  const CollaborativeDocumentRevisionRepository._();

  /// Returns a list of [CollaborativeDocumentRevision]s matching the given query parameters.
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
  Future<List<CollaborativeDocumentRevision>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CollaborativeDocumentRevisionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CollaborativeDocumentRevisionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CollaborativeDocumentRevisionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CollaborativeDocumentRevision>(
      where: where?.call(CollaborativeDocumentRevision.t),
      orderBy: orderBy?.call(CollaborativeDocumentRevision.t),
      orderByList: orderByList?.call(CollaborativeDocumentRevision.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CollaborativeDocumentRevision] matching the given query parameters.
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
  Future<CollaborativeDocumentRevision?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CollaborativeDocumentRevisionTable>? where,
    int? offset,
    _i1.OrderByBuilder<CollaborativeDocumentRevisionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CollaborativeDocumentRevisionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CollaborativeDocumentRevision>(
      where: where?.call(CollaborativeDocumentRevision.t),
      orderBy: orderBy?.call(CollaborativeDocumentRevision.t),
      orderByList: orderByList?.call(CollaborativeDocumentRevision.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CollaborativeDocumentRevision] by its [id] or null if no such row exists.
  Future<CollaborativeDocumentRevision?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CollaborativeDocumentRevision>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CollaborativeDocumentRevision]s in the list and returns the inserted rows.
  ///
  /// The returned [CollaborativeDocumentRevision]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CollaborativeDocumentRevision>> insert(
    _i1.DatabaseSession session,
    List<CollaborativeDocumentRevision> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CollaborativeDocumentRevision>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CollaborativeDocumentRevision] and returns the inserted row.
  ///
  /// The returned [CollaborativeDocumentRevision] will have its `id` field set.
  Future<CollaborativeDocumentRevision> insertRow(
    _i1.DatabaseSession session,
    CollaborativeDocumentRevision row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CollaborativeDocumentRevision>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CollaborativeDocumentRevision]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CollaborativeDocumentRevision>> update(
    _i1.DatabaseSession session,
    List<CollaborativeDocumentRevision> rows, {
    _i1.ColumnSelections<CollaborativeDocumentRevisionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CollaborativeDocumentRevision>(
      rows,
      columns: columns?.call(CollaborativeDocumentRevision.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CollaborativeDocumentRevision]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CollaborativeDocumentRevision> updateRow(
    _i1.DatabaseSession session,
    CollaborativeDocumentRevision row, {
    _i1.ColumnSelections<CollaborativeDocumentRevisionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CollaborativeDocumentRevision>(
      row,
      columns: columns?.call(CollaborativeDocumentRevision.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CollaborativeDocumentRevision] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CollaborativeDocumentRevision?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<
      CollaborativeDocumentRevisionUpdateTable
    >
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CollaborativeDocumentRevision>(
      id,
      columnValues: columnValues(CollaborativeDocumentRevision.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CollaborativeDocumentRevision]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CollaborativeDocumentRevision>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<
      CollaborativeDocumentRevisionUpdateTable
    >
    columnValues,
    required _i1.WhereExpressionBuilder<CollaborativeDocumentRevisionTable>
    where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CollaborativeDocumentRevisionTable>? orderBy,
    _i1.OrderByListBuilder<CollaborativeDocumentRevisionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CollaborativeDocumentRevision>(
      columnValues: columnValues(CollaborativeDocumentRevision.t.updateTable),
      where: where(CollaborativeDocumentRevision.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CollaborativeDocumentRevision.t),
      orderByList: orderByList?.call(CollaborativeDocumentRevision.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CollaborativeDocumentRevision]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CollaborativeDocumentRevision>> delete(
    _i1.DatabaseSession session,
    List<CollaborativeDocumentRevision> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CollaborativeDocumentRevision>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CollaborativeDocumentRevision].
  Future<CollaborativeDocumentRevision> deleteRow(
    _i1.DatabaseSession session,
    CollaborativeDocumentRevision row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CollaborativeDocumentRevision>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CollaborativeDocumentRevision>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CollaborativeDocumentRevisionTable>
    where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CollaborativeDocumentRevision>(
      where: where(CollaborativeDocumentRevision.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CollaborativeDocumentRevisionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CollaborativeDocumentRevision>(
      where: where?.call(CollaborativeDocumentRevision.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CollaborativeDocumentRevision] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CollaborativeDocumentRevisionTable>
    where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CollaborativeDocumentRevision>(
      where: where(CollaborativeDocumentRevision.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
