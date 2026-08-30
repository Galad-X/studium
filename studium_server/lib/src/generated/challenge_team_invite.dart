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

abstract class ChallengeTeamInvite
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ChallengeTeamInvite._({
    this.id,
    required this.teamId,
    required this.inviterId,
    required this.inviteeId,
    required this.tokenHash,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
    this.acceptedAt,
  });

  factory ChallengeTeamInvite({
    int? id,
    required int teamId,
    required int inviterId,
    required int inviteeId,
    required String tokenHash,
    required String status,
    required DateTime expiresAt,
    required DateTime createdAt,
    DateTime? acceptedAt,
  }) = _ChallengeTeamInviteImpl;

  factory ChallengeTeamInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeTeamInvite(
      id: jsonSerialization['id'] as int?,
      teamId: jsonSerialization['teamId'] as int,
      inviterId: jsonSerialization['inviterId'] as int,
      inviteeId: jsonSerialization['inviteeId'] as int,
      tokenHash: jsonSerialization['tokenHash'] as String,
      status: jsonSerialization['status'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
    );
  }

  static final t = ChallengeTeamInviteTable();

  static const db = ChallengeTeamInviteRepository._();

  @override
  int? id;

  int teamId;

  int inviterId;

  int inviteeId;

  String tokenHash;

  String status;

  DateTime expiresAt;

  DateTime createdAt;

  DateTime? acceptedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChallengeTeamInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChallengeTeamInvite copyWith({
    int? id,
    int? teamId,
    int? inviterId,
    int? inviteeId,
    String? tokenHash,
    String? status,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? acceptedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeTeamInvite',
      if (id != null) 'id': id,
      'teamId': teamId,
      'inviterId': inviterId,
      'inviteeId': inviteeId,
      'tokenHash': tokenHash,
      'status': status,
      'expiresAt': expiresAt.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChallengeTeamInvite',
      if (id != null) 'id': id,
      'teamId': teamId,
      'inviterId': inviterId,
      'inviteeId': inviteeId,
      'tokenHash': tokenHash,
      'status': status,
      'expiresAt': expiresAt.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
    };
  }

  static ChallengeTeamInviteInclude include() {
    return ChallengeTeamInviteInclude._();
  }

  static ChallengeTeamInviteIncludeList includeList({
    _i1.WhereExpressionBuilder<ChallengeTeamInviteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTeamInviteTable>? orderByList,
    ChallengeTeamInviteInclude? include,
  }) {
    return ChallengeTeamInviteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeTeamInvite.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChallengeTeamInvite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeTeamInviteImpl extends ChallengeTeamInvite {
  _ChallengeTeamInviteImpl({
    int? id,
    required int teamId,
    required int inviterId,
    required int inviteeId,
    required String tokenHash,
    required String status,
    required DateTime expiresAt,
    required DateTime createdAt,
    DateTime? acceptedAt,
  }) : super._(
         id: id,
         teamId: teamId,
         inviterId: inviterId,
         inviteeId: inviteeId,
         tokenHash: tokenHash,
         status: status,
         expiresAt: expiresAt,
         createdAt: createdAt,
         acceptedAt: acceptedAt,
       );

  /// Returns a shallow copy of this [ChallengeTeamInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChallengeTeamInvite copyWith({
    Object? id = _Undefined,
    int? teamId,
    int? inviterId,
    int? inviteeId,
    String? tokenHash,
    String? status,
    DateTime? expiresAt,
    DateTime? createdAt,
    Object? acceptedAt = _Undefined,
  }) {
    return ChallengeTeamInvite(
      id: id is int? ? id : this.id,
      teamId: teamId ?? this.teamId,
      inviterId: inviterId ?? this.inviterId,
      inviteeId: inviteeId ?? this.inviteeId,
      tokenHash: tokenHash ?? this.tokenHash,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
    );
  }
}

class ChallengeTeamInviteUpdateTable
    extends _i1.UpdateTable<ChallengeTeamInviteTable> {
  ChallengeTeamInviteUpdateTable(super.table);

  _i1.ColumnValue<int, int> teamId(int value) => _i1.ColumnValue(
    table.teamId,
    value,
  );

  _i1.ColumnValue<int, int> inviterId(int value) => _i1.ColumnValue(
    table.inviterId,
    value,
  );

  _i1.ColumnValue<int, int> inviteeId(int value) => _i1.ColumnValue(
    table.inviteeId,
    value,
  );

  _i1.ColumnValue<String, String> tokenHash(String value) => _i1.ColumnValue(
    table.tokenHash,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> acceptedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.acceptedAt,
        value,
      );
}

class ChallengeTeamInviteTable extends _i1.Table<int?> {
  ChallengeTeamInviteTable({super.tableRelation})
    : super(tableName: 'challenge_team_invites') {
    updateTable = ChallengeTeamInviteUpdateTable(this);
    teamId = _i1.ColumnInt(
      'teamId',
      this,
    );
    inviterId = _i1.ColumnInt(
      'inviterId',
      this,
    );
    inviteeId = _i1.ColumnInt(
      'inviteeId',
      this,
    );
    tokenHash = _i1.ColumnString(
      'tokenHash',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    acceptedAt = _i1.ColumnDateTime(
      'acceptedAt',
      this,
    );
  }

  late final ChallengeTeamInviteUpdateTable updateTable;

  late final _i1.ColumnInt teamId;

  late final _i1.ColumnInt inviterId;

  late final _i1.ColumnInt inviteeId;

  late final _i1.ColumnString tokenHash;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime acceptedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    teamId,
    inviterId,
    inviteeId,
    tokenHash,
    status,
    expiresAt,
    createdAt,
    acceptedAt,
  ];
}

class ChallengeTeamInviteInclude extends _i1.IncludeObject {
  ChallengeTeamInviteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ChallengeTeamInvite.t;
}

class ChallengeTeamInviteIncludeList extends _i1.IncludeList {
  ChallengeTeamInviteIncludeList._({
    _i1.WhereExpressionBuilder<ChallengeTeamInviteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChallengeTeamInvite.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChallengeTeamInvite.t;
}

class ChallengeTeamInviteRepository {
  const ChallengeTeamInviteRepository._();

  /// Returns a list of [ChallengeTeamInvite]s matching the given query parameters.
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
  Future<List<ChallengeTeamInvite>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTeamInviteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTeamInviteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChallengeTeamInvite>(
      where: where?.call(ChallengeTeamInvite.t),
      orderBy: orderBy?.call(ChallengeTeamInvite.t),
      orderByList: orderByList?.call(ChallengeTeamInvite.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChallengeTeamInvite] matching the given query parameters.
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
  Future<ChallengeTeamInvite?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTeamInviteTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTeamInviteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChallengeTeamInvite>(
      where: where?.call(ChallengeTeamInvite.t),
      orderBy: orderBy?.call(ChallengeTeamInvite.t),
      orderByList: orderByList?.call(ChallengeTeamInvite.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChallengeTeamInvite] by its [id] or null if no such row exists.
  Future<ChallengeTeamInvite?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChallengeTeamInvite>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChallengeTeamInvite]s in the list and returns the inserted rows.
  ///
  /// The returned [ChallengeTeamInvite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ChallengeTeamInvite>> insert(
    _i1.DatabaseSession session,
    List<ChallengeTeamInvite> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ChallengeTeamInvite>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ChallengeTeamInvite] and returns the inserted row.
  ///
  /// The returned [ChallengeTeamInvite] will have its `id` field set.
  Future<ChallengeTeamInvite> insertRow(
    _i1.DatabaseSession session,
    ChallengeTeamInvite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChallengeTeamInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeTeamInvite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChallengeTeamInvite>> update(
    _i1.DatabaseSession session,
    List<ChallengeTeamInvite> rows, {
    _i1.ColumnSelections<ChallengeTeamInviteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChallengeTeamInvite>(
      rows,
      columns: columns?.call(ChallengeTeamInvite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeTeamInvite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChallengeTeamInvite> updateRow(
    _i1.DatabaseSession session,
    ChallengeTeamInvite row, {
    _i1.ColumnSelections<ChallengeTeamInviteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChallengeTeamInvite>(
      row,
      columns: columns?.call(ChallengeTeamInvite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeTeamInvite] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChallengeTeamInvite?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ChallengeTeamInviteUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ChallengeTeamInvite>(
      id,
      columnValues: columnValues(ChallengeTeamInvite.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeTeamInvite]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ChallengeTeamInvite>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ChallengeTeamInviteUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ChallengeTeamInviteTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamInviteTable>? orderBy,
    _i1.OrderByListBuilder<ChallengeTeamInviteTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ChallengeTeamInvite>(
      columnValues: columnValues(ChallengeTeamInvite.t.updateTable),
      where: where(ChallengeTeamInvite.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeTeamInvite.t),
      orderByList: orderByList?.call(ChallengeTeamInvite.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ChallengeTeamInvite]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChallengeTeamInvite>> delete(
    _i1.DatabaseSession session,
    List<ChallengeTeamInvite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChallengeTeamInvite>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChallengeTeamInvite].
  Future<ChallengeTeamInvite> deleteRow(
    _i1.DatabaseSession session,
    ChallengeTeamInvite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChallengeTeamInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChallengeTeamInvite>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeTeamInviteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChallengeTeamInvite>(
      where: where(ChallengeTeamInvite.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTeamInviteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChallengeTeamInvite>(
      where: where?.call(ChallengeTeamInvite.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChallengeTeamInvite] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeTeamInviteTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChallengeTeamInvite>(
      where: where(ChallengeTeamInvite.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
