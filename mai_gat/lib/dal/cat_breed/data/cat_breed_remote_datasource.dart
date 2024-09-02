import 'package:mai_gat/core/entities/common/result_entity.dart';
import 'package:mai_gat/core/utils/http/http_remote_handler.dart';
import 'package:mai_gat/dal/cat_breed/util/cat_breed_mapping.dart';

class CatBreedRemoteDataSource {

   // [End points]
  static const String _url = 'https://api.thecatapi.com/';
  static const String _apiCatBreeds = 'v1';

  // [Methods]
  final String _getCatBreedsMethod = 'breeds';
  final String _getBreedImageMethod = 'images/search?breed_ids=';

  // [Singleton]
  static final CatBreedRemoteDataSource _instance =
      CatBreedRemoteDataSource._constructor();

  factory CatBreedRemoteDataSource() {
    return _instance;
  }

  // [Contructor]
  CatBreedRemoteDataSource._constructor();

  // [Methods] [GET]
  Future<ResultEntity> getCatBreeds() async {
    // Query params
    String queryParams = '$_apiCatBreeds/$_getCatBreedsMethod';

    // REST
    ResultEntity result = await HttpRemoteHandler().baseGET(_url, queryParams);
    
    // Only read information if result entity is true
    if(result.result) {

      result.cleanContent = result.content;
      
      // Mapping content to entity
      result.content = CatBreedMapping().getCatBreedListEntityFromMap(result.content);
      
    }
    
    return result;
  }


  Future<ResultEntity> getBreedImageById(String idBreed) async {
    // Query params
    String queryParams = '$_apiCatBreeds/$_getBreedImageMethod$idBreed';

    // REST
    ResultEntity result = await HttpRemoteHandler().baseGET(_url, queryParams);
    
    // Only read information if result entity is true
    if(result.result) {

      result.cleanContent = result.content;
      
      // Mapping content to entity
      result.content = CatBreedMapping().getBreedFromMap(result.content);
    }
    
    return result;
  }
}