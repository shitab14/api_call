import 'package:api_call/network/api_endpoints.dart';
import 'package:api_call/pages/theitemlistscreen/response_theitemlist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TheItemPage extends StatefulWidget {
  final Menus item;
  TheItemPage(this.item, {Key? key}) : super(key: key);

  @override
  _TheItemPageState createState() => _TheItemPageState(this.item);

}

class _TheItemPageState extends State<TheItemPage> {
  Menus item;
  _TheItemPageState(this.item);

  /// Functions
  // on device backpress
  Future<bool> _onBackPress() async {
    Navigator.pop(context, true);
    return false;
  }

  @override
  void initState() {
    /// initialize
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
          body: Column(
            children: [
              /// Image
              Container(
                height: 250,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: ApiUrls.instance.photoBase.toString() + item.photo.toString(),
                  placeholder: (context, url) =>
                      Image.asset("assets/images/empty_box.png", fit: BoxFit.cover),
                  errorWidget: (context, url, error) => Image.asset(
                  "assets/images/empty_box.png",
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.fill,
              ),
            ),

              /// Title Price Section
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      item.title.toString(),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      item.price.toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              /// Ingredient Section
              Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 25, bottom: 25, left: 15, right: 15,),
                margin: const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 25),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(1.0),
                  ),
                ),
                child: Text(
                  item.ingredientLists.toString(),
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                  ),
                ),

              ),

              /// Back Button
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.all(35.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(1.0),
                      ),
                    ),
                    child: InkWell(
                      onTap: () => _onBackPress(),
                      child: Center(
                        child: Text(
                          'Back',
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
                ),
              ),
            ],


          ),
        ),
    );
  }

}
