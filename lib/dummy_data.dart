import 'package:flutter/foundation.dart';

import './Models/conversation.dart';
import './Models/disease.dart';
import './Models/diseaseAPI.dart';
import './Models/symptom.dart';

enum Gender { Male, Female }
enum Status { Yes, No, NotSure }
enum TreatmentStatus { Edited, Passed, Lastest }
enum AptStatus { InProgress, Cured, Hospital }

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
  // final int citizenID;
  // final String mdID;
  // final String certID;
  // final bool isApproved;

  Doctor({
    @required this.drId,
    @required this.namePrefix,
    @required this.drName,
    @required this.drSurname,
    @required this.gender,
  });
}

class VitalSign {
  final String vsId;
  final String apId;
  final DateTime vsDt;
  final double bodyTemp;
  final double pulse;
  final double bloodPress;
  final double respiratRate;

  VitalSign({
    @required this.vsId,
    @required this.apId,
    @required this.vsDt,
    @required this.bodyTemp,
    @required this.pulse,
    @required this.bloodPress,
    @required this.respiratRate,
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

Patient dummy_Paitent = Patient(
  pId: 'p001',
  pName: 'Harold',
  pSurname: 'Pain',
  dob: DateTime.utc(1998, 4, 4),
  gender: Gender.Male,
  drugAllegy: ['Paracetamol', 'Aspirin'],
  isSmoke: Status.Yes,
  isDiabetes: Status.NotSure,
  hasHighPress: Status.No,
);

final List<Symptom> dummy_symptoms = [
  Symptom('001', 'Head drop'),
  Symptom('002', 'Head tilt in order to avoid diplopia'),
  Symptom('003', 'Head tremors'),
  Symptom('004', 'Headache'),
  Symptom('005', 'Forearm pain'),
  Symptom('006', 'Sensory loss in both arms'),
  Symptom('007', 'Paralysis'),
  Symptom('008', 'Chest pain'),
  Symptom('009', 'Back pain'),
  Symptom('010', 'Dizziness'),
  Symptom('011', 'Dry eyes'),
  Symptom('012', 'Dry skin'),
  Symptom('013', 'Rash'),
];

final List<Disease> diseases = [
  Disease(
    id: 'D001',
    name: 'Tension Headache',
    description:
        'Pain associated with muscle used and working. pain seem to be aggravated over the day and can relieved by rest.',
    treatment: ['Medication', 'Rest'],
    cause:
        'Tension headaches are caused by muscle contractions in the head and neck regions. These types of contractions can be caused by a variety of foods, activities and stressors. Some people develop tension headaches after staring at a computer screen for a long time or after driving for long periods. Cold temperatures may also trigger a tension headache.',
  ),
  Disease(
    id: 'D001',
    name: 'Tension Headache',
    description:
        'Pain associated with muscle used and working. pain seem to be aggravated over the day and can relieved by rest.',
    treatment: ['Medication', 'Rest'],
    cause:
        'Tension headaches are caused by muscle contractions in the head and neck regions. These types of contractions can be caused by a variety of foods, activities and stressors. Some people develop tension headaches after staring at a computer screen for a long time or after driving for long periods. Cold temperatures may also trigger a tension headache.',
  )
];
final List<DiseaseAPI> diseaseAPIs = [
  DiseaseAPI(
      id: 'D001',
      name: 'Some Science Tension Headache',
      commonName: 'Tension Headache',
      sexFilter: 'both',
      categories: ['HeadoThology'],
      prevalence: 'common',
      acuteness: 'acute',
      severity: 'mild',
      extras: {}),
  DiseaseAPI(
      id: 'D001',
      name: 'Some Science Tension Headache',
      commonName: 'Tension Headache',
      sexFilter: 'both',
      categories: ['HeadoThology'],
      prevalence: 'common',
      acuteness: 'acute',
      severity: 'mild',
      extras: {}),
];
