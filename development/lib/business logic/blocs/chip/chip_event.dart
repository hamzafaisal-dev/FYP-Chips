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
  final String description;
  final String jobMode;
  final File? chipFile;
  final List<String> locations;
  final String jobType;
  final int experienceRequired;
  final DateTime deadline;
  final List<dynamic> skills;
  final double salary;
  final UserModel updatedUser;
  final String uploaderAvatar;

  const UploadChipEvent({
    required this.jobTitle,
    required this.companyName,
    required this.description,
    required this.jobMode,
    this.chipFile,
    required this.locations,
    required this.jobType,
    required this.experienceRequired,
    required this.deadline,
    required this.skills,
    required this.salary,
    required this.updatedUser,
    required this.uploaderAvatar,
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
