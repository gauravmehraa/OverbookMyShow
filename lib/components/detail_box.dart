import 'package:flutter/material.dart';

class DetailBox extends StatelessWidget{
  final String title, data;

  const DetailBox({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20,),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(width: 30),
          Text(data),
        ],
      ),
    );
  }
}