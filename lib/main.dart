import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/view/order/order_details_screen.dart';
import 'package:task/view_model/order_vm/order_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => OrderViewmodel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: OrderDetailsScreen(),
      ),
    );
  }
}
