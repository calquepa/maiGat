
import 'package:mai_gat/core/entities/cat/cat_entity.dart';

abstract class CatBreedState {
  const CatBreedState();
}

// [Life cycle]
class CatBreedInitial extends CatBreedState {
  const CatBreedInitial() : super();
}

// [Breeds]
class CatBreedLoading extends CatBreedState {
  const CatBreedLoading() : super();
}

class CatBreedLoaded extends CatBreedState {
  
  final List<CatBreedEntity> catBreeds;
  final double currentPosition;
  
  const CatBreedLoaded({required this.catBreeds, required this.currentPosition}) : super();
}