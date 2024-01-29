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

  final List<ChipModel>? postedChips;
  final List<ChipModel>? appliedChips;
  final List<ChipModel>? favoritedChips;
  final List<ChipModel>? binnedChips;

  final Map<String, dynamic>? preferences;

  final int? reportCount;
  final bool? isBanned;

  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isDeleted;
}
