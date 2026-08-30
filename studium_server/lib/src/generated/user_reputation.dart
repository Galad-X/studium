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

abstract class UserReputation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserReputation._({
    this.id,
    required this.userId,
    int? score,
    int? acceptedSolutions,
    int? verifiedContributions,
    required this.updatedAt,
  })  : score = score ?? 0,
        acceptedSolutions = acceptedSolutions ?? 0,
        verifiedContributions = verifiedContributions ?? 0;

  factory UserReputation({
    int? id,
    required int userId,
    int? score,
    int? acceptedSolutions,
    int? verifiedContributions,
    required DateTime updatedAt,
  }) = _UserReputationImpl;

  factory UserReputation.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserReputation(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      score: jsonSerialization['score'] as int?,
      acceptedSolutions: jsonSerialization['acceptedSolutions'] as int?,
      verifiedContributions: jsonSerialization['verifiedContributions'] as int?,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = UserReputationTable();

  static const db = UserReputationRepository._();

  @override
  int? id;

  int userId;

  int score;

  int acceptedSolutions;

  int verifiedContributions;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserReputation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserReputation copyWith({
    int? id,
    int? userId,
    int? score,
    int? acceptedSolutions,
    int? verifiedContributions,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserReputation',
      if (id != null) 'id': id,
      'userId': userId,
      'score': score,
      'acceptedSolutions': acceptedSolutions,
      'verifiedContributions': verifiedContributions,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserReputation',
      if (id != null) 'id': id,
      'userId': userId,
      'score': score,
      'acceptedSolutions': acceptedSolutions,
      'verifiedContributions': verifiedContributions,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserReputationInclude include() {
    return UserReputationInclude._();
  }

  static UserReputationIncludeList includeList({
    _i1.WhereExpressionBuilder<UserReputationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserReputationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserReputationTable>? orderByList,
    UserReputationInclude? include,
  }) {
    return UserReputationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserReputation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserReputation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserReputationImpl extends UserReputation {
  _UserReputationImpl({
    int? id,
    required int userId,
    int? score,
    int? acceptedSolutions,
    int? verifiedContributions,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          score: score,
          acceptedSolutions: acceptedSolutions,
          verifiedContributions: verifiedContributions,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [UserReputation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserReputation copyWith({
    Object? id = _Undefined,
    int? userId,
    int? score,
    int? acceptedSolutions,
    int? verifiedContributions,
    DateTime? updatedAt,
  }) {
    return UserReputation(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      score: score ?? this.score,
      acceptedSolutions: acceptedSolutions ?? this.acceptedSolutions,
      verifiedContributions:
          verifiedContributions ?? this.verifiedContributions,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserReputationUpdateTable extends _i1.UpdateTable<UserReputationTable> {
  UserReputationUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<int, int> score(int value) => _i1.ColumnValue(
        table.score,
        value,
      );

  _i1.ColumnValue<int, int> acceptedSolutions(int value) => _i1.ColumnValue(
        table.acceptedSolutions,
        value,
      );

  _i1.ColumnValue<int, int> verifiedContributions(int value) => _i1.ColumnValue(
        table.verifiedContributions,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class UserReputationTable extends _i1.Table<int?> {
  UserReputationTable({super.tableRelation})
      : super(tableName: 'user_reputation') {
    updateTable = UserReputationUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    score = _i1.ColumnInt(
      'score',
      this,
      hasDefault: true,
    );
    acceptedSolutions = _i1.ColumnInt(
      'acceptedSolutions',
      this,
      hasDefault: true,
    );
    verifiedContributions = _i1.ColumnInt(
      'verifiedContributions',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final UserReputationUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt score;

  late final _i1.ColumnInt acceptedSolutions;

  late final _i1.ColumnInt verifiedContributions;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        score,
        acceptedSolutions,
        verifiedContributions,
        updatedAt,
      ];
}

class UserReputationInclude extends _i1.IncludeObject {
  UserReputationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserReputation.t;
}

class UserReputationIncludeList extends _i1.IncludeList {
  UserReputationIncludeList._({
    _i1.WhereExpressionBuilder<UserReputationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserReputation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserReputation.t;
}

class UserReputationRepository {
  const UserReputationRepository._();

  /// Returns a list of [UserReputation]s matching the given query parameters.
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
  Future<List<UserReputation>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserReputationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserReputationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserReputationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserReputation>(
      where: where?.call(UserReputation.t),
      orderBy: orderBy?.call(UserReputation.t),
      orderByList: orderByList?.call(UserReputation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserReputation] matching the given query parameters.
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
  Future<UserReputation?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserReputationTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserReputationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserReputationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserReputation>(
      where: where?.call(UserReputation.t),
      orderBy: orderBy?.call(UserReputation.t),
      orderByList: orderByList?.call(UserReputation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserReputation] by its [id] or null if no such row exists.
  Future<UserReputation?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserReputation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserReputation]s in the list and returns the inserted rows.
  ///
  /// The returned [UserReputation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserReputation>> insert(
    _i1.DatabaseSession session,
    List<UserReputation> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserReputation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserReputation] and returns the inserted row.
  ///
  /// The returned [UserReputation] will have its `id` field set.
  Future<UserReputation> insertRow(
    _i1.DatabaseSession session,
    UserReputation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserReputation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserReputation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserReputation>> update(
    _i1.DatabaseSession session,
    List<UserReputation> rows, {
    _i1.ColumnSelections<UserReputationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserReputation>(
      rows,
      columns: columns?.call(UserReputation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserReputation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserReputation> updateRow(
    _i1.DatabaseSession session,
    UserReputation row, {
    _i1.ColumnSelections<UserReputationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserReputation>(
      row,
      columns: columns?.call(UserReputation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserReputation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserReputation?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserReputationUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserReputation>(
      id,
      columnValues: columnValues(UserReputation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserReputation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserReputation>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserReputationUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserReputationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserReputationTable>? orderBy,
    _i1.OrderByListBuilder<UserReputationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserReputation>(
      columnValues: columnValues(UserReputation.t.updateTable),
      where: where(UserReputation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserReputation.t),
      orderByList: orderByList?.call(UserReputation.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserReputation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserReputation>> delete(
    _i1.DatabaseSession session,
    List<UserReputation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserReputation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserReputation].
  Future<UserReputation> deleteRow(
    _i1.DatabaseSession session,
    UserReputation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserReputation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserReputation>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserReputationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserReputation>(
      where: where(UserReputation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserReputationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserReputation>(
      where: where?.call(UserReputation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserReputation] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserReputationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserReputation>(
      where: where(UserReputation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
