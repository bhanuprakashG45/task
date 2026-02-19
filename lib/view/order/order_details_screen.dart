import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/view_model/order_vm/order_viewmodel.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final TextEditingController amountController = TextEditingController();

  String isSelected = "UPI";
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      top: false,

      child: Scaffold(
        body: Consumer<OrderViewmodel>(
          builder: (context, ordervm, _) {
            final orderData = ordervm.orderDetails;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 30,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1, color: Colors.grey),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.share, size: 18),
                              SizedBox(width: 10),
                              Text("Refer & Earn ₹500"),
                            ],
                          ),
                        ),
                        Spacer(),

                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset("assets/images/image1.png"),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        border: Border.all(width: 0.5, color: Colors.grey),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter your Desired/Bill Amount",
                            style: TextStyle(color: Colors.purple),
                          ),
                          TextField(
                            controller: amountController,
                            onChanged: (value) {
                              ordervm.calculateDiscount(
                                int.tryParse(value) ?? 0,
                                orderData.discounts[0].percent,
                              );
                              ordervm.calculateYoupay(
                                int.tryParse(value) ?? 0,
                                ordervm.discountAmount.toInt(),
                                1,
                              );
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.currency_rupee),
                              hintText: "Enter Amount",
                              hintStyle: TextStyle(fontSize: 18),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              suffixText: orderData.maxAmount.toString(),
                              suffixStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.shade100,
                        border: Border.all(width: 0.5, color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(
                                  "You Pay".toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "₹${ordervm.youpayAmount}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 80, width: 1, color: Colors.grey),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(
                                  "Savings".toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "₹${ordervm.discountAmount.toInt() * ordervm.selectedQuantity}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    SizedBox(
                      height: 100,

                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: orderData.discounts.length,
                              itemBuilder: (context, index) {
                                final data = orderData.discounts[index];
                                return Row(
                                  children: [
                                    _paymentContainers(
                                      image:
                                          "https://t3.ftcdn.net/jpg/05/60/50/16/360_F_560501607_x7crxqBWbmbgK2k8zOL0gICbIbK9hP6y.jpg",
                                      title: data.method,
                                      amount: data.percent,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(8),
                            height: 100,
                            width: width * 0.27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              border: Border.all(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Quantity"),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    InkWell(
                                      onTap: () {
                                        ordervm.selectedQuantity--;
                                        ordervm.calculateYoupay(
                                          int.tryParse(amountController.text) ??
                                              0,
                                          ordervm.discountAmount.toInt(),
                                          ordervm.selectedQuantity,
                                        );
                                      },
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Text(
                                        ordervm.selectedQuantity.toString(),
                                      ),
                                    ),
                                    SizedBox(width: 5),

                                    InkWell(
                                      onTap: () {
                                        ordervm.selectedQuantity++;
                                        ordervm.calculateYoupay(
                                          int.tryParse(amountController.text) ??
                                              0,
                                          ordervm.discountAmount.toInt(),
                                          ordervm.selectedQuantity,
                                        );
                                      },
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      "How to Reedem",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: orderData.redeemSteps.length,
                        itemBuilder: (context, index) {
                          final reedemsteps = orderData.redeemSteps[index];
                          return Text("${index + 1} . $reedemsteps");
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    ordervm.orderDetails.disablePurchase == false
                        ? SizedBox()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    16,
                                    126,
                                    216,
                                  ),
                                ),
                                onPressed: () {
                                int amount =  int.tryParse(amountController.text.trim())??0;

                                if(amount< ordervm.orderDetails.minAmount || amount > ordervm.orderDetails.maxAmount){
                                  debugPrint("Amount is Invalid");
                                }
                                },
                                child: Text(
                                  "Pay Now ₹ ${ordervm.youpayAmount}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _paymentContainers({
    required String title,
    required int amount,
    required String image,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    return Consumer<OrderViewmodel>(
      builder: (context, value, _) {
        return InkWell(
          onTap: () {
            value.selectedId = title;
          },
          child: Container(
            padding: EdgeInsets.all(5),
            height: 100,
            width: width * 0.27,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: value.selectedId == title
                  ? Colors.deepPurpleAccent.withValues(alpha: 0.5)
                  : Colors.white,
              border: value.selectedId == value
                  ? Border.all(width: 1, color: Colors.deepPurple)
                  : Border.all(width: 0.5, color: Colors.grey),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Image.network(image, fit: BoxFit.contain),
                    ),
                    SizedBox(width: 5),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Text(
                  "$amount % off",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
