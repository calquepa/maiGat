import 'package:mai_gat/feature/cat_breed/BLOC/cat_breed_state.dart';

class CatBreedFunctions {

  // [Validations]
  bool thereAreBreedByShowCatBreed(CatBreedState state) {
    bool result = false;

    if (state is CatBreedLoaded && state.catBreeds.isNotEmpty) {
      result = true;
    }

    return result;
  }

  double getCurrentScrollPosition(CatBreedState state) {
    double result = 0.0;

    if(state is CatBreedLoaded) {
      result = state.currentPosition;
    }

    return result;
  }
}