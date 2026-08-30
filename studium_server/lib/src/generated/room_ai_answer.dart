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

abstract class RoomAiAnswer
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RoomAiAnswer._({
    this.id,
    required this.roomId,
    required this.askerId,
    required this.question,
    required this.answer,
    required this.sourceResourceIds,
    required this.citations,
    required this.confidence,
    required this.createdAt,
  });

  factory RoomAiAnswer({
    int? id,
    required int roomId,
    required int askerId,
    required String question,
    required String answer,
    required List<int> sourceResourceIds,
    required List<String> citations,
    required String confidence,
    required DateTime createdAt,
  }) = _RoomAiAnswerImpl;

  factory RoomAiAnswer.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomAiAnswer(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      askerId: jsonSerialization['askerId'] as int,
      question: jsonSerialization['question'] as String,
      answer: jsonSerialization['answer'] as String,
      sourceResourceIds: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['sourceResourceIds'],
      ),
      citations: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['citations'],
      ),
      confidence: jsonSerialization['confidence'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = RoomAiAnswerTable();

  static const db = RoomAiAnswerRepository._();

  @override
  int? id;

  int roomId;

  int askerId;

  String question;

  String answer;

  List<int> sourceResourceIds;

  List<String> citations;

  String confidence;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RoomAiAnswer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoomAiAnswer copyWith({
    int? id,
    int? roomId,
    int? askerId,
    String? question,
    String? answer,
    List<int>? sourceResourceIds,
    List<String>? citations,
    String? confidence,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomAiAnswer',
      if (id != null) 'id': id,
      'roomId': roomId,
      'askerId': askerId,
      'question': question,
      'answer': answer,
      'sourceResourceIds': sourceResourceIds.toJson(),
      'citations': citations.toJson(),
      'confidence': confidence,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RoomAiAnswer',
      if (id != null) 'id': id,
      'roomId': roomId,
      'askerId': askerId,
      'question': question,
      'answer': answer,
      'sourceResourceIds': sourceResourceIds.toJson(),
      'citations': citations.toJson(),
      'confidence': confidence,
      'createdAt': createdAt.toJson(),
    };
  }

  static RoomAiAnswerInclude include() {
    return RoomAiAnswerInclude._();
  }

  static RoomAiAnswerIncludeList includeList({
    _i1.WhereExpressionBuilder<RoomAiAnswerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomAiAnswerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomAiAnswerTable>? orderByList,
    RoomAiAnswerInclude? include,
  }) {
    return RoomAiAnswerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomAiAnswer.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RoomAiAnswer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomAiAnswerImpl extends RoomAiAnswer {
  _RoomAiAnswerImpl({
    int? id,
    required int roomId,
    required int askerId,
    required String question,
    required String answer,
    required List<int> sourceResourceIds,
    required List<String> citations,
    required String confidence,
    required DateTime createdAt,
  }) : super._(
          id: id,
          roomId: roomId,
          askerId: askerId,
          question: question,
          answer: answer,
          sourceResourceIds: sourceResourceIds,
          citations: citations,
          confidence: confidence,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [RoomAiAnswer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoomAiAnswer copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? askerId,
    String? question,
    String? answer,
    List<int>? sourceResourceIds,
    List<String>? citations,
    String? confidence,
    DateTime? createdAt,
  }) {
    return RoomAiAnswer(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      askerId: askerId ?? this.askerId,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      sourceResourceIds:
          sourceResourceIds ?? this.sourceResourceIds.map((e0) => e0).toList(),
      citations: citations ?? this.citations.map((e0) => e0).toList(),
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RoomAiAnswerUpdateTable extends _i1.UpdateTable<RoomAiAnswerTable> {
  RoomAiAnswerUpdateTable(super.table);

  _i1.ColumnValue<int, int> roomId(int value) => _i1.ColumnValue(
        table.roomId,
        value,
      );

  _i1.ColumnValue<int, int> askerId(int value) => _i1.ColumnValue(
        table.askerId,
        value,
      );

  _i1.ColumnValue<String, String> question(String value) => _i1.ColumnValue(
        table.question,
        value,
      );

  _i1.ColumnValue<String, String> answer(String value) => _i1.ColumnValue(
        table.answer,
        value,
      );

  _i1.ColumnValue<List<int>, List<int>> sourceResourceIds(List<int> value) =>
      _i1.ColumnValue(
        table.sourceResourceIds,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> citations(List<String> value) =>
      _i1.ColumnValue(
        table.citations,
        value,
      );

  _i1.ColumnValue<String, String> confidence(String value) => _i1.ColumnValue(
        table.confidence,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class RoomAiAnswerTable extends _i1.Table<int?> {
  RoomAiAnswerTable({super.tableRelation})
      : super(tableName: 'room_ai_answers') {
    updateTable = RoomAiAnswerUpdateTable(this);
    roomId = _i1.ColumnInt(
      'roomId',
      this,
    );
    askerId = _i1.ColumnInt(
      'askerId',
      this,
    );
    question = _i1.ColumnString(
      'question',
      this,
    );
    answer = _i1.ColumnString(
      'answer',
      this,
    );
    sourceResourceIds = _i1.ColumnSerializable<List<int>>(
      'sourceResourceIds',
      this,
    );
    citations = _i1.ColumnSerializable<List<String>>(
      'citations',
      this,
    );
    confidence = _i1.ColumnString(
      'confidence',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final RoomAiAnswerUpdateTable updateTable;

  late final _i1.ColumnInt roomId;

  late final _i1.ColumnInt askerId;

  late final _i1.ColumnString question;

  late final _i1.ColumnString answer;

  late final _i1.ColumnSerializable<List<int>> sourceResourceIds;

  late final _i1.ColumnSerializable<List<String>> citations;

  late final _i1.ColumnString confidence;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        roomId,
        askerId,
        question,
        answer,
        sourceResourceIds,
        citations,
        confidence,
        createdAt,
      ];
}

class RoomAiAnswerInclude extends _i1.IncludeObject {
  RoomAiAnswerInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => RoomAiAnswer.t;
}

class RoomAiAnswerIncludeList extends _i1.IncludeList {
  RoomAiAnswerIncludeList._({
    _i1.WhereExpressionBuilder<RoomAiAnswerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RoomAiAnswer.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RoomAiAnswer.t;
}

class RoomAiAnswerRepository {
  const RoomAiAnswerRepository._();

  /// Returns a list of [RoomAiAnswer]s matching the given query parameters.
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
  Future<List<RoomAiAnswer>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomAiAnswerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomAiAnswerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomAiAnswerTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RoomAiAnswer>(
      where: where?.call(RoomAiAnswer.t),
      orderBy: orderBy?.call(RoomAiAnswer.t),
      orderByList: orderByList?.call(RoomAiAnswer.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RoomAiAnswer] matching the given query parameters.
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
  Future<RoomAiAnswer?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomAiAnswerTable>? where,
    int? offset,
    _i1.OrderByBuilder<RoomAiAnswerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RoomAiAnswerTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RoomAiAnswer>(
      where: where?.call(RoomAiAnswer.t),
      orderBy: orderBy?.call(RoomAiAnswer.t),
      orderByList: orderByList?.call(RoomAiAnswer.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RoomAiAnswer] by its [id] or null if no such row exists.
  Future<RoomAiAnswer?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RoomAiAnswer>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RoomAiAnswer]s in the list and returns the inserted rows.
  ///
  /// The returned [RoomAiAnswer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<RoomAiAnswer>> insert(
    _i1.DatabaseSession session,
    List<RoomAiAnswer> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RoomAiAnswer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RoomAiAnswer] and returns the inserted row.
  ///
  /// The returned [RoomAiAnswer] will have its `id` field set.
  Future<RoomAiAnswer> insertRow(
    _i1.DatabaseSession session,
    RoomAiAnswer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RoomAiAnswer>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RoomAiAnswer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RoomAiAnswer>> update(
    _i1.DatabaseSession session,
    List<RoomAiAnswer> rows, {
    _i1.ColumnSelections<RoomAiAnswerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RoomAiAnswer>(
      rows,
      columns: columns?.call(RoomAiAnswer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomAiAnswer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RoomAiAnswer> updateRow(
    _i1.DatabaseSession session,
    RoomAiAnswer row, {
    _i1.ColumnSelections<RoomAiAnswerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RoomAiAnswer>(
      row,
      columns: columns?.call(RoomAiAnswer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RoomAiAnswer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RoomAiAnswer?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RoomAiAnswerUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RoomAiAnswer>(
      id,
      columnValues: columnValues(RoomAiAnswer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RoomAiAnswer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RoomAiAnswer>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RoomAiAnswerUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RoomAiAnswerTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RoomAiAnswerTable>? orderBy,
    _i1.OrderByListBuilder<RoomAiAnswerTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RoomAiAnswer>(
      columnValues: columnValues(RoomAiAnswer.t.updateTable),
      where: where(RoomAiAnswer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RoomAiAnswer.t),
      orderByList: orderByList?.call(RoomAiAnswer.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RoomAiAnswer]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RoomAiAnswer>> delete(
    _i1.DatabaseSession session,
    List<RoomAiAnswer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RoomAiAnswer>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RoomAiAnswer].
  Future<RoomAiAnswer> deleteRow(
    _i1.DatabaseSession session,
    RoomAiAnswer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RoomAiAnswer>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RoomAiAnswer>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoomAiAnswerTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RoomAiAnswer>(
      where: where(RoomAiAnswer.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RoomAiAnswerTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RoomAiAnswer>(
      where: where?.call(RoomAiAnswer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RoomAiAnswer] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RoomAiAnswerTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RoomAiAnswer>(
      where: where(RoomAiAnswer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
