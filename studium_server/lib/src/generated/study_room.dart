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

abstract class StudyRoom
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StudyRoom._({
    this.id,
    this.institutionId,
    required this.ownerId,
    required this.title,
    required this.description,
    this.subject,
    required this.visibility,
    required this.membershipPolicy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudyRoom({
    int? id,
    int? institutionId,
    required int ownerId,
    required String title,
    required String description,
    String? subject,
    required String visibility,
    required String membershipPolicy,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StudyRoomImpl;

  factory StudyRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyRoom(
      id: jsonSerialization['id'] as int?,
      institutionId: jsonSerialization['institutionId'] as int?,
      ownerId: jsonSerialization['ownerId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      subject: jsonSerialization['subject'] as String?,
      visibility: jsonSerialization['visibility'] as String,
      membershipPolicy: jsonSerialization['membershipPolicy'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = StudyRoomTable();

  static const db = StudyRoomRepository._();

  @override
  int? id;

  int? institutionId;

  int ownerId;

  String title;

  String description;

  String? subject;

  String visibility;

  String membershipPolicy;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudyRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudyRoom copyWith({
    int? id,
    int? institutionId,
    int? ownerId,
    String? title,
    String? description,
    String? subject,
    String? visibility,
    String? membershipPolicy,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyRoom',
      if (id != null) 'id': id,
      if (institutionId != null) 'institutionId': institutionId,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      if (subject != null) 'subject': subject,
      'visibility': visibility,
      'membershipPolicy': membershipPolicy,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyRoom',
      if (id != null) 'id': id,
      if (institutionId != null) 'institutionId': institutionId,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      if (subject != null) 'subject': subject,
      'visibility': visibility,
      'membershipPolicy': membershipPolicy,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static StudyRoomInclude include() {
    return StudyRoomInclude._();
  }

  static StudyRoomIncludeList includeList({
    _i1.WhereExpressionBuilder<StudyRoomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudyRoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudyRoomTable>? orderByList,
    StudyRoomInclude? include,
  }) {
    return StudyRoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyRoom.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StudyRoom.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyRoomImpl extends StudyRoom {
  _StudyRoomImpl({
    int? id,
    int? institutionId,
    required int ownerId,
    required String title,
    required String description,
    String? subject,
    required String visibility,
    required String membershipPolicy,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          institutionId: institutionId,
          ownerId: ownerId,
          title: title,
          description: description,
          subject: subject,
          visibility: visibility,
          membershipPolicy: membershipPolicy,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [StudyRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudyRoom copyWith({
    Object? id = _Undefined,
    Object? institutionId = _Undefined,
    int? ownerId,
    String? title,
    String? description,
    Object? subject = _Undefined,
    String? visibility,
    String? membershipPolicy,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudyRoom(
      id: id is int? ? id : this.id,
      institutionId: institutionId is int? ? institutionId : this.institutionId,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      description: description ?? this.description,
      subject: subject is String? ? subject : this.subject,
      visibility: visibility ?? this.visibility,
      membershipPolicy: membershipPolicy ?? this.membershipPolicy,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class StudyRoomUpdateTable extends _i1.UpdateTable<StudyRoomTable> {
  StudyRoomUpdateTable(super.table);

  _i1.ColumnValue<int, int> institutionId(int? value) => _i1.ColumnValue(
        table.institutionId,
        value,
      );

  _i1.ColumnValue<int, int> ownerId(int value) => _i1.ColumnValue(
        table.ownerId,
        value,
      );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
        table.title,
        value,
      );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
        table.description,
        value,
      );

  _i1.ColumnValue<String, String> subject(String? value) => _i1.ColumnValue(
        table.subject,
        value,
      );

  _i1.ColumnValue<String, String> visibility(String value) => _i1.ColumnValue(
        table.visibility,
        value,
      );

  _i1.ColumnValue<String, String> membershipPolicy(String value) =>
      _i1.ColumnValue(
        table.membershipPolicy,
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

class StudyRoomTable extends _i1.Table<int?> {
  StudyRoomTable({super.tableRelation}) : super(tableName: 'study_rooms') {
    updateTable = StudyRoomUpdateTable(this);
    institutionId = _i1.ColumnInt(
      'institutionId',
      this,
    );
    ownerId = _i1.ColumnInt(
      'ownerId',
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
    subject = _i1.ColumnString(
      'subject',
      this,
    );
    visibility = _i1.ColumnString(
      'visibility',
      this,
    );
    membershipPolicy = _i1.ColumnString(
      'membershipPolicy',
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

  late final StudyRoomUpdateTable updateTable;

  late final _i1.ColumnInt institutionId;

  late final _i1.ColumnInt ownerId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnString subject;

  late final _i1.ColumnString visibility;

  late final _i1.ColumnString membershipPolicy;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        institutionId,
        ownerId,
        title,
        description,
        subject,
        visibility,
        membershipPolicy,
        status,
        createdAt,
        updatedAt,
      ];
}

class StudyRoomInclude extends _i1.IncludeObject {
  StudyRoomInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StudyRoom.t;
}

class StudyRoomIncludeList extends _i1.IncludeList {
  StudyRoomIncludeList._({
    _i1.WhereExpressionBuilder<StudyRoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudyRoom.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StudyRoom.t;
}

class StudyRoomRepository {
  const StudyRoomRepository._();

  /// Returns a list of [StudyRoom]s matching the given query parameters.
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
  Future<List<StudyRoom>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudyRoomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudyRoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudyRoomTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudyRoom>(
      where: where?.call(StudyRoom.t),
      orderBy: orderBy?.call(StudyRoom.t),
      orderByList: orderByList?.call(StudyRoom.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudyRoom] matching the given query parameters.
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
  Future<StudyRoom?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudyRoomTable>? where,
    int? offset,
    _i1.OrderByBuilder<StudyRoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudyRoomTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudyRoom>(
      where: where?.call(StudyRoom.t),
      orderBy: orderBy?.call(StudyRoom.t),
      orderByList: orderByList?.call(StudyRoom.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudyRoom] by its [id] or null if no such row exists.
  Future<StudyRoom?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudyRoom>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudyRoom]s in the list and returns the inserted rows.
  ///
  /// The returned [StudyRoom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StudyRoom>> insert(
    _i1.DatabaseSession session,
    List<StudyRoom> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StudyRoom>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StudyRoom] and returns the inserted row.
  ///
  /// The returned [StudyRoom] will have its `id` field set.
  Future<StudyRoom> insertRow(
    _i1.DatabaseSession session,
    StudyRoom row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudyRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StudyRoom]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StudyRoom>> update(
    _i1.DatabaseSession session,
    List<StudyRoom> rows, {
    _i1.ColumnSelections<StudyRoomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StudyRoom>(
      rows,
      columns: columns?.call(StudyRoom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudyRoom]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudyRoom> updateRow(
    _i1.DatabaseSession session,
    StudyRoom row, {
    _i1.ColumnSelections<StudyRoomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudyRoom>(
      row,
      columns: columns?.call(StudyRoom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudyRoom] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudyRoom?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<StudyRoomUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StudyRoom>(
      id,
      columnValues: columnValues(StudyRoom.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudyRoom]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StudyRoom>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StudyRoomUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StudyRoomTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudyRoomTable>? orderBy,
    _i1.OrderByListBuilder<StudyRoomTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StudyRoom>(
      columnValues: columnValues(StudyRoom.t.updateTable),
      where: where(StudyRoom.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyRoom.t),
      orderByList: orderByList?.call(StudyRoom.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StudyRoom]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StudyRoom>> delete(
    _i1.DatabaseSession session,
    List<StudyRoom> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StudyRoom>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StudyRoom].
  Future<StudyRoom> deleteRow(
    _i1.DatabaseSession session,
    StudyRoom row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudyRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StudyRoom>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudyRoomTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StudyRoom>(
      where: where(StudyRoom.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudyRoomTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StudyRoom>(
      where: where?.call(StudyRoom.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudyRoom] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudyRoomTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudyRoom>(
      where: where(StudyRoom.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
