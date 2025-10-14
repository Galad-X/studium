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

abstract class AcademicWriting
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AcademicWriting._({
    this.id,
    required this.userId,
    this.studyMaterialId,
    required this.type,
    required this.title,
    this.wordCount,
    required this.content,
    required this.format,
    required this.fileUrl,
    required this.createdAt,
  });

  factory AcademicWriting({
    int? id,
    required int userId,
    int? studyMaterialId,
    required String type,
    required String title,
    int? wordCount,
    required String content,
    required String format,
    required String fileUrl,
    required DateTime createdAt,
  }) = _AcademicWritingImpl;

  factory AcademicWriting.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcademicWriting(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int?,
      type: jsonSerialization['type'] as String,
      title: jsonSerialization['title'] as String,
      wordCount: jsonSerialization['wordCount'] as int?,
      content: jsonSerialization['content'] as String,
      format: jsonSerialization['format'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AcademicWritingTable();

  static const db = AcademicWritingRepository._();

  @override
  int? id;

  int userId;

  int? studyMaterialId;

  String type;

  String title;

  int? wordCount;

  String content;

  String format;

  String fileUrl;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AcademicWriting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AcademicWriting copyWith({
    int? id,
    int? userId,
    int? studyMaterialId,
    String? type,
    String? title,
    int? wordCount,
    String? content,
    String? format,
    String? fileUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (studyMaterialId != null) 'studyMaterialId': studyMaterialId,
      'type': type,
      'title': title,
      if (wordCount != null) 'wordCount': wordCount,
      'content': content,
      'format': format,
      'fileUrl': fileUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      if (studyMaterialId != null) 'studyMaterialId': studyMaterialId,
      'type': type,
      'title': title,
      if (wordCount != null) 'wordCount': wordCount,
      'content': content,
      'format': format,
      'fileUrl': fileUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  static AcademicWritingInclude include() {
    return AcademicWritingInclude._();
  }

  static AcademicWritingIncludeList includeList({
    _i1.WhereExpressionBuilder<AcademicWritingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AcademicWritingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AcademicWritingTable>? orderByList,
    AcademicWritingInclude? include,
  }) {
    return AcademicWritingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AcademicWriting.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AcademicWriting.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AcademicWritingImpl extends AcademicWriting {
  _AcademicWritingImpl({
    int? id,
    required int userId,
    int? studyMaterialId,
    required String type,
    required String title,
    int? wordCount,
    required String content,
    required String format,
    required String fileUrl,
    required DateTime createdAt,
  }) : super._(
          id: id,
          userId: userId,
          studyMaterialId: studyMaterialId,
          type: type,
          title: title,
          wordCount: wordCount,
          content: content,
          format: format,
          fileUrl: fileUrl,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [AcademicWriting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AcademicWriting copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? studyMaterialId = _Undefined,
    String? type,
    String? title,
    Object? wordCount = _Undefined,
    String? content,
    String? format,
    String? fileUrl,
    DateTime? createdAt,
  }) {
    return AcademicWriting(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      studyMaterialId:
          studyMaterialId is int? ? studyMaterialId : this.studyMaterialId,
      type: type ?? this.type,
      title: title ?? this.title,
      wordCount: wordCount is int? ? wordCount : this.wordCount,
      content: content ?? this.content,
      format: format ?? this.format,
      fileUrl: fileUrl ?? this.fileUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AcademicWritingTable extends _i1.Table<int?> {
  AcademicWritingTable({super.tableRelation})
      : super(tableName: 'academic_writings') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    studyMaterialId = _i1.ColumnInt(
      'studyMaterialId',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    wordCount = _i1.ColumnInt(
      'wordCount',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    format = _i1.ColumnString(
      'format',
      this,
    );
    fileUrl = _i1.ColumnString(
      'fileUrl',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt studyMaterialId;

  late final _i1.ColumnString type;

  late final _i1.ColumnString title;

  late final _i1.ColumnInt wordCount;

  late final _i1.ColumnString content;

  late final _i1.ColumnString format;

  late final _i1.ColumnString fileUrl;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        studyMaterialId,
        type,
        title,
        wordCount,
        content,
        format,
        fileUrl,
        createdAt,
      ];
}

class AcademicWritingInclude extends _i1.IncludeObject {
  AcademicWritingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AcademicWriting.t;
}

class AcademicWritingIncludeList extends _i1.IncludeList {
  AcademicWritingIncludeList._({
    _i1.WhereExpressionBuilder<AcademicWritingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AcademicWriting.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AcademicWriting.t;
}

class AcademicWritingRepository {
  const AcademicWritingRepository._();

  /// Returns a list of [AcademicWriting]s matching the given query parameters.
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
  Future<List<AcademicWriting>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AcademicWritingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AcademicWritingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AcademicWritingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<AcademicWriting>(
      where: where?.call(AcademicWriting.t),
      orderBy: orderBy?.call(AcademicWriting.t),
      orderByList: orderByList?.call(AcademicWriting.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [AcademicWriting] matching the given query parameters.
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
  Future<AcademicWriting?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AcademicWritingTable>? where,
    int? offset,
    _i1.OrderByBuilder<AcademicWritingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AcademicWritingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<AcademicWriting>(
      where: where?.call(AcademicWriting.t),
      orderBy: orderBy?.call(AcademicWriting.t),
      orderByList: orderByList?.call(AcademicWriting.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [AcademicWriting] by its [id] or null if no such row exists.
  Future<AcademicWriting?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<AcademicWriting>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [AcademicWriting]s in the list and returns the inserted rows.
  ///
  /// The returned [AcademicWriting]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AcademicWriting>> insert(
    _i1.Session session,
    List<AcademicWriting> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AcademicWriting>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AcademicWriting] and returns the inserted row.
  ///
  /// The returned [AcademicWriting] will have its `id` field set.
  Future<AcademicWriting> insertRow(
    _i1.Session session,
    AcademicWriting row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AcademicWriting>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AcademicWriting]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AcademicWriting>> update(
    _i1.Session session,
    List<AcademicWriting> rows, {
    _i1.ColumnSelections<AcademicWritingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AcademicWriting>(
      rows,
      columns: columns?.call(AcademicWriting.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AcademicWriting]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AcademicWriting> updateRow(
    _i1.Session session,
    AcademicWriting row, {
    _i1.ColumnSelections<AcademicWritingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AcademicWriting>(
      row,
      columns: columns?.call(AcademicWriting.t),
      transaction: transaction,
    );
  }

  /// Deletes all [AcademicWriting]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AcademicWriting>> delete(
    _i1.Session session,
    List<AcademicWriting> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AcademicWriting>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AcademicWriting].
  Future<AcademicWriting> deleteRow(
    _i1.Session session,
    AcademicWriting row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AcademicWriting>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AcademicWriting>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AcademicWritingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AcademicWriting>(
      where: where(AcademicWriting.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AcademicWritingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AcademicWriting>(
      where: where?.call(AcademicWriting.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
