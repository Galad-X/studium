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

abstract class CollaborativeDocument
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CollaborativeDocument._({
    this.id,
    required this.roomId,
    required this.ownerId,
    required this.title,
    required this.body,
    required this.version,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CollaborativeDocument({
    int? id,
    required int roomId,
    required int ownerId,
    required String title,
    required String body,
    required int version,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CollaborativeDocumentImpl;

  factory CollaborativeDocument.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CollaborativeDocument(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      ownerId: jsonSerialization['ownerId'] as int,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      version: jsonSerialization['version'] as int,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = CollaborativeDocumentTable();

  static const db = CollaborativeDocumentRepository._();

  @override
  int? id;

  int roomId;

  int ownerId;

  String title;

  String body;

  int version;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CollaborativeDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CollaborativeDocument copyWith({
    int? id,
    int? roomId,
    int? ownerId,
    String? title,
    String? body,
    int? version,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CollaborativeDocument',
      if (id != null) 'id': id,
      'roomId': roomId,
      'ownerId': ownerId,
      'title': title,
      'body': body,
      'version': version,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CollaborativeDocument',
      if (id != null) 'id': id,
      'roomId': roomId,
      'ownerId': ownerId,
      'title': title,
      'body': body,
      'version': version,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static CollaborativeDocumentInclude include() {
    return CollaborativeDocumentInclude._();
  }

  static CollaborativeDocumentIncludeList includeList({
    _i1.WhereExpressionBuilder<CollaborativeDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CollaborativeDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CollaborativeDocumentTable>? orderByList,
    CollaborativeDocumentInclude? include,
  }) {
    return CollaborativeDocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CollaborativeDocument.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CollaborativeDocument.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CollaborativeDocumentImpl extends CollaborativeDocument {
  _CollaborativeDocumentImpl({
    int? id,
    required int roomId,
    required int ownerId,
    required String title,
    required String body,
    required int version,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         roomId: roomId,
         ownerId: ownerId,
         title: title,
         body: body,
         version: version,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CollaborativeDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CollaborativeDocument copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? ownerId,
    String? title,
    String? body,
    int? version,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CollaborativeDocument(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      body: body ?? this.body,
      version: version ?? this.version,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CollaborativeDocumentUpdateTable
    extends _i1.UpdateTable<CollaborativeDocumentTable> {
  CollaborativeDocumentUpdateTable(super.table);

  _i1.ColumnValue<int, int> roomId(int value) => _i1.ColumnValue(
    table.roomId,
    value,
  );

  _i1.ColumnValue<int, int> ownerId(int value) => _i1.ColumnValue(
    table.ownerId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
    table.body,
    value,
  );

  _i1.ColumnValue<int, int> version(int value) => _i1.ColumnValue(
    table.version,
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

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class CollaborativeDocumentTable extends _i1.Table<int?> {
  CollaborativeDocumentTable({super.tableRelation})
    : super(tableName: 'collaborative_documents') {
    updateTable = CollaborativeDocumentUpdateTable(this);
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    ownerId = _i1.ColumnInt(
      'ownerId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    version = _i1.ColumnInt(
      'version',
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
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final CollaborativeDocumentUpdateTable updateTable;

  late final _i1.ColumnInt roomId;

  late final _i1.ColumnInt ownerId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString body;

  late final _i1.ColumnInt version;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    roomId,
    ownerId,
    title,
    body,
    version,
    status,
    createdAt,
    updatedAt,
  ];
}

class CollaborativeDocumentInclude extends _i1.IncludeObject {
  CollaborativeDocumentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CollaborativeDocument.t;
}

class CollaborativeDocumentIncludeList extends _i1.IncludeList {
  CollaborativeDocumentIncludeList._({
    _i1.WhereExpressionBuilder<CollaborativeDocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CollaborativeDocument.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CollaborativeDocument.t;
}

class CollaborativeDocumentRepository {
  const CollaborativeDocumentRepository._();

  /// Returns a list of [CollaborativeDocument]s matching the given query parameters.
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
  Future<List<CollaborativeDocument>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CollaborativeDocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CollaborativeDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CollaborativeDocumentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CollaborativeDocument>(
      where: where?.call(CollaborativeDocument.t),
      orderBy: orderBy?.call(CollaborativeDocument.t),
      orderByList: orderByList?.call(CollaborativeDocument.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CollaborativeDocument] matching the given query parameters.
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
  Future<CollaborativeDocument?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CollaborativeDocumentTable>? where,
    int? offset,
    _i1.OrderByBuilder<CollaborativeDocumentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CollaborativeDocumentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CollaborativeDocument>(
      where: where?.call(CollaborativeDocument.t),
      orderBy: orderBy?.call(CollaborativeDocument.t),
      orderByList: orderByList?.call(CollaborativeDocument.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CollaborativeDocument] by its [id] or null if no such row exists.
  Future<CollaborativeDocument?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CollaborativeDocument>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CollaborativeDocument]s in the list and returns the inserted rows.
  ///
  /// The returned [CollaborativeDocument]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CollaborativeDocument>> insert(
    _i1.DatabaseSession session,
    List<CollaborativeDocument> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CollaborativeDocument>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CollaborativeDocument] and returns the inserted row.
  ///
  /// The returned [CollaborativeDocument] will have its `id` field set.
  Future<CollaborativeDocument> insertRow(
    _i1.DatabaseSession session,
    CollaborativeDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CollaborativeDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CollaborativeDocument]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CollaborativeDocument>> update(
    _i1.DatabaseSession session,
    List<CollaborativeDocument> rows, {
    _i1.ColumnSelections<CollaborativeDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CollaborativeDocument>(
      rows,
      columns: columns?.call(CollaborativeDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CollaborativeDocument]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CollaborativeDocument> updateRow(
    _i1.DatabaseSession session,
    CollaborativeDocument row, {
    _i1.ColumnSelections<CollaborativeDocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CollaborativeDocument>(
      row,
      columns: columns?.call(CollaborativeDocument.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CollaborativeDocument] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CollaborativeDocument?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CollaborativeDocumentUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CollaborativeDocument>(
      id,
      columnValues: columnValues(CollaborativeDocument.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CollaborativeDocument]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CollaborativeDocument>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CollaborativeDocumentUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CollaborativeDocumentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CollaborativeDocumentTable>? orderBy,
    _i1.OrderByListBuilder<CollaborativeDocumentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CollaborativeDocument>(
      columnValues: columnValues(CollaborativeDocument.t.updateTable),
      where: where(CollaborativeDocument.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CollaborativeDocument.t),
      orderByList: orderByList?.call(CollaborativeDocument.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CollaborativeDocument]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CollaborativeDocument>> delete(
    _i1.DatabaseSession session,
    List<CollaborativeDocument> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CollaborativeDocument>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CollaborativeDocument].
  Future<CollaborativeDocument> deleteRow(
    _i1.DatabaseSession session,
    CollaborativeDocument row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CollaborativeDocument>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CollaborativeDocument>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CollaborativeDocumentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CollaborativeDocument>(
      where: where(CollaborativeDocument.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CollaborativeDocumentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CollaborativeDocument>(
      where: where?.call(CollaborativeDocument.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CollaborativeDocument] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CollaborativeDocumentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CollaborativeDocument>(
      where: where(CollaborativeDocument.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
