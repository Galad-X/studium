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

abstract class Challenge
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Challenge._({
    this.id,
    this.roomId,
    required this.ownerId,
    required this.title,
    required this.problemStatement,
    required this.field,
    required this.tags,
    required this.difficulty,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Challenge({
    int? id,
    int? roomId,
    required int ownerId,
    required String title,
    required String problemStatement,
    required String field,
    required List<String> tags,
    required String difficulty,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChallengeImpl;

  factory Challenge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Challenge(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int?,
      ownerId: jsonSerialization['ownerId'] as int,
      title: jsonSerialization['title'] as String,
      problemStatement: jsonSerialization['problemStatement'] as String,
      field: jsonSerialization['field'] as String,
      tags: _i2.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      difficulty: jsonSerialization['difficulty'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ChallengeTable();

  static const db = ChallengeRepository._();

  @override
  int? id;

  int? roomId;

  int ownerId;

  String title;

  String problemStatement;

  String field;

  List<String> tags;

  String difficulty;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Challenge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Challenge copyWith({
    int? id,
    int? roomId,
    int? ownerId,
    String? title,
    String? problemStatement,
    String? field,
    List<String>? tags,
    String? difficulty,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Challenge',
      if (id != null) 'id': id,
      if (roomId != null) 'roomId': roomId,
      'ownerId': ownerId,
      'title': title,
      'problemStatement': problemStatement,
      'field': field,
      'tags': tags.toJson(),
      'difficulty': difficulty,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Challenge',
      if (id != null) 'id': id,
      if (roomId != null) 'roomId': roomId,
      'ownerId': ownerId,
      'title': title,
      'problemStatement': problemStatement,
      'field': field,
      'tags': tags.toJson(),
      'difficulty': difficulty,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChallengeInclude include() {
    return ChallengeInclude._();
  }

  static ChallengeIncludeList includeList({
    _i1.WhereExpressionBuilder<ChallengeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTable>? orderByList,
    ChallengeInclude? include,
  }) {
    return ChallengeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Challenge.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Challenge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeImpl extends Challenge {
  _ChallengeImpl({
    int? id,
    int? roomId,
    required int ownerId,
    required String title,
    required String problemStatement,
    required String field,
    required List<String> tags,
    required String difficulty,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         roomId: roomId,
         ownerId: ownerId,
         title: title,
         problemStatement: problemStatement,
         field: field,
         tags: tags,
         difficulty: difficulty,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Challenge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Challenge copyWith({
    Object? id = _Undefined,
    Object? roomId = _Undefined,
    int? ownerId,
    String? title,
    String? problemStatement,
    String? field,
    List<String>? tags,
    String? difficulty,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Challenge(
      id: id is int? ? id : this.id,
      roomId: roomId is int? ? roomId : this.roomId,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      problemStatement: problemStatement ?? this.problemStatement,
      field: field ?? this.field,
      tags: tags ?? this.tags.map((e0) => e0).toList(),
      difficulty: difficulty ?? this.difficulty,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChallengeUpdateTable extends _i1.UpdateTable<ChallengeTable> {
  ChallengeUpdateTable(super.table);

  _i1.ColumnValue<int, int> roomId(int? value) => _i1.ColumnValue(
    table.roomId,
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

  _i1.ColumnValue<String, String> problemStatement(String value) =>
      _i1.ColumnValue(
        table.problemStatement,
        value,
      );

  _i1.ColumnValue<String, String> field(String value) => _i1.ColumnValue(
    table.field,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> tags(List<String> value) =>
      _i1.ColumnValue(
        table.tags,
        value,
      );

  _i1.ColumnValue<String, String> difficulty(String value) => _i1.ColumnValue(
    table.difficulty,
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

class ChallengeTable extends _i1.Table<int?> {
  ChallengeTable({super.tableRelation}) : super(tableName: 'challenges') {
    updateTable = ChallengeUpdateTable(this);
    roomId = _i1.ColumnInt(
      'roomId',
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
    problemStatement = _i1.ColumnString(
      'problemStatement',
      this,
    );
    field = _i1.ColumnString(
      'field',
      this,
    );
    tags = _i1.ColumnSerializable<List<String>>(
      'tags',
      this,
    );
    difficulty = _i1.ColumnString(
      'difficulty',
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

  late final ChallengeUpdateTable updateTable;

  late final _i1.ColumnInt roomId;

  late final _i1.ColumnInt ownerId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString problemStatement;

  late final _i1.ColumnString field;

  late final _i1.ColumnSerializable<List<String>> tags;

  late final _i1.ColumnString difficulty;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    roomId,
    ownerId,
    title,
    problemStatement,
    field,
    tags,
    difficulty,
    status,
    createdAt,
    updatedAt,
  ];
}

class ChallengeInclude extends _i1.IncludeObject {
  ChallengeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Challenge.t;
}

class ChallengeIncludeList extends _i1.IncludeList {
  ChallengeIncludeList._({
    _i1.WhereExpressionBuilder<ChallengeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Challenge.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Challenge.t;
}

class ChallengeRepository {
  const ChallengeRepository._();

  /// Returns a list of [Challenge]s matching the given query parameters.
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
  Future<List<Challenge>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Challenge>(
      where: where?.call(Challenge.t),
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Challenge] matching the given query parameters.
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
  Future<Challenge?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChallengeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChallengeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Challenge>(
      where: where?.call(Challenge.t),
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Challenge] by its [id] or null if no such row exists.
  Future<Challenge?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Challenge>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Challenge]s in the list and returns the inserted rows.
  ///
  /// The returned [Challenge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Challenge>> insert(
    _i1.DatabaseSession session,
    List<Challenge> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Challenge>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Challenge] and returns the inserted row.
  ///
  /// The returned [Challenge] will have its `id` field set.
  Future<Challenge> insertRow(
    _i1.DatabaseSession session,
    Challenge row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Challenge>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Challenge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Challenge>> update(
    _i1.DatabaseSession session,
    List<Challenge> rows, {
    _i1.ColumnSelections<ChallengeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Challenge>(
      rows,
      columns: columns?.call(Challenge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Challenge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Challenge> updateRow(
    _i1.DatabaseSession session,
    Challenge row, {
    _i1.ColumnSelections<ChallengeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Challenge>(
      row,
      columns: columns?.call(Challenge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Challenge] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Challenge?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ChallengeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Challenge>(
      id,
      columnValues: columnValues(Challenge.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Challenge]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Challenge>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ChallengeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ChallengeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChallengeTable>? orderBy,
    _i1.OrderByListBuilder<ChallengeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Challenge>(
      columnValues: columnValues(Challenge.t.updateTable),
      where: where(Challenge.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Challenge.t),
      orderByList: orderByList?.call(Challenge.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Challenge]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Challenge>> delete(
    _i1.DatabaseSession session,
    List<Challenge> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Challenge>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Challenge].
  Future<Challenge> deleteRow(
    _i1.DatabaseSession session,
    Challenge row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Challenge>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Challenge>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Challenge>(
      where: where(Challenge.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChallengeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Challenge>(
      where: where?.call(Challenge.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Challenge] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChallengeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Challenge>(
      where: where(Challenge.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
