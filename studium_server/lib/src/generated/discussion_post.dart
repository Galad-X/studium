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

abstract class DiscussionPost
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DiscussionPost._({
    this.id,
    required this.roomId,
    required this.authorId,
    this.acceptedCommentId,
    required this.body,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DiscussionPost({
    int? id,
    required int roomId,
    required int authorId,
    int? acceptedCommentId,
    required String body,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DiscussionPostImpl;

  factory DiscussionPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscussionPost(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      authorId: jsonSerialization['authorId'] as int,
      acceptedCommentId: jsonSerialization['acceptedCommentId'] as int?,
      body: jsonSerialization['body'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = DiscussionPostTable();

  static const db = DiscussionPostRepository._();

  @override
  int? id;

  int roomId;

  int authorId;

  int? acceptedCommentId;

  String body;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscussionPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscussionPost copyWith({
    int? id,
    int? roomId,
    int? authorId,
    int? acceptedCommentId,
    String? body,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscussionPost',
      if (id != null) 'id': id,
      'roomId': roomId,
      'authorId': authorId,
      if (acceptedCommentId != null) 'acceptedCommentId': acceptedCommentId,
      'body': body,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscussionPost',
      if (id != null) 'id': id,
      'roomId': roomId,
      'authorId': authorId,
      if (acceptedCommentId != null) 'acceptedCommentId': acceptedCommentId,
      'body': body,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DiscussionPostInclude include() {
    return DiscussionPostInclude._();
  }

  static DiscussionPostIncludeList includeList({
    _i1.WhereExpressionBuilder<DiscussionPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscussionPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscussionPostTable>? orderByList,
    DiscussionPostInclude? include,
  }) {
    return DiscussionPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscussionPost.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DiscussionPost.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscussionPostImpl extends DiscussionPost {
  _DiscussionPostImpl({
    int? id,
    required int roomId,
    required int authorId,
    int? acceptedCommentId,
    required String body,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          roomId: roomId,
          authorId: authorId,
          acceptedCommentId: acceptedCommentId,
          body: body,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [DiscussionPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscussionPost copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? authorId,
    Object? acceptedCommentId = _Undefined,
    String? body,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DiscussionPost(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      authorId: authorId ?? this.authorId,
      acceptedCommentId: acceptedCommentId is int?
          ? acceptedCommentId
          : this.acceptedCommentId,
      body: body ?? this.body,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DiscussionPostUpdateTable extends _i1.UpdateTable<DiscussionPostTable> {
  DiscussionPostUpdateTable(super.table);

  _i1.ColumnValue<int, int> roomId(int value) => _i1.ColumnValue(
        table.roomId,
        value,
      );

  _i1.ColumnValue<int, int> authorId(int value) => _i1.ColumnValue(
        table.authorId,
        value,
      );

  _i1.ColumnValue<int, int> acceptedCommentId(int? value) => _i1.ColumnValue(
        table.acceptedCommentId,
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

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class DiscussionPostTable extends _i1.Table<int?> {
  DiscussionPostTable({super.tableRelation})
      : super(tableName: 'discussion_posts') {
    updateTable = DiscussionPostUpdateTable(this);
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    authorId = _i1.ColumnInt(
      'authorId',
      this,
    );
    acceptedCommentId = _i1.ColumnInt(
      'acceptedCommentId',
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
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final DiscussionPostUpdateTable updateTable;

  late final _i1.ColumnInt roomId;

  late final _i1.ColumnInt authorId;

  late final _i1.ColumnInt acceptedCommentId;

  late final _i1.ColumnString body;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        roomId,
        authorId,
        acceptedCommentId,
        body,
        status,
        createdAt,
        updatedAt,
      ];
}

class DiscussionPostInclude extends _i1.IncludeObject {
  DiscussionPostInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DiscussionPost.t;
}

class DiscussionPostIncludeList extends _i1.IncludeList {
  DiscussionPostIncludeList._({
    _i1.WhereExpressionBuilder<DiscussionPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscussionPost.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DiscussionPost.t;
}

class DiscussionPostRepository {
  const DiscussionPostRepository._();

  /// Returns a list of [DiscussionPost]s matching the given query parameters.
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
  Future<List<DiscussionPost>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscussionPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscussionPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscussionPostTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscussionPost>(
      where: where?.call(DiscussionPost.t),
      orderBy: orderBy?.call(DiscussionPost.t),
      orderByList: orderByList?.call(DiscussionPost.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscussionPost] matching the given query parameters.
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
  Future<DiscussionPost?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscussionPostTable>? where,
    int? offset,
    _i1.OrderByBuilder<DiscussionPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscussionPostTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscussionPost>(
      where: where?.call(DiscussionPost.t),
      orderBy: orderBy?.call(DiscussionPost.t),
      orderByList: orderByList?.call(DiscussionPost.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscussionPost] by its [id] or null if no such row exists.
  Future<DiscussionPost?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscussionPost>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscussionPost]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscussionPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DiscussionPost>> insert(
    _i1.DatabaseSession session,
    List<DiscussionPost> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DiscussionPost>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DiscussionPost] and returns the inserted row.
  ///
  /// The returned [DiscussionPost] will have its `id` field set.
  Future<DiscussionPost> insertRow(
    _i1.DatabaseSession session,
    DiscussionPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscussionPost>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DiscussionPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DiscussionPost>> update(
    _i1.DatabaseSession session,
    List<DiscussionPost> rows, {
    _i1.ColumnSelections<DiscussionPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DiscussionPost>(
      rows,
      columns: columns?.call(DiscussionPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscussionPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscussionPost> updateRow(
    _i1.DatabaseSession session,
    DiscussionPost row, {
    _i1.ColumnSelections<DiscussionPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscussionPost>(
      row,
      columns: columns?.call(DiscussionPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscussionPost] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscussionPost?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DiscussionPostUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscussionPost>(
      id,
      columnValues: columnValues(DiscussionPost.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscussionPost]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DiscussionPost>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DiscussionPostUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DiscussionPostTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscussionPostTable>? orderBy,
    _i1.OrderByListBuilder<DiscussionPostTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DiscussionPost>(
      columnValues: columnValues(DiscussionPost.t.updateTable),
      where: where(DiscussionPost.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscussionPost.t),
      orderByList: orderByList?.call(DiscussionPost.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DiscussionPost]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DiscussionPost>> delete(
    _i1.DatabaseSession session,
    List<DiscussionPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DiscussionPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DiscussionPost].
  Future<DiscussionPost> deleteRow(
    _i1.DatabaseSession session,
    DiscussionPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscussionPost>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DiscussionPost>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscussionPostTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DiscussionPost>(
      where: where(DiscussionPost.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscussionPostTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DiscussionPost>(
      where: where?.call(DiscussionPost.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscussionPost] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscussionPostTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscussionPost>(
      where: where(DiscussionPost.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
