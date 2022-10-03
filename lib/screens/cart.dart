import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/product_view_model.dart';



class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  var productViewModel;

  @override
  void initState() {
    super.initState();
    productViewModel = Provider.of<ProductViewModal>(context,listen:false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Consumer<ProductViewModal>(builder: (context,data,child) {
              return Row(
                children: <Widget>[
                  Expanded(child: Text("My Cart (${data.countCart.toString()})", style: const TextStyle(fontSize: 18))),
                  Text(
                    "Total Price: "+ data.totalPrice.toString(), 
                    style: const TextStyle(fontSize: 16)
                  ),
                ],
              );
            })
          ),
          body: Consumer<ProductViewModal>(builder: (context,data,child){
            return ListView.builder(
                itemCount: productViewModel.cartList.length,
                itemBuilder: (count,index){
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image: NetworkImage(data.cartList[index].image!),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),

                        Expanded(
                          child: Text(data.cartList[index].title!+"/n"+data.cartList[index].price.toString())),

                        InkWell(
                          onTap: (){
                            productViewModel.removeFromCart(data.cartList[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.close,color: Colors.red,),
                          ),
                        )
                      ],
                    ),
                  );
                }
            );
          })
        )
    );
  }
}
