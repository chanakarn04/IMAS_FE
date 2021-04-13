// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:dropdown_date_picker/dropdown_date_picker.dart' as ddp;

// import './registerPatientScreen_2.dart';
// import '../../Widget/progressDot.dart';
// import '../../Widget/AdaptiveRaisedButton.dart';
// import '../../Widget/adaptiveBorderButton.dart';

// class RegisterPatient1Screen extends StatefulWidget {
//   static const routeName = '/Register-patient-step1';

//   @override
//   _RegisterPatient1ScreenState createState() => _RegisterPatient1ScreenState();
// }

// class _RegisterPatient1ScreenState extends State<RegisterPatient1Screen> {
//   final _formKey = GlobalKey<FormState>();

//   var _isLogin = false;

//   final usrnTxtCtrl = TextEditingController();
//   final pswTxtCtrl = TextEditingController();
//   final cfPswTxtCtrl = TextEditingController();
//   final nameTxtCtrl = TextEditingController();
//   final surnameTxtCtrl = TextEditingController();
//   // Map<String, dynamic> registerData = {};
//   String email;
//   String password;
//   String cfPassword;
//   String fname;
//   String sname;
//   DateTime _selectedDate;
//   int selectedGender = 0; // 0 as Male, 1 as Female
//   var _pwsValidate = true;
//   var _mailValidate = true;
//   var _submitValidate = false;

//   @override
//     void dispose() {
//       // TODO: implement dispose
//       usrnTxtCtrl.dispose();
//       pswTxtCtrl.dispose();
//       cfPswTxtCtrl.dispose();
//       nameTxtCtrl.dispose();
//       surnameTxtCtrl.dispose();
//       super.dispose();
//     }

//   void _presentDatePicker() {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime(DateTime.now().year),
//       firstDate: DateTime(1950),
//       lastDate: DateTime.now(),
//       builder: (BuildContext context, Widget child) {
//         return Theme(
//           data: ThemeData().copyWith(
//             colorScheme: ColorScheme.light(
//               primary: Theme.of(context).primaryColor,
//             ),
//           ),
//           child: child,
//         );
//       },
//     ).then((pickedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     });
//   }

//   void toggleGender() {
//     setState(() {
//       if (selectedGender == 0) {
//         selectedGender = 1;
//       } else {
//         selectedGender = 0;
//       }
//     });
//   }

//   // void checkCfPwd() {
//   //   if (pswTxtCtrl.text == cfPswTxtCtrl.text) {
//   //     setState(() {
//   //       _pwsValidate = true;
//   //     });
//   //   } else {
//   //     setState(() {
//   //       pswTxtCtrl.clear();
//   //       cfPswTxtCtrl.clear();
//   //       _pwsValidate = false;
//   //     });
//   //   }
//   // }

//   // void checkMail() {
//   //   if (RegExp(
//   //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//   //       .hasMatch(usrnTxtCtrl.text)) {
//   //     // print('Hi there if');
//   //     setState(() {
//   //       _mailValidate = true;
//   //     });
//   //   } else {
//   //     // print('Hi there else');
//   //     setState(() {
//   //       usrnTxtCtrl.clear();
//   //       // cfPswTxtCtrl.clear();
//   //       _mailValidate = false;
//   //     });
//   //   }
//   // }

//   Widget buildGenderCard(BuildContext context, int gender, String text) {
//     if (selectedGender == gender) {
//       return Container(
//         height: 40,
//         width: 100,
//         decoration: BoxDecoration(
//           color: Theme.of(context).primaryColor,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//       );
//     } else {
//       return InkWell(
//         onTap: toggleGender,
//         child: Container(
//           height: 40,
//           width: 100,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.grey,
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             text,
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       );
//     }
//   }

//   final dropdownDatePicker = ddp.DropdownDatePicker(
//     underLine: Container(
//       height: 1.0,
//       color: Colors.grey,
//     ),
//     initialDate:
//         ddp.ValidDate(year: DateTime.now().year - 15, month: 1, day: 1),
//     firstDate: ddp.ValidDate(year: DateTime.now().year - 80, month: 1, day: 1),
//     lastDate: ddp.ValidDate(
//         year: DateTime.now().year,
//         month: DateTime.now().month,
//         day: DateTime.now().day),
//     textStyle: TextStyle(fontWeight: FontWeight.bold),
//     dropdownColor: Colors.white,
//     dateHint: ddp.DateHint(year: 'year', month: 'month', day: 'day'),
//     ascending: false,
//   );

//   @override
//   Widget build(BuildContext context) {
//     if (usrnTxtCtrl.text.isNotEmpty &&
//         pswTxtCtrl.text.isNotEmpty &&
//         cfPswTxtCtrl.text.isNotEmpty &&
//         nameTxtCtrl.text.isNotEmpty &&
//         surnameTxtCtrl.text.isNotEmpty &&
//         _selectedDate != null) {
//       _submitValidate = true;
//     }
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.only(
//             left: 30,
//             right: 30,
//             bottom: 30,
//             top: 50,
//           ),
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Register',
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               TextField(
//                 controller: usrnTxtCtrl,
//                 decoration: InputDecoration(
//                     labelText: 'Email',
//                     errorText: _mailValidate ? null : '**Mail is not valid'),
//                 keyboardType: TextInputType.emailAddress,
//                 onEditingComplete: () => FocusScope.of(context).nextFocus(),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 controller: pswTxtCtrl,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   errorText:
//                       _pwsValidate ? null : '**Password are not macthing',
//                 ),
//                 onEditingComplete: () => FocusScope.of(context).nextFocus(),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 controller: cfPswTxtCtrl,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Confirm Password',
//                 ),
//                 onEditingComplete: () => FocusScope.of(context).nextFocus(),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 controller: nameTxtCtrl,
//                 decoration: InputDecoration(labelText: 'First name'),
//                 onEditingComplete: () => FocusScope.of(context).nextFocus(),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextField(
//                 controller: surnameTxtCtrl,
//                 decoration: InputDecoration(labelText: 'Surname'),
//                 onSubmitted: (_) => FocusScope.of(context).unfocus(),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 children: <Widget>[
//                   Text(
//                     'Date of Birth',
//                     style: TextStyle(color: Colors.grey[700], fontSize: 16),
//                   ),
//                   Expanded(
//                     child: Container(
//                       alignment: Alignment.centerRight,
//                       child: _selectedDate == null
//                           ? Text(
//                               'No date chosen yet.',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.grey,
//                               ),
//                             )
//                           : Text(
//                               '${DateFormat.yMd().format(_selectedDate)}',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Theme.of(context).primaryColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                     ),
//                   ),
//                   IconButton(
//                     iconSize: 36,
//                     icon: Icon(
//                       Icons.calendar_today_rounded,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     onPressed: _presentDatePicker,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 children: <Widget>[
//                   Text(
//                     'Gender',
//                     style: TextStyle(color: Colors.grey[700], fontSize: 16),
//                   ),
//                   Expanded(child: Container()),
//                   buildGenderCard(context, 0, 'Male'),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   buildGenderCard(context, 1, 'Female'),
//                 ],
//               ),
//               Expanded(child: Container()),
//               Align(
//                 alignment: Alignment.center,
//                 child: ProgressDot(
//                   length: 3,
//                   markedIndex: 1,
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   AdaptiveBorderButton(
//                     buttonText: 'Cancel',
//                     handlerFn: () {
//                       Navigator.of(context).pop();
//                     },
//                     width: 130,
//                     height: 50,
//                   ),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   AdaptiveRaisedButton(
//                     buttonText: 'Next',
//                     handlerFn: (!_submitValidate)
//                     ? null 
//                     : () {
//                       // print(usrnTxtCtrl.text);
//                       // print(pswTxtCtrl.text);
//                       // print(cfPswTxtCtrl.text);
//                       // print(nameTxtCtrl.text);
//                       // print(surnameTxtCtrl.text);
//                       if (usrnTxtCtrl.text.isNotEmpty &&
//                           pswTxtCtrl.text.isNotEmpty &&
//                           cfPswTxtCtrl.text.isNotEmpty &&
//                           nameTxtCtrl.text.isNotEmpty &&
//                           surnameTxtCtrl.text.isNotEmpty &&
//                           _selectedDate != null) {
//                         checkCfPwd();
//                         checkMail();
//                         if (_pwsValidate && _mailValidate) {
//                           registerData.addAll({
//                             'username': usrnTxtCtrl.text,
//                             'password': pswTxtCtrl.text,
//                             'firstName': nameTxtCtrl.text,
//                             'surName': surnameTxtCtrl.text,
//                             'dob': _selectedDate,
//                             'gender': selectedGender,
//                           });
//                           Navigator.of(context).pushNamed(RegisterPatient2Screen.routeName, arguments: registerData);
//                         }
//                       }
//                     },
//                     width: 120,
//                     height: 40,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
