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

abstract class PushDevice
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PushDevice._({
    this.id,
    required this.userId,
    required this.token,
    required this.platform,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PushDevice({
    int? id,
    required int userId,
    required String token,
    required String platform,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PushDeviceImpl;

  factory PushDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return PushDevice(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      token: jsonSerialization['token'] as String,
      platform: jsonSerialization['platform'] as String,
      active: _i1.BoolJsonExtension.fromJson(jsonSerialization['active']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = PushDeviceTable();

  static const db = PushDeviceRepository._();

  @override
  int? id;

  int userId;

  String token;

  String platform;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PushDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PushDevice copyWith({
    int? id,
    int? userId,
    String? token,
    String? platform,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PushDevice',
      if (id != null) 'id': id,
      'userId': userId,
      'token': token,
      'platform': platform,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PushDevice',
      if (id != null) 'id': id,
      'userId': userId,
      'token': token,
      'platform': platform,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PushDeviceInclude include() {
    return PushDeviceInclude._();
  }

  static PushDeviceIncludeList includeList({
    _i1.WhereExpressionBuilder<PushDeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PushDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PushDeviceTable>? orderByList,
    PushDeviceInclude? include,
  }) {
    return PushDeviceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PushDevice.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PushDevice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PushDeviceImpl extends PushDevice {
  _PushDeviceImpl({
    int? id,
    required int userId,
    required String token,
    required String platform,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          token: token,
          platform: platform,
          active: active,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [PushDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PushDevice copyWith({
    Object? id = _Undefined,
    int? userId,
    String? token,
    String? platform,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PushDevice(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      platform: platform ?? this.platform,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PushDeviceUpdateTable extends _i1.UpdateTable<PushDeviceTable> {
  PushDeviceUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> token(String value) => _i1.ColumnValue(
        table.token,
        value,
      );

  _i1.ColumnValue<String, String> platform(String value) => _i1.ColumnValue(
        table.platform,
        value,
      );

  _i1.ColumnValue<bool, bool> active(bool value) => _i1.ColumnValue(
        table.active,
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

class PushDeviceTable extends _i1.Table<int?> {
  PushDeviceTable({super.tableRelation}) : super(tableName: 'push_devices') {
    updateTable = PushDeviceUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    token = _i1.ColumnString(
      'token',
      this,
    );
    platform = _i1.ColumnString(
      'platform',
      this,
    );
    active = _i1.ColumnBool(
      'active',
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

  late final PushDeviceUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString token;

  late final _i1.ColumnString platform;

  late final _i1.ColumnBool active;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        token,
        platform,
        active,
        createdAt,
        updatedAt,
      ];
}

class PushDeviceInclude extends _i1.IncludeObject {
  PushDeviceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PushDevice.t;
}

class PushDeviceIncludeList extends _i1.IncludeList {
  PushDeviceIncludeList._({
    _i1.WhereExpressionBuilder<PushDeviceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PushDevice.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PushDevice.t;
}

class PushDeviceRepository {
  const PushDeviceRepository._();

  /// Returns a list of [PushDevice]s matching the given query parameters.
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
  Future<List<PushDevice>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PushDeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PushDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PushDeviceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PushDevice>(
      where: where?.call(PushDevice.t),
      orderBy: orderBy?.call(PushDevice.t),
      orderByList: orderByList?.call(PushDevice.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PushDevice] matching the given query parameters.
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
  Future<PushDevice?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PushDeviceTable>? where,
    int? offset,
    _i1.OrderByBuilder<PushDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PushDeviceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PushDevice>(
      where: where?.call(PushDevice.t),
      orderBy: orderBy?.call(PushDevice.t),
      orderByList: orderByList?.call(PushDevice.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PushDevice] by its [id] or null if no such row exists.
  Future<PushDevice?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PushDevice>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PushDevice]s in the list and returns the inserted rows.
  ///
  /// The returned [PushDevice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PushDevice>> insert(
    _i1.DatabaseSession session,
    List<PushDevice> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PushDevice>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PushDevice] and returns the inserted row.
  ///
  /// The returned [PushDevice] will have its `id` field set.
  Future<PushDevice> insertRow(
    _i1.DatabaseSession session,
    PushDevice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PushDevice>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PushDevice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PushDevice>> update(
    _i1.DatabaseSession session,
    List<PushDevice> rows, {
    _i1.ColumnSelections<PushDeviceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PushDevice>(
      rows,
      columns: columns?.call(PushDevice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PushDevice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PushDevice> updateRow(
    _i1.DatabaseSession session,
    PushDevice row, {
    _i1.ColumnSelections<PushDeviceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PushDevice>(
      row,
      columns: columns?.call(PushDevice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PushDevice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PushDevice?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PushDeviceUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PushDevice>(
      id,
      columnValues: columnValues(PushDevice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PushDevice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PushDevice>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PushDeviceUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PushDeviceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PushDeviceTable>? orderBy,
    _i1.OrderByListBuilder<PushDeviceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PushDevice>(
      columnValues: columnValues(PushDevice.t.updateTable),
      where: where(PushDevice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PushDevice.t),
      orderByList: orderByList?.call(PushDevice.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PushDevice]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PushDevice>> delete(
    _i1.DatabaseSession session,
    List<PushDevice> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PushDevice>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PushDevice].
  Future<PushDevice> deleteRow(
    _i1.DatabaseSession session,
    PushDevice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PushDevice>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PushDevice>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PushDeviceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PushDevice>(
      where: where(PushDevice.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PushDeviceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PushDevice>(
      where: where?.call(PushDevice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PushDevice] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PushDeviceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PushDevice>(
      where: where(PushDevice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
