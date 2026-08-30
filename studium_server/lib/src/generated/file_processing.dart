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

abstract class FileProcessing
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FileProcessing._({
    this.id,
    required this.studyMaterialId,
    required this.status,
    this.processedText,
    this.errorMessage,
    required this.attempts,
    required this.maxAttempts,
    this.lastStartedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileProcessing({
    int? id,
    required int studyMaterialId,
    required String status,
    String? processedText,
    String? errorMessage,
    required int attempts,
    required int maxAttempts,
    DateTime? lastStartedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FileProcessingImpl;

  factory FileProcessing.fromJson(Map<String, dynamic> jsonSerialization) {
    return FileProcessing(
      id: jsonSerialization['id'] as int?,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int,
      status: jsonSerialization['status'] as String,
      processedText: jsonSerialization['processedText'] as String?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      attempts: jsonSerialization['attempts'] as int,
      maxAttempts: jsonSerialization['maxAttempts'] as int,
      lastStartedAt: jsonSerialization['lastStartedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastStartedAt'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = FileProcessingTable();

  static const db = FileProcessingRepository._();

  @override
  int? id;

  int studyMaterialId;

  String status;

  String? processedText;

  String? errorMessage;

  int attempts;

  int maxAttempts;

  DateTime? lastStartedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FileProcessing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FileProcessing copyWith({
    int? id,
    int? studyMaterialId,
    String? status,
    String? processedText,
    String? errorMessage,
    int? attempts,
    int? maxAttempts,
    DateTime? lastStartedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FileProcessing',
      if (id != null) 'id': id,
      'studyMaterialId': studyMaterialId,
      'status': status,
      if (processedText != null) 'processedText': processedText,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      if (lastStartedAt != null) 'lastStartedAt': lastStartedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FileProcessing',
      if (id != null) 'id': id,
      'studyMaterialId': studyMaterialId,
      'status': status,
      if (processedText != null) 'processedText': processedText,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      if (lastStartedAt != null) 'lastStartedAt': lastStartedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FileProcessingInclude include() {
    return FileProcessingInclude._();
  }

  static FileProcessingIncludeList includeList({
    _i1.WhereExpressionBuilder<FileProcessingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FileProcessingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FileProcessingTable>? orderByList,
    FileProcessingInclude? include,
  }) {
    return FileProcessingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FileProcessing.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FileProcessing.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FileProcessingImpl extends FileProcessing {
  _FileProcessingImpl({
    int? id,
    required int studyMaterialId,
    required String status,
    String? processedText,
    String? errorMessage,
    required int attempts,
    required int maxAttempts,
    DateTime? lastStartedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          studyMaterialId: studyMaterialId,
          status: status,
          processedText: processedText,
          errorMessage: errorMessage,
          attempts: attempts,
          maxAttempts: maxAttempts,
          lastStartedAt: lastStartedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [FileProcessing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FileProcessing copyWith({
    Object? id = _Undefined,
    int? studyMaterialId,
    String? status,
    Object? processedText = _Undefined,
    Object? errorMessage = _Undefined,
    int? attempts,
    int? maxAttempts,
    Object? lastStartedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FileProcessing(
      id: id is int? ? id : this.id,
      studyMaterialId: studyMaterialId ?? this.studyMaterialId,
      status: status ?? this.status,
      processedText:
          processedText is String? ? processedText : this.processedText,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      lastStartedAt:
          lastStartedAt is DateTime? ? lastStartedAt : this.lastStartedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FileProcessingUpdateTable extends _i1.UpdateTable<FileProcessingTable> {
  FileProcessingUpdateTable(super.table);

  _i1.ColumnValue<int, int> studyMaterialId(int value) => _i1.ColumnValue(
        table.studyMaterialId,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
        table.status,
        value,
      );

  _i1.ColumnValue<String, String> processedText(String? value) =>
      _i1.ColumnValue(
        table.processedText,
        value,
      );

  _i1.ColumnValue<String, String> errorMessage(String? value) =>
      _i1.ColumnValue(
        table.errorMessage,
        value,
      );

  _i1.ColumnValue<int, int> attempts(int value) => _i1.ColumnValue(
        table.attempts,
        value,
      );

  _i1.ColumnValue<int, int> maxAttempts(int value) => _i1.ColumnValue(
        table.maxAttempts,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastStartedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastStartedAt,
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

class FileProcessingTable extends _i1.Table<int?> {
  FileProcessingTable({super.tableRelation})
      : super(tableName: 'file_processing') {
    updateTable = FileProcessingUpdateTable(this);
    studyMaterialId = _i1.ColumnInt(
      'studyMaterialId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    processedText = _i1.ColumnString(
      'processedText',
      this,
    );
    errorMessage = _i1.ColumnString(
      'errorMessage',
      this,
    );
    attempts = _i1.ColumnInt(
      'attempts',
      this,
    );
    maxAttempts = _i1.ColumnInt(
      'maxAttempts',
      this,
    );
    lastStartedAt = _i1.ColumnDateTime(
      'lastStartedAt',
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

  late final FileProcessingUpdateTable updateTable;

  late final _i1.ColumnInt studyMaterialId;

  late final _i1.ColumnString status;

  late final _i1.ColumnString processedText;

  late final _i1.ColumnString errorMessage;

  late final _i1.ColumnInt attempts;

  late final _i1.ColumnInt maxAttempts;

  late final _i1.ColumnDateTime lastStartedAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        studyMaterialId,
        status,
        processedText,
        errorMessage,
        attempts,
        maxAttempts,
        lastStartedAt,
        createdAt,
        updatedAt,
      ];
}

class FileProcessingInclude extends _i1.IncludeObject {
  FileProcessingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FileProcessing.t;
}

class FileProcessingIncludeList extends _i1.IncludeList {
  FileProcessingIncludeList._({
    _i1.WhereExpressionBuilder<FileProcessingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FileProcessing.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FileProcessing.t;
}

class FileProcessingRepository {
  const FileProcessingRepository._();

  /// Returns a list of [FileProcessing]s matching the given query parameters.
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
  Future<List<FileProcessing>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FileProcessingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FileProcessingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FileProcessingTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FileProcessing>(
      where: where?.call(FileProcessing.t),
      orderBy: orderBy?.call(FileProcessing.t),
      orderByList: orderByList?.call(FileProcessing.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FileProcessing] matching the given query parameters.
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
  Future<FileProcessing?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FileProcessingTable>? where,
    int? offset,
    _i1.OrderByBuilder<FileProcessingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FileProcessingTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FileProcessing>(
      where: where?.call(FileProcessing.t),
      orderBy: orderBy?.call(FileProcessing.t),
      orderByList: orderByList?.call(FileProcessing.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FileProcessing] by its [id] or null if no such row exists.
  Future<FileProcessing?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FileProcessing>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FileProcessing]s in the list and returns the inserted rows.
  ///
  /// The returned [FileProcessing]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FileProcessing>> insert(
    _i1.DatabaseSession session,
    List<FileProcessing> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FileProcessing>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FileProcessing] and returns the inserted row.
  ///
  /// The returned [FileProcessing] will have its `id` field set.
  Future<FileProcessing> insertRow(
    _i1.DatabaseSession session,
    FileProcessing row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FileProcessing>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FileProcessing]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FileProcessing>> update(
    _i1.DatabaseSession session,
    List<FileProcessing> rows, {
    _i1.ColumnSelections<FileProcessingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FileProcessing>(
      rows,
      columns: columns?.call(FileProcessing.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FileProcessing]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FileProcessing> updateRow(
    _i1.DatabaseSession session,
    FileProcessing row, {
    _i1.ColumnSelections<FileProcessingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FileProcessing>(
      row,
      columns: columns?.call(FileProcessing.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FileProcessing] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FileProcessing?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<FileProcessingUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FileProcessing>(
      id,
      columnValues: columnValues(FileProcessing.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FileProcessing]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FileProcessing>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<FileProcessingUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FileProcessingTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FileProcessingTable>? orderBy,
    _i1.OrderByListBuilder<FileProcessingTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FileProcessing>(
      columnValues: columnValues(FileProcessing.t.updateTable),
      where: where(FileProcessing.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FileProcessing.t),
      orderByList: orderByList?.call(FileProcessing.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FileProcessing]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FileProcessing>> delete(
    _i1.DatabaseSession session,
    List<FileProcessing> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FileProcessing>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FileProcessing].
  Future<FileProcessing> deleteRow(
    _i1.DatabaseSession session,
    FileProcessing row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FileProcessing>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FileProcessing>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FileProcessingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FileProcessing>(
      where: where(FileProcessing.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<FileProcessingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FileProcessing>(
      where: where?.call(FileProcessing.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FileProcessing] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<FileProcessingTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FileProcessing>(
      where: where(FileProcessing.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
