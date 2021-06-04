class TheItemListResponseBody {
  late List<TheItemListResponse> list;

  TheItemListResponseBody({required this.list});

  TheItemListResponseBody.fromJson(Map<String, dynamic> json) {
    if (json['the_array'] != null) {
      list = <TheItemListResponse>[];
      json['the_array'].forEach((v) {
        list
            .add(new TheItemListResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['the_array'] =
          this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class TheItemListResponse {
  int? id;
  String? name;
  List<Menus>? menus;
  late int weight;

  TheItemListResponse({this.id, this.name, this.menus, required this.weight});

  TheItemListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['menus'] != null) {
      menus = [];// List<Menus>();
      json['menus'].forEach((v) {
        menus?.add(new Menus.fromJson(v));
      });
    }
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.menus != null) {
      data['menus'] = this.menus?.map((v) => v.toJson()).toList();
    }
    data['weight'] = this.weight;
    return data;
  }
}

class Menus {
  int? id;
  String? title;
  String? slug;
  String? price;
  String? ingredientLists;
  String? specialNotes;
  String? photo;
  bool? dineIn;
  bool? takeaway;
  // List<Null>? addonCategories;

  Menus(
      {this.id,
        this.title,
        this.slug,
        this.price,
        this.ingredientLists,
        this.specialNotes,
        this.photo,
        this.dineIn,
        this.takeaway,
        // this.addonCategories
      });

  Menus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    ingredientLists = json['ingredient_lists'];
    specialNotes = json['special_notes'];
    photo = json['photo'];
    dineIn = json['dine_in'];
    takeaway = json['takeaway'];
    /*if (json['addon_categories'] != null) {
      addonCategories = List<Null>();
      json['addon_categories'].forEach((v) {
        addonCategories!.add(Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['price'] = this.price;
    data['ingredient_lists'] = this.ingredientLists;
    data['special_notes'] = this.specialNotes;
    data['photo'] = this.photo;
    data['dine_in'] = this.dineIn;
    data['takeaway'] = this.takeaway;
    /*if (this.addonCategories != null) {
      data['addon_categories'] =
          this.addonCategories!.map((v) => v!.toJson()).toList();
    }*/
    return data;
  }
}
