/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Summary
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Summary._({
    this.id,
    required this.studyMaterialId,
    required this.userId,
    required this.isPremium,
    required this.subject,
    required this.topic,
    this.wordCount,
    this.introduction,
    required this.subtopics,
    required this.nuggets,
    required this.createdAt,
  });

  factory Summary({
    int? id,
    required int studyMaterialId,
    required int userId,
    required bool isPremium,
    required String subject,
    required String topic,
    int? wordCount,
    String? introduction,
    required List<String> subtopics,
    required List<String> nuggets,
    required DateTime createdAt,
  }) = _SummaryImpl;

  factory Summary.fromJson(Map<String, dynamic> jsonSerialization) {
    return Summary(
      id: jsonSerialization['id'] as int?,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int,
      userId: jsonSerialization['userId'] as int,
      isPremium: jsonSerialization['isPremium'] as bool,
      subject: jsonSerialization['subject'] as String,
      topic: jsonSerialization['topic'] as String,
      wordCount: jsonSerialization['wordCount'] as int?,
      introduction: jsonSerialization['introduction'] as String?,
      subtopics: (jsonSerialization['subtopics'] as List)
          .map((e) => e as String)
          .toList(),
      nuggets: (jsonSerialization['nuggets'] as List)
          .map((e) => e as String)
          .toList(),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = SummaryTable();

  static const db = SummaryRepository._();

  @override
  int? id;

  int studyMaterialId;

  int userId;

  bool isPremium;

  String subject;

  String topic;

  int? wordCount;

  String? introduction;

  List<String> subtopics;

  List<String> nuggets;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Summary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Summary copyWith({
    int? id,
    int? studyMaterialId,
    int? userId,
    bool? isPremium,
    String? subject,
    String? topic,
    int? wordCount,
    String? introduction,
    List<String>? subtopics,
    List<String>? nuggets,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'studyMaterialId': studyMaterialId,
      'userId': userId,
      'isPremium': isPremium,
      'subject': subject,
      'topic': topic,
      if (wordCount != null) 'wordCount': wordCount,
      if (introduction != null) 'introduction': introduction,
      'subtopics': subtopics.toJson(),
      'nuggets': nuggets.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'studyMaterialId': studyMaterialId,
      'userId': userId,
      'isPremium': isPremium,
      'subject': subject,
      'topic': topic,
      if (wordCount != null) 'wordCount': wordCount,
      if (introduction != null) 'introduction': introduction,
      'subtopics': subtopics.toJson(),
      'nuggets': nuggets.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static SummaryInclude include() {
    return SummaryInclude._();
  }

  static SummaryIncludeList includeList({
    _i1.WhereExpressionBuilder<SummaryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SummaryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SummaryTable>? orderByList,
    SummaryInclude? include,
  }) {
    return SummaryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Summary.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Summary.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SummaryImpl extends Summary {
  _SummaryImpl({
    int? id,
    required int studyMaterialId,
    required int userId,
    required bool isPremium,
    required String subject,
    required String topic,
    int? wordCount,
    String? introduction,
    required List<String> subtopics,
    required List<String> nuggets,
    required DateTime createdAt,
  }) : super._(
          id: id,
          studyMaterialId: studyMaterialId,
          userId: userId,
          isPremium: isPremium,
          subject: subject,
          topic: topic,
          wordCount: wordCount,
          introduction: introduction,
          subtopics: subtopics,
          nuggets: nuggets,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Summary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Summary copyWith({
    Object? id = _Undefined,
    int? studyMaterialId,
    int? userId,
    bool? isPremium,
    String? subject,
    String? topic,
    Object? wordCount = _Undefined,
    Object? introduction = _Undefined,
    List<String>? subtopics,
    List<String>? nuggets,
    DateTime? createdAt,
  }) {
    return Summary(
      id: id is int? ? id : this.id,
      studyMaterialId: studyMaterialId ?? this.studyMaterialId,
      userId: userId ?? this.userId,
      isPremium: isPremium ?? this.isPremium,
      subject: subject ?? this.subject,
      topic: topic ?? this.topic,
      wordCount: wordCount is int? ? wordCount : this.wordCount,
      introduction: introduction is String? ? introduction : this.introduction,
      subtopics: subtopics ?? this.subtopics.map((e0) => e0).toList(),
      nuggets: nuggets ?? this.nuggets.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SummaryTable extends _i1.Table<int?> {
  SummaryTable({super.tableRelation}) : super(tableName: 'summaries') {
    studyMaterialId = _i1.ColumnInt(
      'studyMaterialId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    isPremium = _i1.ColumnBool(
      'isPremium',
      this,
    );
    subject = _i1.ColumnString(
      'subject',
      this,
    );
    topic = _i1.ColumnString(
      'topic',
      this,
    );
    wordCount = _i1.ColumnInt(
      'wordCount',
      this,
    );
    introduction = _i1.ColumnString(
      'introduction',
      this,
    );
    subtopics = _i1.ColumnSerializable(
      'subtopics',
      this,
    );
    nuggets = _i1.ColumnSerializable(
      'nuggets',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt studyMaterialId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnBool isPremium;

  late final _i1.ColumnString subject;

  late final _i1.ColumnString topic;

  late final _i1.ColumnInt wordCount;

  late final _i1.ColumnString introduction;

  late final _i1.ColumnSerializable subtopics;

  late final _i1.ColumnSerializable nuggets;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        studyMaterialId,
        userId,
        isPremium,
        subject,
        topic,
        wordCount,
        introduction,
        subtopics,
        nuggets,
        createdAt,
      ];
}

class SummaryInclude extends _i1.IncludeObject {
  SummaryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Summary.t;
}

class SummaryIncludeList extends _i1.IncludeList {
  SummaryIncludeList._({
    _i1.WhereExpressionBuilder<SummaryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Summary.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Summary.t;
}

class SummaryRepository {
  const SummaryRepository._();

  /// Returns a list of [Summary]s matching the given query parameters.
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
  Future<List<Summary>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SummaryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SummaryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SummaryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Summary>(
      where: where?.call(Summary.t),
      orderBy: orderBy?.call(Summary.t),
      orderByList: orderByList?.call(Summary.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Summary] matching the given query parameters.
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
  Future<Summary?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SummaryTable>? where,
    int? offset,
    _i1.OrderByBuilder<SummaryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SummaryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Summary>(
      where: where?.call(Summary.t),
      orderBy: orderBy?.call(Summary.t),
      orderByList: orderByList?.call(Summary.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Summary] by its [id] or null if no such row exists.
  Future<Summary?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Summary>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Summary]s in the list and returns the inserted rows.
  ///
  /// The returned [Summary]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Summary>> insert(
    _i1.Session session,
    List<Summary> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Summary>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Summary] and returns the inserted row.
  ///
  /// The returned [Summary] will have its `id` field set.
  Future<Summary> insertRow(
    _i1.Session session,
    Summary row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Summary>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Summary]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Summary>> update(
    _i1.Session session,
    List<Summary> rows, {
    _i1.ColumnSelections<SummaryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Summary>(
      rows,
      columns: columns?.call(Summary.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Summary]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Summary> updateRow(
    _i1.Session session,
    Summary row, {
    _i1.ColumnSelections<SummaryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Summary>(
      row,
      columns: columns?.call(Summary.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Summary]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Summary>> delete(
    _i1.Session session,
    List<Summary> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Summary>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Summary].
  Future<Summary> deleteRow(
    _i1.Session session,
    Summary row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Summary>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Summary>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SummaryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Summary>(
      where: where(Summary.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SummaryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Summary>(
      where: where?.call(Summary.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
