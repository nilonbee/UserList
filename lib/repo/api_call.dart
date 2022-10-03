import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';


class ProductRepository{

  static var client = http.Client();

  static Future<List<ProductModal>?>fetchAllProducts()async{

    try {
         var response = await client.get(Uri.parse("https://fakestoreapi.com/products"));
      if(response.statusCode == 200)
        {
          var convertedJsonData = jsonDecode(response.body);
  
          return (convertedJsonData as List).map((e) => ProductModal.fromJson(e)).toList();
        }
      else
        {

          return null;
        }
  
    } catch(e) {

        return Future.error(e.toString());
    }
  }
}