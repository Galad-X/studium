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

abstract class DiscussionReaction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DiscussionReaction._({
    this.id,
    required this.postId,
    required this.userId,
    required this.reaction,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DiscussionReaction({
    int? id,
    required int postId,
    required int userId,
    required String reaction,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DiscussionReactionImpl;

  factory DiscussionReaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscussionReaction(
      id: jsonSerialization['id'] as int?,
      postId: jsonSerialization['postId'] as int,
      userId: jsonSerialization['userId'] as int,
      reaction: jsonSerialization['reaction'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = DiscussionReactionTable();

  static const db = DiscussionReactionRepository._();

  @override
  int? id;

  int postId;

  int userId;

  String reaction;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscussionReaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscussionReaction copyWith({
    int? id,
    int? postId,
    int? userId,
    String? reaction,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscussionReaction',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      'reaction': reaction,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscussionReaction',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      'reaction': reaction,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DiscussionReactionInclude include() {
    return DiscussionReactionInclude._();
  }

  static DiscussionReactionIncludeList includeList({
    _i1.WhereExpressionBuilder<DiscussionReactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscussionReactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscussionReactionTable>? orderByList,
    DiscussionReactionInclude? include,
  }) {
    return DiscussionReactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscussionReaction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DiscussionReaction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscussionReactionImpl extends DiscussionReaction {
  _DiscussionReactionImpl({
    int? id,
    required int postId,
    required int userId,
    required String reaction,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         postId: postId,
         userId: userId,
         reaction: reaction,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DiscussionReaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscussionReaction copyWith({
    Object? id = _Undefined,
    int? postId,
    int? userId,
    String? reaction,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DiscussionReaction(
      id: id is int? ? id : this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      reaction: reaction ?? this.reaction,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DiscussionReactionUpdateTable
    extends _i1.UpdateTable<DiscussionReactionTable> {
  DiscussionReactionUpdateTable(super.table);

  _i1.ColumnValue<int, int> postId(int value) => _i1.ColumnValue(
    table.postId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> reaction(String value) => _i1.ColumnValue(
    table.reaction,
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

class DiscussionReactionTable extends _i1.Table<int?> {
  DiscussionReactionTable({super.tableRelation})
    : super(tableName: 'discussion_reactions') {
    updateTable = DiscussionReactionUpdateTable(this);
    postId = _i1.ColumnInt(
      'postId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    reaction = _i1.ColumnString(
      'reaction',
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

  late final DiscussionReactionUpdateTable updateTable;

  late final _i1.ColumnInt postId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString reaction;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    postId,
    userId,
    reaction,
    createdAt,
    updatedAt,
  ];
}

class DiscussionReactionInclude extends _i1.IncludeObject {
  DiscussionReactionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DiscussionReaction.t;
}

class DiscussionReactionIncludeList extends _i1.IncludeList {
  DiscussionReactionIncludeList._({
    _i1.WhereExpressionBuilder<DiscussionReactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscussionReaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DiscussionReaction.t;
}

class DiscussionReactionRepository {
  const DiscussionReactionRepository._();

  /// Returns a list of [DiscussionReaction]s matching the given query parameters.
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
  Future<List<DiscussionReaction>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscussionReactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscussionReactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscussionReactionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscussionReaction>(
      where: where?.call(DiscussionReaction.t),
      orderBy: orderBy?.call(DiscussionReaction.t),
      orderByList: orderByList?.call(DiscussionReaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscussionReaction] matching the given query parameters.
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
  Future<DiscussionReaction?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscussionReactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<DiscussionReactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscussionReactionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscussionReaction>(
      where: where?.call(DiscussionReaction.t),
      orderBy: orderBy?.call(DiscussionReaction.t),
      orderByList: orderByList?.call(DiscussionReaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscussionReaction] by its [id] or null if no such row exists.
  Future<DiscussionReaction?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscussionReaction>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscussionReaction]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscussionReaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DiscussionReaction>> insert(
    _i1.DatabaseSession session,
    List<DiscussionReaction> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DiscussionReaction>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DiscussionReaction] and returns the inserted row.
  ///
  /// The returned [DiscussionReaction] will have its `id` field set.
  Future<DiscussionReaction> insertRow(
    _i1.DatabaseSession session,
    DiscussionReaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscussionReaction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DiscussionReaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DiscussionReaction>> update(
    _i1.DatabaseSession session,
    List<DiscussionReaction> rows, {
    _i1.ColumnSelections<DiscussionReactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DiscussionReaction>(
      rows,
      columns: columns?.call(DiscussionReaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscussionReaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscussionReaction> updateRow(
    _i1.DatabaseSession session,
    DiscussionReaction row, {
    _i1.ColumnSelections<DiscussionReactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscussionReaction>(
      row,
      columns: columns?.call(DiscussionReaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscussionReaction] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscussionReaction?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DiscussionReactionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscussionReaction>(
      id,
      columnValues: columnValues(DiscussionReaction.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscussionReaction]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DiscussionReaction>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DiscussionReactionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DiscussionReactionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscussionReactionTable>? orderBy,
    _i1.OrderByListBuilder<DiscussionReactionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DiscussionReaction>(
      columnValues: columnValues(DiscussionReaction.t.updateTable),
      where: where(DiscussionReaction.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscussionReaction.t),
      orderByList: orderByList?.call(DiscussionReaction.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DiscussionReaction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DiscussionReaction>> delete(
    _i1.DatabaseSession session,
    List<DiscussionReaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DiscussionReaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DiscussionReaction].
  Future<DiscussionReaction> deleteRow(
    _i1.DatabaseSession session,
    DiscussionReaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscussionReaction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DiscussionReaction>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscussionReactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DiscussionReaction>(
      where: where(DiscussionReaction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscussionReactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DiscussionReaction>(
      where: where?.call(DiscussionReaction.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscussionReaction] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscussionReactionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscussionReaction>(
      where: where(DiscussionReaction.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
