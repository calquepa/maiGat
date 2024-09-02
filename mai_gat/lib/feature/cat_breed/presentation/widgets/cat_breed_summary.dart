import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mai_gat/core/config/environment_config.dart';
import 'package:mai_gat/core/entities/cat/cat_entity.dart';
import 'package:mai_gat/core/utils/http/http_remote_util.dart';
import 'package:mai_gat/core/utils/style/app_theme.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/common/cat_breed_animated_loading.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/common/cat_breed_methods.dart';

class CatBreedSummary extends StatefulWidget {
  
  static const routeName = '/CatBreedSummary';
  const CatBreedSummary({super.key});

  @override
  State<CatBreedSummary> createState() => _CatBreedSummaryState();
}

class _CatBreedSummaryState extends State<CatBreedSummary> {
  
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    CatBreedEntity parameterCatBreed = ModalRoute.of(context)!.settings.arguments as CatBreedEntity;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => _closeSummaryView(context), icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          parameterCatBreed.name ?? EnvironmentConfig.appTitle,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _getBreedImage(parameterCatBreed),
          const SizedBox(height: 5.0),
          _getAllInformation(parameterCatBreed),
          const SizedBox(height: 5.0),
        ]
      ),
    );
  }

  _closeSummaryView(BuildContext context) {
    Navigator.pop(context);
  }

  // [Breed information]
  Widget _getAllInformation(CatBreedEntity parameterCatBreed) {

    return Expanded(
      child: Scrollbar(
        controller: scrollController,
        thickness: 4.0,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 12.0),                           
            _labelInformation(CatBreedMethods().getDescription(parameterCatBreed)),
            const SizedBox(height: 14.0),
            _labelInformation(CatBreedMethods().getCountryOrigin(parameterCatBreed)),
            const SizedBox(height: 14.0),
            _labelInformation(CatBreedMethods().getIntelligence(parameterCatBreed)),
            const SizedBox(height: 14.0),
            _labelInformation(CatBreedMethods().getAdaptability(parameterCatBreed)),
            const SizedBox(height: 14.0),
            _labelInformation(CatBreedMethods().getChildFriendly(parameterCatBreed)),
            const SizedBox(height: 14.0),
            _labelInformation(CatBreedMethods().getLifeSpan(parameterCatBreed)),
            const SizedBox(height: 14.0),
            _labelInformation(CatBreedMethods().getTemperament(parameterCatBreed)),
            const SizedBox(height: 14.0),
          ],
        ),
      ),
    );
  }

  Widget _labelInformation(String information) {
    return Text(information,
        style: AppTheme.textTheme.headlineMedium?.copyWith(color: AppTheme.primaryColor),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        maxLines: 10,
      );
  }

  // [Breed image]
  Widget _getBreedImage(CatBreedEntity parameterCatBreed) {

    return Container(
      color: const Color(0xffE8E6EA),
      height: 400,
      child: Image.network(
        CatBreedMethods().getImageURL(parameterCatBreed),
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