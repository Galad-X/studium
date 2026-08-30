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
import 'package:studium_server/src/generated/protocol.dart' as _i2;

abstract class OpportunityAlert
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OpportunityAlert._({
    this.id,
    required this.userId,
    this.country,
    this.field,
    this.educationLevel,
    required this.opportunityTypes,
    required this.deadlineWithinDays,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OpportunityAlert({
    int? id,
    required int userId,
    String? country,
    String? field,
    String? educationLevel,
    required List<String> opportunityTypes,
    required int deadlineWithinDays,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OpportunityAlertImpl;

  factory OpportunityAlert.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpportunityAlert(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      country: jsonSerialization['country'] as String?,
      field: jsonSerialization['field'] as String?,
      educationLevel: jsonSerialization['educationLevel'] as String?,
      opportunityTypes: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['opportunityTypes'],
      ),
      deadlineWithinDays: jsonSerialization['deadlineWithinDays'] as int,
      active: _i1.BoolJsonExtension.fromJson(jsonSerialization['active']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = OpportunityAlertTable();

  static const db = OpportunityAlertRepository._();

  @override
  int? id;

  int userId;

  String? country;

  String? field;

  String? educationLevel;

  List<String> opportunityTypes;

  int deadlineWithinDays;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OpportunityAlert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OpportunityAlert copyWith({
    int? id,
    int? userId,
    String? country,
    String? field,
    String? educationLevel,
    List<String>? opportunityTypes,
    int? deadlineWithinDays,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpportunityAlert',
      if (id != null) 'id': id,
      'userId': userId,
      if (country != null) 'country': country,
      if (field != null) 'field': field,
      if (educationLevel != null) 'educationLevel': educationLevel,
      'opportunityTypes': opportunityTypes.toJson(),
      'deadlineWithinDays': deadlineWithinDays,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OpportunityAlert',
      if (id != null) 'id': id,
      'userId': userId,
      if (country != null) 'country': country,
      if (field != null) 'field': field,
      if (educationLevel != null) 'educationLevel': educationLevel,
      'opportunityTypes': opportunityTypes.toJson(),
      'deadlineWithinDays': deadlineWithinDays,
      'active': active,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static OpportunityAlertInclude include() {
    return OpportunityAlertInclude._();
  }

  static OpportunityAlertIncludeList includeList({
    _i1.WhereExpressionBuilder<OpportunityAlertTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunityAlertTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunityAlertTable>? orderByList,
    OpportunityAlertInclude? include,
  }) {
    return OpportunityAlertIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OpportunityAlert.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OpportunityAlert.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OpportunityAlertImpl extends OpportunityAlert {
  _OpportunityAlertImpl({
    int? id,
    required int userId,
    String? country,
    String? field,
    String? educationLevel,
    required List<String> opportunityTypes,
    required int deadlineWithinDays,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          country: country,
          field: field,
          educationLevel: educationLevel,
          opportunityTypes: opportunityTypes,
          deadlineWithinDays: deadlineWithinDays,
          active: active,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [OpportunityAlert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OpportunityAlert copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? country = _Undefined,
    Object? field = _Undefined,
    Object? educationLevel = _Undefined,
    List<String>? opportunityTypes,
    int? deadlineWithinDays,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OpportunityAlert(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      country: country is String? ? country : this.country,
      field: field is String? ? field : this.field,
      educationLevel:
          educationLevel is String? ? educationLevel : this.educationLevel,
      opportunityTypes:
          opportunityTypes ?? this.opportunityTypes.map((e0) => e0).toList(),
      deadlineWithinDays: deadlineWithinDays ?? this.deadlineWithinDays,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OpportunityAlertUpdateTable
    extends _i1.UpdateTable<OpportunityAlertTable> {
  OpportunityAlertUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> country(String? value) => _i1.ColumnValue(
        table.country,
        value,
      );

  _i1.ColumnValue<String, String> field(String? value) => _i1.ColumnValue(
        table.field,
        value,
      );

  _i1.ColumnValue<String, String> educationLevel(String? value) =>
      _i1.ColumnValue(
        table.educationLevel,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> opportunityTypes(
    List<String> value,
  ) =>
      _i1.ColumnValue(
        table.opportunityTypes,
        value,
      );

  _i1.ColumnValue<int, int> deadlineWithinDays(int value) => _i1.ColumnValue(
        table.deadlineWithinDays,
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

class OpportunityAlertTable extends _i1.Table<int?> {
  OpportunityAlertTable({super.tableRelation})
      : super(tableName: 'opportunity_alerts') {
    updateTable = OpportunityAlertUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    country = _i1.ColumnString(
      'country',
      this,
    );
    field = _i1.ColumnString(
      'field',
      this,
    );
    educationLevel = _i1.ColumnString(
      'educationLevel',
      this,
    );
    opportunityTypes = _i1.ColumnSerializable<List<String>>(
      'opportunityTypes',
      this,
    );
    deadlineWithinDays = _i1.ColumnInt(
      'deadlineWithinDays',
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

  late final OpportunityAlertUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString country;

  late final _i1.ColumnString field;

  late final _i1.ColumnString educationLevel;

  late final _i1.ColumnSerializable<List<String>> opportunityTypes;

  late final _i1.ColumnInt deadlineWithinDays;

  late final _i1.ColumnBool active;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        country,
        field,
        educationLevel,
        opportunityTypes,
        deadlineWithinDays,
        active,
        createdAt,
        updatedAt,
      ];
}

class OpportunityAlertInclude extends _i1.IncludeObject {
  OpportunityAlertInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OpportunityAlert.t;
}

class OpportunityAlertIncludeList extends _i1.IncludeList {
  OpportunityAlertIncludeList._({
    _i1.WhereExpressionBuilder<OpportunityAlertTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OpportunityAlert.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OpportunityAlert.t;
}

class OpportunityAlertRepository {
  const OpportunityAlertRepository._();

  /// Returns a list of [OpportunityAlert]s matching the given query parameters.
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
  Future<List<OpportunityAlert>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunityAlertTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunityAlertTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunityAlertTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OpportunityAlert>(
      where: where?.call(OpportunityAlert.t),
      orderBy: orderBy?.call(OpportunityAlert.t),
      orderByList: orderByList?.call(OpportunityAlert.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OpportunityAlert] matching the given query parameters.
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
  Future<OpportunityAlert?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunityAlertTable>? where,
    int? offset,
    _i1.OrderByBuilder<OpportunityAlertTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunityAlertTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OpportunityAlert>(
      where: where?.call(OpportunityAlert.t),
      orderBy: orderBy?.call(OpportunityAlert.t),
      orderByList: orderByList?.call(OpportunityAlert.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OpportunityAlert] by its [id] or null if no such row exists.
  Future<OpportunityAlert?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OpportunityAlert>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OpportunityAlert]s in the list and returns the inserted rows.
  ///
  /// The returned [OpportunityAlert]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OpportunityAlert>> insert(
    _i1.DatabaseSession session,
    List<OpportunityAlert> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OpportunityAlert>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OpportunityAlert] and returns the inserted row.
  ///
  /// The returned [OpportunityAlert] will have its `id` field set.
  Future<OpportunityAlert> insertRow(
    _i1.DatabaseSession session,
    OpportunityAlert row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OpportunityAlert>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OpportunityAlert]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OpportunityAlert>> update(
    _i1.DatabaseSession session,
    List<OpportunityAlert> rows, {
    _i1.ColumnSelections<OpportunityAlertTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OpportunityAlert>(
      rows,
      columns: columns?.call(OpportunityAlert.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OpportunityAlert]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OpportunityAlert> updateRow(
    _i1.DatabaseSession session,
    OpportunityAlert row, {
    _i1.ColumnSelections<OpportunityAlertTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OpportunityAlert>(
      row,
      columns: columns?.call(OpportunityAlert.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OpportunityAlert] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OpportunityAlert?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OpportunityAlertUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OpportunityAlert>(
      id,
      columnValues: columnValues(OpportunityAlert.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OpportunityAlert]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OpportunityAlert>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OpportunityAlertUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<OpportunityAlertTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunityAlertTable>? orderBy,
    _i1.OrderByListBuilder<OpportunityAlertTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OpportunityAlert>(
      columnValues: columnValues(OpportunityAlert.t.updateTable),
      where: where(OpportunityAlert.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OpportunityAlert.t),
      orderByList: orderByList?.call(OpportunityAlert.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OpportunityAlert]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OpportunityAlert>> delete(
    _i1.DatabaseSession session,
    List<OpportunityAlert> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OpportunityAlert>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OpportunityAlert].
  Future<OpportunityAlert> deleteRow(
    _i1.DatabaseSession session,
    OpportunityAlert row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OpportunityAlert>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OpportunityAlert>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OpportunityAlertTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OpportunityAlert>(
      where: where(OpportunityAlert.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunityAlertTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OpportunityAlert>(
      where: where?.call(OpportunityAlert.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OpportunityAlert] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OpportunityAlertTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OpportunityAlert>(
      where: where(OpportunityAlert.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
