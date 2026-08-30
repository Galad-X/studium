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

abstract class ConversationReadReceipt
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ConversationReadReceipt._({
    this.id,
    required this.conversationId,
    required this.userId,
    required this.lastReadMessageId,
    required this.updatedAt,
  });

  factory ConversationReadReceipt({
    int? id,
    required int conversationId,
    required int userId,
    required int lastReadMessageId,
    required DateTime updatedAt,
  }) = _ConversationReadReceiptImpl;

  factory ConversationReadReceipt.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ConversationReadReceipt(
      id: jsonSerialization['id'] as int?,
      conversationId: jsonSerialization['conversationId'] as int,
      userId: jsonSerialization['userId'] as int,
      lastReadMessageId: jsonSerialization['lastReadMessageId'] as int,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ConversationReadReceiptTable();

  static const db = ConversationReadReceiptRepository._();

  @override
  int? id;

  int conversationId;

  int userId;

  int lastReadMessageId;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ConversationReadReceipt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ConversationReadReceipt copyWith({
    int? id,
    int? conversationId,
    int? userId,
    int? lastReadMessageId,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConversationReadReceipt',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'userId': userId,
      'lastReadMessageId': lastReadMessageId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConversationReadReceipt',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'userId': userId,
      'lastReadMessageId': lastReadMessageId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ConversationReadReceiptInclude include() {
    return ConversationReadReceiptInclude._();
  }

  static ConversationReadReceiptIncludeList includeList({
    _i1.WhereExpressionBuilder<ConversationReadReceiptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConversationReadReceiptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConversationReadReceiptTable>? orderByList,
    ConversationReadReceiptInclude? include,
  }) {
    return ConversationReadReceiptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConversationReadReceipt.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ConversationReadReceipt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConversationReadReceiptImpl extends ConversationReadReceipt {
  _ConversationReadReceiptImpl({
    int? id,
    required int conversationId,
    required int userId,
    required int lastReadMessageId,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          conversationId: conversationId,
          userId: userId,
          lastReadMessageId: lastReadMessageId,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ConversationReadReceipt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ConversationReadReceipt copyWith({
    Object? id = _Undefined,
    int? conversationId,
    int? userId,
    int? lastReadMessageId,
    DateTime? updatedAt,
  }) {
    return ConversationReadReceipt(
      id: id is int? ? id : this.id,
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      lastReadMessageId: lastReadMessageId ?? this.lastReadMessageId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ConversationReadReceiptUpdateTable
    extends _i1.UpdateTable<ConversationReadReceiptTable> {
  ConversationReadReceiptUpdateTable(super.table);

  _i1.ColumnValue<int, int> conversationId(int value) => _i1.ColumnValue(
        table.conversationId,
        value,
      );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<int, int> lastReadMessageId(int value) => _i1.ColumnValue(
        table.lastReadMessageId,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ConversationReadReceiptTable extends _i1.Table<int?> {
  ConversationReadReceiptTable({super.tableRelation})
      : super(tableName: 'conversation_read_receipts') {
    updateTable = ConversationReadReceiptUpdateTable(this);
    conversationId = _i1.ColumnInt(
      'conversationId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    lastReadMessageId = _i1.ColumnInt(
      'lastReadMessageId',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ConversationReadReceiptUpdateTable updateTable;

  late final _i1.ColumnInt conversationId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt lastReadMessageId;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        conversationId,
        userId,
        lastReadMessageId,
        updatedAt,
      ];
}

class ConversationReadReceiptInclude extends _i1.IncludeObject {
  ConversationReadReceiptInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ConversationReadReceipt.t;
}

class ConversationReadReceiptIncludeList extends _i1.IncludeList {
  ConversationReadReceiptIncludeList._({
    _i1.WhereExpressionBuilder<ConversationReadReceiptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ConversationReadReceipt.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ConversationReadReceipt.t;
}

class ConversationReadReceiptRepository {
  const ConversationReadReceiptRepository._();

  /// Returns a list of [ConversationReadReceipt]s matching the given query parameters.
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
  Future<List<ConversationReadReceipt>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConversationReadReceiptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConversationReadReceiptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConversationReadReceiptTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ConversationReadReceipt>(
      where: where?.call(ConversationReadReceipt.t),
      orderBy: orderBy?.call(ConversationReadReceipt.t),
      orderByList: orderByList?.call(ConversationReadReceipt.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ConversationReadReceipt] matching the given query parameters.
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
  Future<ConversationReadReceipt?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConversationReadReceiptTable>? where,
    int? offset,
    _i1.OrderByBuilder<ConversationReadReceiptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConversationReadReceiptTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ConversationReadReceipt>(
      where: where?.call(ConversationReadReceipt.t),
      orderBy: orderBy?.call(ConversationReadReceipt.t),
      orderByList: orderByList?.call(ConversationReadReceipt.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ConversationReadReceipt] by its [id] or null if no such row exists.
  Future<ConversationReadReceipt?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ConversationReadReceipt>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ConversationReadReceipt]s in the list and returns the inserted rows.
  ///
  /// The returned [ConversationReadReceipt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ConversationReadReceipt>> insert(
    _i1.DatabaseSession session,
    List<ConversationReadReceipt> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ConversationReadReceipt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ConversationReadReceipt] and returns the inserted row.
  ///
  /// The returned [ConversationReadReceipt] will have its `id` field set.
  Future<ConversationReadReceipt> insertRow(
    _i1.DatabaseSession session,
    ConversationReadReceipt row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ConversationReadReceipt>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ConversationReadReceipt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ConversationReadReceipt>> update(
    _i1.DatabaseSession session,
    List<ConversationReadReceipt> rows, {
    _i1.ColumnSelections<ConversationReadReceiptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ConversationReadReceipt>(
      rows,
      columns: columns?.call(ConversationReadReceipt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ConversationReadReceipt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ConversationReadReceipt> updateRow(
    _i1.DatabaseSession session,
    ConversationReadReceipt row, {
    _i1.ColumnSelections<ConversationReadReceiptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ConversationReadReceipt>(
      row,
      columns: columns?.call(ConversationReadReceipt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ConversationReadReceipt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ConversationReadReceipt?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ConversationReadReceiptUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ConversationReadReceipt>(
      id,
      columnValues: columnValues(ConversationReadReceipt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ConversationReadReceipt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ConversationReadReceipt>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ConversationReadReceiptUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<ConversationReadReceiptTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConversationReadReceiptTable>? orderBy,
    _i1.OrderByListBuilder<ConversationReadReceiptTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ConversationReadReceipt>(
      columnValues: columnValues(ConversationReadReceipt.t.updateTable),
      where: where(ConversationReadReceipt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConversationReadReceipt.t),
      orderByList: orderByList?.call(ConversationReadReceipt.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ConversationReadReceipt]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ConversationReadReceipt>> delete(
    _i1.DatabaseSession session,
    List<ConversationReadReceipt> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ConversationReadReceipt>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ConversationReadReceipt].
  Future<ConversationReadReceipt> deleteRow(
    _i1.DatabaseSession session,
    ConversationReadReceipt row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ConversationReadReceipt>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ConversationReadReceipt>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ConversationReadReceiptTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ConversationReadReceipt>(
      where: where(ConversationReadReceipt.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConversationReadReceiptTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ConversationReadReceipt>(
      where: where?.call(ConversationReadReceipt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ConversationReadReceipt] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ConversationReadReceiptTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ConversationReadReceipt>(
      where: where(ConversationReadReceipt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
