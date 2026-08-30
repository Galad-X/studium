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

abstract class DirectMessage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DirectMessage._({
    this.id,
    required this.conversationId,
    required this.authorId,
    required this.body,
    required this.status,
    required this.createdAt,
  });

  factory DirectMessage({
    int? id,
    required int conversationId,
    required int authorId,
    required String body,
    required String status,
    required DateTime createdAt,
  }) = _DirectMessageImpl;

  factory DirectMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return DirectMessage(
      id: jsonSerialization['id'] as int?,
      conversationId: jsonSerialization['conversationId'] as int,
      authorId: jsonSerialization['authorId'] as int,
      body: jsonSerialization['body'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = DirectMessageTable();

  static const db = DirectMessageRepository._();

  @override
  int? id;

  int conversationId;

  int authorId;

  String body;

  String status;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DirectMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DirectMessage copyWith({
    int? id,
    int? conversationId,
    int? authorId,
    String? body,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DirectMessage',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'authorId': authorId,
      'body': body,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DirectMessage',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'authorId': authorId,
      'body': body,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static DirectMessageInclude include() {
    return DirectMessageInclude._();
  }

  static DirectMessageIncludeList includeList({
    _i1.WhereExpressionBuilder<DirectMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DirectMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DirectMessageTable>? orderByList,
    DirectMessageInclude? include,
  }) {
    return DirectMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DirectMessage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DirectMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DirectMessageImpl extends DirectMessage {
  _DirectMessageImpl({
    int? id,
    required int conversationId,
    required int authorId,
    required String body,
    required String status,
    required DateTime createdAt,
  }) : super._(
          id: id,
          conversationId: conversationId,
          authorId: authorId,
          body: body,
          status: status,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [DirectMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DirectMessage copyWith({
    Object? id = _Undefined,
    int? conversationId,
    int? authorId,
    String? body,
    String? status,
    DateTime? createdAt,
  }) {
    return DirectMessage(
      id: id is int? ? id : this.id,
      conversationId: conversationId ?? this.conversationId,
      authorId: authorId ?? this.authorId,
      body: body ?? this.body,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class DirectMessageUpdateTable extends _i1.UpdateTable<DirectMessageTable> {
  DirectMessageUpdateTable(super.table);

  _i1.ColumnValue<int, int> conversationId(int value) => _i1.ColumnValue(
        table.conversationId,
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

class DirectMessageTable extends _i1.Table<int?> {
  DirectMessageTable({super.tableRelation})
      : super(tableName: 'direct_messages') {
    updateTable = DirectMessageUpdateTable(this);
    conversationId = _i1.ColumnInt(
      'conversationId',
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

  late final DirectMessageUpdateTable updateTable;

  late final _i1.ColumnInt conversationId;

  late final _i1.ColumnInt authorId;

  late final _i1.ColumnString body;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        conversationId,
        authorId,
        body,
        status,
        createdAt,
      ];
}

class DirectMessageInclude extends _i1.IncludeObject {
  DirectMessageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DirectMessage.t;
}

class DirectMessageIncludeList extends _i1.IncludeList {
  DirectMessageIncludeList._({
    _i1.WhereExpressionBuilder<DirectMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DirectMessage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DirectMessage.t;
}

class DirectMessageRepository {
  const DirectMessageRepository._();

  /// Returns a list of [DirectMessage]s matching the given query parameters.
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
  Future<List<DirectMessage>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DirectMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DirectMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DirectMessageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DirectMessage>(
      where: where?.call(DirectMessage.t),
      orderBy: orderBy?.call(DirectMessage.t),
      orderByList: orderByList?.call(DirectMessage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DirectMessage] matching the given query parameters.
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
  Future<DirectMessage?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DirectMessageTable>? where,
    int? offset,
    _i1.OrderByBuilder<DirectMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DirectMessageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DirectMessage>(
      where: where?.call(DirectMessage.t),
      orderBy: orderBy?.call(DirectMessage.t),
      orderByList: orderByList?.call(DirectMessage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DirectMessage] by its [id] or null if no such row exists.
  Future<DirectMessage?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DirectMessage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DirectMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [DirectMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DirectMessage>> insert(
    _i1.DatabaseSession session,
    List<DirectMessage> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DirectMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DirectMessage] and returns the inserted row.
  ///
  /// The returned [DirectMessage] will have its `id` field set.
  Future<DirectMessage> insertRow(
    _i1.DatabaseSession session,
    DirectMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DirectMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DirectMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DirectMessage>> update(
    _i1.DatabaseSession session,
    List<DirectMessage> rows, {
    _i1.ColumnSelections<DirectMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DirectMessage>(
      rows,
      columns: columns?.call(DirectMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DirectMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DirectMessage> updateRow(
    _i1.DatabaseSession session,
    DirectMessage row, {
    _i1.ColumnSelections<DirectMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DirectMessage>(
      row,
      columns: columns?.call(DirectMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DirectMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DirectMessage?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DirectMessageUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DirectMessage>(
      id,
      columnValues: columnValues(DirectMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DirectMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DirectMessage>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DirectMessageUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DirectMessageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DirectMessageTable>? orderBy,
    _i1.OrderByListBuilder<DirectMessageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DirectMessage>(
      columnValues: columnValues(DirectMessage.t.updateTable),
      where: where(DirectMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DirectMessage.t),
      orderByList: orderByList?.call(DirectMessage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DirectMessage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DirectMessage>> delete(
    _i1.DatabaseSession session,
    List<DirectMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DirectMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DirectMessage].
  Future<DirectMessage> deleteRow(
    _i1.DatabaseSession session,
    DirectMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DirectMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DirectMessage>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DirectMessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DirectMessage>(
      where: where(DirectMessage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DirectMessageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DirectMessage>(
      where: where?.call(DirectMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DirectMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DirectMessageTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DirectMessage>(
      where: where(DirectMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
