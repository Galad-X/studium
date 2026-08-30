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

abstract class RoomMembership
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RoomMembership._({
    this.id,
    required this.roomId,
    required this.userId,
    required this.role,
    required this.status,
    required this.joinedAt,
  });

  factory RoomMembership({
    int? id,
    required int roomId,
    required int userId,
    required String role,
    required String status,
    required DateTime joinedAt,
  }) = _RoomMembershipImpl;

  factory RoomMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomMembership(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as int,
      role: jsonSerialization['role'] as String,
      status: jsonSerialization['status'] as String,
      joinedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  static final t = RoomMembershipTable();

  static const db = RoomMembershipRepository._();

  @override
  int? id;

  int roomId;

  int userId;

  String role;

  String status;

  DateTime joinedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoomMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoomMembership copyWith({
    int? id,
    int? roomId,
    int? userId,
    String? role,
    String? status,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomMembership',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'role': role,
      'status': status,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomMembership',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'role': role,
      'status': status,
      'joinedAt': joinedAt.toJson(),
    };
  }

  static RoomMembershipInclude include() {
    return RoomMembershipInclude._();
  }

  static RoomMembershipIncludeList includeList({
    _i1.WhereExpressionBuilder<RoomMembershipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomMembershipTable>? orderByList,
    RoomMembershipInclude? include,
  }) {
    return RoomMembershipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomMembership.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoomMembership.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomMembershipImpl extends RoomMembership {
  _RoomMembershipImpl({
    int? id,
    required int roomId,
    required int userId,
    required String role,
    required String status,
    required DateTime joinedAt,
  }) : super._(
          id: id,
          roomId: roomId,
          userId: userId,
          role: role,
          status: status,
          joinedAt: joinedAt,
        );

  /// Returns a shallow copy of this [RoomMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoomMembership copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? userId,
    String? role,
    String? status,
    DateTime? joinedAt,
  }) {
    return RoomMembership(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class RoomMembershipUpdateTable extends _i1.UpdateTable<RoomMembershipTable> {
  RoomMembershipUpdateTable(super.table);

  _i1.ColumnValue<int, int> roomId(int value) => _i1.ColumnValue(
        table.roomId,
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

class RoomMembershipTable extends _i1.Table<int?> {
  RoomMembershipTable({super.tableRelation})
      : super(tableName: 'room_memberships') {
    updateTable = RoomMembershipUpdateTable(this);
    roomId = _i1.ColumnInt(
      'roomId',
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

  late final RoomMembershipUpdateTable updateTable;

  late final _i1.ColumnInt roomId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString role;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime joinedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        roomId,
        userId,
        role,
        status,
        joinedAt,
      ];
}

class RoomMembershipInclude extends _i1.IncludeObject {
  RoomMembershipInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RoomMembership.t;
}

class RoomMembershipIncludeList extends _i1.IncludeList {
  RoomMembershipIncludeList._({
    _i1.WhereExpressionBuilder<RoomMembershipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomMembership.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RoomMembership.t;
}

class RoomMembershipRepository {
  const RoomMembershipRepository._();

  /// Returns a list of [RoomMembership]s matching the given query parameters.
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
  Future<List<RoomMembership>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomMembershipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomMembershipTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoomMembership>(
      where: where?.call(RoomMembership.t),
      orderBy: orderBy?.call(RoomMembership.t),
      orderByList: orderByList?.call(RoomMembership.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoomMembership] matching the given query parameters.
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
  Future<RoomMembership?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomMembershipTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoomMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomMembershipTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoomMembership>(
      where: where?.call(RoomMembership.t),
      orderBy: orderBy?.call(RoomMembership.t),
      orderByList: orderByList?.call(RoomMembership.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoomMembership] by its [id] or null if no such row exists.
  Future<RoomMembership?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoomMembership>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoomMembership]s in the list and returns the inserted rows.
  ///
  /// The returned [RoomMembership]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RoomMembership>> insert(
    _i1.DatabaseSession session,
    List<RoomMembership> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RoomMembership>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RoomMembership] and returns the inserted row.
  ///
  /// The returned [RoomMembership] will have its `id` field set.
  Future<RoomMembership> insertRow(
    _i1.DatabaseSession session,
    RoomMembership row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RoomMembership]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RoomMembership>> update(
    _i1.DatabaseSession session,
    List<RoomMembership> rows, {
    _i1.ColumnSelections<RoomMembershipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RoomMembership>(
      rows,
      columns: columns?.call(RoomMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomMembership]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoomMembership> updateRow(
    _i1.DatabaseSession session,
    RoomMembership row, {
    _i1.ColumnSelections<RoomMembershipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoomMembership>(
      row,
      columns: columns?.call(RoomMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomMembership] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoomMembership?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RoomMembershipUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RoomMembership>(
      id,
      columnValues: columnValues(RoomMembership.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoomMembership]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RoomMembership>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RoomMembershipUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RoomMembershipTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomMembershipTable>? orderBy,
    _i1.OrderByListBuilder<RoomMembershipTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RoomMembership>(
      columnValues: columnValues(RoomMembership.t.updateTable),
      where: where(RoomMembership.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomMembership.t),
      orderByList: orderByList?.call(RoomMembership.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RoomMembership]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RoomMembership>> delete(
    _i1.DatabaseSession session,
    List<RoomMembership> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomMembership>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RoomMembership].
  Future<RoomMembership> deleteRow(
    _i1.DatabaseSession session,
    RoomMembership row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RoomMembership>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoomMembershipTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoomMembership>(
      where: where(RoomMembership.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomMembershipTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoomMembership>(
      where: where?.call(RoomMembership.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoomMembership] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoomMembershipTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoomMembership>(
      where: where(RoomMembership.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
