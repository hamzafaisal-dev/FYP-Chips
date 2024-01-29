class ChipModel {
  const ChipModel({
    required this.chipId,
    required this.jobTitle,
    required this.companyName,
    required this.description,
    required this.jobMode,
    required this.locations,
    required this.jobType,
    required this.experienceRequired,
    required this.deadline,
    required this.skills,
    required this.salary,
    required this.isFlagged,
    required this.isExpired,
    required this.reportCount,
    required this.postedBy,
    required this.createdAt,
    this.updatedAt,
    required this.isActive,
    required this.isDeleted,
  });

  final String chipId;
  final String jobTitle;
  final String companyName;
  final String description;
  final String jobMode;
  final List<String> locations;
  final String jobType;
  final int experienceRequired;
  final DateTime deadline;
  final List<dynamic> skills;
  final double salary;
  final String postedBy;
  final int reportCount;

  final bool isFlagged;
  final bool isExpired;

  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isDeleted;
}
