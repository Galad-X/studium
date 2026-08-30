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

abstract class Question
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Question._({
    this.id,
    required this.studyMaterialId,
    required this.type,
    required this.questionText,
    this.correctAnswer,
    this.options,
    this.explanation,
    required this.difficulty,
    required this.bloomsLevel,
    required this.estimatedTime,
    this.tags,
    this.diagramImageUrl,
    this.labelingPoints,
    required this.createdAt,
  });

  factory Question({
    int? id,
    required int studyMaterialId,
    required String type,
    required String questionText,
    String? correctAnswer,
    List<String>? options,
    String? explanation,
    required String difficulty,
    required String bloomsLevel,
    required int estimatedTime,
    List<String>? tags,
    String? diagramImageUrl,
    List<String>? labelingPoints,
    required DateTime createdAt,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int,
      type: jsonSerialization['type'] as String,
      questionText: jsonSerialization['questionText'] as String,
      correctAnswer: jsonSerialization['correctAnswer'] as String?,
      options: jsonSerialization['options'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['options'],
            ),
      explanation: jsonSerialization['explanation'] as String?,
      difficulty: jsonSerialization['difficulty'] as String,
      bloomsLevel: jsonSerialization['bloomsLevel'] as String,
      estimatedTime: jsonSerialization['estimatedTime'] as int,
      tags: jsonSerialization['tags'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      diagramImageUrl: jsonSerialization['diagramImageUrl'] as String?,
      labelingPoints: jsonSerialization['labelingPoints'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['labelingPoints'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = QuestionTable();

  static const db = QuestionRepository._();

  @override
  int? id;

  int studyMaterialId;

  String type;

  String questionText;

  String? correctAnswer;

  List<String>? options;

  String? explanation;

  String difficulty;

  String bloomsLevel;

  int estimatedTime;

  List<String>? tags;

  String? diagramImageUrl;

  List<String>? labelingPoints;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Question copyWith({
    int? id,
    int? studyMaterialId,
    String? type,
    String? questionText,
    String? correctAnswer,
    List<String>? options,
    String? explanation,
    String? difficulty,
    String? bloomsLevel,
    int? estimatedTime,
    List<String>? tags,
    String? diagramImageUrl,
    List<String>? labelingPoints,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'studyMaterialId': studyMaterialId,
      'type': type,
      'questionText': questionText,
      if (correctAnswer != null) 'correctAnswer': correctAnswer,
      if (options != null) 'options': options?.toJson(),
      if (explanation != null) 'explanation': explanation,
      'difficulty': difficulty,
      'bloomsLevel': bloomsLevel,
      'estimatedTime': estimatedTime,
      if (tags != null) 'tags': tags?.toJson(),
      if (diagramImageUrl != null) 'diagramImageUrl': diagramImageUrl,
      if (labelingPoints != null) 'labelingPoints': labelingPoints?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'studyMaterialId': studyMaterialId,
      'type': type,
      'questionText': questionText,
      if (correctAnswer != null) 'correctAnswer': correctAnswer,
      if (options != null) 'options': options?.toJson(),
      if (explanation != null) 'explanation': explanation,
      'difficulty': difficulty,
      'bloomsLevel': bloomsLevel,
      'estimatedTime': estimatedTime,
      if (tags != null) 'tags': tags?.toJson(),
      if (diagramImageUrl != null) 'diagramImageUrl': diagramImageUrl,
      if (labelingPoints != null) 'labelingPoints': labelingPoints?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static QuestionInclude include() {
    return QuestionInclude._();
  }

  static QuestionIncludeList includeList({
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    QuestionInclude? include,
  }) {
    return QuestionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Question.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required int studyMaterialId,
    required String type,
    required String questionText,
    String? correctAnswer,
    List<String>? options,
    String? explanation,
    required String difficulty,
    required String bloomsLevel,
    required int estimatedTime,
    List<String>? tags,
    String? diagramImageUrl,
    List<String>? labelingPoints,
    required DateTime createdAt,
  }) : super._(
         id: id,
         studyMaterialId: studyMaterialId,
         type: type,
         questionText: questionText,
         correctAnswer: correctAnswer,
         options: options,
         explanation: explanation,
         difficulty: difficulty,
         bloomsLevel: bloomsLevel,
         estimatedTime: estimatedTime,
         tags: tags,
         diagramImageUrl: diagramImageUrl,
         labelingPoints: labelingPoints,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    int? studyMaterialId,
    String? type,
    String? questionText,
    Object? correctAnswer = _Undefined,
    Object? options = _Undefined,
    Object? explanation = _Undefined,
    String? difficulty,
    String? bloomsLevel,
    int? estimatedTime,
    Object? tags = _Undefined,
    Object? diagramImageUrl = _Undefined,
    Object? labelingPoints = _Undefined,
    DateTime? createdAt,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      studyMaterialId: studyMaterialId ?? this.studyMaterialId,
      type: type ?? this.type,
      questionText: questionText ?? this.questionText,
      correctAnswer: correctAnswer is String?
          ? correctAnswer
          : this.correctAnswer,
      options: options is List<String>?
          ? options
          : this.options?.map((e0) => e0).toList(),
      explanation: explanation is String? ? explanation : this.explanation,
      difficulty: difficulty ?? this.difficulty,
      bloomsLevel: bloomsLevel ?? this.bloomsLevel,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      tags: tags is List<String>? ? tags : this.tags?.map((e0) => e0).toList(),
      diagramImageUrl: diagramImageUrl is String?
          ? diagramImageUrl
          : this.diagramImageUrl,
      labelingPoints: labelingPoints is List<String>?
          ? labelingPoints
          : this.labelingPoints?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class QuestionUpdateTable extends _i1.UpdateTable<QuestionTable> {
  QuestionUpdateTable(super.table);

  _i1.ColumnValue<int, int> studyMaterialId(int value) => _i1.ColumnValue(
    table.studyMaterialId,
    value,
  );

  _i1.ColumnValue<String, String> type(String value) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<String, String> questionText(String value) => _i1.ColumnValue(
    table.questionText,
    value,
  );

  _i1.ColumnValue<String, String> correctAnswer(String? value) =>
      _i1.ColumnValue(
        table.correctAnswer,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> options(List<String>? value) =>
      _i1.ColumnValue(
        table.options,
        value,
      );

  _i1.ColumnValue<String, String> explanation(String? value) => _i1.ColumnValue(
    table.explanation,
    value,
  );

  _i1.ColumnValue<String, String> difficulty(String value) => _i1.ColumnValue(
    table.difficulty,
    value,
  );

  _i1.ColumnValue<String, String> bloomsLevel(String value) => _i1.ColumnValue(
    table.bloomsLevel,
    value,
  );

  _i1.ColumnValue<int, int> estimatedTime(int value) => _i1.ColumnValue(
    table.estimatedTime,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> tags(List<String>? value) =>
      _i1.ColumnValue(
        table.tags,
        value,
      );

  _i1.ColumnValue<String, String> diagramImageUrl(String? value) =>
      _i1.ColumnValue(
        table.diagramImageUrl,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> labelingPoints(
    List<String>? value,
  ) => _i1.ColumnValue(
    table.labelingPoints,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class QuestionTable extends _i1.Table<int?> {
  QuestionTable({super.tableRelation}) : super(tableName: 'questions') {
    updateTable = QuestionUpdateTable(this);
    studyMaterialId = _i1.ColumnInt(
      'studyMaterialId',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    questionText = _i1.ColumnString(
      'questionText',
      this,
    );
    correctAnswer = _i1.ColumnString(
      'correctAnswer',
      this,
    );
    options = _i1.ColumnSerializable<List<String>>(
      'options',
      this,
    );
    explanation = _i1.ColumnString(
      'explanation',
      this,
    );
    difficulty = _i1.ColumnString(
      'difficulty',
      this,
    );
    bloomsLevel = _i1.ColumnString(
      'bloomsLevel',
      this,
    );
    estimatedTime = _i1.ColumnInt(
      'estimatedTime',
      this,
    );
    tags = _i1.ColumnSerializable<List<String>>(
      'tags',
      this,
    );
    diagramImageUrl = _i1.ColumnString(
      'diagramImageUrl',
      this,
    );
    labelingPoints = _i1.ColumnSerializable<List<String>>(
      'labelingPoints',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final QuestionUpdateTable updateTable;

  late final _i1.ColumnInt studyMaterialId;

  late final _i1.ColumnString type;

  late final _i1.ColumnString questionText;

  late final _i1.ColumnString correctAnswer;

  late final _i1.ColumnSerializable<List<String>> options;

  late final _i1.ColumnString explanation;

  late final _i1.ColumnString difficulty;

  late final _i1.ColumnString bloomsLevel;

  late final _i1.ColumnInt estimatedTime;

  late final _i1.ColumnSerializable<List<String>> tags;

  late final _i1.ColumnString diagramImageUrl;

  late final _i1.ColumnSerializable<List<String>> labelingPoints;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    studyMaterialId,
    type,
    questionText,
    correctAnswer,
    options,
    explanation,
    difficulty,
    bloomsLevel,
    estimatedTime,
    tags,
    diagramImageUrl,
    labelingPoints,
    createdAt,
  ];
}

class QuestionInclude extends _i1.IncludeObject {
  QuestionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Question.t;
}

class QuestionIncludeList extends _i1.IncludeList {
  QuestionIncludeList._({
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Question.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Question.t;
}

class QuestionRepository {
  const QuestionRepository._();

  /// Returns a list of [Question]s matching the given query parameters.
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
  Future<List<Question>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Question] matching the given query parameters.
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
  Future<Question?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Question] by its [id] or null if no such row exists.
  Future<Question?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Question>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Question]s in the list and returns the inserted rows.
  ///
  /// The returned [Question]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Question>> insert(
    _i1.DatabaseSession session,
    List<Question> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Question>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Question] and returns the inserted row.
  ///
  /// The returned [Question] will have its `id` field set.
  Future<Question> insertRow(
    _i1.DatabaseSession session,
    Question row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Question]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Question>> update(
    _i1.DatabaseSession session,
    List<Question> rows, {
    _i1.ColumnSelections<QuestionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Question>(
      rows,
      columns: columns?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Question]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Question> updateRow(
    _i1.DatabaseSession session,
    Question row, {
    _i1.ColumnSelections<QuestionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Question>(
      row,
      columns: columns?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Question] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Question?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Question>(
      id,
      columnValues: columnValues(Question.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Question]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Question>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<QuestionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuestionTable>? orderBy,
    _i1.OrderByListBuilder<QuestionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Question>(
      columnValues: columnValues(Question.t.updateTable),
      where: where(Question.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Question]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Question>> delete(
    _i1.DatabaseSession session,
    List<Question> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Question>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Question].
  Future<Question> deleteRow(
    _i1.DatabaseSession session,
    Question row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Question>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<QuestionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Question>(
      where: where(Question.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Question>(
      where: where?.call(Question.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Question] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<QuestionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Question>(
      where: where(Question.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
