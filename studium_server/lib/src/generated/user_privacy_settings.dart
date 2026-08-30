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

abstract class UserPrivacySettings
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserPrivacySettings._({
    this.id,
    required this.userId,
    bool? isMinor,
    bool? allowUnknownDirectMessages,
    required this.updatedAt,
  })  : isMinor = isMinor ?? false,
        allowUnknownDirectMessages = allowUnknownDirectMessages ?? true;

  factory UserPrivacySettings({
    int? id,
    required int userId,
    bool? isMinor,
    bool? allowUnknownDirectMessages,
    required DateTime updatedAt,
  }) = _UserPrivacySettingsImpl;

  factory UserPrivacySettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPrivacySettings(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      isMinor: jsonSerialization['isMinor'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isMinor']),
      allowUnknownDirectMessages:
          jsonSerialization['allowUnknownDirectMessages'] == null
              ? null
              : _i1.BoolJsonExtension.fromJson(
                  jsonSerialization['allowUnknownDirectMessages'],
                ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = UserPrivacySettingsTable();

  static const db = UserPrivacySettingsRepository._();

  @override
  int? id;

  int userId;

  bool isMinor;

  bool allowUnknownDirectMessages;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserPrivacySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserPrivacySettings copyWith({
    int? id,
    int? userId,
    bool? isMinor,
    bool? allowUnknownDirectMessages,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserPrivacySettings',
      if (id != null) 'id': id,
      'userId': userId,
      'isMinor': isMinor,
      'allowUnknownDirectMessages': allowUnknownDirectMessages,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserPrivacySettings',
      if (id != null) 'id': id,
      'userId': userId,
      'isMinor': isMinor,
      'allowUnknownDirectMessages': allowUnknownDirectMessages,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserPrivacySettingsInclude include() {
    return UserPrivacySettingsInclude._();
  }

  static UserPrivacySettingsIncludeList includeList({
    _i1.WhereExpressionBuilder<UserPrivacySettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPrivacySettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPrivacySettingsTable>? orderByList,
    UserPrivacySettingsInclude? include,
  }) {
    return UserPrivacySettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserPrivacySettings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserPrivacySettings.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPrivacySettingsImpl extends UserPrivacySettings {
  _UserPrivacySettingsImpl({
    int? id,
    required int userId,
    bool? isMinor,
    bool? allowUnknownDirectMessages,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          isMinor: isMinor,
          allowUnknownDirectMessages: allowUnknownDirectMessages,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [UserPrivacySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserPrivacySettings copyWith({
    Object? id = _Undefined,
    int? userId,
    bool? isMinor,
    bool? allowUnknownDirectMessages,
    DateTime? updatedAt,
  }) {
    return UserPrivacySettings(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      isMinor: isMinor ?? this.isMinor,
      allowUnknownDirectMessages:
          allowUnknownDirectMessages ?? this.allowUnknownDirectMessages,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserPrivacySettingsUpdateTable
    extends _i1.UpdateTable<UserPrivacySettingsTable> {
  UserPrivacySettingsUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<bool, bool> isMinor(bool value) => _i1.ColumnValue(
        table.isMinor,
        value,
      );

  _i1.ColumnValue<bool, bool> allowUnknownDirectMessages(bool value) =>
      _i1.ColumnValue(
        table.allowUnknownDirectMessages,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class UserPrivacySettingsTable extends _i1.Table<int?> {
  UserPrivacySettingsTable({super.tableRelation})
      : super(tableName: 'user_privacy_settings') {
    updateTable = UserPrivacySettingsUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    isMinor = _i1.ColumnBool(
      'isMinor',
      this,
      hasDefault: true,
    );
    allowUnknownDirectMessages = _i1.ColumnBool(
      'allowUnknownDirectMessages',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final UserPrivacySettingsUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnBool isMinor;

  late final _i1.ColumnBool allowUnknownDirectMessages;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        isMinor,
        allowUnknownDirectMessages,
        updatedAt,
      ];
}

class UserPrivacySettingsInclude extends _i1.IncludeObject {
  UserPrivacySettingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserPrivacySettings.t;
}

class UserPrivacySettingsIncludeList extends _i1.IncludeList {
  UserPrivacySettingsIncludeList._({
    _i1.WhereExpressionBuilder<UserPrivacySettingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserPrivacySettings.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserPrivacySettings.t;
}

class UserPrivacySettingsRepository {
  const UserPrivacySettingsRepository._();

  /// Returns a list of [UserPrivacySettings]s matching the given query parameters.
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
  Future<List<UserPrivacySettings>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserPrivacySettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPrivacySettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPrivacySettingsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserPrivacySettings>(
      where: where?.call(UserPrivacySettings.t),
      orderBy: orderBy?.call(UserPrivacySettings.t),
      orderByList: orderByList?.call(UserPrivacySettings.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserPrivacySettings] matching the given query parameters.
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
  Future<UserPrivacySettings?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserPrivacySettingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserPrivacySettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserPrivacySettingsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserPrivacySettings>(
      where: where?.call(UserPrivacySettings.t),
      orderBy: orderBy?.call(UserPrivacySettings.t),
      orderByList: orderByList?.call(UserPrivacySettings.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserPrivacySettings] by its [id] or null if no such row exists.
  Future<UserPrivacySettings?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserPrivacySettings>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserPrivacySettings]s in the list and returns the inserted rows.
  ///
  /// The returned [UserPrivacySettings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserPrivacySettings>> insert(
    _i1.DatabaseSession session,
    List<UserPrivacySettings> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserPrivacySettings>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserPrivacySettings] and returns the inserted row.
  ///
  /// The returned [UserPrivacySettings] will have its `id` field set.
  Future<UserPrivacySettings> insertRow(
    _i1.DatabaseSession session,
    UserPrivacySettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserPrivacySettings>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserPrivacySettings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserPrivacySettings>> update(
    _i1.DatabaseSession session,
    List<UserPrivacySettings> rows, {
    _i1.ColumnSelections<UserPrivacySettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserPrivacySettings>(
      rows,
      columns: columns?.call(UserPrivacySettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserPrivacySettings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserPrivacySettings> updateRow(
    _i1.DatabaseSession session,
    UserPrivacySettings row, {
    _i1.ColumnSelections<UserPrivacySettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserPrivacySettings>(
      row,
      columns: columns?.call(UserPrivacySettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserPrivacySettings] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserPrivacySettings?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserPrivacySettingsUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserPrivacySettings>(
      id,
      columnValues: columnValues(UserPrivacySettings.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserPrivacySettings]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserPrivacySettings>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserPrivacySettingsUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<UserPrivacySettingsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserPrivacySettingsTable>? orderBy,
    _i1.OrderByListBuilder<UserPrivacySettingsTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserPrivacySettings>(
      columnValues: columnValues(UserPrivacySettings.t.updateTable),
      where: where(UserPrivacySettings.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserPrivacySettings.t),
      orderByList: orderByList?.call(UserPrivacySettings.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserPrivacySettings]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserPrivacySettings>> delete(
    _i1.DatabaseSession session,
    List<UserPrivacySettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserPrivacySettings>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserPrivacySettings].
  Future<UserPrivacySettings> deleteRow(
    _i1.DatabaseSession session,
    UserPrivacySettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserPrivacySettings>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserPrivacySettings>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserPrivacySettingsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserPrivacySettings>(
      where: where(UserPrivacySettings.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserPrivacySettingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserPrivacySettings>(
      where: where?.call(UserPrivacySettings.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserPrivacySettings] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserPrivacySettingsTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserPrivacySettings>(
      where: where(UserPrivacySettings.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
