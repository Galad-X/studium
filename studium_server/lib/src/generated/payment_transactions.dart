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

abstract class PaymentTransaction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PaymentTransaction._({
    this.id,
    required this.subscriptionId,
    required this.userId,
    required this.amount,
    this.currency,
    this.settlementAmount,
    this.settlementCurrency,
    this.exchangeRate,
    this.settlementSource,
    required this.status,
    required this.gateway,
    required this.transactionId,
    required this.createdAt,
  });

  factory PaymentTransaction({
    int? id,
    required int subscriptionId,
    required int userId,
    required double amount,
    String? currency,
    double? settlementAmount,
    String? settlementCurrency,
    double? exchangeRate,
    String? settlementSource,
    required String status,
    required String gateway,
    required String transactionId,
    required DateTime createdAt,
  }) = _PaymentTransactionImpl;

  factory PaymentTransaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return PaymentTransaction(
      id: jsonSerialization['id'] as int?,
      subscriptionId: jsonSerialization['subscriptionId'] as int,
      userId: jsonSerialization['userId'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String?,
      settlementAmount:
          (jsonSerialization['settlementAmount'] as num?)?.toDouble(),
      settlementCurrency: jsonSerialization['settlementCurrency'] as String?,
      exchangeRate: (jsonSerialization['exchangeRate'] as num?)?.toDouble(),
      settlementSource: jsonSerialization['settlementSource'] as String?,
      status: jsonSerialization['status'] as String,
      gateway: jsonSerialization['gateway'] as String,
      transactionId: jsonSerialization['transactionId'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PaymentTransactionTable();

  static const db = PaymentTransactionRepository._();

  @override
  int? id;

  int subscriptionId;

  int userId;

  double amount;

  String? currency;

  double? settlementAmount;

  String? settlementCurrency;

  double? exchangeRate;

  String? settlementSource;

  String status;

  String gateway;

  String transactionId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PaymentTransaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PaymentTransaction copyWith({
    int? id,
    int? subscriptionId,
    int? userId,
    double? amount,
    String? currency,
    double? settlementAmount,
    String? settlementCurrency,
    double? exchangeRate,
    String? settlementSource,
    String? status,
    String? gateway,
    String? transactionId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PaymentTransaction',
      if (id != null) 'id': id,
      'subscriptionId': subscriptionId,
      'userId': userId,
      'amount': amount,
      if (currency != null) 'currency': currency,
      if (settlementAmount != null) 'settlementAmount': settlementAmount,
      if (settlementCurrency != null) 'settlementCurrency': settlementCurrency,
      if (exchangeRate != null) 'exchangeRate': exchangeRate,
      if (settlementSource != null) 'settlementSource': settlementSource,
      'status': status,
      'gateway': gateway,
      'transactionId': transactionId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PaymentTransaction',
      if (id != null) 'id': id,
      'subscriptionId': subscriptionId,
      'userId': userId,
      'amount': amount,
      if (currency != null) 'currency': currency,
      if (settlementAmount != null) 'settlementAmount': settlementAmount,
      if (settlementCurrency != null) 'settlementCurrency': settlementCurrency,
      if (exchangeRate != null) 'exchangeRate': exchangeRate,
      if (settlementSource != null) 'settlementSource': settlementSource,
      'status': status,
      'gateway': gateway,
      'transactionId': transactionId,
      'createdAt': createdAt.toJson(),
    };
  }

  static PaymentTransactionInclude include() {
    return PaymentTransactionInclude._();
  }

  static PaymentTransactionIncludeList includeList({
    _i1.WhereExpressionBuilder<PaymentTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTransactionTable>? orderByList,
    PaymentTransactionInclude? include,
  }) {
    return PaymentTransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PaymentTransaction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PaymentTransaction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentTransactionImpl extends PaymentTransaction {
  _PaymentTransactionImpl({
    int? id,
    required int subscriptionId,
    required int userId,
    required double amount,
    String? currency,
    double? settlementAmount,
    String? settlementCurrency,
    double? exchangeRate,
    String? settlementSource,
    required String status,
    required String gateway,
    required String transactionId,
    required DateTime createdAt,
  }) : super._(
          id: id,
          subscriptionId: subscriptionId,
          userId: userId,
          amount: amount,
          currency: currency,
          settlementAmount: settlementAmount,
          settlementCurrency: settlementCurrency,
          exchangeRate: exchangeRate,
          settlementSource: settlementSource,
          status: status,
          gateway: gateway,
          transactionId: transactionId,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [PaymentTransaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PaymentTransaction copyWith({
    Object? id = _Undefined,
    int? subscriptionId,
    int? userId,
    double? amount,
    Object? currency = _Undefined,
    Object? settlementAmount = _Undefined,
    Object? settlementCurrency = _Undefined,
    Object? exchangeRate = _Undefined,
    Object? settlementSource = _Undefined,
    String? status,
    String? gateway,
    String? transactionId,
    DateTime? createdAt,
  }) {
    return PaymentTransaction(
      id: id is int? ? id : this.id,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      currency: currency is String? ? currency : this.currency,
      settlementAmount: settlementAmount is double?
          ? settlementAmount
          : this.settlementAmount,
      settlementCurrency: settlementCurrency is String?
          ? settlementCurrency
          : this.settlementCurrency,
      exchangeRate: exchangeRate is double? ? exchangeRate : this.exchangeRate,
      settlementSource: settlementSource is String?
          ? settlementSource
          : this.settlementSource,
      status: status ?? this.status,
      gateway: gateway ?? this.gateway,
      transactionId: transactionId ?? this.transactionId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PaymentTransactionUpdateTable
    extends _i1.UpdateTable<PaymentTransactionTable> {
  PaymentTransactionUpdateTable(super.table);

  _i1.ColumnValue<int, int> subscriptionId(int value) => _i1.ColumnValue(
        table.subscriptionId,
        value,
      );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<double, double> amount(double value) => _i1.ColumnValue(
        table.amount,
        value,
      );

  _i1.ColumnValue<String, String> currency(String? value) => _i1.ColumnValue(
        table.currency,
        value,
      );

  _i1.ColumnValue<double, double> settlementAmount(double? value) =>
      _i1.ColumnValue(
        table.settlementAmount,
        value,
      );

  _i1.ColumnValue<String, String> settlementCurrency(String? value) =>
      _i1.ColumnValue(
        table.settlementCurrency,
        value,
      );

  _i1.ColumnValue<double, double> exchangeRate(double? value) =>
      _i1.ColumnValue(
        table.exchangeRate,
        value,
      );

  _i1.ColumnValue<String, String> settlementSource(String? value) =>
      _i1.ColumnValue(
        table.settlementSource,
        value,
      );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
        table.status,
        value,
      );

  _i1.ColumnValue<String, String> gateway(String value) => _i1.ColumnValue(
        table.gateway,
        value,
      );

  _i1.ColumnValue<String, String> transactionId(String value) =>
      _i1.ColumnValue(
        table.transactionId,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class PaymentTransactionTable extends _i1.Table<int?> {
  PaymentTransactionTable({super.tableRelation})
      : super(tableName: 'payment_transactions') {
    updateTable = PaymentTransactionUpdateTable(this);
    subscriptionId = _i1.ColumnInt(
      'subscriptionId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    currency = _i1.ColumnString(
      'currency',
      this,
    );
    settlementAmount = _i1.ColumnDouble(
      'settlementAmount',
      this,
    );
    settlementCurrency = _i1.ColumnString(
      'settlementCurrency',
      this,
    );
    exchangeRate = _i1.ColumnDouble(
      'exchangeRate',
      this,
    );
    settlementSource = _i1.ColumnString(
      'settlementSource',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    gateway = _i1.ColumnString(
      'gateway',
      this,
    );
    transactionId = _i1.ColumnString(
      'transactionId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PaymentTransactionUpdateTable updateTable;

  late final _i1.ColumnInt subscriptionId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnString currency;

  late final _i1.ColumnDouble settlementAmount;

  late final _i1.ColumnString settlementCurrency;

  late final _i1.ColumnDouble exchangeRate;

  late final _i1.ColumnString settlementSource;

  late final _i1.ColumnString status;

  late final _i1.ColumnString gateway;

  late final _i1.ColumnString transactionId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        subscriptionId,
        userId,
        amount,
        currency,
        settlementAmount,
        settlementCurrency,
        exchangeRate,
        settlementSource,
        status,
        gateway,
        transactionId,
        createdAt,
      ];
}

class PaymentTransactionInclude extends _i1.IncludeObject {
  PaymentTransactionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PaymentTransaction.t;
}

class PaymentTransactionIncludeList extends _i1.IncludeList {
  PaymentTransactionIncludeList._({
    _i1.WhereExpressionBuilder<PaymentTransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PaymentTransaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PaymentTransaction.t;
}

class PaymentTransactionRepository {
  const PaymentTransactionRepository._();

  /// Returns a list of [PaymentTransaction]s matching the given query parameters.
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
  Future<List<PaymentTransaction>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PaymentTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PaymentTransaction>(
      where: where?.call(PaymentTransaction.t),
      orderBy: orderBy?.call(PaymentTransaction.t),
      orderByList: orderByList?.call(PaymentTransaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PaymentTransaction] matching the given query parameters.
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
  Future<PaymentTransaction?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PaymentTransactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<PaymentTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PaymentTransaction>(
      where: where?.call(PaymentTransaction.t),
      orderBy: orderBy?.call(PaymentTransaction.t),
      orderByList: orderByList?.call(PaymentTransaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PaymentTransaction] by its [id] or null if no such row exists.
  Future<PaymentTransaction?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PaymentTransaction>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PaymentTransaction]s in the list and returns the inserted rows.
  ///
  /// The returned [PaymentTransaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PaymentTransaction>> insert(
    _i1.DatabaseSession session,
    List<PaymentTransaction> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PaymentTransaction>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PaymentTransaction] and returns the inserted row.
  ///
  /// The returned [PaymentTransaction] will have its `id` field set.
  Future<PaymentTransaction> insertRow(
    _i1.DatabaseSession session,
    PaymentTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PaymentTransaction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PaymentTransaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PaymentTransaction>> update(
    _i1.DatabaseSession session,
    List<PaymentTransaction> rows, {
    _i1.ColumnSelections<PaymentTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PaymentTransaction>(
      rows,
      columns: columns?.call(PaymentTransaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PaymentTransaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PaymentTransaction> updateRow(
    _i1.DatabaseSession session,
    PaymentTransaction row, {
    _i1.ColumnSelections<PaymentTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PaymentTransaction>(
      row,
      columns: columns?.call(PaymentTransaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PaymentTransaction] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PaymentTransaction?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PaymentTransactionUpdateTable>
        columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PaymentTransaction>(
      id,
      columnValues: columnValues(PaymentTransaction.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PaymentTransaction]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PaymentTransaction>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PaymentTransactionUpdateTable>
        columnValues,
    required _i1.WhereExpressionBuilder<PaymentTransactionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTransactionTable>? orderBy,
    _i1.OrderByListBuilder<PaymentTransactionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PaymentTransaction>(
      columnValues: columnValues(PaymentTransaction.t.updateTable),
      where: where(PaymentTransaction.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PaymentTransaction.t),
      orderByList: orderByList?.call(PaymentTransaction.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PaymentTransaction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PaymentTransaction>> delete(
    _i1.DatabaseSession session,
    List<PaymentTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PaymentTransaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PaymentTransaction].
  Future<PaymentTransaction> deleteRow(
    _i1.DatabaseSession session,
    PaymentTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PaymentTransaction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PaymentTransaction>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PaymentTransactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PaymentTransaction>(
      where: where(PaymentTransaction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PaymentTransactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PaymentTransaction>(
      where: where?.call(PaymentTransaction.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PaymentTransaction] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PaymentTransactionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PaymentTransaction>(
      where: where(PaymentTransaction.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
