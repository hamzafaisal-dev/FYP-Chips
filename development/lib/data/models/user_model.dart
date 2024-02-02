// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:development/data/models/chip_model.dart';

class UserModel {
  const UserModel({
    required this.userId,
    required this.role,
    required this.email,
    required this.userName,
    required this.postedChips,
    required this.appliedChips,
    required this.favoritedChips,
    required this.binnedChips,
    required this.preferences,
    required this.reportCount,
    required this.isBanned,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isDeleted,
  });

  final String userId;
  final String role;
  final String email;
  final String userName;

  final List<ChipModel> postedChips;
  final List<ChipModel> appliedChips;
  final List<ChipModel> favoritedChips;
  final List<ChipModel> binnedChips;

  final Map<String, dynamic> preferences;

  final int reportCount;
  final bool isBanned;

  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isDeleted;

  UserModel copyWith({
    String? userId,
    String? role,
    String? email,
    String? userName,
    List<ChipModel>? postedChips,
    List<ChipModel>? appliedChips,
    List<ChipModel>? favoritedChips,
    List<ChipModel>? binnedChips,
    Map<String, dynamic>? preferences,
    int? reportCount,
    bool? isBanned,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isDeleted,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      postedChips: postedChips ?? this.postedChips,
      appliedChips: appliedChips ?? this.appliedChips,
      favoritedChips: favoritedChips ?? this.favoritedChips,
      binnedChips: binnedChips ?? this.binnedChips,
      preferences: preferences ?? this.preferences,
      reportCount: reportCount ?? this.reportCount,
      isBanned: isBanned ?? this.isBanned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'role': role,
      'email': email,
      'userName': userName,
      'postedChips': postedChips.map((x) => x.toMap()).toList(),
      'appliedChips': appliedChips.map((x) => x.toMap()).toList(),
      'favoritedChips': favoritedChips.map((x) => x.toMap()).toList(),
      'binnedChips': binnedChips.map((x) => x.toMap()).toList(),
      'preferences': preferences,
      'reportCount': reportCount,
      'isBanned': isBanned,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      //
      userId: map['userId'] as String,
      role: map['role'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,

      postedChips: List<ChipModel>.from(
        (map['postedChips']).map<ChipModel>(
          (x) => ChipModel.fromMap(x as Map<String, dynamic>),
        ),
      ),

      appliedChips: List<ChipModel>.from(
        (map['appliedChips']).map<ChipModel>(
          (x) => ChipModel.fromMap(x as Map<String, dynamic>),
        ),
      ),

      favoritedChips: List<ChipModel>.from(
        (map['favoritedChips']).map<ChipModel>(
          (x) => ChipModel.fromMap(x as Map<String, dynamic>),
        ),
      ),

      binnedChips: List<ChipModel>.from(
        (map['binnedChips']).map<ChipModel>(
          (x) => ChipModel.fromMap(x as Map<String, dynamic>),
        ),
      ),

      preferences: Map<String, dynamic>.from(
          (map['preferences'] as Map<String, dynamic>)),

      reportCount: map['reportCount'] as int,
      isBanned: map['isBanned'] as bool,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      isActive: map['isActive'] as bool,
      isDeleted: map['isDeleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userId: $userId, role: $role, email: $email, userName: $userName, postedChips: $postedChips, appliedChips: $appliedChips, favoritedChips: $favoritedChips, binnedChips: $binnedChips, preferences: $preferences, reportCount: $reportCount, isBanned: $isBanned, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.role == role &&
        other.email == email &&
        other.userName == userName &&
        listEquals(other.postedChips, postedChips) &&
        listEquals(other.appliedChips, appliedChips) &&
        listEquals(other.favoritedChips, favoritedChips) &&
        listEquals(other.binnedChips, binnedChips) &&
        mapEquals(other.preferences, preferences) &&
        other.reportCount == reportCount &&
        other.isBanned == isBanned &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isActive == isActive &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        role.hashCode ^
        email.hashCode ^
        userName.hashCode ^
        postedChips.hashCode ^
        appliedChips.hashCode ^
        favoritedChips.hashCode ^
        binnedChips.hashCode ^
        preferences.hashCode ^
        reportCount.hashCode ^
        isBanned.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        isActive.hashCode ^
        isDeleted.hashCode;
  }
}
