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

abstract class ChallengeTeam
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ChallengeTeam._({
    this.id,
    required this.challengeId,
    required this.ownerId,
    required this.name,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChallengeTeam({
    int? id,
    required int challengeId,
    required int ownerId,
    required String name,
    String? description,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChallengeTeamImpl;

  factory ChallengeTeam.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeTeam(
      id: jsonSerialization['id'] as int?,
      challengeId: jsonSerialization['challengeId'] as int,
      ownerId: jsonSerialization['ownerId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ChallengeTeamTable();

  static const db = ChallengeTeamRepository._();

  @override
  int? id;

  int challengeId;

  int ownerId;

  String name;

  String? description;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChallengeTeam]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChallengeTeam copyWith({
    int? id,
    int? challengeId,
    int? ownerId,
    String? name,
    String? description,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeTeam',
      if (id != null) 'id': id,
      'challengeId': challengeId,
      'ownerId': ownerId,
      'name': name,
      if (description != null) 'description': description,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChallengeTeam',
      if (id != null) 'id': id,
      'challengeId': challengeId,
      'ownerId': ownerId,
      'name': name,
      if (description != null) 'description': description,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChallengeTeamInclude include() {
    return ChallengeTeamInclude._();
  }

  static ChallengeTeamIncludeList includeList({
    _i1.WhereExpressionBuilder<ChallengeTeamTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTeamTable>? orderByList,
    ChallengeTeamInclude? include,
  }) {
    return ChallengeTeamIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeTeam.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChallengeTeam.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeTeamImpl extends ChallengeTeam {
  _ChallengeTeamImpl({
    int? id,
    required int challengeId,
    required int ownerId,
    required String name,
    String? description,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         challengeId: challengeId,
         ownerId: ownerId,
         name: name,
         description: description,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ChallengeTeam]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChallengeTeam copyWith({
    Object? id = _Undefined,
    int? challengeId,
    int? ownerId,
    String? name,
    Object? description = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChallengeTeam(
      id: id is int? ? id : this.id,
      challengeId: challengeId ?? this.challengeId,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChallengeTeamUpdateTable extends _i1.UpdateTable<ChallengeTeamTable> {
  ChallengeTeamUpdateTable(super.table);

  _i1.ColumnValue<int, int> challengeId(int value) => _i1.ColumnValue(
    table.challengeId,
    value,
  );

  _i1.ColumnValue<int, int> ownerId(int value) => _i1.ColumnValue(
    table.ownerId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
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

class ChallengeTeamTable extends _i1.Table<int?> {
  ChallengeTeamTable({super.tableRelation})
    : super(tableName: 'challenge_teams') {
    updateTable = ChallengeTeamUpdateTable(this);
    challengeId = _i1.ColumnInt(
      'challengeId',
      this,
    );
    ownerId = _i1.ColumnInt(
      'ownerId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
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

  late final ChallengeTeamUpdateTable updateTable;

  late final _i1.ColumnInt challengeId;

  late final _i1.ColumnInt ownerId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    challengeId,
    ownerId,
    name,
    description,
    status,
    createdAt,
    updatedAt,
  ];
}

class ChallengeTeamInclude extends _i1.IncludeObject {
  ChallengeTeamInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ChallengeTeam.t;
}

class ChallengeTeamIncludeList extends _i1.IncludeList {
  ChallengeTeamIncludeList._({
    _i1.WhereExpressionBuilder<ChallengeTeamTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChallengeTeam.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChallengeTeam.t;
}

class ChallengeTeamRepository {
  const ChallengeTeamRepository._();

  /// Returns a list of [ChallengeTeam]s matching the given query parameters.
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
  Future<List<ChallengeTeam>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTeamTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTeamTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChallengeTeam>(
      where: where?.call(ChallengeTeam.t),
      orderBy: orderBy?.call(ChallengeTeam.t),
      orderByList: orderByList?.call(ChallengeTeam.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChallengeTeam] matching the given query parameters.
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
  Future<ChallengeTeam?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTeamTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTeamTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChallengeTeam>(
      where: where?.call(ChallengeTeam.t),
      orderBy: orderBy?.call(ChallengeTeam.t),
      orderByList: orderByList?.call(ChallengeTeam.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChallengeTeam] by its [id] or null if no such row exists.
  Future<ChallengeTeam?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChallengeTeam>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChallengeTeam]s in the list and returns the inserted rows.
  ///
  /// The returned [ChallengeTeam]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ChallengeTeam>> insert(
    _i1.DatabaseSession session,
    List<ChallengeTeam> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ChallengeTeam>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ChallengeTeam] and returns the inserted row.
  ///
  /// The returned [ChallengeTeam] will have its `id` field set.
  Future<ChallengeTeam> insertRow(
    _i1.DatabaseSession session,
    ChallengeTeam row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChallengeTeam>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeTeam]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChallengeTeam>> update(
    _i1.DatabaseSession session,
    List<ChallengeTeam> rows, {
    _i1.ColumnSelections<ChallengeTeamTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChallengeTeam>(
      rows,
      columns: columns?.call(ChallengeTeam.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeTeam]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChallengeTeam> updateRow(
    _i1.DatabaseSession session,
    ChallengeTeam row, {
    _i1.ColumnSelections<ChallengeTeamTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChallengeTeam>(
      row,
      columns: columns?.call(ChallengeTeam.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeTeam] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChallengeTeam?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ChallengeTeamUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ChallengeTeam>(
      id,
      columnValues: columnValues(ChallengeTeam.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeTeam]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ChallengeTeam>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ChallengeTeamUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ChallengeTeamTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTeamTable>? orderBy,
    _i1.OrderByListBuilder<ChallengeTeamTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ChallengeTeam>(
      columnValues: columnValues(ChallengeTeam.t.updateTable),
      where: where(ChallengeTeam.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeTeam.t),
      orderByList: orderByList?.call(ChallengeTeam.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ChallengeTeam]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChallengeTeam>> delete(
    _i1.DatabaseSession session,
    List<ChallengeTeam> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChallengeTeam>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChallengeTeam].
  Future<ChallengeTeam> deleteRow(
    _i1.DatabaseSession session,
    ChallengeTeam row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChallengeTeam>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChallengeTeam>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeTeamTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChallengeTeam>(
      where: where(ChallengeTeam.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTeamTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChallengeTeam>(
      where: where?.call(ChallengeTeam.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChallengeTeam] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeTeamTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChallengeTeam>(
      where: where(ChallengeTeam.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
