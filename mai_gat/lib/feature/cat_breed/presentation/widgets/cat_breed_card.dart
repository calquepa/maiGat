import 'package:flutter/material.dart';
import 'package:mai_gat/core/entities/cat/cat_entity.dart';
import 'package:mai_gat/core/navigation/routes.dart';
import 'package:mai_gat/core/utils/http/http_remote_util.dart';
import 'package:mai_gat/core/utils/style/app_theme.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/common/cat_breed_methods.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/common/cat_breed_animated_loading.dart';

class CatBreedCard extends StatefulWidget {
  final CatBreedEntity catBreedEntity;

  const CatBreedCard({super.key, required this.catBreedEntity});

  @override
  State<CatBreedCard> createState() => _CatBreedCardState();
}

class _CatBreedCardState extends State<CatBreedCard> {
  CatBreedEntity catBreedEntity = CatBreedEntity();

  @override
  Widget build(BuildContext context) {
    // Set current card information
    initLocalState();

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.summaryBreedRoute, arguments: catBreedEntity);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        margin: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
        elevation: 5,
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0))
          ),
          child: Column(
            children: <Widget>[
              _getNameBreed(),
              const SizedBox(height: 5.0),
              _getBreedImage(),
              const SizedBox(height: 5.0),
              _getCountryOrigin(),
              const SizedBox(height: 5.0),
            ]
          )
        )
      )
    );
  }

  void initLocalState() {
    catBreedEntity = widget.catBreedEntity;
  }

  // [Widgets]

  // [Breed information]
  Widget _getNameBreed() {

    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 12.0),                           
          Expanded(
            child: Text(CatBreedMethods().getNameCatBreed(catBreedEntity),
                style: AppTheme.textTheme.headlineMedium?.copyWith(color: AppTheme.primaryColor),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              )
          ),
          const SizedBox(width: 12.0),
        ],
      ),
    );
  }

  Widget _getCountryOrigin() {

    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 0.0),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 12.0),                           
          Expanded(
            child: Text(CatBreedMethods().getCountryOrigin(catBreedEntity),
                style: AppTheme.textTheme.headlineMedium?.copyWith(color: AppTheme.primaryColor),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              )
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(CatBreedMethods().getIntelligence(catBreedEntity),
                style: AppTheme.textTheme.headlineMedium?.copyWith(color: AppTheme.primaryColor),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              )
          ),
          const SizedBox(width: 12.0),
        ],
      ),
    );
  }

  // [Breed image]
  Widget _getBreedImage() {

    return Container(
      color: const Color(0xffE8E6EA),
      height: 400,
      child: Image.network(
        CatBreedMethods().getImageURL(catBreedEntity),
        fit: BoxFit.fitWidth,
        headers: HttpRemoteUtil().getDefaultHeaders(),
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CatBreedAnimatedLoading(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'lib/core/assets/images/cat_error_no_data.png',
            fit: BoxFit.cover,
            height: 400,
            width: double.infinity,
          );
        },
      ),
    );
  }
}