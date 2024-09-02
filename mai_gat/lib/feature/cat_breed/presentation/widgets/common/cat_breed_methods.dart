import 'package:mai_gat/core/entities/cat/cat_entity.dart';

class CatBreedMethods {

  // [Information]
  String getImageURL(CatBreedEntity catBreedEntity) {
    return catBreedEntity.referenceImageId ?? '';
  }

  String getNameCatBreed(CatBreedEntity catBreedEntity) {
    return catBreedEntity.name ?? '';
  }

  String getCountryOrigin(CatBreedEntity catBreedEntity) {
    return catBreedEntity.origin ?? '';
  }
  
  String getIntelligence(CatBreedEntity catBreedEntity) {
    return 'Inteligencia: ${catBreedEntity.intelligence}';
  }

  String getDescription(CatBreedEntity catBreedEntity) {
    return catBreedEntity.description ?? '';
  }

  String getTemperament(CatBreedEntity catBreedEntity) {
    return 'Temperamento: ${catBreedEntity.temperament}';
  }

  String getLifeSpan(CatBreedEntity catBreedEntity) {
    return 'Expectativa de vida: ${catBreedEntity.lifeSpan} años';
  }
  
  String getChildFriendly(CatBreedEntity catBreedEntity) {
    return 'Amigable con niños: ${catBreedEntity.childFriendly}';
  }

  String getAdaptability(CatBreedEntity catBreedEntity) {
    return 'Adaptabilidad: ${catBreedEntity.adaptability}';
  }

  // [Id]

  String getBreedId(CatBreedEntity catBreedEntity) {
    return catBreedEntity.id ?? '';
  }

}