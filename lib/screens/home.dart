import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list_app/screens/cart.dart';

import '../view_models/product_view_model.dart';
import 'details.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var productViewModal;

  @override
  void initState() {
    super.initState();

    productViewModal = Provider.of<ProductViewModal>(context, listen: false);
    productViewModal.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        appBar: AppBar(
          leading: Icon(Icons.shopify_rounded),
          title: Text('Shoppingfy'),
          actions: [
            Consumer<ProductViewModal>(
              builder: (context, data, child) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                },
                child: (
                  Container(
                padding: EdgeInsets.all(4),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.shopping_cart),
                    Text(data.countCart.toString())
                  ],
                ),
                )),
              );
            })
          ],
        ),
        body: Consumer<ProductViewModal>(builder:(context, data, child) {
          return ListView.builder(
            itemCount: data.productList.length,
            itemBuilder: (context, index) {

              return  Container(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  trailing: data.cartList.contains(data.productList[index]) ?
                    IconButton(
                    color: Colors.black,
                    iconSize: 22,
                    icon: const Icon(Icons.minimize_rounded),
                    onPressed:() {
                      productViewModal.removeFromCart(data.productList[index]);
                    })
                      :
                    IconButton(
                       color: Colors.black,
                       iconSize: 22,
                       icon: const Icon(Icons.add_shopping_cart_outlined),
                       onPressed:() {
                         productViewModal.addToCart(data.productList[index]);
                       }),
                     leading: CircleAvatar(
                       backgroundImage:
                           NetworkImage(data.productList[index].image!),
                     ),

                  title: Container(
                    width: 80,
                    child: Text(data.productList[index].title!, style: const TextStyle(fontSize: 12),)),
                    subtitle: Text(data.productList[index].price!.toString()),
                    hoverColor: Colors.indigo[400],
                    onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserDetail(data.productList[index]),
                      ),
                    );
                  }),
              );
            });
        })
      ));
  }
}
