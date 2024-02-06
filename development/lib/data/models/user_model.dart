// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  final List<String> postedChips;
  final List<String> appliedChips;
  final List<String> favoritedChips;
  final List<String> binnedChips;

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
    List<String>? postedChips,
    List<String>? appliedChips,
    List<String>? favoritedChips,
    List<String>? binnedChips,
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
      'postedChips': postedChips,
      'appliedChips': appliedChips,
      'favoritedChips': favoritedChips,
      'binnedChips': binnedChips,
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
      userId: map['userId'] as String,
      role: map['role'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,
      postedChips: List.from(map['postedChips']),
      appliedChips: List.from(map['appliedChips']),
      favoritedChips: List.from(map['favoritedChips']),
      binnedChips: List.from(map['binnedChips']),
      preferences: Map.from((map['preferences'])),
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
}