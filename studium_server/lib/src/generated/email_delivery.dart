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

abstract class EmailDelivery
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  EmailDelivery._({
    this.id,
    required this.recipient,
    required this.subject,
    required this.htmlBody,
    this.dedupeKey,
    required this.status,
    required this.attempts,
    required this.maxAttempts,
    required this.availableAt,
    this.lockedAt,
    this.lockToken,
    this.lastError,
    this.sentAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmailDelivery({
    int? id,
    required String recipient,
    required String subject,
    required String htmlBody,
    String? dedupeKey,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EmailDeliveryImpl;

  factory EmailDelivery.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmailDelivery(
      id: jsonSerialization['id'] as int?,
      recipient: jsonSerialization['recipient'] as String,
      subject: jsonSerialization['subject'] as String,
      htmlBody: jsonSerialization['htmlBody'] as String,
      dedupeKey: jsonSerialization['dedupeKey'] as String?,
      status: jsonSerialization['status'] as String,
      attempts: jsonSerialization['attempts'] as int,
      maxAttempts: jsonSerialization['maxAttempts'] as int,
      availableAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['availableAt'],
      ),
      lockedAt: jsonSerialization['lockedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lockedAt']),
      lockToken: jsonSerialization['lockToken'] as String?,
      lastError: jsonSerialization['lastError'] as String?,
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = EmailDeliveryTable();

  static const db = EmailDeliveryRepository._();

  @override
  int? id;

  String recipient;

  String subject;

  String htmlBody;

  String? dedupeKey;

  String status;

  int attempts;

  int maxAttempts;

  DateTime availableAt;

  DateTime? lockedAt;

  String? lockToken;

  String? lastError;

  DateTime? sentAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [EmailDelivery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmailDelivery copyWith({
    int? id,
    String? recipient,
    String? subject,
    String? htmlBody,
    String? dedupeKey,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmailDelivery',
      if (id != null) 'id': id,
      'recipient': recipient,
      'subject': subject,
      'htmlBody': htmlBody,
      if (dedupeKey != null) 'dedupeKey': dedupeKey,
      'status': status,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'availableAt': availableAt.toJson(),
      if (lockedAt != null) 'lockedAt': lockedAt?.toJson(),
      if (lockToken != null) 'lockToken': lockToken,
      if (lastError != null) 'lastError': lastError,
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmailDelivery',
      if (id != null) 'id': id,
      'recipient': recipient,
      'subject': subject,
      'htmlBody': htmlBody,
      if (dedupeKey != null) 'dedupeKey': dedupeKey,
      'status': status,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'availableAt': availableAt.toJson(),
      if (lockedAt != null) 'lockedAt': lockedAt?.toJson(),
      if (lockToken != null) 'lockToken': lockToken,
      if (lastError != null) 'lastError': lastError,
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static EmailDeliveryInclude include() {
    return EmailDeliveryInclude._();
  }

  static EmailDeliveryIncludeList includeList({
    _i1.WhereExpressionBuilder<EmailDeliveryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmailDeliveryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmailDeliveryTable>? orderByList,
    EmailDeliveryInclude? include,
  }) {
    return EmailDeliveryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmailDelivery.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EmailDelivery.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmailDeliveryImpl extends EmailDelivery {
  _EmailDeliveryImpl({
    int? id,
    required String recipient,
    required String subject,
    required String htmlBody,
    String? dedupeKey,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          recipient: recipient,
          subject: subject,
          htmlBody: htmlBody,
          dedupeKey: dedupeKey,
          status: status,
          attempts: attempts,
          maxAttempts: maxAttempts,
          availableAt: availableAt,
          lockedAt: lockedAt,
          lockToken: lockToken,
          lastError: lastError,
          sentAt: sentAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [EmailDelivery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmailDelivery copyWith({
    Object? id = _Undefined,
    String? recipient,
    String? subject,
    String? htmlBody,
    Object? dedupeKey = _Undefined,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    Object? lockedAt = _Undefined,
    Object? lockToken = _Undefined,
    Object? lastError = _Undefined,
    Object? sentAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmailDelivery(
      id: id is int? ? id : this.id,
      recipient: recipient ?? this.recipient,
      subject: subject ?? this.subject,
      htmlBody: htmlBody ?? this.htmlBody,
      dedupeKey: dedupeKey is String? ? dedupeKey : this.dedupeKey,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      availableAt: availableAt ?? this.availableAt,
      lockedAt: lockedAt is DateTime? ? lockedAt : this.lockedAt,
      lockToken: lockToken is String? ? lockToken : this.lockToken,
      lastError: lastError is String? ? lastError : this.lastError,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class EmailDeliveryUpdateTable extends _i1.UpdateTable<EmailDeliveryTable> {
  EmailDeliveryUpdateTable(super.table);

  _i1.ColumnValue<String, String> recipient(String value) => _i1.ColumnValue(
        table.recipient,
        value,
      );

  _i1.ColumnValue<String, String> subject(String value) => _i1.ColumnValue(
        table.subject,
        value,
      );

  _i1.ColumnValue<String, String> htmlBody(String value) => _i1.ColumnValue(
        table.htmlBody,
        value,
      );

  _i1.ColumnValue<String, String> dedupeKey(String? value) => _i1.ColumnValue(
        table.dedupeKey,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
        table.status,
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

  _i1.ColumnValue<DateTime, DateTime> availableAt(DateTime value) =>
      _i1.ColumnValue(
        table.availableAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lockedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lockedAt,
        value,
      );

  _i1.ColumnValue<String, String> lockToken(String? value) => _i1.ColumnValue(
        table.lockToken,
        value,
      );

  _i1.ColumnValue<String, String> lastError(String? value) => _i1.ColumnValue(
        table.lastError,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> sentAt(DateTime? value) =>
      _i1.ColumnValue(
        table.sentAt,
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

class EmailDeliveryTable extends _i1.Table<int?> {
  EmailDeliveryTable({super.tableRelation})
      : super(tableName: 'email_deliveries') {
    updateTable = EmailDeliveryUpdateTable(this);
    recipient = _i1.ColumnString(
      'recipient',
      this,
    );
    subject = _i1.ColumnString(
      'subject',
      this,
    );
    htmlBody = _i1.ColumnString(
      'htmlBody',
      this,
    );
    dedupeKey = _i1.ColumnString(
      'dedupeKey',
      this,
    );
    status = _i1.ColumnString(
      'status',
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
    availableAt = _i1.ColumnDateTime(
      'availableAt',
      this,
    );
    lockedAt = _i1.ColumnDateTime(
      'lockedAt',
      this,
    );
    lockToken = _i1.ColumnString(
      'lockToken',
      this,
    );
    lastError = _i1.ColumnString(
      'lastError',
      this,
    );
    sentAt = _i1.ColumnDateTime(
      'sentAt',
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

  late final EmailDeliveryUpdateTable updateTable;

  late final _i1.ColumnString recipient;

  late final _i1.ColumnString subject;

  late final _i1.ColumnString htmlBody;

  late final _i1.ColumnString dedupeKey;

  late final _i1.ColumnString status;

  late final _i1.ColumnInt attempts;

  late final _i1.ColumnInt maxAttempts;

  late final _i1.ColumnDateTime availableAt;

  late final _i1.ColumnDateTime lockedAt;

  late final _i1.ColumnString lockToken;

  late final _i1.ColumnString lastError;

  late final _i1.ColumnDateTime sentAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        recipient,
        subject,
        htmlBody,
        dedupeKey,
        status,
        attempts,
        maxAttempts,
        availableAt,
        lockedAt,
        lockToken,
        lastError,
        sentAt,
        createdAt,
        updatedAt,
      ];
}

class EmailDeliveryInclude extends _i1.IncludeObject {
  EmailDeliveryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => EmailDelivery.t;
}

class EmailDeliveryIncludeList extends _i1.IncludeList {
  EmailDeliveryIncludeList._({
    _i1.WhereExpressionBuilder<EmailDeliveryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EmailDelivery.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => EmailDelivery.t;
}

class EmailDeliveryRepository {
  const EmailDeliveryRepository._();

  /// Returns a list of [EmailDelivery]s matching the given query parameters.
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
  Future<List<EmailDelivery>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EmailDeliveryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmailDeliveryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmailDeliveryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EmailDelivery>(
      where: where?.call(EmailDelivery.t),
      orderBy: orderBy?.call(EmailDelivery.t),
      orderByList: orderByList?.call(EmailDelivery.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EmailDelivery] matching the given query parameters.
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
  Future<EmailDelivery?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EmailDeliveryTable>? where,
    int? offset,
    _i1.OrderByBuilder<EmailDeliveryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmailDeliveryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EmailDelivery>(
      where: where?.call(EmailDelivery.t),
      orderBy: orderBy?.call(EmailDelivery.t),
      orderByList: orderByList?.call(EmailDelivery.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EmailDelivery] by its [id] or null if no such row exists.
  Future<EmailDelivery?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EmailDelivery>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EmailDelivery]s in the list and returns the inserted rows.
  ///
  /// The returned [EmailDelivery]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<EmailDelivery>> insert(
    _i1.DatabaseSession session,
    List<EmailDelivery> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<EmailDelivery>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [EmailDelivery] and returns the inserted row.
  ///
  /// The returned [EmailDelivery] will have its `id` field set.
  Future<EmailDelivery> insertRow(
    _i1.DatabaseSession session,
    EmailDelivery row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EmailDelivery>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EmailDelivery]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EmailDelivery>> update(
    _i1.DatabaseSession session,
    List<EmailDelivery> rows, {
    _i1.ColumnSelections<EmailDeliveryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EmailDelivery>(
      rows,
      columns: columns?.call(EmailDelivery.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EmailDelivery]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EmailDelivery> updateRow(
    _i1.DatabaseSession session,
    EmailDelivery row, {
    _i1.ColumnSelections<EmailDeliveryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EmailDelivery>(
      row,
      columns: columns?.call(EmailDelivery.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EmailDelivery] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EmailDelivery?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<EmailDeliveryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<EmailDelivery>(
      id,
      columnValues: columnValues(EmailDelivery.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EmailDelivery]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<EmailDelivery>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<EmailDeliveryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EmailDeliveryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmailDeliveryTable>? orderBy,
    _i1.OrderByListBuilder<EmailDeliveryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<EmailDelivery>(
      columnValues: columnValues(EmailDelivery.t.updateTable),
      where: where(EmailDelivery.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EmailDelivery.t),
      orderByList: orderByList?.call(EmailDelivery.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [EmailDelivery]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EmailDelivery>> delete(
    _i1.DatabaseSession session,
    List<EmailDelivery> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EmailDelivery>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EmailDelivery].
  Future<EmailDelivery> deleteRow(
    _i1.DatabaseSession session,
    EmailDelivery row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EmailDelivery>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EmailDelivery>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EmailDeliveryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EmailDelivery>(
      where: where(EmailDelivery.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EmailDeliveryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EmailDelivery>(
      where: where?.call(EmailDelivery.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EmailDelivery] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EmailDeliveryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EmailDelivery>(
      where: where(EmailDelivery.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
