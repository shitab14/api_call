import 'dart:convert';

import 'package:api_call/network/api_client.dart';
import 'package:api_call/network/api_endpoints.dart';
import 'package:api_call/pages/loginscreen/response_login.dart';
import 'package:api_call/pages/theitemlistscreen/response_theitemlist.dart';
import 'package:flutter/cupertino.dart';

class ApiRepository {

  void loginToAccount(BuildContext context, Map<String, dynamic> data,
      {void Function(LoginResponse)? onSuccess,
        void Function(String)? onFailure}) async {

    try {
      final response = await ApiClient.post(ApiUrls.baseUrl + ApiUrls.login, null, data, false);
      var callResponse = LoginResponse.fromJson(response);
      if (callResponse != null) {
        onSuccess!(callResponse);
      } else {
        onFailure!('No Data Found');

      }
    } catch (e) {
      onFailure!(e.toString());
    }

  }

  void getRestaurantList(BuildContext context, Map<String, dynamic>? params,
      {void Function(TheItemListResponseBody)? onSuccess,
        void Function(String)? onFailure}) async {

    try {

      /// Testing
      final response = await ApiClient.getJs(ApiUrls.instance.myBaseUrl, params, false);
      var callResponse = TheItemListResponseBody.fromJson(response);

      /// OG
      // final response = await ApiClient.getJs(ApiUrls.baseUrl2+ApiUrls.listEndpoint, params, false);

      // Iterable l = json.decode(response.body.toString());
      // List<TheItemListResponse> callResponse = List<TheItemListResponse>.from(l.map((model)=> TheItemListResponse.fromJson(model)));

      // var theResponse = json.decode(response);
      print(response);

      // List<TheItemListResponse> callResponse = List<TheItemListResponse>.from(theResponse.data.map((i) => TheItemListResponse.fromJson(i)));

      // var callResponse = TheItemListResponseBody.fromJson(response);
      if (callResponse != null) {
        onSuccess!(callResponse);
      } else {
        onFailure!('No Data Found');

      }
    } catch (e) {
      onFailure!(e.toString());
    }

  }

}