import 'dart:convert';

import 'package:mai_gat/core/entities/cat/cat_entity.dart';

class CatBreedMapping {

  List<CatBreedEntity> getCatBreedListEntityFromMap(dynamic jsonResult) {
    // Cat breeds
    List<CatBreedEntity> catBreeds = [];
    
    // From request
    List<dynamic> source = json.decode(jsonResult);

    if(source.isNotEmpty) {
      catBreeds = (source).map((x) => getCatBreedEntityFromMap(getSourceFromJSON(x))).toList();
    }

    return catBreeds;
  }

  Map<String, dynamic> getSourceFromJSON(dynamic jsonResult) {
    Map<String, dynamic> source = {};

    if(jsonResult is String) {
      source = json.decode(jsonResult);
    }
    else if(jsonResult is Map<String, dynamic>) {
      source = jsonResult;
    }

    return source;
  }

  CatBreedEntity getCatBreedEntityFromMap(dynamic source) {


    CatBreedEntity catBreed = CatBreedEntity();

    catBreed.weight = getWeightFromMap(source["weight"]);
    catBreed.id = source["id"];
    catBreed.name = source["name"];
    catBreed.cfaUrl = source["cfa_url"];
    catBreed.vetstreetUrl = source["vetstreet_url"];
    catBreed.vcahospitalsUrl = source["vcahospitals_url"];
    catBreed.temperament = source["temperament"];
    catBreed.origin = source["origin"];
    catBreed.countryCodes = source["country_codes"];
    catBreed.countryCode = source["country_code"];
    catBreed.description = source["description"];
    catBreed.lifeSpan = source["life_span"];
    catBreed.indoor = source["indoor"];
    catBreed.lap = source["lap"];
    catBreed.altNames = source["alt_names"];
    catBreed.adaptability = source["adaptability"];
    catBreed.affectionLevel = source["affection_level"];
    catBreed.childFriendly = source["child_friendly"];
    catBreed.dogFriendly = source["dog_friendly"];
    catBreed.energyLevel = source["energy_level"];
    catBreed.grooming = source["grooming"];
    catBreed.healthIssues = source["health_issues"];
    catBreed.intelligence = source["intelligence"];
    catBreed.sheddingLevel = source["shedding_level"];
    catBreed.socialNeeds = source["social_needs"];
    catBreed.strangerFriendly = source["stranger_friendly"];
    catBreed.vocalisation = source["vocalisation"];
    catBreed.experimental = source["experimental"];
    catBreed.hairless = source["hairless"];
    catBreed.natural = source["natural"];
    catBreed.rare = source["rare"];
    catBreed.rex = source["rex"];
    catBreed.suppressedTail = source["suppressed_tail"];
    catBreed.shortLegs = source["short_legs"];
    catBreed.wikipediaUrl = source["wikipedia_url"];
    catBreed.hypoallergenic = source["hypoallergenic"];
    catBreed.referenceImageId  = source["reference_image_id"];

    return catBreed;
  }

  
  Weight getWeightFromMap(Map<String, dynamic> source) {
    Weight weightBreed = Weight();
    
    weightBreed.imperial = source["imperial"];
    weightBreed.metric = source["metric"];

    return weightBreed;
  }

  List<Breed> getBreedFromMap(dynamic jsonResult) {
    // Cat breeds
    List<Breed> breeds = [];
    
    // From request
    List<dynamic> source = json.decode(jsonResult);

    if(source.isNotEmpty) {
      breeds = (source).map((x) => getBreedEntityFromMap(getSourceFromJSON(x))).toList();
    }

    return breeds;
  }

  Breed getBreedEntityFromMap(Map<String, dynamic> source) {
    Breed breed = Breed();
    
    breed.id = source["id"];
    breed.url = source["url"];
    breed.width = source["width"];
    breed.height = source["height"];

    return breed;
  }
}