import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/homePages.dart';
import './registerPage.dart';
import '../Provider/user-info.dart';
import '../Provider/chatRoom_info.dart';

class LogInPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final usrnTextController = TextEditingController();
  final pswTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    final chatroom = Provider.of<ChatRoomProvider>(context);
    if (userInfo.role != Role.UnAuthen) {
      Future.delayed(Duration.zero, () =>
        Navigator.of(context).pushReplacementNamed(HomePage.routeName),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: 30,
            bottom: 15,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: (!userInfo.loginError && userInfo.loginIn)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: CircularProgressIndicator(
                          strokeWidth: 8.0,
                          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Logging in...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(),
                        flex: 2,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Welcome',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Intelligent ',
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          Text('Medical Assisstant System'),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width - 120,
                        width: MediaQuery.of(context).size.width - 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/loginImage.png'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            errorText: userInfo.loginError
                                ? 'Username or password incorrect'
                                : null,
                          ),
                          controller: usrnTextController,
                          onEditingComplete: () => FocusScope.of(context).nextFocus(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            errorText: userInfo.loginError ? '' : null,
                          ),
                          controller: pswTextController,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (usrnTextController.text.isNotEmpty &&
                              pswTextController.text.isNotEmpty) {
                            setState(() {
                              userInfo.loginIn = true;
                              userInfo.loginError = false;
                            });
                            await userInfo.login(
                              usrnTextController.text,
                              pswTextController.text,
                            );
                            if (userInfo.role == Role.Doctor) {
                              await chatroom.loadChatState(userId: userInfo.userId);
                            } else {
                              await chatroom.loadChatState(
                                userId: userInfo.userId,
                                role: Role.Patient,
                              );
                            }
                            usrnTextController.clear();
                            pswTextController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          padding: EdgeInsets.all(5),
                          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 0,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(7),
                          height: 30,
                          width: 200,
                          alignment: Alignment.center,
                          child: Text('Login'),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Don\u0027t have an account? ',
                              style: TextStyle(color: Color.fromARGB(255, 165, 165, 165)),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pushNamed(RegisterPage.routeName),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
