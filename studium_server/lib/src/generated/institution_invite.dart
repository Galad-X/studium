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

abstract class InstitutionInvite
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  InstitutionInvite._({
    this.id,
    required this.institutionId,
    required this.createdById,
    required this.tokenHash,
    required this.expiresAt,
    required this.maxUses,
    required this.uses,
    required this.status,
    required this.createdAt,
  });

  factory InstitutionInvite({
    int? id,
    required int institutionId,
    required int createdById,
    required String tokenHash,
    required DateTime expiresAt,
    required int maxUses,
    required int uses,
    required String status,
    required DateTime createdAt,
  }) = _InstitutionInviteImpl;

  factory InstitutionInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return InstitutionInvite(
      id: jsonSerialization['id'] as int?,
      institutionId: jsonSerialization['institutionId'] as int,
      createdById: jsonSerialization['createdById'] as int,
      tokenHash: jsonSerialization['tokenHash'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      maxUses: jsonSerialization['maxUses'] as int,
      uses: jsonSerialization['uses'] as int,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = InstitutionInviteTable();

  static const db = InstitutionInviteRepository._();

  @override
  int? id;

  int institutionId;

  int createdById;

  String tokenHash;

  DateTime expiresAt;

  int maxUses;

  int uses;

  String status;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InstitutionInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InstitutionInvite copyWith({
    int? id,
    int? institutionId,
    int? createdById,
    String? tokenHash,
    DateTime? expiresAt,
    int? maxUses,
    int? uses,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InstitutionInvite',
      if (id != null) 'id': id,
      'institutionId': institutionId,
      'createdById': createdById,
      'tokenHash': tokenHash,
      'expiresAt': expiresAt.toJson(),
      'maxUses': maxUses,
      'uses': uses,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InstitutionInvite',
      if (id != null) 'id': id,
      'institutionId': institutionId,
      'createdById': createdById,
      'tokenHash': tokenHash,
      'expiresAt': expiresAt.toJson(),
      'maxUses': maxUses,
      'uses': uses,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static InstitutionInviteInclude include() {
    return InstitutionInviteInclude._();
  }

  static InstitutionInviteIncludeList includeList({
    _i1.WhereExpressionBuilder<InstitutionInviteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InstitutionInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InstitutionInviteTable>? orderByList,
    InstitutionInviteInclude? include,
  }) {
    return InstitutionInviteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InstitutionInvite.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InstitutionInvite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InstitutionInviteImpl extends InstitutionInvite {
  _InstitutionInviteImpl({
    int? id,
    required int institutionId,
    required int createdById,
    required String tokenHash,
    required DateTime expiresAt,
    required int maxUses,
    required int uses,
    required String status,
    required DateTime createdAt,
  }) : super._(
          id: id,
          institutionId: institutionId,
          createdById: createdById,
          tokenHash: tokenHash,
          expiresAt: expiresAt,
          maxUses: maxUses,
          uses: uses,
          status: status,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [InstitutionInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InstitutionInvite copyWith({
    Object? id = _Undefined,
    int? institutionId,
    int? createdById,
    String? tokenHash,
    DateTime? expiresAt,
    int? maxUses,
    int? uses,
    String? status,
    DateTime? createdAt,
  }) {
    return InstitutionInvite(
      id: id is int? ? id : this.id,
      institutionId: institutionId ?? this.institutionId,
      createdById: createdById ?? this.createdById,
      tokenHash: tokenHash ?? this.tokenHash,
      expiresAt: expiresAt ?? this.expiresAt,
      maxUses: maxUses ?? this.maxUses,
      uses: uses ?? this.uses,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class InstitutionInviteUpdateTable
    extends _i1.UpdateTable<InstitutionInviteTable> {
  InstitutionInviteUpdateTable(super.table);

  _i1.ColumnValue<int, int> institutionId(int value) => _i1.ColumnValue(
        table.institutionId,
        value,
      );

  _i1.ColumnValue<int, int> createdById(int value) => _i1.ColumnValue(
        table.createdById,
        value,
      );

  _i1.ColumnValue<String, String> tokenHash(String value) => _i1.ColumnValue(
        table.tokenHash,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<int, int> maxUses(int value) => _i1.ColumnValue(
        table.maxUses,
        value,
      );

  _i1.ColumnValue<int, int> uses(int value) => _i1.ColumnValue(
        table.uses,
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

class InstitutionInviteTable extends _i1.Table<int?> {
  InstitutionInviteTable({super.tableRelation})
      : super(tableName: 'institution_invites') {
    updateTable = InstitutionInviteUpdateTable(this);
    institutionId = _i1.ColumnInt(
      'institutionId',
      this,
    );
    createdById = _i1.ColumnInt(
      'createdById',
      this,
    );
    tokenHash = _i1.ColumnString(
      'tokenHash',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    maxUses = _i1.ColumnInt(
      'maxUses',
      this,
    );
    uses = _i1.ColumnInt(
      'uses',
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

  late final InstitutionInviteUpdateTable updateTable;

  late final _i1.ColumnInt institutionId;

  late final _i1.ColumnInt createdById;

  late final _i1.ColumnString tokenHash;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnInt maxUses;

  late final _i1.ColumnInt uses;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        institutionId,
        createdById,
        tokenHash,
        expiresAt,
        maxUses,
        uses,
        status,
        createdAt,
      ];
}

class InstitutionInviteInclude extends _i1.IncludeObject {
  InstitutionInviteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => InstitutionInvite.t;
}

class InstitutionInviteIncludeList extends _i1.IncludeList {
  InstitutionInviteIncludeList._({
    _i1.WhereExpressionBuilder<InstitutionInviteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InstitutionInvite.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InstitutionInvite.t;
}

class InstitutionInviteRepository {
  const InstitutionInviteRepository._();

  /// Returns a list of [InstitutionInvite]s matching the given query parameters.
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
  Future<List<InstitutionInvite>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InstitutionInviteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InstitutionInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InstitutionInviteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InstitutionInvite>(
      where: where?.call(InstitutionInvite.t),
      orderBy: orderBy?.call(InstitutionInvite.t),
      orderByList: orderByList?.call(InstitutionInvite.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InstitutionInvite] matching the given query parameters.
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
  Future<InstitutionInvite?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InstitutionInviteTable>? where,
    int? offset,
    _i1.OrderByBuilder<InstitutionInviteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InstitutionInviteTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InstitutionInvite>(
      where: where?.call(InstitutionInvite.t),
      orderBy: orderBy?.call(InstitutionInvite.t),
      orderByList: orderByList?.call(InstitutionInvite.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InstitutionInvite] by its [id] or null if no such row exists.
  Future<InstitutionInvite?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InstitutionInvite>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InstitutionInvite]s in the list and returns the inserted rows.
  ///
  /// The returned [InstitutionInvite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<InstitutionInvite>> insert(
    _i1.DatabaseSession session,
    List<InstitutionInvite> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<InstitutionInvite>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [InstitutionInvite] and returns the inserted row.
  ///
  /// The returned [InstitutionInvite] will have its `id` field set.
  Future<InstitutionInvite> insertRow(
    _i1.DatabaseSession session,
    InstitutionInvite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InstitutionInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InstitutionInvite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InstitutionInvite>> update(
    _i1.DatabaseSession session,
    List<InstitutionInvite> rows, {
    _i1.ColumnSelections<InstitutionInviteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InstitutionInvite>(
      rows,
      columns: columns?.call(InstitutionInvite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InstitutionInvite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InstitutionInvite> updateRow(
    _i1.DatabaseSession session,
    InstitutionInvite row, {
    _i1.ColumnSelections<InstitutionInviteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InstitutionInvite>(
      row,
      columns: columns?.call(InstitutionInvite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InstitutionInvite] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InstitutionInvite?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<InstitutionInviteUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<InstitutionInvite>(
      id,
      columnValues: columnValues(InstitutionInvite.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InstitutionInvite]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<InstitutionInvite>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<InstitutionInviteUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<InstitutionInviteTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InstitutionInviteTable>? orderBy,
    _i1.OrderByListBuilder<InstitutionInviteTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<InstitutionInvite>(
      columnValues: columnValues(InstitutionInvite.t.updateTable),
      where: where(InstitutionInvite.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InstitutionInvite.t),
      orderByList: orderByList?.call(InstitutionInvite.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [InstitutionInvite]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InstitutionInvite>> delete(
    _i1.DatabaseSession session,
    List<InstitutionInvite> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InstitutionInvite>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InstitutionInvite].
  Future<InstitutionInvite> deleteRow(
    _i1.DatabaseSession session,
    InstitutionInvite row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InstitutionInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InstitutionInvite>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InstitutionInviteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InstitutionInvite>(
      where: where(InstitutionInvite.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InstitutionInviteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InstitutionInvite>(
      where: where?.call(InstitutionInvite.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InstitutionInvite] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InstitutionInviteTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InstitutionInvite>(
      where: where(InstitutionInvite.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
