import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping_list_app/screens/home.dart';
import 'package:shopping_list_app/view_models/product_view_model.dart';

void main () {
  Provider.debugCheckInvalidValueType = null;
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductViewModal>(create: (context) => ProductViewModal())
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
        title:'Shoppingfy',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          backgroundColor: Colors.white,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

