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

abstract class ChallengeMilestone
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ChallengeMilestone._({
    this.id,
    required this.teamId,
    required this.title,
    this.description,
    required this.status,
    this.dueAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChallengeMilestone({
    int? id,
    required int teamId,
    required String title,
    String? description,
    required String status,
    DateTime? dueAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChallengeMilestoneImpl;

  factory ChallengeMilestone.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeMilestone(
      id: jsonSerialization['id'] as int?,
      teamId: jsonSerialization['teamId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as String,
      dueAt: jsonSerialization['dueAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ChallengeMilestoneTable();

  static const db = ChallengeMilestoneRepository._();

  @override
  int? id;

  int teamId;

  String title;

  String? description;

  String status;

  DateTime? dueAt;

  DateTime? completedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChallengeMilestone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChallengeMilestone copyWith({
    int? id,
    int? teamId,
    String? title,
    String? description,
    String? status,
    DateTime? dueAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeMilestone',
      if (id != null) 'id': id,
      'teamId': teamId,
      'title': title,
      if (description != null) 'description': description,
      'status': status,
      if (dueAt != null) 'dueAt': dueAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChallengeMilestone',
      if (id != null) 'id': id,
      'teamId': teamId,
      'title': title,
      if (description != null) 'description': description,
      'status': status,
      if (dueAt != null) 'dueAt': dueAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChallengeMilestoneInclude include() {
    return ChallengeMilestoneInclude._();
  }

  static ChallengeMilestoneIncludeList includeList({
    _i1.WhereExpressionBuilder<ChallengeMilestoneTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeMilestoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeMilestoneTable>? orderByList,
    ChallengeMilestoneInclude? include,
  }) {
    return ChallengeMilestoneIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeMilestone.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChallengeMilestone.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeMilestoneImpl extends ChallengeMilestone {
  _ChallengeMilestoneImpl({
    int? id,
    required int teamId,
    required String title,
    String? description,
    required String status,
    DateTime? dueAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         teamId: teamId,
         title: title,
         description: description,
         status: status,
         dueAt: dueAt,
         completedAt: completedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ChallengeMilestone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChallengeMilestone copyWith({
    Object? id = _Undefined,
    int? teamId,
    String? title,
    Object? description = _Undefined,
    String? status,
    Object? dueAt = _Undefined,
    Object? completedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChallengeMilestone(
      id: id is int? ? id : this.id,
      teamId: teamId ?? this.teamId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      dueAt: dueAt is DateTime? ? dueAt : this.dueAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChallengeMilestoneUpdateTable
    extends _i1.UpdateTable<ChallengeMilestoneTable> {
  ChallengeMilestoneUpdateTable(super.table);

  _i1.ColumnValue<int, int> teamId(int value) => _i1.ColumnValue(
    table.teamId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
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

  _i1.ColumnValue<DateTime, DateTime> dueAt(DateTime? value) => _i1.ColumnValue(
    table.dueAt,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
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

class ChallengeMilestoneTable extends _i1.Table<int?> {
  ChallengeMilestoneTable({super.tableRelation})
    : super(tableName: 'challenge_milestones') {
    updateTable = ChallengeMilestoneUpdateTable(this);
    teamId = _i1.ColumnInt(
      'teamId',
      this,
    );
    title = _i1.ColumnString(
      'title',
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
    dueAt = _i1.ColumnDateTime(
      'dueAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
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

  late final ChallengeMilestoneUpdateTable updateTable;

  late final _i1.ColumnInt teamId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime dueAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    teamId,
    title,
    description,
    status,
    dueAt,
    completedAt,
    createdAt,
    updatedAt,
  ];
}

class ChallengeMilestoneInclude extends _i1.IncludeObject {
  ChallengeMilestoneInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ChallengeMilestone.t;
}

class ChallengeMilestoneIncludeList extends _i1.IncludeList {
  ChallengeMilestoneIncludeList._({
    _i1.WhereExpressionBuilder<ChallengeMilestoneTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChallengeMilestone.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChallengeMilestone.t;
}

class ChallengeMilestoneRepository {
  const ChallengeMilestoneRepository._();

  /// Returns a list of [ChallengeMilestone]s matching the given query parameters.
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
  Future<List<ChallengeMilestone>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeMilestoneTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeMilestoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeMilestoneTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChallengeMilestone>(
      where: where?.call(ChallengeMilestone.t),
      orderBy: orderBy?.call(ChallengeMilestone.t),
      orderByList: orderByList?.call(ChallengeMilestone.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChallengeMilestone] matching the given query parameters.
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
  Future<ChallengeMilestone?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeMilestoneTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChallengeMilestoneTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeMilestoneTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChallengeMilestone>(
      where: where?.call(ChallengeMilestone.t),
      orderBy: orderBy?.call(ChallengeMilestone.t),
      orderByList: orderByList?.call(ChallengeMilestone.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChallengeMilestone] by its [id] or null if no such row exists.
  Future<ChallengeMilestone?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChallengeMilestone>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChallengeMilestone]s in the list and returns the inserted rows.
  ///
  /// The returned [ChallengeMilestone]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ChallengeMilestone>> insert(
    _i1.DatabaseSession session,
    List<ChallengeMilestone> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ChallengeMilestone>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ChallengeMilestone] and returns the inserted row.
  ///
  /// The returned [ChallengeMilestone] will have its `id` field set.
  Future<ChallengeMilestone> insertRow(
    _i1.DatabaseSession session,
    ChallengeMilestone row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChallengeMilestone>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeMilestone]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChallengeMilestone>> update(
    _i1.DatabaseSession session,
    List<ChallengeMilestone> rows, {
    _i1.ColumnSelections<ChallengeMilestoneTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChallengeMilestone>(
      rows,
      columns: columns?.call(ChallengeMilestone.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeMilestone]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChallengeMilestone> updateRow(
    _i1.DatabaseSession session,
    ChallengeMilestone row, {
    _i1.ColumnSelections<ChallengeMilestoneTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChallengeMilestone>(
      row,
      columns: columns?.call(ChallengeMilestone.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChallengeMilestone] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChallengeMilestone?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ChallengeMilestoneUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ChallengeMilestone>(
      id,
      columnValues: columnValues(ChallengeMilestone.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChallengeMilestone]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ChallengeMilestone>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ChallengeMilestoneUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ChallengeMilestoneTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeMilestoneTable>? orderBy,
    _i1.OrderByListBuilder<ChallengeMilestoneTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ChallengeMilestone>(
      columnValues: columnValues(ChallengeMilestone.t.updateTable),
      where: where(ChallengeMilestone.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChallengeMilestone.t),
      orderByList: orderByList?.call(ChallengeMilestone.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ChallengeMilestone]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChallengeMilestone>> delete(
    _i1.DatabaseSession session,
    List<ChallengeMilestone> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChallengeMilestone>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChallengeMilestone].
  Future<ChallengeMilestone> deleteRow(
    _i1.DatabaseSession session,
    ChallengeMilestone row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChallengeMilestone>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChallengeMilestone>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeMilestoneTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChallengeMilestone>(
      where: where(ChallengeMilestone.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeMilestoneTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChallengeMilestone>(
      where: where?.call(ChallengeMilestone.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChallengeMilestone] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeMilestoneTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChallengeMilestone>(
      where: where(ChallengeMilestone.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
