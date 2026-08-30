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

abstract class OpportunityApplicationTracker
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OpportunityApplicationTracker._({
    this.id,
    required this.opportunityId,
    required this.userId,
    required this.status,
    this.notes,
    this.applicationUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OpportunityApplicationTracker({
    int? id,
    required int opportunityId,
    required int userId,
    required String status,
    String? notes,
    String? applicationUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OpportunityApplicationTrackerImpl;

  factory OpportunityApplicationTracker.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OpportunityApplicationTracker(
      id: jsonSerialization['id'] as int?,
      opportunityId: jsonSerialization['opportunityId'] as int,
      userId: jsonSerialization['userId'] as int,
      status: jsonSerialization['status'] as String,
      notes: jsonSerialization['notes'] as String?,
      applicationUrl: jsonSerialization['applicationUrl'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = OpportunityApplicationTrackerTable();

  static const db = OpportunityApplicationTrackerRepository._();

  @override
  int? id;

  int opportunityId;

  int userId;

  String status;

  String? notes;

  String? applicationUrl;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OpportunityApplicationTracker]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OpportunityApplicationTracker copyWith({
    int? id,
    int? opportunityId,
    int? userId,
    String? status,
    String? notes,
    String? applicationUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpportunityApplicationTracker',
      if (id != null) 'id': id,
      'opportunityId': opportunityId,
      'userId': userId,
      'status': status,
      if (notes != null) 'notes': notes,
      if (applicationUrl != null) 'applicationUrl': applicationUrl,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OpportunityApplicationTracker',
      if (id != null) 'id': id,
      'opportunityId': opportunityId,
      'userId': userId,
      'status': status,
      if (notes != null) 'notes': notes,
      if (applicationUrl != null) 'applicationUrl': applicationUrl,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static OpportunityApplicationTrackerInclude include() {
    return OpportunityApplicationTrackerInclude._();
  }

  static OpportunityApplicationTrackerIncludeList includeList({
    _i1.WhereExpressionBuilder<OpportunityApplicationTrackerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunityApplicationTrackerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunityApplicationTrackerTable>? orderByList,
    OpportunityApplicationTrackerInclude? include,
  }) {
    return OpportunityApplicationTrackerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OpportunityApplicationTracker.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OpportunityApplicationTracker.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OpportunityApplicationTrackerImpl extends OpportunityApplicationTracker {
  _OpportunityApplicationTrackerImpl({
    int? id,
    required int opportunityId,
    required int userId,
    required String status,
    String? notes,
    String? applicationUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          opportunityId: opportunityId,
          userId: userId,
          status: status,
          notes: notes,
          applicationUrl: applicationUrl,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [OpportunityApplicationTracker]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OpportunityApplicationTracker copyWith({
    Object? id = _Undefined,
    int? opportunityId,
    int? userId,
    String? status,
    Object? notes = _Undefined,
    Object? applicationUrl = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OpportunityApplicationTracker(
      id: id is int? ? id : this.id,
      opportunityId: opportunityId ?? this.opportunityId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      notes: notes is String? ? notes : this.notes,
      applicationUrl:
          applicationUrl is String? ? applicationUrl : this.applicationUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OpportunityApplicationTrackerUpdateTable
    extends _i1.UpdateTable<OpportunityApplicationTrackerTable> {
  OpportunityApplicationTrackerUpdateTable(super.table);

  _i1.ColumnValue<int, int> opportunityId(int value) => _i1.ColumnValue(
        table.opportunityId,
        value,
      );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
        table.status,
        value,
      );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
        table.notes,
        value,
      );

  _i1.ColumnValue<String, String> applicationUrl(String? value) =>
      _i1.ColumnValue(
        table.applicationUrl,
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

class OpportunityApplicationTrackerTable extends _i1.Table<int?> {
  OpportunityApplicationTrackerTable({super.tableRelation})
      : super(tableName: 'opportunity_application_trackers') {
    updateTable = OpportunityApplicationTrackerUpdateTable(this);
    opportunityId = _i1.ColumnInt(
      'opportunityId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    applicationUrl = _i1.ColumnString(
      'applicationUrl',
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

  late final OpportunityApplicationTrackerUpdateTable updateTable;

  late final _i1.ColumnInt opportunityId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString status;

  late final _i1.ColumnString notes;

  late final _i1.ColumnString applicationUrl;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        opportunityId,
        userId,
        status,
        notes,
        applicationUrl,
        createdAt,
        updatedAt,
      ];
}

class OpportunityApplicationTrackerInclude extends _i1.IncludeObject {
  OpportunityApplicationTrackerInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OpportunityApplicationTracker.t;
}

class OpportunityApplicationTrackerIncludeList extends _i1.IncludeList {
  OpportunityApplicationTrackerIncludeList._({
    _i1.WhereExpressionBuilder<OpportunityApplicationTrackerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OpportunityApplicationTracker.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OpportunityApplicationTracker.t;
}

class OpportunityApplicationTrackerRepository {
  const OpportunityApplicationTrackerRepository._();

  /// Returns a list of [OpportunityApplicationTracker]s matching the given query parameters.
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
  Future<List<OpportunityApplicationTracker>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunityApplicationTrackerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunityApplicationTrackerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunityApplicationTrackerTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OpportunityApplicationTracker>(
      where: where?.call(OpportunityApplicationTracker.t),
      orderBy: orderBy?.call(OpportunityApplicationTracker.t),
      orderByList: orderByList?.call(OpportunityApplicationTracker.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OpportunityApplicationTracker] matching the given query parameters.
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
  Future<OpportunityApplicationTracker?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunityApplicationTrackerTable>? where,
    int? offset,
    _i1.OrderByBuilder<OpportunityApplicationTrackerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunityApplicationTrackerTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OpportunityApplicationTracker>(
      where: where?.call(OpportunityApplicationTracker.t),
      orderBy: orderBy?.call(OpportunityApplicationTracker.t),
      orderByList: orderByList?.call(OpportunityApplicationTracker.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OpportunityApplicationTracker] by its [id] or null if no such row exists.
  Future<OpportunityApplicationTracker?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OpportunityApplicationTracker>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OpportunityApplicationTracker]s in the list and returns the inserted rows.
  ///
  /// The returned [OpportunityApplicationTracker]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OpportunityApplicationTracker>> insert(
    _i1.DatabaseSession session,
    List<OpportunityApplicationTracker> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OpportunityApplicationTracker>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OpportunityApplicationTracker] and returns the inserted row.
  ///
  /// The returned [OpportunityApplicationTracker] will have its `id` field set.
  Future<OpportunityApplicationTracker> insertRow(
    _i1.DatabaseSession session,
    OpportunityApplicationTracker row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OpportunityApplicationTracker>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OpportunityApplicationTracker]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OpportunityApplicationTracker>> update(
    _i1.DatabaseSession session,
    List<OpportunityApplicationTracker> rows, {
    _i1.ColumnSelections<OpportunityApplicationTrackerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OpportunityApplicationTracker>(
      rows,
      columns: columns?.call(OpportunityApplicationTracker.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OpportunityApplicationTracker]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OpportunityApplicationTracker> updateRow(
    _i1.DatabaseSession session,
    OpportunityApplicationTracker row, {
    _i1.ColumnSelections<OpportunityApplicationTrackerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OpportunityApplicationTracker>(
      row,
      columns: columns?.call(OpportunityApplicationTracker.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OpportunityApplicationTracker] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OpportunityApplicationTracker?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1
        .ColumnValueListBuilder<OpportunityApplicationTrackerUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OpportunityApplicationTracker>(
      id,
      columnValues: columnValues(OpportunityApplicationTracker.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OpportunityApplicationTracker]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OpportunityApplicationTracker>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1
        .ColumnValueListBuilder<OpportunityApplicationTrackerUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<OpportunityApplicationTrackerTable>
        where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunityApplicationTrackerTable>? orderBy,
    _i1.OrderByListBuilder<OpportunityApplicationTrackerTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OpportunityApplicationTracker>(
      columnValues: columnValues(OpportunityApplicationTracker.t.updateTable),
      where: where(OpportunityApplicationTracker.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OpportunityApplicationTracker.t),
      orderByList: orderByList?.call(OpportunityApplicationTracker.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OpportunityApplicationTracker]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OpportunityApplicationTracker>> delete(
    _i1.DatabaseSession session,
    List<OpportunityApplicationTracker> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OpportunityApplicationTracker>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OpportunityApplicationTracker].
  Future<OpportunityApplicationTracker> deleteRow(
    _i1.DatabaseSession session,
    OpportunityApplicationTracker row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OpportunityApplicationTracker>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OpportunityApplicationTracker>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OpportunityApplicationTrackerTable>
        where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OpportunityApplicationTracker>(
      where: where(OpportunityApplicationTracker.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunityApplicationTrackerTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OpportunityApplicationTracker>(
      where: where?.call(OpportunityApplicationTracker.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OpportunityApplicationTracker] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OpportunityApplicationTrackerTable>
        where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OpportunityApplicationTracker>(
      where: where(OpportunityApplicationTracker.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
