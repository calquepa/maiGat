
abstract class CatBreedEvent {
  // [Constructor]
  const CatBreedEvent();
}

// Breeds
class DoGetCatBreeds extends CatBreedEvent {
  const DoGetCatBreeds();
}

// Filter search
class DoFilterSearch extends CatBreedEvent {
  final String nameBreed;
  
  const DoFilterSearch({required this.nameBreed});
}

// Card
class DoUpdateScrollPosition extends CatBreedEvent {
  final double scrollPosition;

  const DoUpdateScrollPosition({required this.scrollPosition});
}