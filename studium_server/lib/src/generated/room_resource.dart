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

abstract class RoomResource
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RoomResource._({
    this.id,
    required this.roomId,
    required this.ownerId,
    required this.resourceType,
    required this.title,
    this.uri,
    this.content,
    this.citation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomResource({
    int? id,
    required int roomId,
    required int ownerId,
    required String resourceType,
    required String title,
    String? uri,
    String? content,
    String? citation,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RoomResourceImpl;

  factory RoomResource.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomResource(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      ownerId: jsonSerialization['ownerId'] as int,
      resourceType: jsonSerialization['resourceType'] as String,
      title: jsonSerialization['title'] as String,
      uri: jsonSerialization['uri'] as String?,
      content: jsonSerialization['content'] as String?,
      citation: jsonSerialization['citation'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = RoomResourceTable();

  static const db = RoomResourceRepository._();

  @override
  int? id;

  int roomId;

  int ownerId;

  String resourceType;

  String title;

  String? uri;

  String? content;

  String? citation;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoomResource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoomResource copyWith({
    int? id,
    int? roomId,
    int? ownerId,
    String? resourceType,
    String? title,
    String? uri,
    String? content,
    String? citation,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomResource',
      if (id != null) 'id': id,
      'roomId': roomId,
      'ownerId': ownerId,
      'resourceType': resourceType,
      'title': title,
      if (uri != null) 'uri': uri,
      if (content != null) 'content': content,
      if (citation != null) 'citation': citation,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomResource',
      if (id != null) 'id': id,
      'roomId': roomId,
      'ownerId': ownerId,
      'resourceType': resourceType,
      'title': title,
      if (uri != null) 'uri': uri,
      if (content != null) 'content': content,
      if (citation != null) 'citation': citation,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static RoomResourceInclude include() {
    return RoomResourceInclude._();
  }

  static RoomResourceIncludeList includeList({
    _i1.WhereExpressionBuilder<RoomResourceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomResourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomResourceTable>? orderByList,
    RoomResourceInclude? include,
  }) {
    return RoomResourceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomResource.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoomResource.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomResourceImpl extends RoomResource {
  _RoomResourceImpl({
    int? id,
    required int roomId,
    required int ownerId,
    required String resourceType,
    required String title,
    String? uri,
    String? content,
    String? citation,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         roomId: roomId,
         ownerId: ownerId,
         resourceType: resourceType,
         title: title,
         uri: uri,
         content: content,
         citation: citation,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [RoomResource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoomResource copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? ownerId,
    String? resourceType,
    String? title,
    Object? uri = _Undefined,
    Object? content = _Undefined,
    Object? citation = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoomResource(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      ownerId: ownerId ?? this.ownerId,
      resourceType: resourceType ?? this.resourceType,
      title: title ?? this.title,
      uri: uri is String? ? uri : this.uri,
      content: content is String? ? content : this.content,
      citation: citation is String? ? citation : this.citation,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class RoomResourceUpdateTable extends _i1.UpdateTable<RoomResourceTable> {
  RoomResourceUpdateTable(super.table);

  _i1.ColumnValue<int, int> roomId(int value) => _i1.ColumnValue(
    table.roomId,
    value,
  );

  _i1.ColumnValue<int, int> ownerId(int value) => _i1.ColumnValue(
    table.ownerId,
    value,
  );

  _i1.ColumnValue<String, String> resourceType(String value) => _i1.ColumnValue(
    table.resourceType,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> uri(String? value) => _i1.ColumnValue(
    table.uri,
    value,
  );

  _i1.ColumnValue<String, String> content(String? value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<String, String> citation(String? value) => _i1.ColumnValue(
    table.citation,
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

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class RoomResourceTable extends _i1.Table<int?> {
  RoomResourceTable({super.tableRelation})
    : super(tableName: 'room_resources') {
    updateTable = RoomResourceUpdateTable(this);
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    ownerId = _i1.ColumnInt(
      'ownerId',
      this,
    );
    resourceType = _i1.ColumnString(
      'resourceType',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    uri = _i1.ColumnString(
      'uri',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    citation = _i1.ColumnString(
      'citation',
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
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final RoomResourceUpdateTable updateTable;

  late final _i1.ColumnInt roomId;

  late final _i1.ColumnInt ownerId;

  late final _i1.ColumnString resourceType;

  late final _i1.ColumnString title;

  late final _i1.ColumnString uri;

  late final _i1.ColumnString content;

  late final _i1.ColumnString citation;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    roomId,
    ownerId,
    resourceType,
    title,
    uri,
    content,
    citation,
    status,
    createdAt,
    updatedAt,
  ];
}

class RoomResourceInclude extends _i1.IncludeObject {
  RoomResourceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RoomResource.t;
}

class RoomResourceIncludeList extends _i1.IncludeList {
  RoomResourceIncludeList._({
    _i1.WhereExpressionBuilder<RoomResourceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomResource.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RoomResource.t;
}

class RoomResourceRepository {
  const RoomResourceRepository._();

  /// Returns a list of [RoomResource]s matching the given query parameters.
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
  Future<List<RoomResource>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomResourceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomResourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomResourceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoomResource>(
      where: where?.call(RoomResource.t),
      orderBy: orderBy?.call(RoomResource.t),
      orderByList: orderByList?.call(RoomResource.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoomResource] matching the given query parameters.
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
  Future<RoomResource?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomResourceTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoomResourceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomResourceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoomResource>(
      where: where?.call(RoomResource.t),
      orderBy: orderBy?.call(RoomResource.t),
      orderByList: orderByList?.call(RoomResource.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoomResource] by its [id] or null if no such row exists.
  Future<RoomResource?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoomResource>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoomResource]s in the list and returns the inserted rows.
  ///
  /// The returned [RoomResource]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RoomResource>> insert(
    _i1.DatabaseSession session,
    List<RoomResource> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RoomResource>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RoomResource] and returns the inserted row.
  ///
  /// The returned [RoomResource] will have its `id` field set.
  Future<RoomResource> insertRow(
    _i1.DatabaseSession session,
    RoomResource row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomResource>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RoomResource]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RoomResource>> update(
    _i1.DatabaseSession session,
    List<RoomResource> rows, {
    _i1.ColumnSelections<RoomResourceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RoomResource>(
      rows,
      columns: columns?.call(RoomResource.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomResource]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoomResource> updateRow(
    _i1.DatabaseSession session,
    RoomResource row, {
    _i1.ColumnSelections<RoomResourceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoomResource>(
      row,
      columns: columns?.call(RoomResource.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomResource] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoomResource?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RoomResourceUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RoomResource>(
      id,
      columnValues: columnValues(RoomResource.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoomResource]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RoomResource>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RoomResourceUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RoomResourceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomResourceTable>? orderBy,
    _i1.OrderByListBuilder<RoomResourceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RoomResource>(
      columnValues: columnValues(RoomResource.t.updateTable),
      where: where(RoomResource.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomResource.t),
      orderByList: orderByList?.call(RoomResource.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RoomResource]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RoomResource>> delete(
    _i1.DatabaseSession session,
    List<RoomResource> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomResource>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RoomResource].
  Future<RoomResource> deleteRow(
    _i1.DatabaseSession session,
    RoomResource row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomResource>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RoomResource>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoomResourceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoomResource>(
      where: where(RoomResource.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomResourceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoomResource>(
      where: where?.call(RoomResource.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoomResource] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoomResourceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoomResource>(
      where: where(RoomResource.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
