import 'package:flutter/foundation.dart';

import './Models/conversation.dart';
import './Models/disease.dart';
import './Models/diseaseAPI.dart';
import './Models/symptom.dart';

enum Gender { Male, Female }
enum Status { Yes, No, NotSure }
enum AptStatus { Edited, Passed, Lastest }
enum TreatmentStatus { InProgress, Cured, Hospital }

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

final Patient dummy_Paitent = Patient(
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

final Doctor dummy_doctor = Doctor(
  drId: 'd001',
  drName: 'Harold',
  drSurname: 'NoPain',
  namePrefix: 'Dr.',
  gender: Gender.Male,
);

final TreatmentPlan dummy_treatmentPlan = TreatmentPlan(
  tpId: 'tp001',
  pId: 'p001',
  drId: 'd001',
  status: TreatmentStatus.InProgress,
);

final List<Appointment> dummy_appointment = [
  Appointment(
    apId: 'ap001',
    tpId: 'tp001',
    note: '',
    advises: 'Rest mak mak na',
    apDt: DateTime.utc(2020, 12, 20),
    status: AptStatus.Edited,
  ),
  Appointment(
    apId: 'ap002',
    tpId: 'tp001',
    note: '',
    advises: 'Kin kwaw yer yer',
    apDt: DateTime.utc(2020, 12, 26),
    status: AptStatus.Edited,
  ),
  Appointment(
    apId: 'ap003',
    tpId: 'tp001',
    note: '',
    advises: '',
    apDt: DateTime.now(),
    status: AptStatus.Lastest,
  ),
];

final List<Symptom> dummy_symptoms = [
  Symptom('s001', 'Head drop'),
  Symptom('s002', 'Head tilt in order to avoid diplopia'),
  Symptom('s003', 'Head tremors'),
  Symptom('s004', 'Headache'),
  Symptom('s005', 'Forearm pain'),
  Symptom('s006', 'Sensory loss in both arms'),
  Symptom('s007', 'Paralysis'),
  Symptom('s008', 'Chest pain'),
  Symptom('s009', 'Back pain'),
  Symptom('s010', 'Dizziness'),
  Symptom('s011', 'Dry eyes'),
  Symptom('s012', 'Dry skin'),
  Symptom('s013', 'Rash'),
];

final List<Disease> dummy_diseases = [
  Disease(
    id: 'd001',
    name: 'Tension Headache',
    description:
        'Pain associated with muscle used and working. pain seem to be aggravated over the day and can relieved by rest.',
    treatment: ['Medication', 'Rest'],
    cause:
        'Tension headaches are caused by muscle contractions in the head and neck regions. These types of contractions can be caused by a variety of foods, activities and stressors. Some people develop tension headaches after staring at a computer screen for a long time or after driving for long periods. Cold temperatures may also trigger a tension headache.',
  ),
];

final List<DiseaseAPI> dummy_diseaseAPIs = [
  DiseaseAPI(
      id: 'd001',
      name: 'Some Science Tension Headache',
      commonName: 'Tension Headache',
      sexFilter: 'both',
      categories: ['HeadoThology'],
      prevalence: 'common',
      acuteness: 'acute',
      severity: 'mild',
      extras: {}),
];

final List<Prescription> dummy_prescriptions = [
  Prescription(
    psId: 'ps001',
    psDt: DateTime.utc(2020, 12, 20),
    apId: 'ap001',
  ),
  Prescription(
    psId: 'ps002',
    psDt: DateTime.utc(2020, 12, 26),
    apId: 'ap002',
  ),
];

final List<Drug> dummy_drug = [
  Drug(
    item: 1,
    psId: 'ps001',
    drugDetail: 'Paracetamol',
  ),
  Drug(
    item: 1,
    psId: 'ps002',
    drugDetail: 'Paracetamol',
  ),
  Drug(
    item: 2,
    psId: 'ps002',
    drugDetail: 'Bakamol',
  ),
];

final List<DetectedSymptom> dummy_dtdSymptoms = [
  DetectedSymptom(
    dsId: 'ds001',
    apId: 'ap001',
    stId: 's004',
    painScore: 1,
    dsDt: DateTime.utc(2020, 12, 20),
  ),
  DetectedSymptom(
    dsId: 'ds002',
    apId: 'ap002',
    stId: 's004',
    painScore: 6,
    dsDt: DateTime.utc(2020, 12, 26),
  ),
  DetectedSymptom(
    dsId: 'ds003',
    apId: 'ap002',
    stId: 's007',
    painScore: 9,
    dsDt: DateTime.utc(2020, 12, 26),
  ),
];

final List<DiagnosedDisease> dummy_diagDiseases = [
  DiagnosedDisease(ddId: 'dd001', dId: 'd001', apId: 'ap001'),
  DiagnosedDisease(ddId: 'dd002', dId: 'd001', apId: 'ap002'),
];

final List<VitalSign> dummy_vitalSign = [
  VitalSign(
    vsId: 'vs001',
    apId: 'ap001',
    vsDt: DateTime.utc(2020, 12, 20),
    bodyTemp: 36.5,
    pulse: 87.0,
    respiratRate: 15,
    bloodPress: '80/120',
  ),
  VitalSign(
    vsId: 'vs002',
    apId: 'ap001',
    vsDt: DateTime.utc(2020, 12, 26),
    bodyTemp: 37.5,
    pulse: 90.0,
    respiratRate: null,
    bloodPress: null,
  ),
  VitalSign(
    vsId: 'vs003',
    apId: 'ap003',
    vsDt: DateTime.utc(2020, 12, 27),
    bodyTemp: 36.5,
    pulse: 87.0,
    respiratRate: null,
    bloodPress: null,
  ),
];
