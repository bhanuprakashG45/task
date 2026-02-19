import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  String id;
  String title;
  int minAmount;
  int maxAmount;
  bool disablePurchase;
  List<Discount> discounts;
  List<String> redeemSteps;

  OrderDetailsModel({
    required this.id,
    required this.title,
    required this.minAmount,
    required this.maxAmount,
    required this.disablePurchase,
    required this.discounts,
    required this.redeemSteps,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json["id"] ?? '',
        title: json["title"]??'',
        minAmount: json["minAmount"]??0,
        maxAmount: json["maxAmount"]??0,
        disablePurchase: json["disablePurchase"],
        discounts: List<Discount>.from(
          json["discounts"].map((x) => Discount.fromJson(x)),
        ),
        redeemSteps: List<String>.from(json["redeemSteps"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "minAmount": minAmount,
    "maxAmount": maxAmount,
    "disablePurchase": disablePurchase,
    "discounts": List<dynamic>.from(discounts.map((x) => x.toJson())),
    "redeemSteps": List<dynamic>.from(redeemSteps.map((x) => x)),
  };
}

class Discount {
  String method;
  int percent;

  Discount({required this.method, required this.percent});

  factory Discount.fromJson(Map<String, dynamic> json) =>
      Discount(method: json["method"], percent: json["percent"]);

  Map<String, dynamic> toJson() => {"method": method, "percent": percent};
}
