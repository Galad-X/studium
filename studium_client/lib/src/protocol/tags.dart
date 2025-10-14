/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Tag implements _i1.SerializableModel {
  Tag._({
    this.id,
    required this.name,
    required this.studyMaterialId,
    required this.createdAt,
  });

  factory Tag({
    int? id,
    required String name,
    required int studyMaterialId,
    required DateTime createdAt,
  }) = _TagImpl;

  factory Tag.fromJson(Map<String, dynamic> jsonSerialization) {
    return Tag(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  int studyMaterialId;

  DateTime createdAt;

  /// Returns a shallow copy of this [Tag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Tag copyWith({
    int? id,
    String? name,
    int? studyMaterialId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'studyMaterialId': studyMaterialId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TagImpl extends Tag {
  _TagImpl({
    int? id,
    required String name,
    required int studyMaterialId,
    required DateTime createdAt,
  }) : super._(
          id: id,
          name: name,
          studyMaterialId: studyMaterialId,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Tag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Tag copyWith({
    Object? id = _Undefined,
    String? name,
    int? studyMaterialId,
    DateTime? createdAt,
  }) {
    return Tag(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      studyMaterialId: studyMaterialId ?? this.studyMaterialId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
