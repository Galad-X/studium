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

abstract class OpportunitySource
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OpportunitySource._({
    this.id,
    required this.name,
    required this.provider,
    required this.feedUrl,
    required this.verificationStatus,
    required this.createdById,
    this.lastSyncedAt,
    this.nextSyncAt,
    this.lastSyncStatus,
    this.lastSyncError,
    this.staleAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OpportunitySource({
    int? id,
    required String name,
    required String provider,
    required String feedUrl,
    required String verificationStatus,
    required int createdById,
    DateTime? lastSyncedAt,
    DateTime? nextSyncAt,
    String? lastSyncStatus,
    String? lastSyncError,
    DateTime? staleAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OpportunitySourceImpl;

  factory OpportunitySource.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpportunitySource(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      provider: jsonSerialization['provider'] as String,
      feedUrl: jsonSerialization['feedUrl'] as String,
      verificationStatus: jsonSerialization['verificationStatus'] as String,
      createdById: jsonSerialization['createdById'] as int,
      lastSyncedAt: jsonSerialization['lastSyncedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSyncedAt'],
            ),
      nextSyncAt: jsonSerialization['nextSyncAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['nextSyncAt']),
      lastSyncStatus: jsonSerialization['lastSyncStatus'] as String?,
      lastSyncError: jsonSerialization['lastSyncError'] as String?,
      staleAt: jsonSerialization['staleAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['staleAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = OpportunitySourceTable();

  static const db = OpportunitySourceRepository._();

  @override
  int? id;

  String name;

  String provider;

  String feedUrl;

  String verificationStatus;

  int createdById;

  DateTime? lastSyncedAt;

  DateTime? nextSyncAt;

  String? lastSyncStatus;

  String? lastSyncError;

  DateTime? staleAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OpportunitySource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OpportunitySource copyWith({
    int? id,
    String? name,
    String? provider,
    String? feedUrl,
    String? verificationStatus,
    int? createdById,
    DateTime? lastSyncedAt,
    DateTime? nextSyncAt,
    String? lastSyncStatus,
    String? lastSyncError,
    DateTime? staleAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpportunitySource',
      if (id != null) 'id': id,
      'name': name,
      'provider': provider,
      'feedUrl': feedUrl,
      'verificationStatus': verificationStatus,
      'createdById': createdById,
      if (lastSyncedAt != null) 'lastSyncedAt': lastSyncedAt?.toJson(),
      if (nextSyncAt != null) 'nextSyncAt': nextSyncAt?.toJson(),
      if (lastSyncStatus != null) 'lastSyncStatus': lastSyncStatus,
      if (lastSyncError != null) 'lastSyncError': lastSyncError,
      if (staleAt != null) 'staleAt': staleAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OpportunitySource',
      if (id != null) 'id': id,
      'name': name,
      'provider': provider,
      'feedUrl': feedUrl,
      'verificationStatus': verificationStatus,
      'createdById': createdById,
      if (lastSyncedAt != null) 'lastSyncedAt': lastSyncedAt?.toJson(),
      if (nextSyncAt != null) 'nextSyncAt': nextSyncAt?.toJson(),
      if (lastSyncStatus != null) 'lastSyncStatus': lastSyncStatus,
      if (lastSyncError != null) 'lastSyncError': lastSyncError,
      if (staleAt != null) 'staleAt': staleAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static OpportunitySourceInclude include() {
    return OpportunitySourceInclude._();
  }

  static OpportunitySourceIncludeList includeList({
    _i1.WhereExpressionBuilder<OpportunitySourceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunitySourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunitySourceTable>? orderByList,
    OpportunitySourceInclude? include,
  }) {
    return OpportunitySourceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OpportunitySource.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OpportunitySource.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OpportunitySourceImpl extends OpportunitySource {
  _OpportunitySourceImpl({
    int? id,
    required String name,
    required String provider,
    required String feedUrl,
    required String verificationStatus,
    required int createdById,
    DateTime? lastSyncedAt,
    DateTime? nextSyncAt,
    String? lastSyncStatus,
    String? lastSyncError,
    DateTime? staleAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         name: name,
         provider: provider,
         feedUrl: feedUrl,
         verificationStatus: verificationStatus,
         createdById: createdById,
         lastSyncedAt: lastSyncedAt,
         nextSyncAt: nextSyncAt,
         lastSyncStatus: lastSyncStatus,
         lastSyncError: lastSyncError,
         staleAt: staleAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [OpportunitySource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OpportunitySource copyWith({
    Object? id = _Undefined,
    String? name,
    String? provider,
    String? feedUrl,
    String? verificationStatus,
    int? createdById,
    Object? lastSyncedAt = _Undefined,
    Object? nextSyncAt = _Undefined,
    Object? lastSyncStatus = _Undefined,
    Object? lastSyncError = _Undefined,
    Object? staleAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OpportunitySource(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      provider: provider ?? this.provider,
      feedUrl: feedUrl ?? this.feedUrl,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      createdById: createdById ?? this.createdById,
      lastSyncedAt: lastSyncedAt is DateTime?
          ? lastSyncedAt
          : this.lastSyncedAt,
      nextSyncAt: nextSyncAt is DateTime? ? nextSyncAt : this.nextSyncAt,
      lastSyncStatus: lastSyncStatus is String?
          ? lastSyncStatus
          : this.lastSyncStatus,
      lastSyncError: lastSyncError is String?
          ? lastSyncError
          : this.lastSyncError,
      staleAt: staleAt is DateTime? ? staleAt : this.staleAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OpportunitySourceUpdateTable
    extends _i1.UpdateTable<OpportunitySourceTable> {
  OpportunitySourceUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> provider(String value) => _i1.ColumnValue(
    table.provider,
    value,
  );

  _i1.ColumnValue<String, String> feedUrl(String value) => _i1.ColumnValue(
    table.feedUrl,
    value,
  );

  _i1.ColumnValue<String, String> verificationStatus(String value) =>
      _i1.ColumnValue(
        table.verificationStatus,
        value,
      );

  _i1.ColumnValue<int, int> createdById(int value) => _i1.ColumnValue(
    table.createdById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastSyncedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastSyncedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> nextSyncAt(DateTime? value) =>
      _i1.ColumnValue(
        table.nextSyncAt,
        value,
      );

  _i1.ColumnValue<String, String> lastSyncStatus(String? value) =>
      _i1.ColumnValue(
        table.lastSyncStatus,
        value,
      );

  _i1.ColumnValue<String, String> lastSyncError(String? value) =>
      _i1.ColumnValue(
        table.lastSyncError,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> staleAt(DateTime? value) =>
      _i1.ColumnValue(
        table.staleAt,
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

class OpportunitySourceTable extends _i1.Table<int?> {
  OpportunitySourceTable({super.tableRelation})
    : super(tableName: 'opportunity_sources') {
    updateTable = OpportunitySourceUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    provider = _i1.ColumnString(
      'provider',
      this,
    );
    feedUrl = _i1.ColumnString(
      'feedUrl',
      this,
    );
    verificationStatus = _i1.ColumnString(
      'verificationStatus',
      this,
    );
    createdById = _i1.ColumnInt(
      'createdById',
      this,
    );
    lastSyncedAt = _i1.ColumnDateTime(
      'lastSyncedAt',
      this,
    );
    nextSyncAt = _i1.ColumnDateTime(
      'nextSyncAt',
      this,
    );
    lastSyncStatus = _i1.ColumnString(
      'lastSyncStatus',
      this,
    );
    lastSyncError = _i1.ColumnString(
      'lastSyncError',
      this,
    );
    staleAt = _i1.ColumnDateTime(
      'staleAt',
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

  late final OpportunitySourceUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString provider;

  late final _i1.ColumnString feedUrl;

  late final _i1.ColumnString verificationStatus;

  late final _i1.ColumnInt createdById;

  late final _i1.ColumnDateTime lastSyncedAt;

  late final _i1.ColumnDateTime nextSyncAt;

  late final _i1.ColumnString lastSyncStatus;

  late final _i1.ColumnString lastSyncError;

  late final _i1.ColumnDateTime staleAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    provider,
    feedUrl,
    verificationStatus,
    createdById,
    lastSyncedAt,
    nextSyncAt,
    lastSyncStatus,
    lastSyncError,
    staleAt,
    createdAt,
    updatedAt,
  ];
}

class OpportunitySourceInclude extends _i1.IncludeObject {
  OpportunitySourceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OpportunitySource.t;
}

class OpportunitySourceIncludeList extends _i1.IncludeList {
  OpportunitySourceIncludeList._({
    _i1.WhereExpressionBuilder<OpportunitySourceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OpportunitySource.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OpportunitySource.t;
}

class OpportunitySourceRepository {
  const OpportunitySourceRepository._();

  /// Returns a list of [OpportunitySource]s matching the given query parameters.
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
  Future<List<OpportunitySource>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunitySourceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunitySourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunitySourceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OpportunitySource>(
      where: where?.call(OpportunitySource.t),
      orderBy: orderBy?.call(OpportunitySource.t),
      orderByList: orderByList?.call(OpportunitySource.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OpportunitySource] matching the given query parameters.
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
  Future<OpportunitySource?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunitySourceTable>? where,
    int? offset,
    _i1.OrderByBuilder<OpportunitySourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunitySourceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OpportunitySource>(
      where: where?.call(OpportunitySource.t),
      orderBy: orderBy?.call(OpportunitySource.t),
      orderByList: orderByList?.call(OpportunitySource.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OpportunitySource] by its [id] or null if no such row exists.
  Future<OpportunitySource?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OpportunitySource>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OpportunitySource]s in the list and returns the inserted rows.
  ///
  /// The returned [OpportunitySource]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OpportunitySource>> insert(
    _i1.DatabaseSession session,
    List<OpportunitySource> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OpportunitySource>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OpportunitySource] and returns the inserted row.
  ///
  /// The returned [OpportunitySource] will have its `id` field set.
  Future<OpportunitySource> insertRow(
    _i1.DatabaseSession session,
    OpportunitySource row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OpportunitySource>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OpportunitySource]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OpportunitySource>> update(
    _i1.DatabaseSession session,
    List<OpportunitySource> rows, {
    _i1.ColumnSelections<OpportunitySourceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OpportunitySource>(
      rows,
      columns: columns?.call(OpportunitySource.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OpportunitySource]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OpportunitySource> updateRow(
    _i1.DatabaseSession session,
    OpportunitySource row, {
    _i1.ColumnSelections<OpportunitySourceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OpportunitySource>(
      row,
      columns: columns?.call(OpportunitySource.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OpportunitySource] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OpportunitySource?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OpportunitySourceUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OpportunitySource>(
      id,
      columnValues: columnValues(OpportunitySource.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OpportunitySource]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OpportunitySource>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OpportunitySourceUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<OpportunitySourceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunitySourceTable>? orderBy,
    _i1.OrderByListBuilder<OpportunitySourceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OpportunitySource>(
      columnValues: columnValues(OpportunitySource.t.updateTable),
      where: where(OpportunitySource.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OpportunitySource.t),
      orderByList: orderByList?.call(OpportunitySource.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OpportunitySource]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OpportunitySource>> delete(
    _i1.DatabaseSession session,
    List<OpportunitySource> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OpportunitySource>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OpportunitySource].
  Future<OpportunitySource> deleteRow(
    _i1.DatabaseSession session,
    OpportunitySource row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OpportunitySource>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OpportunitySource>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OpportunitySourceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OpportunitySource>(
      where: where(OpportunitySource.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunitySourceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OpportunitySource>(
      where: where?.call(OpportunitySource.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OpportunitySource] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OpportunitySourceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OpportunitySource>(
      where: where(OpportunitySource.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
