import 'dart:async';

import 'package:flutter/material.dart';

class CatBreedAnimatedLoading extends StatefulWidget {
  const CatBreedAnimatedLoading({super.key});

  @override
  State<CatBreedAnimatedLoading> createState() => _CatBreedLoader();
}

class _CatBreedLoader extends State<CatBreedAnimatedLoading> {

  late final Timer timer;
  int _index = 1;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      setState(() => _index++);
      if (_index>4) {
        _index = 1;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: 
              Image.asset('lib/core/assets/images/cat_loading$_index.png', fit: BoxFit.fitWidth, key: UniqueKey(),),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
