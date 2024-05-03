// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  const UserModel({
    required this.userId,
    required this.role,
    required this.email,
    required this.username,
    required this.name,
    required this.postedChips,
    required this.appliedChips,
    required this.favoritedChips,
    required this.binnedChips,
    this.skills,
    required this.preferences,
    required this.reportCount,
    required this.isBanned,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isDeleted,
    required this.profilePictureUrl,
    required this.likesCount,
    required this.dislikesCount,
    required this.bookmarkCount,
  });

  final String userId;
  final String role;
  final String email;
  final String username;
  final String name;
  final List<String> postedChips;
  final List<String> appliedChips;
  final List<String> favoritedChips;
  final List<String> binnedChips;
  final List<String>? skills;
  final Map<String, dynamic> preferences;
  final int reportCount;
  final bool isBanned;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isDeleted;
  final String profilePictureUrl;
  final int likesCount;
  final int dislikesCount;
  final int bookmarkCount;

  UserModel copyWith({
    String? userId,
    String? role,
    String? email,
    String? userName,
    String? name,
    List<String>? postedChips,
    List<String>? appliedChips,
    List<String>? favoritedChips,
    List<String>? binnedChips,
    List<String>? skills,
    Map<String, dynamic>? preferences,
    int? reportCount,
    bool? isBanned,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isDeleted,
    String? profilePictureUrl,
    int? likesCount,
    int? dislikesCount,
    int? bookmarkCount,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      email: email ?? this.email,
      username: userName ?? username,
      name: name ?? this.name,
      postedChips: postedChips ?? this.postedChips,
      appliedChips: appliedChips ?? this.appliedChips,
      favoritedChips: favoritedChips ?? this.favoritedChips,
      binnedChips: binnedChips ?? this.binnedChips,
      skills: skills ?? this.skills,
      preferences: preferences ?? this.preferences,
      reportCount: reportCount ?? this.reportCount,
      isBanned: isBanned ?? this.isBanned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      likesCount: likesCount ?? this.likesCount,
      dislikesCount: dislikesCount ?? this.dislikesCount,
      bookmarkCount: bookmarkCount ?? this.bookmarkCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'role': role,
      'email': email,
      'userName': username,
      'name': name,
      'postedChips': postedChips,
      'appliedChips': appliedChips,
      'favoritedChips': favoritedChips,
      'binnedChips': binnedChips,
      'skills': skills,
      'preferences': preferences,
      'reportCount': reportCount,
      'isBanned': isBanned,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'profilePictureUrl': profilePictureUrl,
      'likesCount': likesCount,
      'dislikesCount': dislikesCount,
      'bookmarkCount': bookmarkCount,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      role: map['role'] as String,
      email: map['email'] as String,
      username: map['userName'] as String,
      name: map['name'] as String,
      postedChips: List.from(map['postedChips']),
      appliedChips: List.from(map['appliedChips']),
      favoritedChips: List.from(map['favoritedChips']),
      binnedChips: List.from(map['binnedChips']),
      skills: List.from(map['skills']),
      preferences: Map.from((map['preferences'])),
      reportCount: map['reportCount'] as int,
      isBanned: map['isBanned'] as bool,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      isActive: map['isActive'] as bool,
      isDeleted: map['isDeleted'] as bool,
      profilePictureUrl: map['profilePictureUrl'] as String,
      likesCount: map['likesCount'] as int,
      dislikesCount: map['dislikesCount'] as int,
      bookmarkCount: map['bookmarkCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
