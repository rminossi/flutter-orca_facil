import 'package:flutter/material.dart';
import 'package:ihc_g2/datas/product_data.dart';

class ProductPage extends StatefulWidget {

  final ProductData product;

  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState(product);
}

class _ProductPageState extends State<ProductPage> {
  
final ProductData product;

  _ProductPageState(this.product);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${product.title} ${product.type} de ${product.material}"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Image.network(
              product.image
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text(
                  "${product.title} - ${product.width.toStringAsFixed(2)} x ${product.height.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                  maxLines: 3,
                ),
                Text(
                  "${product.material} - ${product.type}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 24.0,),
                Text(
                  "Quantidade",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Container(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 5,
                        right: 5,
                        bottom: 5,
                        top: 5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  height: 44,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: (){},
                    child: Text("Adicionar ao Orçamento",
                      style: TextStyle(fontSize: 18)
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}