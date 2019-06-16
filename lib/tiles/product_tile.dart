import 'package:flutter/material.dart';
import 'package:ihc_g2/datas/product_data.dart';
import 'package:ihc_g2/pages/product_page.dart';

class ProductTile extends StatelessWidget {
  
  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ProductPage(product))
        );
      },
      child: Card(
        child: type == "grid" ? 
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(
                product.image,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text(
                      "${product.title} - ${product.width.toStringAsFixed(2)} x ${product.height.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "${product.material} - ${product.type}",
                      style: TextStyle(
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
        : Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                product.image,
                fit: BoxFit.fitWidth,
                height: 160,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text(
                      "${product.title} - ${product.width.toStringAsFixed(2)} x ${product.height.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "${product.material} - ${product.type}",
                      style: TextStyle(
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}