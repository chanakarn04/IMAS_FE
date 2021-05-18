import 'package:flutter/material.dart';

import './Pages/homePages.dart';
import './Pages/assessmentPages.dart';
import './Pages/assessmentHistoryPage.dart';
import './Pages/suggestionPage.dart';
import './Pages/searchResultPages.dart';
import './Pages/answerQuestionPages.dart';
import './Pages/profilePages.dart';
import './Pages/chatRoom.dart';
import './Pages/nearbyHospitalPages.dart';
import './Pages/settingPages.dart';
import './Pages/vitalSignStartPages.dart';
import './Pages/vitalSign/vs_BodyTempPage.dart';
import './Pages/vitalSign/vs_HeartRatePage.dart';
import './Pages/vitalSign/vs_RespiratoryRatePage.dart';
import './Pages/vitalSign/vs_BloodPressurePage.dart';
import './Pages/painScoreStartPage.dart';
import './Pages/painScorePage.dart';
import './Pages/predictionResultPage.dart';
import './Pages/diseaseDetail.dart';
import './Pages/patientInfoPage.dart';
import './Pages/loginPage.dart';
import './Pages/forgetPswPage.dart';
import './Pages/registerPage.dart';
import './Pages/register/registerPatientScreen_1.dart';
import './Pages/register/registerPatientScreen_2.dart';
import './Pages/register/registerPatientScreen_3.dart';
import './Pages/register/registerDoctorScreen.dart';
import './Pages/patientFollowUpPage.dart';
import './Pages/caseMangementPage.dart';
import './Pages/closeCasePage.dart';
import './Pages/appointmentPatient.dart';
import './Pages/appointmentDoctor.dart';
import './Pages/as_addMoreSymptom.dart';
import './Pages/WaitingDoctor.dart';
// import './Pages/WaitChatroomCreating.dart';
import './Pages/loggingOut.dart';


class Routes {
  static routes() {
    return {
      HomePage.routeName: (ctx) => HomePage(),
      LogInPage.routeName: (ctx) => LogInPage(),
      RegisterPage.routeName: (ctx) => RegisterPage(),
      RegisterPatient1Screen.routeName: (ctx) => RegisterPatient1Screen(),
      RegisterPatient2Screen.routeName: (ctx) => RegisterPatient2Screen(),
      RegisterPatient3Screen.routeName: (ctx) => RegisterPatient3Screen(),
      RegisterDoctorScreen.routeName: (ctx) => RegisterDoctorScreen(),
      ForgetPswPage.routeName: (ctx) => ForgetPswPage(),
      AssessmentPages.routeName: (ctx) => AssessmentPages(),
      AssessmentHistoryPage.routeName: (ctx) => AssessmentHistoryPage(),
      SuggestionPage.routeName: (ctx) => SuggestionPage(),
      PredictionResultPage.routeName: (ctx) => PredictionResultPage(),
      DiseaseDetailPages.routeName: (ctx) => DiseaseDetailPages(),
      SearchResultPages.routeName: (ctx) => SearchResultPages(),
      AnswerQuestionPages.routeName: (ctx) => AnswerQuestionPages(),
      ProfilePages.routeName: (ctx) => ProfilePages(),
      ChatRoom.routeName: (ctx) => ChatRoom(),
      NearbyHospitalPages.routeName: (ctx) => NearbyHospitalPages(),
      SettingPages.routeName: (ctx) => SettingPages(),
      VitalSignStartPage.routeName: (ctx) => VitalSignStartPage(),
      VSBodyTempPage.routeName: (ctx) => VSBodyTempPage(),
      VSHeartRatePage.routeName: (ctx) => VSHeartRatePage(),
      VSRespiratoryRatePage.routeName: (ctx) => VSRespiratoryRatePage(),
      VSBloodPressurePage.routeName: (ctx) => VSBloodPressurePage(),
      PainScoreStartPage.routeName: (ctx) => PainScoreStartPage(),
      PainScorePage.routeName: (ctx) => PainScorePage(),
      PatientInfoPage.routeName: (ctx) => PatientInfoPage(),
      PatientFollowUpPage.routeName: (ctx) => PatientFollowUpPage(),
      CaseManagementPage.routeName: (ctx) => CaseManagementPage(),
      CloseCasePage.routneName: (ctx) => CloseCasePage(),
      AppointmentPatientPage.routeName: (ctx) => AppointmentPatientPage(),
      AppointmentDoctorPage.routeName: (ctx) => AppointmentDoctorPage(),
      AddMoreSymptom.routeName: (ctx) => AddMoreSymptom(),
      WaitingPage.routeName: (ctx) => WaitingPage(),
      // WaitChatroomCreating.routeName: (ctx) => WaitChatroomCreating(),
      LoggingOut.routeName: (ctx) => LoggingOut(),
    };
  }

  static initPageRoute() {
    return LogInPage.routeName;
  }
}

// Map<String, (BuildContext) => Widget> route = {
//   HomePage.routeName: (ctx) => HomePage(),
//   LogInPage.routeName: (ctx) => LogInPage(),
//   RegisterPage.routeName: (ctx) => RegisterPage(),
//   RegisterPatient1Screen.routeName: (ctx) => RegisterPatient1Screen(),
//   RegisterPatient2Screen.routeName: (ctx) => RegisterPatient2Screen(),
//   RegisterPatient3Screen.routeName: (ctx) => RegisterPatient3Screen(),
//   RegisterDoctorScreen.routeName: (ctx) => RegisterDoctorScreen(),
//   ForgetPswPage.routeName: (ctx) => ForgetPswPage(),
//   AssessmentPages.routeName: (ctx) => AssessmentPages(),
//   AssessmentHistoryPage.routeName: (ctx) => AssessmentHistoryPage(),
//   SuggestionPage.routeName: (ctx) => SuggestionPage(),
//   PredictionResultPage.routeName: (ctx) => PredictionResultPage(),
//   DiseaseDetailPages.routeName: (ctx) => DiseaseDetailPages(),
//   SearchResultPages.routeName: (ctx) => SearchResultPages(),
//   AnswerQuestionPages.routeName: (ctx) => AnswerQuestionPages(),
//   ProfilePages.routeName: (ctx) => ProfilePages(),
//   ChatRoom.routeName: (ctx) => ChatRoom(),
//   NearbyHospitalPages.routeName: (ctx) => NearbyHospitalPages(),
//   SettingPages.routeName: (ctx) => SettingPages(),
//   VitalSignStartPage.routeName: (ctx) => VitalSignStartPage(),
//   VSBodyTempPage.routeName: (ctx) => VSBodyTempPage(),
//   VSHeartRatePage.routeName: (ctx) => VSHeartRatePage(),
//   VSRespiratoryRatePage.routeName: (ctx) => VSRespiratoryRatePage(),
//   VSBloodPressurePage.routeName: (ctx) => VSBloodPressurePage(),
//   PainScoreStartPage.routeName: (ctx) => PainScoreStartPage(),
//   PainScorePage.routeName: (ctx) => PainScorePage(),
//   PatientInfoPage.routeName: (ctx) => PatientInfoPage(),
//   PatientFollowUpPage.routeName: (ctx) => PatientFollowUpPage(),
//   CaseManagementPage.routeName: (ctx) => CaseManagementPage(),
//   CloseCasePage.routneName: (ctx) => CloseCasePage(),
//   AppointmentPatientPage.routeName: (ctx) => AppointmentPatientPage(),
//   AppointmentDoctorPage.routeName: (ctx) => AppointmentDoctorPage(),
// };
