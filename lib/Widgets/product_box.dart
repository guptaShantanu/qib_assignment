import 'package:flutter/material.dart';

class ProductBox extends StatefulWidget {
  final String image;
  final int star;

  ProductBox({this.image,this.star});
  @override
  _ProductBoxState createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {

  List<Widget> _buildStars(BuildContext){
    List<Widget> list = [];
    for(int i =0;i<widget.star;i++){
      list.add(Icon(Icons.star,
        color: Colors.yellow,
      size: 10.0,));
    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 200.0,
      width: 150.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(15.0),topRight:Radius.circular(15.0)),

                  image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₹ 782',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),),
                  //Rating box
                  Container(
                    child: Row(
                      children: _buildStars(context),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(15.0),bottomRight:Radius.circular(15.0)),
                color: Color(0xff040F4F),
              ),
              child: Text('Add to Cart',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
            ),
          )
        ],
      ),
    );
  }
}
