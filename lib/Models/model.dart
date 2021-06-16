import 'package:flutter/foundation.dart';

enum Gender { Male, Female }
enum Status { Yes, No, NotSure }
enum AptStatus { Pass, Cancel, Waiting }
enum TreatmentStatus { InProgress, Healed, Hospital, Api }

Gender gernderGenerate(bool gender) {
  switch (gender) {
    case true:
      return Gender.Male;
      break;
    case false:
      return Gender.Female;
      break;
  }
}

Status statusGenerate(int status) {
  switch (status) {
    case 0:
      return Status.NotSure;
      break;
    case 1:
      return Status.No;
      break;
    case 2:
      return Status.Yes;
      break;
  }
}

AptStatus aptStatusGenerate(int status) {
  switch (status) {
    case 0:
      return AptStatus.Pass;
      break;
    case 1:
      return AptStatus.Cancel;
      break;
    case 2:
      return AptStatus.Waiting;
      break;
  }
}

TreatmentStatus tpStatusGenerate(int status) {
  switch (status) {
    case 0:
      return TreatmentStatus.InProgress;
      break;
    case 1:
      return TreatmentStatus.Healed;
      break;
    case 2:
      return TreatmentStatus.Hospital;
      break;
    case 3:
      return TreatmentStatus.Api;
      break;
  }
}
