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

abstract class ChallengeTeamMember
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ChallengeTeamMember._({
    this.id,
    required this.teamId,
    required this.userId,
    required this.role,
    required this.status,
    required this.joinedAt,
  });

  factory ChallengeTeamMember({
    int? id,
    required int teamId,
    required int userId,
    required String role,
    required String status,
    required DateTime joinedAt,
  }) = _ChallengeTeamMemberImpl;

  factory ChallengeTeamMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeTeamMember(
      id: jsonSerialization['id'] as int?,
      teamId: jsonSerialization['teamId'] as int,
      userId: jsonSerialization['userId'] as int,
      role: jsonSerialization['role'] as String,
      status: jsonSerialization['status'] as String,
      joinedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  static final t = ChallengeTeamMemberTable();

  static const db = ChallengeTeamMemberRepository._();

  @override
  int? id;

  int teamId;

  int userId;

  String role;

  String status;

  DateTime joinedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChallengeTeamMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChallengeTeamMember copyWith({
    int? id,
    int? teamId,
    int? userId,
    String? role,
    String? status,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeTeamMember',
      if (id != null) 'id': id,
      'teamId': teamId,
      'userId': userId,
      'role': role,
      'status': status,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChallengeTeamMember',
      if (id != null) 'id': id,
      'teamId': teamId,
      'userId': userId,
      'role': role,
      'status': status,
      'joinedAt': joinedAt.toJson(),
    };
  }

  static ChallengeTeamMemberInclude include() {
    return ChallengeTeamMemberInclude._();
  }

  static ChallengeTeamMemberIncludeList includeList({
    _i1.WhereExpressionBuilder<ChallengeTeamMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTeamMemberTable>? orderByList,
    ChallengeTeamMemberInclude? include,
  }) {
    return ChallengeTeamMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeTeamMember.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChallengeTeamMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeTeamMemberImpl extends ChallengeTeamMember {
  _ChallengeTeamMemberImpl({
    int? id,
    required int teamId,
    required int userId,
    required String role,
    required String status,
    required DateTime joinedAt,
  }) : super._(
          id: id,
          teamId: teamId,
          userId: userId,
          role: role,
          status: status,
          joinedAt: joinedAt,
        );

  /// Returns a shallow copy of this [ChallengeTeamMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChallengeTeamMember copyWith({
    Object? id = _Undefined,
    int? teamId,
    int? userId,
    String? role,
    String? status,
    DateTime? joinedAt,
  }) {
    return ChallengeTeamMember(
      id: id is int? ? id : this.id,
      teamId: teamId ?? this.teamId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class ChallengeTeamMemberUpdateTable
    extends _i1.UpdateTable<ChallengeTeamMemberTable> {
  ChallengeTeamMemberUpdateTable(super.table);

  _i1.ColumnValue<int, int> teamId(int value) => _i1.ColumnValue(
        table.teamId,
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

class ChallengeTeamMemberTable extends _i1.Table<int?> {
  ChallengeTeamMemberTable({super.tableRelation})
      : super(tableName: 'challenge_team_members') {
    updateTable = ChallengeTeamMemberUpdateTable(this);
    teamId = _i1.ColumnInt(
      'teamId',
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

  late final ChallengeTeamMemberUpdateTable updateTable;

  late final _i1.ColumnInt teamId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString role;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime joinedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        teamId,
        userId,
        role,
        status,
        joinedAt,
      ];
}

class ChallengeTeamMemberInclude extends _i1.IncludeObject {
  ChallengeTeamMemberInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ChallengeTeamMember.t;
}

class ChallengeTeamMemberIncludeList extends _i1.IncludeList {
  ChallengeTeamMemberIncludeList._({
    _i1.WhereExpressionBuilder<ChallengeTeamMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChallengeTeamMember.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChallengeTeamMember.t;
}

class ChallengeTeamMemberRepository {
  const ChallengeTeamMemberRepository._();

  /// Returns a list of [ChallengeTeamMember]s matching the given query parameters.
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
  Future<List<ChallengeTeamMember>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTeamMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTeamMemberTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChallengeTeamMember>(
      where: where?.call(ChallengeTeamMember.t),
      orderBy: orderBy?.call(ChallengeTeamMember.t),
      orderByList: orderByList?.call(ChallengeTeamMember.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChallengeTeamMember] matching the given query parameters.
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
  Future<ChallengeTeamMember?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTeamMemberTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTeamMemberTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChallengeTeamMember>(
      where: where?.call(ChallengeTeamMember.t),
      orderBy: orderBy?.call(ChallengeTeamMember.t),
      orderByList: orderByList?.call(ChallengeTeamMember.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChallengeTeamMember] by its [id] or null if no such row exists.
  Future<ChallengeTeamMember?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChallengeTeamMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChallengeTeamMember]s in the list and returns the inserted rows.
  ///
  /// The returned [ChallengeTeamMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ChallengeTeamMember>> insert(
    _i1.DatabaseSession session,
    List<ChallengeTeamMember> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ChallengeTeamMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ChallengeTeamMember] and returns the inserted row.
  ///
  /// The returned [ChallengeTeamMember] will have its `id` field set.
  Future<ChallengeTeamMember> insertRow(
    _i1.DatabaseSession session,
    ChallengeTeamMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChallengeTeamMember>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeTeamMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChallengeTeamMember>> update(
    _i1.DatabaseSession session,
    List<ChallengeTeamMember> rows, {
    _i1.ColumnSelections<ChallengeTeamMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChallengeTeamMember>(
      rows,
      columns: columns?.call(ChallengeTeamMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeTeamMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChallengeTeamMember> updateRow(
    _i1.DatabaseSession session,
    ChallengeTeamMember row, {
    _i1.ColumnSelections<ChallengeTeamMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChallengeTeamMember>(
      row,
      columns: columns?.call(ChallengeTeamMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeTeamMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChallengeTeamMember?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ChallengeTeamMemberUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ChallengeTeamMember>(
      id,
      columnValues: columnValues(ChallengeTeamMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeTeamMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ChallengeTeamMember>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ChallengeTeamMemberUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<ChallengeTeamMemberTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamMemberTable>? orderBy,
    _i1.OrderByListBuilder<ChallengeTeamMemberTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ChallengeTeamMember>(
      columnValues: columnValues(ChallengeTeamMember.t.updateTable),
      where: where(ChallengeTeamMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeTeamMember.t),
      orderByList: orderByList?.call(ChallengeTeamMember.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ChallengeTeamMember]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChallengeTeamMember>> delete(
    _i1.DatabaseSession session,
    List<ChallengeTeamMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChallengeTeamMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChallengeTeamMember].
  Future<ChallengeTeamMember> deleteRow(
    _i1.DatabaseSession session,
    ChallengeTeamMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChallengeTeamMember>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChallengeTeamMember>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeTeamMemberTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChallengeTeamMember>(
      where: where(ChallengeTeamMember.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTeamMemberTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChallengeTeamMember>(
      where: where?.call(ChallengeTeamMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChallengeTeamMember] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeTeamMemberTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChallengeTeamMember>(
      where: where(ChallengeTeamMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
