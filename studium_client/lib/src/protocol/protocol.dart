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
import 'academic_writings.dart' as _i2;
import 'answers.dart' as _i3;
import 'dashboard_bundle.dart' as _i4;
import 'file_processing.dart' as _i5;
import 'notifications.dart' as _i6;
import 'payment_transactions.dart' as _i7;
import 'questions.dart' as _i8;
import 'research_comparisons.dart' as _i9;
import 'study_history.dart' as _i10;
import 'study_materials.dart' as _i11;
import 'subscriptions.dart' as _i12;
import 'summaries.dart' as _i13;
import 'tags.dart' as _i14;
import 'user_analytics.dart' as _i15;
import 'user_profile.dart' as _i16;
import 'user_profile_bundle.dart' as _i17;
import 'package:studium_client/src/protocol/academic_writings.dart' as _i18;
import 'package:studium_client/src/protocol/questions.dart' as _i19;
import 'package:studium_client/src/protocol/user_analytics.dart' as _i20;
import 'package:studium_client/src/protocol/notifications.dart' as _i21;
import 'package:studium_client/src/protocol/study_materials.dart' as _i22;
import 'package:studium_client/src/protocol/summaries.dart' as _i23;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i24;
export 'academic_writings.dart';
export 'answers.dart';
export 'dashboard_bundle.dart';
export 'file_processing.dart';
export 'notifications.dart';
export 'payment_transactions.dart';
export 'questions.dart';
export 'research_comparisons.dart';
export 'study_history.dart';
export 'study_materials.dart';
export 'subscriptions.dart';
export 'summaries.dart';
export 'tags.dart';
export 'user_analytics.dart';
export 'user_profile.dart';
export 'user_profile_bundle.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.AcademicWriting) {
      return _i2.AcademicWriting.fromJson(data) as T;
    }
    if (t == _i3.Answer) {
      return _i3.Answer.fromJson(data) as T;
    }
    if (t == _i4.DashboardBundle) {
      return _i4.DashboardBundle.fromJson(data) as T;
    }
    if (t == _i5.FileProcessing) {
      return _i5.FileProcessing.fromJson(data) as T;
    }
    if (t == _i6.Notification) {
      return _i6.Notification.fromJson(data) as T;
    }
    if (t == _i7.PaymentTransaction) {
      return _i7.PaymentTransaction.fromJson(data) as T;
    }
    if (t == _i8.Question) {
      return _i8.Question.fromJson(data) as T;
    }
    if (t == _i9.ResearchComparison) {
      return _i9.ResearchComparison.fromJson(data) as T;
    }
    if (t == _i10.StudyHistory) {
      return _i10.StudyHistory.fromJson(data) as T;
    }
    if (t == _i11.StudyMaterial) {
      return _i11.StudyMaterial.fromJson(data) as T;
    }
    if (t == _i12.Subscription) {
      return _i12.Subscription.fromJson(data) as T;
    }
    if (t == _i13.Summary) {
      return _i13.Summary.fromJson(data) as T;
    }
    if (t == _i14.Tag) {
      return _i14.Tag.fromJson(data) as T;
    }
    if (t == _i15.UserAnalytics) {
      return _i15.UserAnalytics.fromJson(data) as T;
    }
    if (t == _i16.UserProfile) {
      return _i16.UserProfile.fromJson(data) as T;
    }
    if (t == _i17.UserProfileBundle) {
      return _i17.UserProfileBundle.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AcademicWriting?>()) {
      return (data != null ? _i2.AcademicWriting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Answer?>()) {
      return (data != null ? _i3.Answer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.DashboardBundle?>()) {
      return (data != null ? _i4.DashboardBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.FileProcessing?>()) {
      return (data != null ? _i5.FileProcessing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Notification?>()) {
      return (data != null ? _i6.Notification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.PaymentTransaction?>()) {
      return (data != null ? _i7.PaymentTransaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Question?>()) {
      return (data != null ? _i8.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ResearchComparison?>()) {
      return (data != null ? _i9.ResearchComparison.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.StudyHistory?>()) {
      return (data != null ? _i10.StudyHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.StudyMaterial?>()) {
      return (data != null ? _i11.StudyMaterial.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Subscription?>()) {
      return (data != null ? _i12.Subscription.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Summary?>()) {
      return (data != null ? _i13.Summary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Tag?>()) {
      return (data != null ? _i14.Tag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.UserAnalytics?>()) {
      return (data != null ? _i15.UserAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.UserProfile?>()) {
      return (data != null ? _i16.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.UserProfileBundle?>()) {
      return (data != null ? _i17.UserProfileBundle.fromJson(data) : null) as T;
    }
    if (t == List<_i11.StudyMaterial>) {
      return (data as List)
          .map((e) => deserialize<_i11.StudyMaterial>(e))
          .toList() as T;
    }
    if (t == List<_i13.Summary>) {
      return (data as List).map((e) => deserialize<_i13.Summary>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i18.AcademicWriting>) {
      return (data as List)
          .map((e) => deserialize<_i18.AcademicWriting>(e))
          .toList() as T;
    }
    if (t == List<_i19.Question>) {
      return (data as List).map((e) => deserialize<_i19.Question>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == List<_i20.UserAnalytics>) {
      return (data as List)
          .map((e) => deserialize<_i20.UserAnalytics>(e))
          .toList() as T;
    }
    if (t == List<_i21.Notification>) {
      return (data as List)
          .map((e) => deserialize<_i21.Notification>(e))
          .toList() as T;
    }
    if (t == List<_i22.StudyMaterial>) {
      return (data as List)
          .map((e) => deserialize<_i22.StudyMaterial>(e))
          .toList() as T;
    }
    if (t == _i1.getType<Map<String, dynamic>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<dynamic>(v)))
          : null) as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<dynamic>(v))) as T;
    }
    if (t == List<_i23.Summary>) {
      return (data as List).map((e) => deserialize<_i23.Summary>(e)).toList()
          as T;
    }
    try {
      return _i24.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.AcademicWriting) {
      return 'AcademicWriting';
    }
    if (data is _i3.Answer) {
      return 'Answer';
    }
    if (data is _i4.DashboardBundle) {
      return 'DashboardBundle';
    }
    if (data is _i5.FileProcessing) {
      return 'FileProcessing';
    }
    if (data is _i6.Notification) {
      return 'Notification';
    }
    if (data is _i7.PaymentTransaction) {
      return 'PaymentTransaction';
    }
    if (data is _i8.Question) {
      return 'Question';
    }
    if (data is _i9.ResearchComparison) {
      return 'ResearchComparison';
    }
    if (data is _i10.StudyHistory) {
      return 'StudyHistory';
    }
    if (data is _i11.StudyMaterial) {
      return 'StudyMaterial';
    }
    if (data is _i12.Subscription) {
      return 'Subscription';
    }
    if (data is _i13.Summary) {
      return 'Summary';
    }
    if (data is _i14.Tag) {
      return 'Tag';
    }
    if (data is _i15.UserAnalytics) {
      return 'UserAnalytics';
    }
    if (data is _i16.UserProfile) {
      return 'UserProfile';
    }
    if (data is _i17.UserProfileBundle) {
      return 'UserProfileBundle';
    }
    className = _i24.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AcademicWriting') {
      return deserialize<_i2.AcademicWriting>(data['data']);
    }
    if (dataClassName == 'Answer') {
      return deserialize<_i3.Answer>(data['data']);
    }
    if (dataClassName == 'DashboardBundle') {
      return deserialize<_i4.DashboardBundle>(data['data']);
    }
    if (dataClassName == 'FileProcessing') {
      return deserialize<_i5.FileProcessing>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_i6.Notification>(data['data']);
    }
    if (dataClassName == 'PaymentTransaction') {
      return deserialize<_i7.PaymentTransaction>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_i8.Question>(data['data']);
    }
    if (dataClassName == 'ResearchComparison') {
      return deserialize<_i9.ResearchComparison>(data['data']);
    }
    if (dataClassName == 'StudyHistory') {
      return deserialize<_i10.StudyHistory>(data['data']);
    }
    if (dataClassName == 'StudyMaterial') {
      return deserialize<_i11.StudyMaterial>(data['data']);
    }
    if (dataClassName == 'Subscription') {
      return deserialize<_i12.Subscription>(data['data']);
    }
    if (dataClassName == 'Summary') {
      return deserialize<_i13.Summary>(data['data']);
    }
    if (dataClassName == 'Tag') {
      return deserialize<_i14.Tag>(data['data']);
    }
    if (dataClassName == 'UserAnalytics') {
      return deserialize<_i15.UserAnalytics>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i16.UserProfile>(data['data']);
    }
    if (dataClassName == 'UserProfileBundle') {
      return deserialize<_i17.UserProfileBundle>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i24.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
