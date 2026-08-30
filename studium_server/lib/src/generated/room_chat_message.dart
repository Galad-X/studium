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

abstract class RoomChatMessage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RoomChatMessage._({
    this.id,
    required this.roomId,
    required this.authorId,
    required this.body,
    required this.status,
    required this.createdAt,
  });

  factory RoomChatMessage({
    int? id,
    required int roomId,
    required int authorId,
    required String body,
    required String status,
    required DateTime createdAt,
  }) = _RoomChatMessageImpl;

  factory RoomChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomChatMessage(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      authorId: jsonSerialization['authorId'] as int,
      body: jsonSerialization['body'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = RoomChatMessageTable();

  static const db = RoomChatMessageRepository._();

  @override
  int? id;

  int roomId;

  int authorId;

  String body;

  String status;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoomChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoomChatMessage copyWith({
    int? id,
    int? roomId,
    int? authorId,
    String? body,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomChatMessage',
      if (id != null) 'id': id,
      'roomId': roomId,
      'authorId': authorId,
      'body': body,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomChatMessage',
      if (id != null) 'id': id,
      'roomId': roomId,
      'authorId': authorId,
      'body': body,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static RoomChatMessageInclude include() {
    return RoomChatMessageInclude._();
  }

  static RoomChatMessageIncludeList includeList({
    _i1.WhereExpressionBuilder<RoomChatMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomChatMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomChatMessageTable>? orderByList,
    RoomChatMessageInclude? include,
  }) {
    return RoomChatMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomChatMessage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoomChatMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomChatMessageImpl extends RoomChatMessage {
  _RoomChatMessageImpl({
    int? id,
    required int roomId,
    required int authorId,
    required String body,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         authorId: authorId,
         body: body,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RoomChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoomChatMessage copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? authorId,
    String? body,
    String? status,
    DateTime? createdAt,
  }) {
    return RoomChatMessage(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      authorId: authorId ?? this.authorId,
      body: body ?? this.body,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RoomChatMessageUpdateTable extends _i1.UpdateTable<RoomChatMessageTable> {
  RoomChatMessageUpdateTable(super.table);

  _i1.ColumnValue<int, int> roomId(int value) => _i1.ColumnValue(
    table.roomId,
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

class RoomChatMessageTable extends _i1.Table<int?> {
  RoomChatMessageTable({super.tableRelation})
    : super(tableName: 'room_chat_messages') {
    updateTable = RoomChatMessageUpdateTable(this);
    roomId = _i1.ColumnInt(
      'roomId',
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

  late final RoomChatMessageUpdateTable updateTable;

  late final _i1.ColumnInt roomId;

  late final _i1.ColumnInt authorId;

  late final _i1.ColumnString body;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    roomId,
    authorId,
    body,
    status,
    createdAt,
  ];
}

class RoomChatMessageInclude extends _i1.IncludeObject {
  RoomChatMessageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RoomChatMessage.t;
}

class RoomChatMessageIncludeList extends _i1.IncludeList {
  RoomChatMessageIncludeList._({
    _i1.WhereExpressionBuilder<RoomChatMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomChatMessage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RoomChatMessage.t;
}

class RoomChatMessageRepository {
  const RoomChatMessageRepository._();

  /// Returns a list of [RoomChatMessage]s matching the given query parameters.
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
  Future<List<RoomChatMessage>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomChatMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomChatMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomChatMessageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoomChatMessage>(
      where: where?.call(RoomChatMessage.t),
      orderBy: orderBy?.call(RoomChatMessage.t),
      orderByList: orderByList?.call(RoomChatMessage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoomChatMessage] matching the given query parameters.
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
  Future<RoomChatMessage?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomChatMessageTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoomChatMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomChatMessageTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoomChatMessage>(
      where: where?.call(RoomChatMessage.t),
      orderBy: orderBy?.call(RoomChatMessage.t),
      orderByList: orderByList?.call(RoomChatMessage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoomChatMessage] by its [id] or null if no such row exists.
  Future<RoomChatMessage?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoomChatMessage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoomChatMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [RoomChatMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RoomChatMessage>> insert(
    _i1.DatabaseSession session,
    List<RoomChatMessage> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RoomChatMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RoomChatMessage] and returns the inserted row.
  ///
  /// The returned [RoomChatMessage] will have its `id` field set.
  Future<RoomChatMessage> insertRow(
    _i1.DatabaseSession session,
    RoomChatMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomChatMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RoomChatMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RoomChatMessage>> update(
    _i1.DatabaseSession session,
    List<RoomChatMessage> rows, {
    _i1.ColumnSelections<RoomChatMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RoomChatMessage>(
      rows,
      columns: columns?.call(RoomChatMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomChatMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoomChatMessage> updateRow(
    _i1.DatabaseSession session,
    RoomChatMessage row, {
    _i1.ColumnSelections<RoomChatMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoomChatMessage>(
      row,
      columns: columns?.call(RoomChatMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomChatMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoomChatMessage?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RoomChatMessageUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RoomChatMessage>(
      id,
      columnValues: columnValues(RoomChatMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoomChatMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RoomChatMessage>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RoomChatMessageUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<RoomChatMessageTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomChatMessageTable>? orderBy,
    _i1.OrderByListBuilder<RoomChatMessageTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RoomChatMessage>(
      columnValues: columnValues(RoomChatMessage.t.updateTable),
      where: where(RoomChatMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomChatMessage.t),
      orderByList: orderByList?.call(RoomChatMessage.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RoomChatMessage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RoomChatMessage>> delete(
    _i1.DatabaseSession session,
    List<RoomChatMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomChatMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RoomChatMessage].
  Future<RoomChatMessage> deleteRow(
    _i1.DatabaseSession session,
    RoomChatMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomChatMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RoomChatMessage>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoomChatMessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoomChatMessage>(
      where: where(RoomChatMessage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomChatMessageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoomChatMessage>(
      where: where?.call(RoomChatMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoomChatMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoomChatMessageTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoomChatMessage>(
      where: where(RoomChatMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
