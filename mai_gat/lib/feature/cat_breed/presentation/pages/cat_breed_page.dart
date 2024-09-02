import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai_gat/core/config/environment_config.dart';
import 'package:mai_gat/core/entities/cat/cat_entity.dart';

import 'package:mai_gat/core/utils/style/app_theme.dart';
import 'package:mai_gat/feature/cat_breed/BLOC/cat_breed_bloc.dart';
import 'package:mai_gat/feature/cat_breed/BLOC/cat_breed_event.dart';
import 'package:mai_gat/feature/cat_breed/BLOC/cat_breed_state.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/cat_breed_data.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/cat_breed_no_data.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/common/cat_breed_functions.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/common/cat_breed_animated_loading.dart';

class CatBreedPage extends StatefulWidget {
  const CatBreedPage({super.key});

  @override
  State<StatefulWidget> createState() => _CatBreedPageState();
}

class _CatBreedPageState extends State<CatBreedPage> {

  final SearchController searchController = SearchController();
  
  @override
  void initState() {
    context.read<CatBreedBloc>().add(const DoGetCatBreeds());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatBreedBloc, CatBreedState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(EnvironmentConfig.appTitle,
              style: AppTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.primaryColor)),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: state is CatBreedLoaded,
                child: SearchAnchor(
                  isFullScreen: false,
                  builder: (BuildContext context, searchController) {
                    return SearchBar(
                      controller: searchController,
                      hintText: 'Buscar...',
                      onTap: () => searchController.openView(),
                      onSubmitted: (value) {
                        searchController.closeView(searchController.value.text);
                        // Action to filter breed name
                        context.read<CatBreedBloc>().add(DoFilterSearch(nameBreed: searchController.value.text));
                      },
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      
                      onChanged: (_) {
                        // Action to filter breed name
                        context.read<CatBreedBloc>().add(DoFilterSearch(nameBreed: searchController.value.text));
                      },
                    );
                  },
                  suggestionsBuilder: (BuildContext context, searchController) {
                    List<CatBreedEntity> listCatBreeds = [];
                    if (state is CatBreedLoaded){
                      listCatBreeds = state.catBreeds;
                    }
                    listCatBreeds = listCatBreeds.where((e) => e.name.toString().toLowerCase().contains(searchController.value.text.toLowerCase())).toList();
                    return listCatBreeds.map((item) {
                      return ListTile(
                        title: Text(item.name!),
                        onTap: () {
                          setState(() {
                            // Action to filter breed name
                            context.read<CatBreedBloc>().add(DoFilterSearch(nameBreed: item.name!));
                            searchController.closeView(item.name);
                          });
                        },
                      );
                    });
                  }
                ),
              ),
              Expanded(
                child: 
                  state is CatBreedLoaded ?
                  // Cat Breeds loaded
                  (CatBreedFunctions().thereAreBreedByShowCatBreed(state) ?
                  const CatBreedData() :
                  const CatBreedNoData()) :
                // Cat Breeds in another state
                const CatBreedAnimatedLoading(),
              ),
            ],
          )
        );
      }
    );
  }
}