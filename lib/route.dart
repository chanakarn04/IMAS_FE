import './Pages/homePages.dart';
import './Pages/assessmentPages.dart';
import './Pages/assessmentHistoryPage.dart';
import './Pages/searchResultPages.dart';
import './Pages/answerQuestionPages.dart';
import './Pages/profilePages.dart';
import './Pages/chatRoom.dart';
import './Pages/vitalSignStartPages.dart';
import './Pages/vitalSign/vs_BodyTempPage.dart';
import './Pages/vitalSign/vs_HeartRatePage.dart';
import './Pages/vitalSign/vs_RespiratoryRatePage.dart';
import './Pages/vitalSign/vs_BloodPressurePage.dart';
import './Pages/painScoreStartPage.dart';
import './Pages/painScorePage.dart';
import './Pages/predictionResultPage.dart';
import './Pages/patientInfoPage.dart';
import './Pages/loginPage.dart';
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
import './Pages/loggingOut.dart';
import './Pages/detailAssessHist.dart';
import './Pages/caseMangeConditionSearch.dart';


class Routes {
  static routes() {
    return {
      HomePage.routeName: (ctx) => HomePage(),
      LogInPage.routeName: (ctx) => LogInPage(),
      LoggingOut.routeName: (ctx) => LoggingOut(),
      RegisterPage.routeName: (ctx) => RegisterPage(),
      RegisterPatient1Screen.routeName: (ctx) => RegisterPatient1Screen(),
      RegisterPatient2Screen.routeName: (ctx) => RegisterPatient2Screen(),
      RegisterPatient3Screen.routeName: (ctx) => RegisterPatient3Screen(),
      RegisterDoctorScreen.routeName: (ctx) => RegisterDoctorScreen(),
      AssessmentPages.routeName: (ctx) => AssessmentPages(),
      AddMoreSymptom.routeName: (ctx) => AddMoreSymptom(),
      SearchResultPages.routeName: (ctx) => SearchResultPages(),
      AnswerQuestionPages.routeName: (ctx) => AnswerQuestionPages(),
      PredictionResultPage.routeName: (ctx) => PredictionResultPage(),
      DetailAssessmentHistory.routeName: (ctx) => DetailAssessmentHistory(),
      AssessmentHistoryPage.routeName: (ctx) => AssessmentHistoryPage(),
      ProfilePages.routeName: (ctx) => ProfilePages(),
      ChatRoom.routeName: (ctx) => ChatRoom(),
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
      WaitingPage.routeName: (ctx) => WaitingPage(),
      CaseManagementConditionSearch.routeName: (ctx) => CaseManagementConditionSearch(),
    };
  }

  static initPageRoute() {
    return LogInPage.routeName;
  }
}