
import 'package:mai_gat/core/entities/cat/cat_entity.dart';
import 'package:mai_gat/core/entities/common/result_entity.dart';
import 'package:mai_gat/dal/cat_breed/data/cat_breed_local_datasource.dart';
import 'package:mai_gat/dal/cat_breed/data/cat_breed_remote_datasource.dart';

class CatBreedDomainRepository {

  // Singleton
  static final CatBreedDomainRepository _instance = CatBreedDomainRepository._constructor();

  // Contructor
  CatBreedDomainRepository._constructor();

  // Get instance
  factory CatBreedDomainRepository() {
    return _instance;
  }

  // [Rest]

  // [Get]
  Future<List<CatBreedEntity>> getAllCatBreeds() async {

    // Local memory
    List<CatBreedEntity> baseCatBreeds = CatBreedLocalDatasource().getAllBaseCatBreeds();

    if(baseCatBreeds.isEmpty) {
      for(int numberAttempts = 0; numberAttempts < 3; numberAttempts++) {
        // Remote
        ResultEntity result = await CatBreedRemoteDataSource().getCatBreeds();

        if(result.result) {
          // Set cat breeds in response
          baseCatBreeds = result.content;
          
          // Validate and Check Image Id
          for (CatBreedEntity element in baseCatBreeds) {
            List<Breed> breed;
            ResultEntity resultEntityBreed = await CatBreedRemoteDataSource().getBreedImageById(element.id!);
            if (resultEntityBreed.result) {
              breed = resultEntityBreed.content;
              if (breed.isNotEmpty) {
                element.referenceImageId = breed[0].url;
              }
            }
          }

          // Set Local Repository
          CatBreedLocalDatasource().updateAllBaseCatBreeds(baseCatBreeds);
          break;
        }
      }
    }

    return baseCatBreeds;
  }
  
  Future<List<CatBreedEntity>> getCatBreedsFilter(String catBreedName) async {

    // Local memory
    List<CatBreedEntity> baseCatBreeds = CatBreedLocalDatasource().getAllBaseCatBreeds();

    if(baseCatBreeds.isNotEmpty) {
      baseCatBreeds = baseCatBreeds.where((e) => e.name.toString().toLowerCase().contains(catBreedName.toLowerCase())).toList();
    }

    return baseCatBreeds;
  }
  
  // [Delete]
  Future<void> deleteAllCatBreeds() async {
    // By local cat breeds
    await CatBreedLocalDatasource().deleteAllBaseCatBreeds();
  }
/*
  // Show detail breed
  Future<void> openActivity(ActivityEntity activity, String idWorkflow) async {
    // get system activity
    SystemActivityEntity systemActivity = ActivityLocalDatasource().getSystemActivity(activity, idWorkflow);

    if(systemActivity.idCase != null && systemActivity.idCase!.isNotEmpty) {
      await ActivityLocalPlatform().observableOpenActivityForm(systemActivity);
    }
  }*/
}
