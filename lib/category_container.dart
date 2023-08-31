import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  String bg_img, title;
  final onpress;
  CategoryContainer({Key? key, required this.bg_img, required this.title, required this.onpress,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onpress,
        child: Container(
          height: 90,
          width: 160,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(19),
            image: DecorationImage(
                image: NetworkImage(bg_img), fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)
            ),
          ),
          child: Center(child: Text(title, style: const TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w500),)),

        ),
      ),
    );
  }
}
