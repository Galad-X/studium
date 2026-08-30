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

abstract class Institution
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Institution._({
    this.id,
    required this.name,
    required this.country,
    this.region,
    required this.domains,
    this.subjects,
    this.languages,
    this.submittedById,
    this.logoUrl,
    required this.verificationStatus,
    required this.createdAt,
  });

  factory Institution({
    int? id,
    required String name,
    required String country,
    String? region,
    required List<String> domains,
    List<String>? subjects,
    List<String>? languages,
    int? submittedById,
    String? logoUrl,
    required String verificationStatus,
    required DateTime createdAt,
  }) = _InstitutionImpl;

  factory Institution.fromJson(Map<String, dynamic> jsonSerialization) {
    return Institution(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      country: jsonSerialization['country'] as String,
      region: jsonSerialization['region'] as String?,
      domains: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['domains'],
      ),
      subjects: jsonSerialization['subjects'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['subjects'],
            ),
      languages: jsonSerialization['languages'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['languages'],
            ),
      submittedById: jsonSerialization['submittedById'] as int?,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      verificationStatus: jsonSerialization['verificationStatus'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = InstitutionTable();

  static const db = InstitutionRepository._();

  @override
  int? id;

  String name;

  String country;

  String? region;

  List<String> domains;

  List<String>? subjects;

  List<String>? languages;

  int? submittedById;

  String? logoUrl;

  String verificationStatus;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Institution]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Institution copyWith({
    int? id,
    String? name,
    String? country,
    String? region,
    List<String>? domains,
    List<String>? subjects,
    List<String>? languages,
    int? submittedById,
    String? logoUrl,
    String? verificationStatus,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Institution',
      if (id != null) 'id': id,
      'name': name,
      'country': country,
      if (region != null) 'region': region,
      'domains': domains.toJson(),
      if (subjects != null) 'subjects': subjects?.toJson(),
      if (languages != null) 'languages': languages?.toJson(),
      if (submittedById != null) 'submittedById': submittedById,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'verificationStatus': verificationStatus,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Institution',
      if (id != null) 'id': id,
      'name': name,
      'country': country,
      if (region != null) 'region': region,
      'domains': domains.toJson(),
      if (subjects != null) 'subjects': subjects?.toJson(),
      if (languages != null) 'languages': languages?.toJson(),
      if (submittedById != null) 'submittedById': submittedById,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'verificationStatus': verificationStatus,
      'createdAt': createdAt.toJson(),
    };
  }

  static InstitutionInclude include() {
    return InstitutionInclude._();
  }

  static InstitutionIncludeList includeList({
    _i1.WhereExpressionBuilder<InstitutionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InstitutionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InstitutionTable>? orderByList,
    InstitutionInclude? include,
  }) {
    return InstitutionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Institution.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Institution.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InstitutionImpl extends Institution {
  _InstitutionImpl({
    int? id,
    required String name,
    required String country,
    String? region,
    required List<String> domains,
    List<String>? subjects,
    List<String>? languages,
    int? submittedById,
    String? logoUrl,
    required String verificationStatus,
    required DateTime createdAt,
  }) : super._(
          id: id,
          name: name,
          country: country,
          region: region,
          domains: domains,
          subjects: subjects,
          languages: languages,
          submittedById: submittedById,
          logoUrl: logoUrl,
          verificationStatus: verificationStatus,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Institution]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Institution copyWith({
    Object? id = _Undefined,
    String? name,
    String? country,
    Object? region = _Undefined,
    List<String>? domains,
    Object? subjects = _Undefined,
    Object? languages = _Undefined,
    Object? submittedById = _Undefined,
    Object? logoUrl = _Undefined,
    String? verificationStatus,
    DateTime? createdAt,
  }) {
    return Institution(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      region: region is String? ? region : this.region,
      domains: domains ?? this.domains.map((e0) => e0).toList(),
      subjects: subjects is List<String>?
          ? subjects
          : this.subjects?.map((e0) => e0).toList(),
      languages: languages is List<String>?
          ? languages
          : this.languages?.map((e0) => e0).toList(),
      submittedById: submittedById is int? ? submittedById : this.submittedById,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class InstitutionUpdateTable extends _i1.UpdateTable<InstitutionTable> {
  InstitutionUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
        table.name,
        value,
      );

  _i1.ColumnValue<String, String> country(String value) => _i1.ColumnValue(
        table.country,
        value,
      );

  _i1.ColumnValue<String, String> region(String? value) => _i1.ColumnValue(
        table.region,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> domains(List<String> value) =>
      _i1.ColumnValue(
        table.domains,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> subjects(List<String>? value) =>
      _i1.ColumnValue(
        table.subjects,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> languages(List<String>? value) =>
      _i1.ColumnValue(
        table.languages,
        value,
      );

  _i1.ColumnValue<int, int> submittedById(int? value) => _i1.ColumnValue(
        table.submittedById,
        value,
      );

  _i1.ColumnValue<String, String> logoUrl(String? value) => _i1.ColumnValue(
        table.logoUrl,
        value,
      );

  _i1.ColumnValue<String, String> verificationStatus(String value) =>
      _i1.ColumnValue(
        table.verificationStatus,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class InstitutionTable extends _i1.Table<int?> {
  InstitutionTable({super.tableRelation}) : super(tableName: 'institutions') {
    updateTable = InstitutionUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    country = _i1.ColumnString(
      'country',
      this,
    );
    region = _i1.ColumnString(
      'region',
      this,
    );
    domains = _i1.ColumnSerializable<List<String>>(
      'domains',
      this,
    );
    subjects = _i1.ColumnSerializable<List<String>>(
      'subjects',
      this,
    );
    languages = _i1.ColumnSerializable<List<String>>(
      'languages',
      this,
    );
    submittedById = _i1.ColumnInt(
      'submittedById',
      this,
    );
    logoUrl = _i1.ColumnString(
      'logoUrl',
      this,
    );
    verificationStatus = _i1.ColumnString(
      'verificationStatus',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final InstitutionUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString country;

  late final _i1.ColumnString region;

  late final _i1.ColumnSerializable<List<String>> domains;

  late final _i1.ColumnSerializable<List<String>> subjects;

  late final _i1.ColumnSerializable<List<String>> languages;

  late final _i1.ColumnInt submittedById;

  late final _i1.ColumnString logoUrl;

  late final _i1.ColumnString verificationStatus;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        country,
        region,
        domains,
        subjects,
        languages,
        submittedById,
        logoUrl,
        verificationStatus,
        createdAt,
      ];
}

class InstitutionInclude extends _i1.IncludeObject {
  InstitutionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Institution.t;
}

class InstitutionIncludeList extends _i1.IncludeList {
  InstitutionIncludeList._({
    _i1.WhereExpressionBuilder<InstitutionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Institution.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Institution.t;
}

class InstitutionRepository {
  const InstitutionRepository._();

  /// Returns a list of [Institution]s matching the given query parameters.
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
  Future<List<Institution>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InstitutionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InstitutionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InstitutionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Institution>(
      where: where?.call(Institution.t),
      orderBy: orderBy?.call(Institution.t),
      orderByList: orderByList?.call(Institution.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Institution] matching the given query parameters.
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
  Future<Institution?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InstitutionTable>? where,
    int? offset,
    _i1.OrderByBuilder<InstitutionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InstitutionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Institution>(
      where: where?.call(Institution.t),
      orderBy: orderBy?.call(Institution.t),
      orderByList: orderByList?.call(Institution.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Institution] by its [id] or null if no such row exists.
  Future<Institution?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Institution>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Institution]s in the list and returns the inserted rows.
  ///
  /// The returned [Institution]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Institution>> insert(
    _i1.DatabaseSession session,
    List<Institution> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Institution>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Institution] and returns the inserted row.
  ///
  /// The returned [Institution] will have its `id` field set.
  Future<Institution> insertRow(
    _i1.DatabaseSession session,
    Institution row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Institution>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Institution]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Institution>> update(
    _i1.DatabaseSession session,
    List<Institution> rows, {
    _i1.ColumnSelections<InstitutionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Institution>(
      rows,
      columns: columns?.call(Institution.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Institution]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Institution> updateRow(
    _i1.DatabaseSession session,
    Institution row, {
    _i1.ColumnSelections<InstitutionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Institution>(
      row,
      columns: columns?.call(Institution.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Institution] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Institution?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<InstitutionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Institution>(
      id,
      columnValues: columnValues(Institution.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Institution]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Institution>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<InstitutionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<InstitutionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InstitutionTable>? orderBy,
    _i1.OrderByListBuilder<InstitutionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Institution>(
      columnValues: columnValues(Institution.t.updateTable),
      where: where(Institution.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Institution.t),
      orderByList: orderByList?.call(Institution.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Institution]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Institution>> delete(
    _i1.DatabaseSession session,
    List<Institution> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Institution>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Institution].
  Future<Institution> deleteRow(
    _i1.DatabaseSession session,
    Institution row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Institution>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Institution>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InstitutionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Institution>(
      where: where(Institution.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InstitutionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Institution>(
      where: where?.call(Institution.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Institution] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InstitutionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Institution>(
      where: where(Institution.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
