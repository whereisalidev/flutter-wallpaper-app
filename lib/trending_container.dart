import 'package:flutter/material.dart';

class TrendingContainer extends StatelessWidget {
  String imgsrc;
  TrendingContainer({Key? key, required this.imgsrc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              height: 300,
              width: 145,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  imgsrc, fit: BoxFit.cover,
                height: 100,
                width: 100,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
