import 'dart:io';

import 'package:development/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChipEvent extends Equatable {
  const ChipEvent([List props = const []]) : super();
}

class FetchChips extends ChipEvent {
  const FetchChips() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchChipsStream extends ChipEvent {
  const FetchChipsStream() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadChipEvent extends ChipEvent {
  final String jobTitle;
  final String companyName;
  final String applicationLink;
  final String? description;
  final String? jobMode;
  final File? chipFile;
  final List<String> locations;
  final String? jobType;
  final int? experienceRequired;
  final DateTime deadline;
  final List<dynamic> skills;
  final double? salary;
  final UserModel updatedUser;

  const UploadChipEvent({
    required this.jobTitle,
    required this.companyName,
    required this.applicationLink,
    this.description,
    this.jobMode,
    this.chipFile,
    required this.locations,
    this.jobType,
    this.experienceRequired,
    required this.deadline,
    required this.skills,
    this.salary,
    required this.updatedUser,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class DeleteChipEvent extends ChipEvent {
  final String chipId;
  final UserModel user;

  const DeleteChipEvent({required this.chipId, required this.user});

  @override
  List<Object?> get props => throw UnimplementedError();
}
