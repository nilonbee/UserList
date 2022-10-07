import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/product_view_model.dart';
import '../models/product_model.dart';
import 'cart.dart';


class UserDetail extends StatefulWidget {
  final ProductModal product;
  UserDetail(this.product);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {

  var productViewModal;

  @override
  void initState() {
    super.initState();
    productViewModal = Provider.of<ProductViewModal>(context,listen:false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Shoppingfy',
            style: TextStyle(fontSize: 16.0, color: Colors.white)),
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
          ]),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            BuildContent(),
            BuildTop(),
            buildAbout(),
          ],
        ),
    );
  }

  Widget BuildTop() {

    return Container(
      margin: EdgeInsets.all(24),
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: BuildCoverImage()
              ),
          ],
        ),
    );
  }

  Widget BuildContent()  => Column(
   children: <Widget>[
    const SizedBox(height: 8),
    Center(
      child: Text(
        widget.product.title!,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    const SizedBox(height: 8),
    Text(
      '${widget.product.price!.toString()} GBP',
      style: TextStyle(
        fontSize: 23, 
        fontWeight: FontWeight.w800, 
        color: Colors.deepPurple
      ),
    ),
    const SizedBox(height: 18),
   ],
  );

  Widget buildAbout() => Container(
    padding: EdgeInsets.symmetric(horizontal: 14),
    child: Consumer<ProductViewModal>(builder: (context,data,child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[

          const SizedBox(height: 12,),

          ElevatedButton(
            onPressed: () {
              data.addToCart(widget.product);
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Text('Add To Cart'),
          ),

          const Text(
            'More info',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)
          ),

          const SizedBox(height: 8),
          
          Text(
            widget.product.description!, 
            style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w600)
          ),

          SizedBox(height: 20),
        ],
     );
    })
  );

  Widget BuildCoverImage() => FullScreenWidget(
    backgroundIsTransparent: true,
    child: Container(
      color: Colors.grey,
        child: Image.network(widget.product.image!,
          width: 200,
          height: 250,
          fit: BoxFit.cover,
        ),
    ),
  );
}


