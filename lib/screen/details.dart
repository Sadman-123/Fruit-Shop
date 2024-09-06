import 'package:flutter/material.dart';
class Details extends StatelessWidget
{
  dynamic lst;
  int ind;
  Details({required this.lst,required this.ind});
  int getsum(String x,String y)
  {
    int xx=int.parse(x);
    int yy=int.parse(y);
    return xx*yy;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Out #${this.lst[ind]['code']}",style: TextStyle(fontSize: 29,fontWeight: FontWeight.w900),),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Hero(tag: "${this.lst[ind]['code']}", child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage("${this.lst[ind]['pic']}"),fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)
                      )
                  ),
                ),),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${this.lst[ind]['item']}",style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold),),
                      Text("${this.lst[ind]['price']}\$",style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(3),
                  alignment: Alignment.topRight,
                  child:Text("x${this.lst[ind]['quantity']}",style: TextStyle(fontSize:23 ),) ,
                )
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Price:",style: TextStyle(fontSize: 25),),
                      Text("${this.getsum(lst[ind]['price'],lst[ind]['quantity'])}\$",style: TextStyle(fontSize: 27,fontWeight: FontWeight.w800),)
                    ],
                  ),
                  margin: EdgeInsets.all(10),
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 59,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue.shade400
                    ),
                    alignment: Alignment.center,
                    child: Text("PLACE ORDER",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900),),
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