import 'package:api_call/pages/loginscreen/presenter_login.dart';
import 'package:api_call/pages/loginscreen/response_login.dart';
import 'package:api_call/pages/theitemlistscreen/screen_theitemlist.dart';
import 'package:api_call/utility/utility.dart';
import 'package:flutter/material.dart';


class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> implements LoginInterface{

  /// Variables
  var _passwordTextController;
  var _emailTextController;

  /// Presenter
  late LoginPresenter _presenter;

  /// Flags
  var _loginButtonEnabled = true;

  /// Functions
  // Validate & Login
  _validateAndLogin() {
    var emailText = _emailTextController.text.toString();
    if(emailText.isNotEmpty && _passwordTextController.text.toString().isNotEmpty) {

      // Email Format Check
      if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailText)) {

        // Get Body Data
        Map<String, dynamic> data = _getFormData();
        // API Call
        _presenter.getIn(context, data);

      } else CommonUtil.instance.showToast(context, 'Please enter a valid email id');


    } else CommonUtil.instance.showToast(context, 'Please enter in both email & password');
  }

  // Collecting Form Data
  Map<String, dynamic> _getFormData() {
    Map<String, dynamic> data = {};

    /// Email
    data["email"] = _emailTextController.text.toString();
    /// Password
    data["password"] = _passwordTextController.text.toString();
    /// Others
    data["restaurant"] = 'kababbox';
    data["is_terms_accepted"] = true;

    return data;
  }

  /// Overridden Methods
  @override
  void initState() {
    /// initialize
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    //Delete after debug
    setState(() {
      _emailTextController.text = 'customer_330612@zfoodbd.com';
      _passwordTextController.text = 'ginger001';
    });

    _presenter = LoginPresenter(this);

    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// Email Text
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.all(10),
                child: Text(
                  'Email',
                  textAlign: TextAlign.left,
                ),
              ),
              /// Email Field
              TextField(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white70
                ),
              ),

              /// Password Text
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.all(10),
                child: Text(
                  'Password',
                  textAlign: TextAlign.left,
                ),
              ),
              /// Password Field
              TextField(
                controller: _passwordTextController,
                obscureText: true,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white70
                ),
              ),

              /// Login Button
              Container(
                height: 60,
                margin: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(1.0),
                  ),
                ),
                child: InkWell(
                  onTap: () => {
                    if (_loginButtonEnabled) {
                      _validateAndLogin(),
                    }
                  },
                  child: Center(
                    child: Text(
                      'Login',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  /// API Responses
  @override
  void onStartShowing() {
    setState(() {
      _loginButtonEnabled = false;
    });
    // CommonUtil.instance.showToast(context, 'Logging In ...');
  }

  @override
  void onStopLoading() {
    setState(() {
      _loginButtonEnabled = true;
    });
  }

  @override
  void setResponse(LoginResponse response) {
    if(response.detail == null) {
      // Success
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TheItemListPage()),
      );
    } else {
      // Login Failed
      CommonUtil.instance.showToast(context, response.detail.toString());
    }
  }


}
