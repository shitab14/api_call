import 'package:api_call/network/api_endpoints.dart';
import 'package:api_call/pages/theitemlistscreen/response_theitemlist.dart';
import 'package:api_call/pages/theitemscreen/screen_theitempage.dart';
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
            title: Text(
              'Menu',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black87
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
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
  void setResponse(List<TheItemListResponse> response) {
    if (response != null) {
      setState(() {
        _listData = List.from(response);

        // Sorting by weight
        _listData.sort((a,b) => a.weight.compareTo(b.weight));

        _listVisible = true;
      });
    }
  }

}


/// ListViews
class ListOfRestaurants extends StatelessWidget {
  final int index;
  final List<TheItemListResponse> item;

  const ListOfRestaurants(this.index,
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
          margin: EdgeInsets.all(4),
          child: Text(item[index].name.toString()),
          decoration: BoxDecoration(
            color:  const Color(0xff64a4d5),
            border: Border.all(
                color: Colors.black
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(1.0),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: item[index].menus!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, position) {
            return ListOfMenus (position, item[index].menus);
          },
        ),
      ],

    );
  }


}

class ListOfMenus extends StatelessWidget {
  final int index;
  final List<Menus>? item;

  const ListOfMenus(this.index,
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
            _goToItemScreenPage(context, item![index]);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                /// Image
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.only(left: 12, right: 9),
                  child: CachedNetworkImage(
                    imageUrl: ApiUrls.instance.photoBase.toString() + item![index].photo.toString(),
                    placeholder: (context, url) =>
                        Image.asset("assets/images/empty_box.png", fit: BoxFit.cover),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/empty_box.png",
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.fill,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black
                    ),
                  ),
                ),

                /// Menu Title
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                    child: Text(
                        item![index].title.toString(),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black
                      ),
                    ),
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