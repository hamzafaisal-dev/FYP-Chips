// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChipModel {
  const ChipModel({
    required this.chipId,
    required this.jobTitle,
    required this.companyName,
    required this.applicationLink,
    this.description,
    this.jobMode,
    this.locations,
    this.jobType,
    this.experienceRequired,
    required this.deadline,
    required this.skills,
    this.imageUrl,
    this.salary,
    required this.postedBy,
    required this.reportCount,
    required this.isFlagged,
    required this.isExpired,
    required this.createdAt,
    this.updatedAt,
    required this.isActive,
    required this.isDeleted,
  });

  final String chipId;
  final String jobTitle;
  final String companyName;
  final String applicationLink; // this can be a url, a phone number or an email
  final String? description;
  final String? jobMode;
  final List<String>? locations;
  final String? jobType;
  final int? experienceRequired;
  final DateTime deadline;
  final List<dynamic> skills;
  final String? imageUrl;
  final double? salary;
  final String postedBy;
  final int reportCount;

  final bool isFlagged;
  final bool isExpired;

  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isDeleted;

  factory ChipModel.fromMap(Map<String, dynamic> map) {
    return ChipModel(
      chipId: map['chipId'] as String,
      jobTitle: map['jobTitle'] as String,
      companyName: map['companyName'] as String,
      applicationLink: map['applicationLink'] as String,
      description: map['description'] as String,
      jobMode: map['jobMode'],
      locations: List<String>.from(map['locations']),
      jobType: map['jobType'],
      experienceRequired: map['experienceRequired'],
      deadline: (map['deadline'] as Timestamp).toDate(),
      skills: List<dynamic>.from(map['skills']),
      imageUrl: map['imageUrl'],
      salary: map['salary'],
      postedBy: map['postedBy'] as String,
      reportCount: map['reportCount'] as int,
      isFlagged: map['isFlagged'] as bool,
      isExpired: map['isExpired'] as bool,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
      isActive: map['isActive'] as bool,
      isDeleted: map['isDeleted'] as bool,
    );
  }

  ChipModel copyWith({
    String? chipId,
    String? jobTitle,
    String? companyName,
    String? applicationLink,
    String? description,
    String? jobMode,
    List<String>? locations,
    String? jobType,
    int? experienceRequired,
    DateTime? deadline,
    List<dynamic>? skills,
    String? imageUrl,
    double? salary,
    String? postedBy,
    int? reportCount,
    bool? isFlagged,
    bool? isExpired,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isDeleted,
  }) {
    return ChipModel(
      chipId: chipId ?? this.chipId,
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      applicationLink: applicationLink ?? this.applicationLink,
      description: description ?? this.description,
      jobMode: jobMode ?? this.jobMode,
      locations: locations ?? this.locations,
      jobType: jobType ?? this.jobType,
      experienceRequired: experienceRequired ?? this.experienceRequired,
      deadline: deadline ?? this.deadline,
      skills: skills ?? this.skills,
      imageUrl: imageUrl ?? this.imageUrl,
      salary: salary ?? this.salary,
      postedBy: postedBy ?? this.postedBy,
      reportCount: reportCount ?? this.reportCount,
      isFlagged: isFlagged ?? this.isFlagged,
      isExpired: isExpired ?? this.isExpired,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chipId': chipId,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'applicationLink': applicationLink,
      'description': description,
      'jobMode': jobMode,
      'locations': locations,
      'jobType': jobType,
      'experienceRequired': experienceRequired,
      'deadline': deadline.millisecondsSinceEpoch,
      'skills': skills,
      'imageUrl': imageUrl,
      'salary': salary,
      'postedBy': postedBy,
      'reportCount': reportCount,
      'isFlagged': isFlagged,
      'isExpired': isExpired,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }

  String toJson() => json.encode(toMap());

  factory ChipModel.fromJson(String source) =>
      ChipModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChipModel(chipId: $chipId, jobTitle: $jobTitle, companyName: $companyName, applicationLink: $applicationLink, description: $description, jobMode: $jobMode, locations: $locations, jobType: $jobType, experienceRequired: $experienceRequired, deadline: $deadline, skills: $skills, imageUrl: $imageUrl, salary: $salary, postedBy: $postedBy, reportCount: $reportCount, isFlagged: $isFlagged, isExpired: $isExpired, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, isDeleted: $isDeleted)';
  }
}
