import 'package:api_call/network/api_endpoints.dart';
import 'package:api_call/pages/theitemlistscreen/response_theitemlist.dart';
import 'package:api_call/pages/theitemscreen/screen_theitempage.dart';
import 'package:api_call/utility/utility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'presenter_theitemlist.dart';

class TheItemListPage extends StatefulWidget {
  TheItemListPage({Key? key}) : super(key: key);

  @override
  _TheItemListPageState createState() => _TheItemListPageState();

}

class _TheItemListPageState extends State<TheItemListPage> implements TheItemListInterface{

  ///Data
  List<TheItemListResponse> _listData = [];

  /// Flags
  bool _listVisible = false;

  /// Presenter
  TheItemListPresenter? _presenter;

  /// Functions
  // on device backpress
  Future<bool> _onBackPress() async {
    Navigator.pop(context, true);
    return false;
  }

  @override
  void initState() {
    /// initialize
    _presenter = TheItemListPresenter(this);

    /// API Call
    _presenter?.getRestaurantData(context, null);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPress,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Menu'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Visibility(
            visible: _listVisible,
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _listData.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, position) {
                  return ListOfRestaurants (position, _listData);
                },
              ),
            ),
          ),
        )
    );
  }

  /// API Call Responses
  @override
  void onStartShowing() {
    // CommonUtil.instance.showToast(context, 'Loading Data');
  }

  @override
  void onStopLoading() {
  }

  @override
  void setResponse(TheItemListResponseBody response) {
    if (response != null) {
      setState(() {
        _listData = List.from(response.list);

        // Sorting by weight
        _listData.sort((a,b) => a.weight.compareTo(b.weight));

        _listVisible = true;
      });
    }
  }

}


/// ListViews
class ListOfRestaurants extends StatelessWidget {
  final int position;
  final List<TheItemListResponse> item;

  const ListOfRestaurants(this.position,
      this.item,
      {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color:  Colors.lightBlue,
          child: Center(child: Text(item[position].name.toString())),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: item[position].menus!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, position) {
            return ListOfMenus (position, item[position].menus);
          },
        ),
      ],

    );
  }


}

class ListOfMenus extends StatelessWidget {
  final int position;
  final List<Menus>? item;

  const ListOfMenus(this.position,
      this.item,
      {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _goToItemScreenPage(context, item![position]);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                /// Image
                Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.only(right: 8),
                  child: CachedNetworkImage(
                    imageUrl: ApiUrls.instance.photoBase.toString() + item![position].photo.toString(),
                    placeholder: (context, url) =>
                        Image.asset("assets/images/empty_box.png", fit: BoxFit.cover),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/empty_box.png",
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),

                /// Menu Title
                Container(
                  child: Text(
                      item![position].title.toString(),
                  ),
                ),
              ],
            ),
          ),
        ),

      ],

    );
  }


  void _goToItemScreenPage(BuildContext context, Menus item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TheItemPage(item)),
    );
  }
}