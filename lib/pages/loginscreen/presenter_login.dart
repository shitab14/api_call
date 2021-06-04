
import 'package:api_call/network/api_repository.dart';
import 'package:api_call/pages/loginscreen/response_login.dart';
import 'package:api_call/utility/utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';


class LoginInterface {
  void onStartShowing() {}
  void onStopLoading() {}
  void setResponse(LoginResponse response){}
}

class LoginPresenter {
  LoginInterface? _interface;
  ApiRepository? _apiRepository;

  LoginPresenter(LoginInterface? interface){
    this._interface = interface;
    this._apiRepository = ApiRepository();
  }

  void getIn(BuildContext context, Map<String, dynamic> data,) {
    CommonUtil.instance.internetCheck().then((value) async {
      if (value) {
        this._interface?.onStartShowing();
        _apiRepository?.loginToAccount(context, data,
            onSuccess: (LoginResponse response) {
              this._interface?.onStopLoading();
              if(response != null) {
                this._interface?.setResponse(response);
              } else {
                print("No Data found");
                CommonUtil.instance.showToast(context, 'No Data');
              }
            },
            onFailure: (String error) {
              this._interface?.onStopLoading();
              print(error);
              CommonUtil.instance.showToast(context, 'Invalid email or password');
            });
      } else {
        this._interface?.onStopLoading();
        print("No Internet");
        CommonUtil.instance.showToast(context, 'No Internet, Please Connect to a network');
      }

    });
  }


}