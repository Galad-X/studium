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

abstract class PaymentTransaction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PaymentTransaction._({
    this.id,
    required this.subscriptionId,
    required this.userId,
    required this.amount,
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
      status: jsonSerialization['status'] as String,
      gateway: jsonSerialization['gateway'] as String,
      transactionId: jsonSerialization['transactionId'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PaymentTransactionTable();

  static const db = PaymentTransactionRepository._();

  @override
  int? id;

  int subscriptionId;

  int userId;

  double amount;

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
    String? status,
    String? gateway,
    String? transactionId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'subscriptionId': subscriptionId,
      'userId': userId,
      'amount': amount,
      'status': status,
      'gateway': gateway,
      'transactionId': transactionId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'subscriptionId': subscriptionId,
      'userId': userId,
      'amount': amount,
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
    required String status,
    required String gateway,
    required String transactionId,
    required DateTime createdAt,
  }) : super._(
          id: id,
          subscriptionId: subscriptionId,
          userId: userId,
          amount: amount,
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
      status: status ?? this.status,
      gateway: gateway ?? this.gateway,
      transactionId: transactionId ?? this.transactionId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PaymentTransactionTable extends _i1.Table<int?> {
  PaymentTransactionTable({super.tableRelation})
      : super(tableName: 'payment_transactions') {
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

  late final _i1.ColumnInt subscriptionId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDouble amount;

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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PaymentTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PaymentTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PaymentTransaction>(
      where: where?.call(PaymentTransaction.t),
      orderBy: orderBy?.call(PaymentTransaction.t),
      orderByList: orderByList?.call(PaymentTransaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PaymentTransactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<PaymentTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PaymentTransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PaymentTransaction>(
      where: where?.call(PaymentTransaction.t),
      orderBy: orderBy?.call(PaymentTransaction.t),
      orderByList: orderByList?.call(PaymentTransaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PaymentTransaction] by its [id] or null if no such row exists.
  Future<PaymentTransaction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PaymentTransaction>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PaymentTransaction]s in the list and returns the inserted rows.
  ///
  /// The returned [PaymentTransaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PaymentTransaction>> insert(
    _i1.Session session,
    List<PaymentTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PaymentTransaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PaymentTransaction] and returns the inserted row.
  ///
  /// The returned [PaymentTransaction] will have its `id` field set.
  Future<PaymentTransaction> insertRow(
    _i1.Session session,
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
    _i1.Session session,
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
    _i1.Session session,
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

  /// Deletes all [PaymentTransaction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PaymentTransaction>> delete(
    _i1.Session session,
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
    _i1.Session session,
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
    _i1.Session session, {
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
    _i1.Session session, {
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
}
