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

abstract class ConversationMember
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ConversationMember._({
    this.id,
    required this.conversationId,
    required this.userId,
    required this.role,
    required this.status,
    required this.joinedAt,
  });

  factory ConversationMember({
    int? id,
    required int conversationId,
    required int userId,
    required String role,
    required String status,
    required DateTime joinedAt,
  }) = _ConversationMemberImpl;

  factory ConversationMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConversationMember(
      id: jsonSerialization['id'] as int?,
      conversationId: jsonSerialization['conversationId'] as int,
      userId: jsonSerialization['userId'] as int,
      role: jsonSerialization['role'] as String,
      status: jsonSerialization['status'] as String,
      joinedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  static final t = ConversationMemberTable();

  static const db = ConversationMemberRepository._();

  @override
  int? id;

  int conversationId;

  int userId;

  String role;

  String status;

  DateTime joinedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ConversationMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ConversationMember copyWith({
    int? id,
    int? conversationId,
    int? userId,
    String? role,
    String? status,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConversationMember',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'userId': userId,
      'role': role,
      'status': status,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConversationMember',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'userId': userId,
      'role': role,
      'status': status,
      'joinedAt': joinedAt.toJson(),
    };
  }

  static ConversationMemberInclude include() {
    return ConversationMemberInclude._();
  }

  static ConversationMemberIncludeList includeList({
    _i1.WhereExpressionBuilder<ConversationMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConversationMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConversationMemberTable>? orderByList,
    ConversationMemberInclude? include,
  }) {
    return ConversationMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConversationMember.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ConversationMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConversationMemberImpl extends ConversationMember {
  _ConversationMemberImpl({
    int? id,
    required int conversationId,
    required int userId,
    required String role,
    required String status,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         conversationId: conversationId,
         userId: userId,
         role: role,
         status: status,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [ConversationMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ConversationMember copyWith({
    Object? id = _Undefined,
    int? conversationId,
    int? userId,
    String? role,
    String? status,
    DateTime? joinedAt,
  }) {
    return ConversationMember(
      id: id is int? ? id : this.id,
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class ConversationMemberUpdateTable
    extends _i1.UpdateTable<ConversationMemberTable> {
  ConversationMemberUpdateTable(super.table);

  _i1.ColumnValue<int, int> conversationId(int value) => _i1.ColumnValue(
    table.conversationId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> role(String value) => _i1.ColumnValue(
    table.role,
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

class ConversationMemberTable extends _i1.Table<int?> {
  ConversationMemberTable({super.tableRelation})
    : super(tableName: 'conversation_members') {
    updateTable = ConversationMemberUpdateTable(this);
    conversationId = _i1.ColumnInt(
      'conversationId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    role = _i1.ColumnString(
      'role',
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

  late final ConversationMemberUpdateTable updateTable;

  late final _i1.ColumnInt conversationId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString role;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime joinedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    conversationId,
    userId,
    role,
    status,
    joinedAt,
  ];
}

class ConversationMemberInclude extends _i1.IncludeObject {
  ConversationMemberInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ConversationMember.t;
}

class ConversationMemberIncludeList extends _i1.IncludeList {
  ConversationMemberIncludeList._({
    _i1.WhereExpressionBuilder<ConversationMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ConversationMember.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ConversationMember.t;
}

class ConversationMemberRepository {
  const ConversationMemberRepository._();

  /// Returns a list of [ConversationMember]s matching the given query parameters.
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
  Future<List<ConversationMember>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConversationMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConversationMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConversationMemberTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ConversationMember>(
      where: where?.call(ConversationMember.t),
      orderBy: orderBy?.call(ConversationMember.t),
      orderByList: orderByList?.call(ConversationMember.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ConversationMember] matching the given query parameters.
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
  Future<ConversationMember?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConversationMemberTable>? where,
    int? offset,
    _i1.OrderByBuilder<ConversationMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ConversationMemberTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ConversationMember>(
      where: where?.call(ConversationMember.t),
      orderBy: orderBy?.call(ConversationMember.t),
      orderByList: orderByList?.call(ConversationMember.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ConversationMember] by its [id] or null if no such row exists.
  Future<ConversationMember?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ConversationMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ConversationMember]s in the list and returns the inserted rows.
  ///
  /// The returned [ConversationMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ConversationMember>> insert(
    _i1.DatabaseSession session,
    List<ConversationMember> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ConversationMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ConversationMember] and returns the inserted row.
  ///
  /// The returned [ConversationMember] will have its `id` field set.
  Future<ConversationMember> insertRow(
    _i1.DatabaseSession session,
    ConversationMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ConversationMember>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ConversationMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ConversationMember>> update(
    _i1.DatabaseSession session,
    List<ConversationMember> rows, {
    _i1.ColumnSelections<ConversationMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ConversationMember>(
      rows,
      columns: columns?.call(ConversationMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ConversationMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ConversationMember> updateRow(
    _i1.DatabaseSession session,
    ConversationMember row, {
    _i1.ColumnSelections<ConversationMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ConversationMember>(
      row,
      columns: columns?.call(ConversationMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ConversationMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ConversationMember?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ConversationMemberUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ConversationMember>(
      id,
      columnValues: columnValues(ConversationMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ConversationMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ConversationMember>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ConversationMemberUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ConversationMemberTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ConversationMemberTable>? orderBy,
    _i1.OrderByListBuilder<ConversationMemberTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ConversationMember>(
      columnValues: columnValues(ConversationMember.t.updateTable),
      where: where(ConversationMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConversationMember.t),
      orderByList: orderByList?.call(ConversationMember.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ConversationMember]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ConversationMember>> delete(
    _i1.DatabaseSession session,
    List<ConversationMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ConversationMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ConversationMember].
  Future<ConversationMember> deleteRow(
    _i1.DatabaseSession session,
    ConversationMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ConversationMember>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ConversationMember>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ConversationMemberTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ConversationMember>(
      where: where(ConversationMember.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ConversationMemberTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ConversationMember>(
      where: where?.call(ConversationMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ConversationMember] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ConversationMemberTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ConversationMember>(
      where: where(ConversationMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
