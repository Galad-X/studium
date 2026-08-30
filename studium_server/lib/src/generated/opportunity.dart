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

abstract class Opportunity
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Opportunity._({
    this.id,
    required this.title,
    required this.opportunityType,
    required this.provider,
    required this.country,
    this.eligibilityRegion,
    required this.field,
    required this.educationLevel,
    required this.deadline,
    required this.fundingDetails,
    required this.officialUrl,
    required this.verificationStatus,
    this.sourceId,
    this.externalId,
    this.submittedById,
    this.lastSeenAt,
    this.staleAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Opportunity({
    int? id,
    required String title,
    required String opportunityType,
    required String provider,
    required String country,
    String? eligibilityRegion,
    required String field,
    required String educationLevel,
    required DateTime deadline,
    required String fundingDetails,
    required String officialUrl,
    required String verificationStatus,
    int? sourceId,
    String? externalId,
    int? submittedById,
    DateTime? lastSeenAt,
    DateTime? staleAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OpportunityImpl;

  factory Opportunity.fromJson(Map<String, dynamic> jsonSerialization) {
    return Opportunity(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      opportunityType: jsonSerialization['opportunityType'] as String,
      provider: jsonSerialization['provider'] as String,
      country: jsonSerialization['country'] as String,
      eligibilityRegion: jsonSerialization['eligibilityRegion'] as String?,
      field: jsonSerialization['field'] as String,
      educationLevel: jsonSerialization['educationLevel'] as String,
      deadline: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['deadline'],
      ),
      fundingDetails: jsonSerialization['fundingDetails'] as String,
      officialUrl: jsonSerialization['officialUrl'] as String,
      verificationStatus: jsonSerialization['verificationStatus'] as String,
      sourceId: jsonSerialization['sourceId'] as int?,
      externalId: jsonSerialization['externalId'] as String?,
      submittedById: jsonSerialization['submittedById'] as int?,
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastSeenAt']),
      staleAt: jsonSerialization['staleAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['staleAt']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = OpportunityTable();

  static const db = OpportunityRepository._();

  @override
  int? id;

  String title;

  String opportunityType;

  String provider;

  String country;

  String? eligibilityRegion;

  String field;

  String educationLevel;

  DateTime deadline;

  String fundingDetails;

  String officialUrl;

  String verificationStatus;

  int? sourceId;

  String? externalId;

  int? submittedById;

  DateTime? lastSeenAt;

  DateTime? staleAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Opportunity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Opportunity copyWith({
    int? id,
    String? title,
    String? opportunityType,
    String? provider,
    String? country,
    String? eligibilityRegion,
    String? field,
    String? educationLevel,
    DateTime? deadline,
    String? fundingDetails,
    String? officialUrl,
    String? verificationStatus,
    int? sourceId,
    String? externalId,
    int? submittedById,
    DateTime? lastSeenAt,
    DateTime? staleAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Opportunity',
      if (id != null) 'id': id,
      'title': title,
      'opportunityType': opportunityType,
      'provider': provider,
      'country': country,
      if (eligibilityRegion != null) 'eligibilityRegion': eligibilityRegion,
      'field': field,
      'educationLevel': educationLevel,
      'deadline': deadline.toJson(),
      'fundingDetails': fundingDetails,
      'officialUrl': officialUrl,
      'verificationStatus': verificationStatus,
      if (sourceId != null) 'sourceId': sourceId,
      if (externalId != null) 'externalId': externalId,
      if (submittedById != null) 'submittedById': submittedById,
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
      if (staleAt != null) 'staleAt': staleAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Opportunity',
      if (id != null) 'id': id,
      'title': title,
      'opportunityType': opportunityType,
      'provider': provider,
      'country': country,
      if (eligibilityRegion != null) 'eligibilityRegion': eligibilityRegion,
      'field': field,
      'educationLevel': educationLevel,
      'deadline': deadline.toJson(),
      'fundingDetails': fundingDetails,
      'officialUrl': officialUrl,
      'verificationStatus': verificationStatus,
      if (sourceId != null) 'sourceId': sourceId,
      if (externalId != null) 'externalId': externalId,
      if (submittedById != null) 'submittedById': submittedById,
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
      if (staleAt != null) 'staleAt': staleAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static OpportunityInclude include() {
    return OpportunityInclude._();
  }

  static OpportunityIncludeList includeList({
    _i1.WhereExpressionBuilder<OpportunityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunityTable>? orderByList,
    OpportunityInclude? include,
  }) {
    return OpportunityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Opportunity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Opportunity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OpportunityImpl extends Opportunity {
  _OpportunityImpl({
    int? id,
    required String title,
    required String opportunityType,
    required String provider,
    required String country,
    String? eligibilityRegion,
    required String field,
    required String educationLevel,
    required DateTime deadline,
    required String fundingDetails,
    required String officialUrl,
    required String verificationStatus,
    int? sourceId,
    String? externalId,
    int? submittedById,
    DateTime? lastSeenAt,
    DateTime? staleAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         title: title,
         opportunityType: opportunityType,
         provider: provider,
         country: country,
         eligibilityRegion: eligibilityRegion,
         field: field,
         educationLevel: educationLevel,
         deadline: deadline,
         fundingDetails: fundingDetails,
         officialUrl: officialUrl,
         verificationStatus: verificationStatus,
         sourceId: sourceId,
         externalId: externalId,
         submittedById: submittedById,
         lastSeenAt: lastSeenAt,
         staleAt: staleAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Opportunity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Opportunity copyWith({
    Object? id = _Undefined,
    String? title,
    String? opportunityType,
    String? provider,
    String? country,
    Object? eligibilityRegion = _Undefined,
    String? field,
    String? educationLevel,
    DateTime? deadline,
    String? fundingDetails,
    String? officialUrl,
    String? verificationStatus,
    Object? sourceId = _Undefined,
    Object? externalId = _Undefined,
    Object? submittedById = _Undefined,
    Object? lastSeenAt = _Undefined,
    Object? staleAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Opportunity(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      opportunityType: opportunityType ?? this.opportunityType,
      provider: provider ?? this.provider,
      country: country ?? this.country,
      eligibilityRegion: eligibilityRegion is String?
          ? eligibilityRegion
          : this.eligibilityRegion,
      field: field ?? this.field,
      educationLevel: educationLevel ?? this.educationLevel,
      deadline: deadline ?? this.deadline,
      fundingDetails: fundingDetails ?? this.fundingDetails,
      officialUrl: officialUrl ?? this.officialUrl,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      externalId: externalId is String? ? externalId : this.externalId,
      submittedById: submittedById is int? ? submittedById : this.submittedById,
      lastSeenAt: lastSeenAt is DateTime? ? lastSeenAt : this.lastSeenAt,
      staleAt: staleAt is DateTime? ? staleAt : this.staleAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OpportunityUpdateTable extends _i1.UpdateTable<OpportunityTable> {
  OpportunityUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> opportunityType(String value) =>
      _i1.ColumnValue(
        table.opportunityType,
        value,
      );

  _i1.ColumnValue<String, String> provider(String value) => _i1.ColumnValue(
    table.provider,
    value,
  );

  _i1.ColumnValue<String, String> country(String value) => _i1.ColumnValue(
    table.country,
    value,
  );

  _i1.ColumnValue<String, String> eligibilityRegion(String? value) =>
      _i1.ColumnValue(
        table.eligibilityRegion,
        value,
      );

  _i1.ColumnValue<String, String> field(String value) => _i1.ColumnValue(
    table.field,
    value,
  );

  _i1.ColumnValue<String, String> educationLevel(String value) =>
      _i1.ColumnValue(
        table.educationLevel,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> deadline(DateTime value) =>
      _i1.ColumnValue(
        table.deadline,
        value,
      );

  _i1.ColumnValue<String, String> fundingDetails(String value) =>
      _i1.ColumnValue(
        table.fundingDetails,
        value,
      );

  _i1.ColumnValue<String, String> officialUrl(String value) => _i1.ColumnValue(
    table.officialUrl,
    value,
  );

  _i1.ColumnValue<String, String> verificationStatus(String value) =>
      _i1.ColumnValue(
        table.verificationStatus,
        value,
      );

  _i1.ColumnValue<int, int> sourceId(int? value) => _i1.ColumnValue(
    table.sourceId,
    value,
  );

  _i1.ColumnValue<String, String> externalId(String? value) => _i1.ColumnValue(
    table.externalId,
    value,
  );

  _i1.ColumnValue<int, int> submittedById(int? value) => _i1.ColumnValue(
    table.submittedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastSeenAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> staleAt(DateTime? value) =>
      _i1.ColumnValue(
        table.staleAt,
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

class OpportunityTable extends _i1.Table<int?> {
  OpportunityTable({super.tableRelation}) : super(tableName: 'opportunities') {
    updateTable = OpportunityUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    opportunityType = _i1.ColumnString(
      'opportunityType',
      this,
    );
    provider = _i1.ColumnString(
      'provider',
      this,
    );
    country = _i1.ColumnString(
      'country',
      this,
    );
    eligibilityRegion = _i1.ColumnString(
      'eligibilityRegion',
      this,
    );
    field = _i1.ColumnString(
      'field',
      this,
    );
    educationLevel = _i1.ColumnString(
      'educationLevel',
      this,
    );
    deadline = _i1.ColumnDateTime(
      'deadline',
      this,
    );
    fundingDetails = _i1.ColumnString(
      'fundingDetails',
      this,
    );
    officialUrl = _i1.ColumnString(
      'officialUrl',
      this,
    );
    verificationStatus = _i1.ColumnString(
      'verificationStatus',
      this,
    );
    sourceId = _i1.ColumnInt(
      'sourceId',
      this,
    );
    externalId = _i1.ColumnString(
      'externalId',
      this,
    );
    submittedById = _i1.ColumnInt(
      'submittedById',
      this,
    );
    lastSeenAt = _i1.ColumnDateTime(
      'lastSeenAt',
      this,
    );
    staleAt = _i1.ColumnDateTime(
      'staleAt',
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

  late final OpportunityUpdateTable updateTable;

  late final _i1.ColumnString title;

  late final _i1.ColumnString opportunityType;

  late final _i1.ColumnString provider;

  late final _i1.ColumnString country;

  late final _i1.ColumnString eligibilityRegion;

  late final _i1.ColumnString field;

  late final _i1.ColumnString educationLevel;

  late final _i1.ColumnDateTime deadline;

  late final _i1.ColumnString fundingDetails;

  late final _i1.ColumnString officialUrl;

  late final _i1.ColumnString verificationStatus;

  late final _i1.ColumnInt sourceId;

  late final _i1.ColumnString externalId;

  late final _i1.ColumnInt submittedById;

  late final _i1.ColumnDateTime lastSeenAt;

  late final _i1.ColumnDateTime staleAt;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    opportunityType,
    provider,
    country,
    eligibilityRegion,
    field,
    educationLevel,
    deadline,
    fundingDetails,
    officialUrl,
    verificationStatus,
    sourceId,
    externalId,
    submittedById,
    lastSeenAt,
    staleAt,
    createdAt,
    updatedAt,
  ];
}

class OpportunityInclude extends _i1.IncludeObject {
  OpportunityInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Opportunity.t;
}

class OpportunityIncludeList extends _i1.IncludeList {
  OpportunityIncludeList._({
    _i1.WhereExpressionBuilder<OpportunityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Opportunity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Opportunity.t;
}

class OpportunityRepository {
  const OpportunityRepository._();

  /// Returns a list of [Opportunity]s matching the given query parameters.
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
  Future<List<Opportunity>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunityTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Opportunity>(
      where: where?.call(Opportunity.t),
      orderBy: orderBy?.call(Opportunity.t),
      orderByList: orderByList?.call(Opportunity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Opportunity] matching the given query parameters.
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
  Future<Opportunity?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunityTable>? where,
    int? offset,
    _i1.OrderByBuilder<OpportunityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OpportunityTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Opportunity>(
      where: where?.call(Opportunity.t),
      orderBy: orderBy?.call(Opportunity.t),
      orderByList: orderByList?.call(Opportunity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Opportunity] by its [id] or null if no such row exists.
  Future<Opportunity?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Opportunity>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Opportunity]s in the list and returns the inserted rows.
  ///
  /// The returned [Opportunity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Opportunity>> insert(
    _i1.DatabaseSession session,
    List<Opportunity> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Opportunity>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Opportunity] and returns the inserted row.
  ///
  /// The returned [Opportunity] will have its `id` field set.
  Future<Opportunity> insertRow(
    _i1.DatabaseSession session,
    Opportunity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Opportunity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Opportunity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Opportunity>> update(
    _i1.DatabaseSession session,
    List<Opportunity> rows, {
    _i1.ColumnSelections<OpportunityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Opportunity>(
      rows,
      columns: columns?.call(Opportunity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Opportunity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Opportunity> updateRow(
    _i1.DatabaseSession session,
    Opportunity row, {
    _i1.ColumnSelections<OpportunityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Opportunity>(
      row,
      columns: columns?.call(Opportunity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Opportunity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Opportunity?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OpportunityUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Opportunity>(
      id,
      columnValues: columnValues(Opportunity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Opportunity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Opportunity>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OpportunityUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OpportunityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OpportunityTable>? orderBy,
    _i1.OrderByListBuilder<OpportunityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Opportunity>(
      columnValues: columnValues(Opportunity.t.updateTable),
      where: where(Opportunity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Opportunity.t),
      orderByList: orderByList?.call(Opportunity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Opportunity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Opportunity>> delete(
    _i1.DatabaseSession session,
    List<Opportunity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Opportunity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Opportunity].
  Future<Opportunity> deleteRow(
    _i1.DatabaseSession session,
    Opportunity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Opportunity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Opportunity>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OpportunityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Opportunity>(
      where: where(Opportunity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OpportunityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Opportunity>(
      where: where?.call(Opportunity.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Opportunity] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OpportunityTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Opportunity>(
      where: where(Opportunity.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
