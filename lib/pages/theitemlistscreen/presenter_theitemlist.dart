import 'package:api_call/network/api_repository.dart';
import 'package:api_call/pages/theitemlistscreen/response_theitemlist.dart';
import 'package:api_call/utility/utility.dart';
import 'package:flutter/cupertino.dart';

class TheItemListInterface {
  void onStartShowing() {}
  void onStopLoading() {}
  void setResponse(TheItemListResponseBody response){}
}

class TheItemListPresenter {
  TheItemListInterface? _interface;
  ApiRepository? _apiRepository;

  TheItemListPresenter(TheItemListInterface? interface) {
    this._interface = interface;
    this._apiRepository = ApiRepository();
  }

  void getRestaurantData(BuildContext context, Map<String, dynamic>? params,) {
    CommonUtil.instance.internetCheck().then((value) async {
      if (value) {
        this._interface?.onStartShowing();
        _apiRepository?.getRestaurantList(context, params,
            onSuccess: (TheItemListResponseBody response) {
              this._interface?.onStopLoading();
              if (response != null) {
                this._interface?.setResponse(response);
              } else {
                print("No Data found");
                CommonUtil.instance.showToast(context, 'No Data');
              }
            },
            onFailure: (String error) {
              this._interface?.onStopLoading();
              print(error);
              CommonUtil.instance.showToast(context, '$error');
            });
      } else {
        this._interface?.onStopLoading();
        print("No Internet");
        CommonUtil.instance.showToast(
            context, 'No Internet, Please Connect to a network');
      }
    });
  }
}

