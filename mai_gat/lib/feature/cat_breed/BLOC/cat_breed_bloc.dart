import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mai_gat/core/entities/cat/cat_entity.dart';
import 'package:mai_gat/dal/cat_breed/domain/cat_breed_domain_repository.dart';
import 'package:mai_gat/feature/cat_breed/BLOC/cat_breed_event.dart';
import 'package:mai_gat/feature/cat_breed/BLOC/cat_breed_state.dart';

class CatBreedBloc extends Bloc<CatBreedEvent, CatBreedState> {
  
  // [Properties]
  
  // :Cat breeds cards:
  static List<CatBreedEntity> readBaseBreeds = [CatBreedEntity(referenceImageId: '312')];
  static double currentPosition = 0;
  static DateTime lastRefresh = DateTime.now();
  
  // :Collapse title:
  static Map<String, bool> cardViewStateSummary = {};
  
  // [Constructor]
  CatBreedBloc() : super(getInitialInfo()) {
    // [Breeds]
    on<DoGetCatBreeds>(_onGetCatBreeds);
    // [Filter Search]
    on<DoFilterSearch>(_onFilterSearch);
    // [Behavior cards]
    on<DoUpdateScrollPosition>(_onUpdateScrollPosition);
  }

  // [Bloc]

  // [Life ciclye]
  static CatBreedState getInitialInfo() {
    return const CatBreedInitial();
  }

  // [Events]
  Future<void> _onGetCatBreeds(DoGetCatBreeds event, Emitter<CatBreedState> emit) async {
    // Show loader
    emit(const CatBreedLoading());

    // Get breeds
    readBaseBreeds = await getCatBreeds();
    
    // Set event
    emit(CatBreedLoaded(catBreeds: readBaseBreeds, currentPosition: currentPosition));
  }

  Future<void> _onUpdateScrollPosition(DoUpdateScrollPosition event, Emitter<CatBreedState> emit) async {
    currentPosition = event.scrollPosition;
  }

  Future<void> _onFilterSearch(DoFilterSearch event, Emitter<CatBreedState> emit) async {
    // Get activities by page
    await getCatBreedsFilter(event.nameBreed);

    // Set event
    emit(CatBreedLoaded(catBreeds: readBaseBreeds, currentPosition: 0));
  }
  
  // [Methods]
  Future<List<CatBreedEntity>> getCatBreeds() async {
    readBaseBreeds = await CatBreedDomainRepository().getAllCatBreeds();
    currentPosition = 0;

    return readBaseBreeds;
  }

  Future<List<CatBreedEntity>> getCatBreedsFilter(String breedName) async {
    readBaseBreeds = await CatBreedDomainRepository().getCatBreedsFilter(breedName);
    currentPosition = 0;

    return readBaseBreeds;
  }
}