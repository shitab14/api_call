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
      {void Function(List<TheItemListResponse>)? onSuccess,
        void Function(String)? onFailure}) async {

    try {

      /// Testing
      // final response = await ApiClient.get(ApiUrls.instance.myBaseUrl, params, false);
      // var callResponse = TheItemListResponseBody.fromJson(response);
      /*if (callResponse != null) {
        onSuccess!(callResponse);
      } else {
        onFailure!('No Data Found');

      }*/

      /// OG
      final response = await ApiClient.getList(ApiUrls.baseUrl2+ApiUrls.listEndpoint, params, false);
      // Parsing List
      var responseList =  (response as List).map((x) => TheItemListResponse.fromJson(x))
        .toList();
      print(responseList);
      if (responseList != null) {
        onSuccess!(responseList);
      } else {
        onFailure!('No Data Found');

      }

    } catch (e) {
      onFailure!(e.toString());
    }

  }

}