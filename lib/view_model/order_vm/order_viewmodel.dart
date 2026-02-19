import 'package:flutter/material.dart';
import 'package:task/data/model/order_details_model.dart';

class OrderViewmodel with ChangeNotifier {
  final OrderDetailsModel _orderDetails = OrderDetailsModel(
    id: "zepto-100",
    title: "Zepto Instant Voucher",
    minAmount: 50,
    maxAmount: 10000,
    disablePurchase: false,
    discounts: [
      Discount(method: "UPI", percent: 4),
      Discount(method: "CARD", percent: 4),
    ],
    redeemSteps: [
      "Login to Zepto Platform",
      "Click on My profile / Settings",
      "Go to Zepto Cash & Gift Card",
      "Click on Add Card option",
    ],
  );
  OrderDetailsModel get orderDetails => _orderDetails;

  double _discountAmount = 0.0;
  double get discountAmount => _discountAmount;

  int _youpayAmount = 0;
  int get youpayAmount => _youpayAmount;

  void calculateDiscount(int amount, int percent) {
    _discountAmount = amount * percent / 100;
    notifyListeners();
  }

  void calculateYoupay(int amount, int discountAmount, int quantity) {
    _youpayAmount = (amount - discountAmount) * quantity;
    notifyListeners();
  }

  int _selectedQuantity = 1;
  int get selectedQuantity => _selectedQuantity;

  set selectedQuantity(int value) {
    _selectedQuantity = value;
    notifyListeners();
  }

  String _selectedId = "";
  String get selectedId => _selectedId;

  set selectedId(String id) {
    _selectedId = id;
    notifyListeners();
  }
}



// discountAmount = amount * percent / 100
// • youPay = (amount - discountAmount) * quantity
// • savings = discountAmount * quantity
// • Amount must be between minAmount and maxAmount.
// • Disable Pay button if disablePurchase = tru