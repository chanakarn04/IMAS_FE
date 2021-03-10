import 'package:flutter/foundation.dart';

enum Gender { Male, Female }
enum Status { Yes, No, NotSure }
enum AptStatus { Edited, Passed, Lastest }
enum TreatmentStatus { InProgress, Cured, Hospital, Api }

class Patient {
  final String pId;
  // final String userName;
  // final String password;
  final String pName;
  final String pSurname;
  final DateTime dob;
  final Gender gender;
  final List<String> drugAllegy;
  final Status isSmoke;
  final Status isDiabetes;
  final Status hasHighPress;

  Patient({
    @required this.pId,
    @required this.pName,
    @required this.pSurname,
    @required this.dob,
    @required this.gender,
    @required this.drugAllegy,
    @required this.isSmoke,
    @required this.isDiabetes,
    @required this.hasHighPress,
  });
}

class Doctor {
  final String drId;
  // final String userName;
  // final String password;
  final String namePrefix;
  final String drName;
  final String drSurname;
  final Gender gender;
  final int citizenID;
  final String mdID;
  final String certID;
  // final bool isApproved;

  Doctor({
    @required this.drId,
    @required this.namePrefix,
    @required this.drName,
    @required this.drSurname,
    @required this.gender,
    @required this.citizenID,
    @required this.mdID,
    @required this.certID,
  });
}

class VitalSign {
  final String vsId;
  final String apId;
  final DateTime vsDt;
  final double bodyTemp;
  final double pulse;
  final double respiratRate;
  final String bloodPress;

  VitalSign({
    @required this.vsId,
    @required this.apId,
    @required this.vsDt,
    @required this.bodyTemp,
    @required this.pulse,
    @required this.respiratRate,
    @required this.bloodPress,
  });
}

class DetectedSymptom {
  final String dsId;
  final String apId;
  final String stId;
  final int painScore;
  final DateTime dsDt;

  DetectedSymptom({
    @required this.dsId,
    @required this.apId,
    @required this.stId,
    @required this.painScore,
    @required this.dsDt,
  });
}

class DiagnosedDisease {
  final String ddId;
  final String dId;
  final String apId;

  DiagnosedDisease({
    @required this.ddId,
    @required this.dId,
    @required this.apId,
  });
}

class Drug {
  final int item;
  final String psId;
  final String drugDetail;

  Drug({
    @required this.item,
    @required this.psId,
    @required this.drugDetail,
  });
}

class Prescription {
  final String psId;
  final DateTime psDt;
  final String apId;

  Prescription({
    @required this.psId,
    @required this.psDt,
    @required this.apId,
  });
}

class Appointment {
  final String apId;
  final String tpId;
  final String note;
  final String advises;
  final DateTime apDt;
  final AptStatus status;

  Appointment({
    @required this.apId,
    @required this.tpId,
    @required this.note,
    @required this.advises,
    @required this.apDt,
    @required this.status,
  });
}

class TreatmentPlan {
  final String tpId;
  final String pId;
  final String drId;
  final TreatmentStatus status;

  TreatmentPlan({
    @required this.tpId,
    @required this.pId,
    @required this.drId,
    @required this.status,
  });
}
