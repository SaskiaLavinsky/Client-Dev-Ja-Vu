import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;
  final Function onTap;
  const ProductCard({super.key, required this.name, required this.imageUrl, required this.price, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Mengatur borderRadius di sini
        ),
        child: Column(
          children: [
             ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.network(
                  imageUrl,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 90,
              ),
            ),
            SizedBox(height: 9,),
            Text(
              name, 
              style: TextStyle(fontSize: 23, fontFamily: 'Beau Rivage', fontWeight: FontWeight.w400 ), 
              overflow: TextOverflow.ellipsis, 
            ),
            Text(
              'Rp: $price', 
              style: TextStyle(fontSize: 16, fontFamily: 'Alegreya'), 
              overflow: TextOverflow.ellipsis, 
            ),
          ],
        ),
      ),
    );
  }
}