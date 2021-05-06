import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food/model/cart_maodel.dart';
import 'package:fast_food/model/ordering_model.dart';
import 'package:fast_food/model/single_food.dart';
import 'package:fast_food/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MoreCategory with ChangeNotifier {
  SingleFood singleFood;
  List<SingleFood> drinkList = [];
  Future<void> fetchDrinkCagtegories() async {
    List<SingleFood> drinkNewList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('morecategories')
        .doc('4SpPOYG5OWcddolunw0L')
        .collection('dosa')
        .get();
    querySnapshot.docs.forEach((element) {
      String drinkImage = element.data()['dosaImage'];
      String drinkTitle = element.data()['dosaTitle'];
      double drinkPrice = element.data()['drinkPrice'];

      singleFood = SingleFood(
        foodTitle: drinkTitle,
        foodPrice: drinkPrice,
        foodimage: drinkImage,
      );
      drinkNewList.add(singleFood);
    });
    drinkList = drinkNewList;
    notifyListeners();
  }

  List<SingleFood> get getDrinkCategoryList => List.from(drinkList);
///////////////////////// burgerCategory
  List<SingleFood> burgerList = [];
  Future<void> fetchBugerCagtegories() async {
    List<SingleFood> burgerNewList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('morecategories')
        .doc('4SpPOYG5OWcddolunw0L')
        .collection('Burgers')
        .get();
    querySnapshot.docs.forEach((element) {
      String foodImage = element.data()['foodImage'];
      String foodTitle = element.data()['foodTitle'];
      double foodPrice = element.data()['foodPrice'];

      singleFood = SingleFood(
        foodTitle: foodTitle,
        foodPrice: foodPrice,
        foodimage: foodImage,
      );
      burgerNewList.add(singleFood);
    });
    burgerList = burgerNewList;
    notifyListeners();
  }

  List<SingleFood> get getBurgerCategoryList => List.from(burgerList);
/////////////////   Pizza Category

  List<SingleFood> pizzaList = [];

  Future<void> fetchPizzaCagtegories() async {
    List<SingleFood> pizzaNewList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('morecategories')
        .doc('4SpPOYG5OWcddolunw0L')
        .collection('Pizza')
        .get();
    querySnapshot.docs.forEach((element) {
      String foodImage = element.data()['foodImage'];
      String foodTitle = element.data()['foodTitle'];
      double foodPrice = element.data()['foodPrice'];

      singleFood = SingleFood(
        foodTitle: foodTitle,
        foodPrice: foodPrice,
        foodimage: foodImage,
      );
      pizzaNewList.add(singleFood);
    });
    pizzaList = pizzaNewList;
    notifyListeners();
  }

  List<SingleFood> get getPizzaCategoryList => List.from(pizzaList);
  ////////// HomeFrontedCategory
  List<SingleFood> _singleFoodList = [];
  SingleFood _singleFood;
  Future<void> fetchSingleFoodData() async {
    List<SingleFood> _singleFoodNewList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('food').get();
    querySnapshot.docs.forEach(
      (element) {
        String foodTitle = element.data()['foodName'];
        String foodimage = element.data()['foodImage'];
        double foodPrice = element.data()['foodPrice'];
        _singleFood = SingleFood(
          foodTitle: foodTitle,
          foodPrice: foodPrice,
          foodimage: foodimage,
        );
        _singleFoodNewList.add(_singleFood);
      },
    );
    _singleFoodList = _singleFoodNewList;
    notifyListeners();
  }

  List<SingleFood> get getsingleFoodList => List.from(_singleFoodList);
  //////////////////// Cart Part
  List<CartModel> cartList = [];
  CartModel cartModel;
  void addCartModel({
    String image,
    String title,
    double price,
    int quantity,
  }) {
    cartModel = CartModel(
      quantity: quantity,
      price: price,
      title: title,
      image: image,
    );
    cartList.add(cartModel);
    notifyListeners();
  }

  List<CartModel> get getCartList => List.from(
        cartList,
      );

  int get cartListlength {
    return cartList.length;
  }

  void clean() {
    return cartList.clear();
  }

  void remove(index) {
    cartList.removeAt(index);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    cartList.forEach(
      (element) {
        total += element.price * element.quantity;
      },
    );
    return total;
  }

  //////////////// UserProfile
  UserModel userModel;
  User currentUser = FirebaseAuth.instance.currentUser;
  Future<void> fetchUserData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('UserData').get();
    querySnapshot.docs.forEach((element) {
      if (currentUser.uid == element.data()['UserId']) {
        String emailId = element.data()['emailId'];
        String mobileNumber = element.data()['mobileNumber'];
        String password = element.data()['password'];
        String userName = element.data()['userName'];
        String image = element.data()['ImageUrl'];

        userModel = UserModel(
          emailId: emailId,
          mobileNumber: mobileNumber,
          password: password,
          userName: userName,
          image: image,
        );
      }
    });
  }

  get currentUsers {
    return userModel ??
        UserModel(
          emailId: '',
          mobileNumber: '',
          password: '',
          userName: '',
          image:
              'https://www.pngfind.com/pngs/m/169-1699926_user-plus-user-user-add-profile-add-profile.png',
        );
  }

  ////////// User Ordering
  List<OrderingModel> _order = [];
  List<OrderingModel> get order {
    return _order;
  }

  void cleanOrder() {
    return order.clear();
  }

  Future<void> addOrder(List<CartModel> cart, double total) async {
    final timeStamp = DateTime.now();
    try {
      FirebaseFirestore.instance.collection('UserOders').doc().set({
        'UserName': userModel.userName,
        'UserEmail': userModel.emailId,
        'UserImage': userModel.image,
        'UserMobileNumber': userModel.mobileNumber,
        'OrderId': DateTime.now().toString(),
        'OrderAmount': total,
        'OrderTimeDate': timeStamp.toIso8601String(),
        'OderFood': cart
            .map((e) => {
                  'OrderImage': e.image,
                  'OrderName': e.title,
                  'OrderPrice': e.price,
                  'OrderQuantity': e.quantity,
                })
            .toList()
      });
      _order.insert(
        0,
        OrderingModel(
          food: cart,
          price: total,
          time: timeStamp,
          id: DateTime.now().toString(),
        ),
      );
      notifyListeners();
    } catch (error) {
      return error;
    }
  }

  ///////////SearchBar...
  List<SingleFood> search(String query) {
    List<SingleFood> searchList = _singleFoodList.where((element) {
      return element.foodTitle.toUpperCase().contains(query) ||
          element.foodTitle.toLowerCase().contains(query) ||
          element.foodTitle.toUpperCase().contains(query) &&
              element.foodTitle.toLowerCase().contains(query);
    }).toList();
    return searchList;
  }

  List<SingleFood> searchlist;
  void getSearchList({List<SingleFood> list}) {
    searchlist = list;
  }

  List<SingleFood> categoriesSearch(String query) {
    List<SingleFood> searchList = searchlist.where((element) {
      return element.foodTitle.toUpperCase().contains(query) ||
          element.foodTitle.toLowerCase().contains(query) ||
          element.foodTitle.toUpperCase().contains(query) &&
              element.foodTitle.toLowerCase().contains(query);
    }).toList();
    return searchList;
  }
}
