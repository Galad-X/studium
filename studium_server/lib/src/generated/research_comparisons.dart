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

abstract class ResearchComparison
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ResearchComparison._({
    this.id,
    this.summaryId,
    required this.studyMaterialId,
    required this.newerFindings,
    required this.unsolvedProblems,
    required this.createdAt,
  });

  factory ResearchComparison({
    int? id,
    int? summaryId,
    required int studyMaterialId,
    required String newerFindings,
    required List<String> unsolvedProblems,
    required DateTime createdAt,
  }) = _ResearchComparisonImpl;

  factory ResearchComparison.fromJson(Map<String, dynamic> jsonSerialization) {
    return ResearchComparison(
      id: jsonSerialization['id'] as int?,
      summaryId: jsonSerialization['summaryId'] as int?,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int,
      newerFindings: jsonSerialization['newerFindings'] as String,
      unsolvedProblems: (jsonSerialization['unsolvedProblems'] as List)
          .map((e) => e as String)
          .toList(),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ResearchComparisonTable();

  static const db = ResearchComparisonRepository._();

  @override
  int? id;

  int? summaryId;

  int studyMaterialId;

  String newerFindings;

  List<String> unsolvedProblems;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ResearchComparison]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ResearchComparison copyWith({
    int? id,
    int? summaryId,
    int? studyMaterialId,
    String? newerFindings,
    List<String>? unsolvedProblems,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (summaryId != null) 'summaryId': summaryId,
      'studyMaterialId': studyMaterialId,
      'newerFindings': newerFindings,
      'unsolvedProblems': unsolvedProblems.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (summaryId != null) 'summaryId': summaryId,
      'studyMaterialId': studyMaterialId,
      'newerFindings': newerFindings,
      'unsolvedProblems': unsolvedProblems.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static ResearchComparisonInclude include() {
    return ResearchComparisonInclude._();
  }

  static ResearchComparisonIncludeList includeList({
    _i1.WhereExpressionBuilder<ResearchComparisonTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ResearchComparisonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ResearchComparisonTable>? orderByList,
    ResearchComparisonInclude? include,
  }) {
    return ResearchComparisonIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ResearchComparison.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ResearchComparison.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ResearchComparisonImpl extends ResearchComparison {
  _ResearchComparisonImpl({
    int? id,
    int? summaryId,
    required int studyMaterialId,
    required String newerFindings,
    required List<String> unsolvedProblems,
    required DateTime createdAt,
  }) : super._(
          id: id,
          summaryId: summaryId,
          studyMaterialId: studyMaterialId,
          newerFindings: newerFindings,
          unsolvedProblems: unsolvedProblems,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ResearchComparison]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ResearchComparison copyWith({
    Object? id = _Undefined,
    Object? summaryId = _Undefined,
    int? studyMaterialId,
    String? newerFindings,
    List<String>? unsolvedProblems,
    DateTime? createdAt,
  }) {
    return ResearchComparison(
      id: id is int? ? id : this.id,
      summaryId: summaryId is int? ? summaryId : this.summaryId,
      studyMaterialId: studyMaterialId ?? this.studyMaterialId,
      newerFindings: newerFindings ?? this.newerFindings,
      unsolvedProblems:
          unsolvedProblems ?? this.unsolvedProblems.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ResearchComparisonTable extends _i1.Table<int?> {
  ResearchComparisonTable({super.tableRelation})
      : super(tableName: 'research_comparisons') {
    summaryId = _i1.ColumnInt(
      'summaryId',
      this,
    );
    studyMaterialId = _i1.ColumnInt(
      'studyMaterialId',
      this,
    );
    newerFindings = _i1.ColumnString(
      'newerFindings',
      this,
    );
    unsolvedProblems = _i1.ColumnSerializable(
      'unsolvedProblems',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt summaryId;

  late final _i1.ColumnInt studyMaterialId;

  late final _i1.ColumnString newerFindings;

  late final _i1.ColumnSerializable unsolvedProblems;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        summaryId,
        studyMaterialId,
        newerFindings,
        unsolvedProblems,
        createdAt,
      ];
}

class ResearchComparisonInclude extends _i1.IncludeObject {
  ResearchComparisonInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ResearchComparison.t;
}

class ResearchComparisonIncludeList extends _i1.IncludeList {
  ResearchComparisonIncludeList._({
    _i1.WhereExpressionBuilder<ResearchComparisonTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ResearchComparison.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ResearchComparison.t;
}

class ResearchComparisonRepository {
  const ResearchComparisonRepository._();

  /// Returns a list of [ResearchComparison]s matching the given query parameters.
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
  Future<List<ResearchComparison>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ResearchComparisonTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ResearchComparisonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ResearchComparisonTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ResearchComparison>(
      where: where?.call(ResearchComparison.t),
      orderBy: orderBy?.call(ResearchComparison.t),
      orderByList: orderByList?.call(ResearchComparison.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ResearchComparison] matching the given query parameters.
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
  Future<ResearchComparison?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ResearchComparisonTable>? where,
    int? offset,
    _i1.OrderByBuilder<ResearchComparisonTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ResearchComparisonTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ResearchComparison>(
      where: where?.call(ResearchComparison.t),
      orderBy: orderBy?.call(ResearchComparison.t),
      orderByList: orderByList?.call(ResearchComparison.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ResearchComparison] by its [id] or null if no such row exists.
  Future<ResearchComparison?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ResearchComparison>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ResearchComparison]s in the list and returns the inserted rows.
  ///
  /// The returned [ResearchComparison]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ResearchComparison>> insert(
    _i1.Session session,
    List<ResearchComparison> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ResearchComparison>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ResearchComparison] and returns the inserted row.
  ///
  /// The returned [ResearchComparison] will have its `id` field set.
  Future<ResearchComparison> insertRow(
    _i1.Session session,
    ResearchComparison row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ResearchComparison>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ResearchComparison]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ResearchComparison>> update(
    _i1.Session session,
    List<ResearchComparison> rows, {
    _i1.ColumnSelections<ResearchComparisonTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ResearchComparison>(
      rows,
      columns: columns?.call(ResearchComparison.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ResearchComparison]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ResearchComparison> updateRow(
    _i1.Session session,
    ResearchComparison row, {
    _i1.ColumnSelections<ResearchComparisonTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ResearchComparison>(
      row,
      columns: columns?.call(ResearchComparison.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ResearchComparison]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ResearchComparison>> delete(
    _i1.Session session,
    List<ResearchComparison> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ResearchComparison>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ResearchComparison].
  Future<ResearchComparison> deleteRow(
    _i1.Session session,
    ResearchComparison row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ResearchComparison>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ResearchComparison>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ResearchComparisonTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ResearchComparison>(
      where: where(ResearchComparison.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ResearchComparisonTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ResearchComparison>(
      where: where?.call(ResearchComparison.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
