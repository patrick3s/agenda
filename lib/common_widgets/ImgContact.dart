import 'dart:convert';

import 'package:flutter/material.dart';

class ImgContact extends StatelessWidget {
  final double size;
  final String? img;
  ImgContact({ Key? key,required this.size,  this.img }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final empty = img ?? '';
    return Container(
      height: size,
      width: size,
      child: img == null || empty.isEmpty ? CircleAvatar(
        radius: size,
        backgroundColor: Colors.grey.withOpacity(.08),
        child: Icon(Icons.person,
        size: size * .8,
        color: Colors.black12.withOpacity(.05),
        ),
      ) 
      :ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(360)),
        child: Image.memory(base64Decode(img!),
        fit: BoxFit.cover,
        ),
      ),
    );
  }
}