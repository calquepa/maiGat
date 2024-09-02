
import 'package:mai_gat/core/entities/cat/cat_entity.dart';

class CatBreedLocalDatasource {

  // Local memory
  List<CatBreedEntity> localCatBreeds = [];
  
  // [Singleton]
  static final CatBreedLocalDatasource _instance = CatBreedLocalDatasource._constructor();

  factory CatBreedLocalDatasource() {
    return _instance;
  }

  // [Constructor]
  CatBreedLocalDatasource._constructor();

  // : Methods :

  // [Local cat breeds]
  List<CatBreedEntity> getAllBaseCatBreeds() {
    return localCatBreeds;
  }
  
  void updateAllBaseCatBreeds(List<CatBreedEntity> baseCatBreeds) {
    // init local cat breeds
    localCatBreeds = baseCatBreeds;
  }
  
  Future<void> deleteAllBaseCatBreeds() async {
    localCatBreeds = [];
  }
}