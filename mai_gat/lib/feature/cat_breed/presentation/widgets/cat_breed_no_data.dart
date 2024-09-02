import 'package:flutter/material.dart';

class CatBreedNoData extends StatefulWidget {
  const CatBreedNoData({super.key});

  @override
  State<CatBreedNoData> createState() => _CatBreedNoData();
}

class _CatBreedNoData extends State<CatBreedNoData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/core/assets/images/cat_error_no_data.png', fit: BoxFit.fitWidth)
        ],
      ),
    );
  }
}