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

abstract class ScheduledStudySession
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ScheduledStudySession._({
    this.id,
    required this.roomId,
    required this.organizerId,
    required this.title,
    this.description,
    required this.startsAt,
    required this.endsAt,
    this.meetingUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduledStudySession({
    int? id,
    required int roomId,
    required int organizerId,
    required String title,
    String? description,
    required DateTime startsAt,
    required DateTime endsAt,
    String? meetingUrl,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ScheduledStudySessionImpl;

  factory ScheduledStudySession.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScheduledStudySession(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      organizerId: jsonSerialization['organizerId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      meetingUrl: jsonSerialization['meetingUrl'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ScheduledStudySessionTable();

  static const db = ScheduledStudySessionRepository._();

  @override
  int? id;

  int roomId;

  int organizerId;

  String title;

  String? description;

  DateTime startsAt;

  DateTime endsAt;

  String? meetingUrl;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ScheduledStudySession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledStudySession copyWith({
    int? id,
    int? roomId,
    int? organizerId,
    String? title,
    String? description,
    DateTime? startsAt,
    DateTime? endsAt,
    String? meetingUrl,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScheduledStudySession',
      if (id != null) 'id': id,
      'roomId': roomId,
      'organizerId': organizerId,
      'title': title,
      if (description != null) 'description': description,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      if (meetingUrl != null) 'meetingUrl': meetingUrl,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScheduledStudySession',
      if (id != null) 'id': id,
      'roomId': roomId,
      'organizerId': organizerId,
      'title': title,
      if (description != null) 'description': description,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      if (meetingUrl != null) 'meetingUrl': meetingUrl,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ScheduledStudySessionInclude include() {
    return ScheduledStudySessionInclude._();
  }

  static ScheduledStudySessionIncludeList includeList({
    _i1.WhereExpressionBuilder<ScheduledStudySessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledStudySessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledStudySessionTable>? orderByList,
    ScheduledStudySessionInclude? include,
  }) {
    return ScheduledStudySessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduledStudySession.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScheduledStudySession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduledStudySessionImpl extends ScheduledStudySession {
  _ScheduledStudySessionImpl({
    int? id,
    required int roomId,
    required int organizerId,
    required String title,
    String? description,
    required DateTime startsAt,
    required DateTime endsAt,
    String? meetingUrl,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          roomId: roomId,
          organizerId: organizerId,
          title: title,
          description: description,
          startsAt: startsAt,
          endsAt: endsAt,
          meetingUrl: meetingUrl,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ScheduledStudySession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledStudySession copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? organizerId,
    String? title,
    Object? description = _Undefined,
    DateTime? startsAt,
    DateTime? endsAt,
    Object? meetingUrl = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScheduledStudySession(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      organizerId: organizerId ?? this.organizerId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      meetingUrl: meetingUrl is String? ? meetingUrl : this.meetingUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ScheduledStudySessionUpdateTable
    extends _i1.UpdateTable<ScheduledStudySessionTable> {
  ScheduledStudySessionUpdateTable(super.table);

  _i1.ColumnValue<int, int> roomId(int value) => _i1.ColumnValue(
        table.roomId,
        value,
      );

  _i1.ColumnValue<int, int> organizerId(int value) => _i1.ColumnValue(
        table.organizerId,
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

  _i1.ColumnValue<DateTime, DateTime> startsAt(DateTime value) =>
      _i1.ColumnValue(
        table.startsAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endsAt(DateTime value) => _i1.ColumnValue(
        table.endsAt,
        value,
      );

  _i1.ColumnValue<String, String> meetingUrl(String? value) => _i1.ColumnValue(
        table.meetingUrl,
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

class ScheduledStudySessionTable extends _i1.Table<int?> {
  ScheduledStudySessionTable({super.tableRelation})
      : super(tableName: 'scheduled_study_sessions') {
    updateTable = ScheduledStudySessionUpdateTable(this);
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    organizerId = _i1.ColumnInt(
      'organizerId',
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
    startsAt = _i1.ColumnDateTime(
      'startsAt',
      this,
    );
    endsAt = _i1.ColumnDateTime(
      'endsAt',
      this,
    );
    meetingUrl = _i1.ColumnString(
      'meetingUrl',
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

  late final ScheduledStudySessionUpdateTable updateTable;

  late final _i1.ColumnInt roomId;

  late final _i1.ColumnInt organizerId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime startsAt;

  late final _i1.ColumnDateTime endsAt;

  late final _i1.ColumnString meetingUrl;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        roomId,
        organizerId,
        title,
        description,
        startsAt,
        endsAt,
        meetingUrl,
        status,
        createdAt,
        updatedAt,
      ];
}

class ScheduledStudySessionInclude extends _i1.IncludeObject {
  ScheduledStudySessionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ScheduledStudySession.t;
}

class ScheduledStudySessionIncludeList extends _i1.IncludeList {
  ScheduledStudySessionIncludeList._({
    _i1.WhereExpressionBuilder<ScheduledStudySessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScheduledStudySession.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ScheduledStudySession.t;
}

class ScheduledStudySessionRepository {
  const ScheduledStudySessionRepository._();

  /// Returns a list of [ScheduledStudySession]s matching the given query parameters.
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
  Future<List<ScheduledStudySession>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScheduledStudySessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledStudySessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledStudySessionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ScheduledStudySession>(
      where: where?.call(ScheduledStudySession.t),
      orderBy: orderBy?.call(ScheduledStudySession.t),
      orderByList: orderByList?.call(ScheduledStudySession.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ScheduledStudySession] matching the given query parameters.
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
  Future<ScheduledStudySession?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScheduledStudySessionTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScheduledStudySessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledStudySessionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ScheduledStudySession>(
      where: where?.call(ScheduledStudySession.t),
      orderBy: orderBy?.call(ScheduledStudySession.t),
      orderByList: orderByList?.call(ScheduledStudySession.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ScheduledStudySession] by its [id] or null if no such row exists.
  Future<ScheduledStudySession?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ScheduledStudySession>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ScheduledStudySession]s in the list and returns the inserted rows.
  ///
  /// The returned [ScheduledStudySession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ScheduledStudySession>> insert(
    _i1.DatabaseSession session,
    List<ScheduledStudySession> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ScheduledStudySession>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ScheduledStudySession] and returns the inserted row.
  ///
  /// The returned [ScheduledStudySession] will have its `id` field set.
  Future<ScheduledStudySession> insertRow(
    _i1.DatabaseSession session,
    ScheduledStudySession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScheduledStudySession>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScheduledStudySession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScheduledStudySession>> update(
    _i1.DatabaseSession session,
    List<ScheduledStudySession> rows, {
    _i1.ColumnSelections<ScheduledStudySessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScheduledStudySession>(
      rows,
      columns: columns?.call(ScheduledStudySession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduledStudySession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScheduledStudySession> updateRow(
    _i1.DatabaseSession session,
    ScheduledStudySession row, {
    _i1.ColumnSelections<ScheduledStudySessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScheduledStudySession>(
      row,
      columns: columns?.call(ScheduledStudySession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduledStudySession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ScheduledStudySession?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ScheduledStudySessionUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ScheduledStudySession>(
      id,
      columnValues: columnValues(ScheduledStudySession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ScheduledStudySession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ScheduledStudySession>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ScheduledStudySessionUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<ScheduledStudySessionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledStudySessionTable>? orderBy,
    _i1.OrderByListBuilder<ScheduledStudySessionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ScheduledStudySession>(
      columnValues: columnValues(ScheduledStudySession.t.updateTable),
      where: where(ScheduledStudySession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduledStudySession.t),
      orderByList: orderByList?.call(ScheduledStudySession.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ScheduledStudySession]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScheduledStudySession>> delete(
    _i1.DatabaseSession session,
    List<ScheduledStudySession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScheduledStudySession>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScheduledStudySession].
  Future<ScheduledStudySession> deleteRow(
    _i1.DatabaseSession session,
    ScheduledStudySession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScheduledStudySession>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScheduledStudySession>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ScheduledStudySessionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScheduledStudySession>(
      where: where(ScheduledStudySession.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScheduledStudySessionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScheduledStudySession>(
      where: where?.call(ScheduledStudySession.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ScheduledStudySession] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ScheduledStudySessionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ScheduledStudySession>(
      where: where(ScheduledStudySession.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
