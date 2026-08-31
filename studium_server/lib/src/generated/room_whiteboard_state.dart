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

abstract class RoomWhiteboardState
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RoomWhiteboardState._({
    this.id,
    required this.roomId,
    int? version,
    required this.strokesJson,
    required this.updatedById,
    required this.updatedAt,
  }) : version = version ?? 0;

  factory RoomWhiteboardState({
    int? id,
    required int roomId,
    int? version,
    required String strokesJson,
    required int updatedById,
    required DateTime updatedAt,
  }) = _RoomWhiteboardStateImpl;

  factory RoomWhiteboardState.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomWhiteboardState(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      version: jsonSerialization['version'] as int?,
      strokesJson: jsonSerialization['strokesJson'] as String,
      updatedById: jsonSerialization['updatedById'] as int,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = RoomWhiteboardStateTable();

  static const db = RoomWhiteboardStateRepository._();

  @override
  int? id;

  int roomId;

  int version;

  String strokesJson;

  int updatedById;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoomWhiteboardState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoomWhiteboardState copyWith({
    int? id,
    int? roomId,
    int? version,
    String? strokesJson,
    int? updatedById,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomWhiteboardState',
      if (id != null) 'id': id,
      'roomId': roomId,
      'version': version,
      'strokesJson': strokesJson,
      'updatedById': updatedById,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomWhiteboardState',
      if (id != null) 'id': id,
      'roomId': roomId,
      'version': version,
      'strokesJson': strokesJson,
      'updatedById': updatedById,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static RoomWhiteboardStateInclude include() {
    return RoomWhiteboardStateInclude._();
  }

  static RoomWhiteboardStateIncludeList includeList({
    _i1.WhereExpressionBuilder<RoomWhiteboardStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomWhiteboardStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomWhiteboardStateTable>? orderByList,
    RoomWhiteboardStateInclude? include,
  }) {
    return RoomWhiteboardStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomWhiteboardState.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoomWhiteboardState.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomWhiteboardStateImpl extends RoomWhiteboardState {
  _RoomWhiteboardStateImpl({
    int? id,
    required int roomId,
    int? version,
    required String strokesJson,
    required int updatedById,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          roomId: roomId,
          version: version,
          strokesJson: strokesJson,
          updatedById: updatedById,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [RoomWhiteboardState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoomWhiteboardState copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? version,
    String? strokesJson,
    int? updatedById,
    DateTime? updatedAt,
  }) {
    return RoomWhiteboardState(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      version: version ?? this.version,
      strokesJson: strokesJson ?? this.strokesJson,
      updatedById: updatedById ?? this.updatedById,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class RoomWhiteboardStateUpdateTable
    extends _i1.UpdateTable<RoomWhiteboardStateTable> {
  RoomWhiteboardStateUpdateTable(super.table);

  _i1.ColumnValue<int, int> roomId(int value) => _i1.ColumnValue(
        table.roomId,
        value,
      );

  _i1.ColumnValue<int, int> version(int value) => _i1.ColumnValue(
        table.version,
        value,
      );

  _i1.ColumnValue<String, String> strokesJson(String value) => _i1.ColumnValue(
        table.strokesJson,
        value,
      );

  _i1.ColumnValue<int, int> updatedById(int value) => _i1.ColumnValue(
        table.updatedById,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class RoomWhiteboardStateTable extends _i1.Table<int?> {
  RoomWhiteboardStateTable({super.tableRelation})
      : super(tableName: 'room_whiteboard_states') {
    updateTable = RoomWhiteboardStateUpdateTable(this);
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
      hasDefault: true,
    );
    strokesJson = _i1.ColumnString(
      'strokesJson',
      this,
    );
    updatedById = _i1.ColumnInt(
      'updatedById',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final RoomWhiteboardStateUpdateTable updateTable;

  late final _i1.ColumnInt roomId;

  late final _i1.ColumnInt version;

  late final _i1.ColumnString strokesJson;

  late final _i1.ColumnInt updatedById;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        roomId,
        version,
        strokesJson,
        updatedById,
        updatedAt,
      ];
}

class RoomWhiteboardStateInclude extends _i1.IncludeObject {
  RoomWhiteboardStateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RoomWhiteboardState.t;
}

class RoomWhiteboardStateIncludeList extends _i1.IncludeList {
  RoomWhiteboardStateIncludeList._({
    _i1.WhereExpressionBuilder<RoomWhiteboardStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomWhiteboardState.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RoomWhiteboardState.t;
}

class RoomWhiteboardStateRepository {
  const RoomWhiteboardStateRepository._();

  /// Returns a list of [RoomWhiteboardState]s matching the given query parameters.
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
  Future<List<RoomWhiteboardState>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomWhiteboardStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomWhiteboardStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomWhiteboardStateTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoomWhiteboardState>(
      where: where?.call(RoomWhiteboardState.t),
      orderBy: orderBy?.call(RoomWhiteboardState.t),
      orderByList: orderByList?.call(RoomWhiteboardState.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoomWhiteboardState] matching the given query parameters.
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
  Future<RoomWhiteboardState?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomWhiteboardStateTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoomWhiteboardStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomWhiteboardStateTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoomWhiteboardState>(
      where: where?.call(RoomWhiteboardState.t),
      orderBy: orderBy?.call(RoomWhiteboardState.t),
      orderByList: orderByList?.call(RoomWhiteboardState.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoomWhiteboardState] by its [id] or null if no such row exists.
  Future<RoomWhiteboardState?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoomWhiteboardState>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoomWhiteboardState]s in the list and returns the inserted rows.
  ///
  /// The returned [RoomWhiteboardState]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RoomWhiteboardState>> insert(
    _i1.DatabaseSession session,
    List<RoomWhiteboardState> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RoomWhiteboardState>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RoomWhiteboardState] and returns the inserted row.
  ///
  /// The returned [RoomWhiteboardState] will have its `id` field set.
  Future<RoomWhiteboardState> insertRow(
    _i1.DatabaseSession session,
    RoomWhiteboardState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomWhiteboardState>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RoomWhiteboardState]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RoomWhiteboardState>> update(
    _i1.DatabaseSession session,
    List<RoomWhiteboardState> rows, {
    _i1.ColumnSelections<RoomWhiteboardStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RoomWhiteboardState>(
      rows,
      columns: columns?.call(RoomWhiteboardState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomWhiteboardState]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoomWhiteboardState> updateRow(
    _i1.DatabaseSession session,
    RoomWhiteboardState row, {
    _i1.ColumnSelections<RoomWhiteboardStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoomWhiteboardState>(
      row,
      columns: columns?.call(RoomWhiteboardState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomWhiteboardState] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoomWhiteboardState?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RoomWhiteboardStateUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RoomWhiteboardState>(
      id,
      columnValues: columnValues(RoomWhiteboardState.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoomWhiteboardState]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RoomWhiteboardState>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RoomWhiteboardStateUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<RoomWhiteboardStateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomWhiteboardStateTable>? orderBy,
    _i1.OrderByListBuilder<RoomWhiteboardStateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RoomWhiteboardState>(
      columnValues: columnValues(RoomWhiteboardState.t.updateTable),
      where: where(RoomWhiteboardState.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomWhiteboardState.t),
      orderByList: orderByList?.call(RoomWhiteboardState.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RoomWhiteboardState]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RoomWhiteboardState>> delete(
    _i1.DatabaseSession session,
    List<RoomWhiteboardState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomWhiteboardState>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RoomWhiteboardState].
  Future<RoomWhiteboardState> deleteRow(
    _i1.DatabaseSession session,
    RoomWhiteboardState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomWhiteboardState>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RoomWhiteboardState>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoomWhiteboardStateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoomWhiteboardState>(
      where: where(RoomWhiteboardState.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomWhiteboardStateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoomWhiteboardState>(
      where: where?.call(RoomWhiteboardState.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoomWhiteboardState] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoomWhiteboardStateTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoomWhiteboardState>(
      where: where(RoomWhiteboardState.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
