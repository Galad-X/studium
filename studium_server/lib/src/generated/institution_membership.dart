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

abstract class InstitutionMembership
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  InstitutionMembership._({
    this.id,
    required this.userId,
    required this.institutionId,
    required this.role,
    required this.verificationMethod,
    required this.status,
    required this.createdAt,
    this.verifiedAt,
  });

  factory InstitutionMembership({
    int? id,
    required int userId,
    required int institutionId,
    required String role,
    required String verificationMethod,
    required String status,
    required DateTime createdAt,
    DateTime? verifiedAt,
  }) = _InstitutionMembershipImpl;

  factory InstitutionMembership.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return InstitutionMembership(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      institutionId: jsonSerialization['institutionId'] as int,
      role: jsonSerialization['role'] as String,
      verificationMethod: jsonSerialization['verificationMethod'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      verifiedAt: jsonSerialization['verifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['verifiedAt']),
    );
  }

  static final t = InstitutionMembershipTable();

  static const db = InstitutionMembershipRepository._();

  @override
  int? id;

  int userId;

  int institutionId;

  String role;

  String verificationMethod;

  String status;

  DateTime createdAt;

  DateTime? verifiedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InstitutionMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InstitutionMembership copyWith({
    int? id,
    int? userId,
    int? institutionId,
    String? role,
    String? verificationMethod,
    String? status,
    DateTime? createdAt,
    DateTime? verifiedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InstitutionMembership',
      if (id != null) 'id': id,
      'userId': userId,
      'institutionId': institutionId,
      'role': role,
      'verificationMethod': verificationMethod,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InstitutionMembership',
      if (id != null) 'id': id,
      'userId': userId,
      'institutionId': institutionId,
      'role': role,
      'verificationMethod': verificationMethod,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
    };
  }

  static InstitutionMembershipInclude include() {
    return InstitutionMembershipInclude._();
  }

  static InstitutionMembershipIncludeList includeList({
    _i1.WhereExpressionBuilder<InstitutionMembershipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InstitutionMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InstitutionMembershipTable>? orderByList,
    InstitutionMembershipInclude? include,
  }) {
    return InstitutionMembershipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InstitutionMembership.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InstitutionMembership.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InstitutionMembershipImpl extends InstitutionMembership {
  _InstitutionMembershipImpl({
    int? id,
    required int userId,
    required int institutionId,
    required String role,
    required String verificationMethod,
    required String status,
    required DateTime createdAt,
    DateTime? verifiedAt,
  }) : super._(
         id: id,
         userId: userId,
         institutionId: institutionId,
         role: role,
         verificationMethod: verificationMethod,
         status: status,
         createdAt: createdAt,
         verifiedAt: verifiedAt,
       );

  /// Returns a shallow copy of this [InstitutionMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InstitutionMembership copyWith({
    Object? id = _Undefined,
    int? userId,
    int? institutionId,
    String? role,
    String? verificationMethod,
    String? status,
    DateTime? createdAt,
    Object? verifiedAt = _Undefined,
  }) {
    return InstitutionMembership(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      institutionId: institutionId ?? this.institutionId,
      role: role ?? this.role,
      verificationMethod: verificationMethod ?? this.verificationMethod,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      verifiedAt: verifiedAt is DateTime? ? verifiedAt : this.verifiedAt,
    );
  }
}

class InstitutionMembershipUpdateTable
    extends _i1.UpdateTable<InstitutionMembershipTable> {
  InstitutionMembershipUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> institutionId(int value) => _i1.ColumnValue(
    table.institutionId,
    value,
  );

  _i1.ColumnValue<String, String> role(String value) => _i1.ColumnValue(
    table.role,
    value,
  );

  _i1.ColumnValue<String, String> verificationMethod(String value) =>
      _i1.ColumnValue(
        table.verificationMethod,
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

  _i1.ColumnValue<DateTime, DateTime> verifiedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.verifiedAt,
        value,
      );
}

class InstitutionMembershipTable extends _i1.Table<int?> {
  InstitutionMembershipTable({super.tableRelation})
    : super(tableName: 'institution_memberships') {
    updateTable = InstitutionMembershipUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    institutionId = _i1.ColumnInt(
      'institutionId',
      this,
    );
    role = _i1.ColumnString(
      'role',
      this,
    );
    verificationMethod = _i1.ColumnString(
      'verificationMethod',
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
    verifiedAt = _i1.ColumnDateTime(
      'verifiedAt',
      this,
    );
  }

  late final InstitutionMembershipUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt institutionId;

  late final _i1.ColumnString role;

  late final _i1.ColumnString verificationMethod;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime verifiedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    institutionId,
    role,
    verificationMethod,
    status,
    createdAt,
    verifiedAt,
  ];
}

class InstitutionMembershipInclude extends _i1.IncludeObject {
  InstitutionMembershipInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => InstitutionMembership.t;
}

class InstitutionMembershipIncludeList extends _i1.IncludeList {
  InstitutionMembershipIncludeList._({
    _i1.WhereExpressionBuilder<InstitutionMembershipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InstitutionMembership.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InstitutionMembership.t;
}

class InstitutionMembershipRepository {
  const InstitutionMembershipRepository._();

  /// Returns a list of [InstitutionMembership]s matching the given query parameters.
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
  Future<List<InstitutionMembership>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InstitutionMembershipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InstitutionMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InstitutionMembershipTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InstitutionMembership>(
      where: where?.call(InstitutionMembership.t),
      orderBy: orderBy?.call(InstitutionMembership.t),
      orderByList: orderByList?.call(InstitutionMembership.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InstitutionMembership] matching the given query parameters.
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
  Future<InstitutionMembership?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InstitutionMembershipTable>? where,
    int? offset,
    _i1.OrderByBuilder<InstitutionMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InstitutionMembershipTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InstitutionMembership>(
      where: where?.call(InstitutionMembership.t),
      orderBy: orderBy?.call(InstitutionMembership.t),
      orderByList: orderByList?.call(InstitutionMembership.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InstitutionMembership] by its [id] or null if no such row exists.
  Future<InstitutionMembership?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InstitutionMembership>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InstitutionMembership]s in the list and returns the inserted rows.
  ///
  /// The returned [InstitutionMembership]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<InstitutionMembership>> insert(
    _i1.DatabaseSession session,
    List<InstitutionMembership> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<InstitutionMembership>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [InstitutionMembership] and returns the inserted row.
  ///
  /// The returned [InstitutionMembership] will have its `id` field set.
  Future<InstitutionMembership> insertRow(
    _i1.DatabaseSession session,
    InstitutionMembership row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InstitutionMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InstitutionMembership]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InstitutionMembership>> update(
    _i1.DatabaseSession session,
    List<InstitutionMembership> rows, {
    _i1.ColumnSelections<InstitutionMembershipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InstitutionMembership>(
      rows,
      columns: columns?.call(InstitutionMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InstitutionMembership]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InstitutionMembership> updateRow(
    _i1.DatabaseSession session,
    InstitutionMembership row, {
    _i1.ColumnSelections<InstitutionMembershipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InstitutionMembership>(
      row,
      columns: columns?.call(InstitutionMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InstitutionMembership] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InstitutionMembership?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<InstitutionMembershipUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<InstitutionMembership>(
      id,
      columnValues: columnValues(InstitutionMembership.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InstitutionMembership]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<InstitutionMembership>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<InstitutionMembershipUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<InstitutionMembershipTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InstitutionMembershipTable>? orderBy,
    _i1.OrderByListBuilder<InstitutionMembershipTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<InstitutionMembership>(
      columnValues: columnValues(InstitutionMembership.t.updateTable),
      where: where(InstitutionMembership.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InstitutionMembership.t),
      orderByList: orderByList?.call(InstitutionMembership.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [InstitutionMembership]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InstitutionMembership>> delete(
    _i1.DatabaseSession session,
    List<InstitutionMembership> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InstitutionMembership>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InstitutionMembership].
  Future<InstitutionMembership> deleteRow(
    _i1.DatabaseSession session,
    InstitutionMembership row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InstitutionMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InstitutionMembership>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InstitutionMembershipTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InstitutionMembership>(
      where: where(InstitutionMembership.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InstitutionMembershipTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InstitutionMembership>(
      where: where?.call(InstitutionMembership.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InstitutionMembership] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InstitutionMembershipTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InstitutionMembership>(
      where: where(InstitutionMembership.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
