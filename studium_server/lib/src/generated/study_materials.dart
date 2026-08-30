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

abstract class StudyMaterial
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StudyMaterial._({
    this.id,
    required this.userId,
    required this.title,
    required this.fileType,
    required this.fileUrl,
    required this.uploadDate,
    this.size,
    this.contentText,
  });

  factory StudyMaterial({
    int? id,
    required int userId,
    required String title,
    required String fileType,
    required String fileUrl,
    required DateTime uploadDate,
    int? size,
    String? contentText,
  }) = _StudyMaterialImpl;

  factory StudyMaterial.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyMaterial(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      fileType: jsonSerialization['fileType'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      uploadDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['uploadDate'],
      ),
      size: jsonSerialization['size'] as int?,
      contentText: jsonSerialization['contentText'] as String?,
    );
  }

  static final t = StudyMaterialTable();

  static const db = StudyMaterialRepository._();

  @override
  int? id;

  int userId;

  String title;

  String fileType;

  String fileUrl;

  DateTime uploadDate;

  int? size;

  String? contentText;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudyMaterial]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudyMaterial copyWith({
    int? id,
    int? userId,
    String? title,
    String? fileType,
    String? fileUrl,
    DateTime? uploadDate,
    int? size,
    String? contentText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyMaterial',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'fileType': fileType,
      'fileUrl': fileUrl,
      'uploadDate': uploadDate.toJson(),
      if (size != null) 'size': size,
      if (contentText != null) 'contentText': contentText,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudyMaterial',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'fileType': fileType,
      'fileUrl': fileUrl,
      'uploadDate': uploadDate.toJson(),
      if (size != null) 'size': size,
      if (contentText != null) 'contentText': contentText,
    };
  }

  static StudyMaterialInclude include() {
    return StudyMaterialInclude._();
  }

  static StudyMaterialIncludeList includeList({
    _i1.WhereExpressionBuilder<StudyMaterialTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudyMaterialTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudyMaterialTable>? orderByList,
    StudyMaterialInclude? include,
  }) {
    return StudyMaterialIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyMaterial.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StudyMaterial.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyMaterialImpl extends StudyMaterial {
  _StudyMaterialImpl({
    int? id,
    required int userId,
    required String title,
    required String fileType,
    required String fileUrl,
    required DateTime uploadDate,
    int? size,
    String? contentText,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         fileType: fileType,
         fileUrl: fileUrl,
         uploadDate: uploadDate,
         size: size,
         contentText: contentText,
       );

  /// Returns a shallow copy of this [StudyMaterial]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudyMaterial copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    String? fileType,
    String? fileUrl,
    DateTime? uploadDate,
    Object? size = _Undefined,
    Object? contentText = _Undefined,
  }) {
    return StudyMaterial(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      fileType: fileType ?? this.fileType,
      fileUrl: fileUrl ?? this.fileUrl,
      uploadDate: uploadDate ?? this.uploadDate,
      size: size is int? ? size : this.size,
      contentText: contentText is String? ? contentText : this.contentText,
    );
  }
}

class StudyMaterialUpdateTable extends _i1.UpdateTable<StudyMaterialTable> {
  StudyMaterialUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> fileType(String value) => _i1.ColumnValue(
    table.fileType,
    value,
  );

  _i1.ColumnValue<String, String> fileUrl(String value) => _i1.ColumnValue(
    table.fileUrl,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> uploadDate(DateTime value) =>
      _i1.ColumnValue(
        table.uploadDate,
        value,
      );

  _i1.ColumnValue<int, int> size(int? value) => _i1.ColumnValue(
    table.size,
    value,
  );

  _i1.ColumnValue<String, String> contentText(String? value) => _i1.ColumnValue(
    table.contentText,
    value,
  );
}

class StudyMaterialTable extends _i1.Table<int?> {
  StudyMaterialTable({super.tableRelation})
    : super(tableName: 'study_materials') {
    updateTable = StudyMaterialUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    fileType = _i1.ColumnString(
      'fileType',
      this,
    );
    fileUrl = _i1.ColumnString(
      'fileUrl',
      this,
    );
    uploadDate = _i1.ColumnDateTime(
      'uploadDate',
      this,
    );
    size = _i1.ColumnInt(
      'size',
      this,
    );
    contentText = _i1.ColumnString(
      'contentText',
      this,
    );
  }

  late final StudyMaterialUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString fileType;

  late final _i1.ColumnString fileUrl;

  late final _i1.ColumnDateTime uploadDate;

  late final _i1.ColumnInt size;

  late final _i1.ColumnString contentText;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    title,
    fileType,
    fileUrl,
    uploadDate,
    size,
    contentText,
  ];
}

class StudyMaterialInclude extends _i1.IncludeObject {
  StudyMaterialInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => StudyMaterial.t;
}

class StudyMaterialIncludeList extends _i1.IncludeList {
  StudyMaterialIncludeList._({
    _i1.WhereExpressionBuilder<StudyMaterialTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudyMaterial.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StudyMaterial.t;
}

class StudyMaterialRepository {
  const StudyMaterialRepository._();

  /// Returns a list of [StudyMaterial]s matching the given query parameters.
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
  Future<List<StudyMaterial>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudyMaterialTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudyMaterialTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudyMaterialTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudyMaterial>(
      where: where?.call(StudyMaterial.t),
      orderBy: orderBy?.call(StudyMaterial.t),
      orderByList: orderByList?.call(StudyMaterial.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudyMaterial] matching the given query parameters.
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
  Future<StudyMaterial?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudyMaterialTable>? where,
    int? offset,
    _i1.OrderByBuilder<StudyMaterialTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StudyMaterialTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudyMaterial>(
      where: where?.call(StudyMaterial.t),
      orderBy: orderBy?.call(StudyMaterial.t),
      orderByList: orderByList?.call(StudyMaterial.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudyMaterial] by its [id] or null if no such row exists.
  Future<StudyMaterial?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudyMaterial>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudyMaterial]s in the list and returns the inserted rows.
  ///
  /// The returned [StudyMaterial]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<StudyMaterial>> insert(
    _i1.DatabaseSession session,
    List<StudyMaterial> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<StudyMaterial>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [StudyMaterial] and returns the inserted row.
  ///
  /// The returned [StudyMaterial] will have its `id` field set.
  Future<StudyMaterial> insertRow(
    _i1.DatabaseSession session,
    StudyMaterial row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudyMaterial>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StudyMaterial]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StudyMaterial>> update(
    _i1.DatabaseSession session,
    List<StudyMaterial> rows, {
    _i1.ColumnSelections<StudyMaterialTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StudyMaterial>(
      rows,
      columns: columns?.call(StudyMaterial.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudyMaterial]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudyMaterial> updateRow(
    _i1.DatabaseSession session,
    StudyMaterial row, {
    _i1.ColumnSelections<StudyMaterialTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudyMaterial>(
      row,
      columns: columns?.call(StudyMaterial.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudyMaterial] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudyMaterial?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<StudyMaterialUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<StudyMaterial>(
      id,
      columnValues: columnValues(StudyMaterial.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudyMaterial]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<StudyMaterial>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StudyMaterialUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StudyMaterialTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StudyMaterialTable>? orderBy,
    _i1.OrderByListBuilder<StudyMaterialTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<StudyMaterial>(
      columnValues: columnValues(StudyMaterial.t.updateTable),
      where: where(StudyMaterial.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudyMaterial.t),
      orderByList: orderByList?.call(StudyMaterial.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [StudyMaterial]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StudyMaterial>> delete(
    _i1.DatabaseSession session,
    List<StudyMaterial> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StudyMaterial>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StudyMaterial].
  Future<StudyMaterial> deleteRow(
    _i1.DatabaseSession session,
    StudyMaterial row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudyMaterial>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StudyMaterial>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudyMaterialTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StudyMaterial>(
      where: where(StudyMaterial.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StudyMaterialTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StudyMaterial>(
      where: where?.call(StudyMaterial.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudyMaterial] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StudyMaterialTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudyMaterial>(
      where: where(StudyMaterial.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
