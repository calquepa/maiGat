import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai_gat/core/entities/cat/cat_entity.dart';
import 'package:mai_gat/feature/cat_breed/BLOC/cat_breed_bloc.dart';
import 'package:mai_gat/feature/cat_breed/BLOC/cat_breed_event.dart';
import 'package:mai_gat/feature/cat_breed/BLOC/cat_breed_state.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/cat_breed_card.dart';
import 'package:mai_gat/feature/cat_breed/presentation/widgets/common/cat_breed_functions.dart';

class CatBreedData extends StatefulWidget {
  const CatBreedData({super.key});

  @override
  State<CatBreedData> createState() => _CatBreedData();
}

class _CatBreedData extends State<CatBreedData> {

  ScrollController _cardsScrollController = ScrollController();
  List<Widget> dataWidgets = [];
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    _cardsScrollController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatBreedBloc, CatBreedState>(
      builder: (context, state) {
        _cardsScrollController = ScrollController(initialScrollOffset: CatBreedFunctions().getCurrentScrollPosition(state));

        if(state is CatBreedLoaded) {
          // Clean cards
          dataWidgets = [];
          // Fill cards by state
          fillCards(state);
        }
        return Scrollbar(
          controller: _cardsScrollController,
          thickness: 4.0,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollUpdateNotification) {
                            context.read<CatBreedBloc>().add(DoUpdateScrollPosition(scrollPosition: notification.metrics.pixels));
                          }
                          return false;
                        },
                        child:  ListView.builder(
                          // This is for last card (bottom => Navigation bar)
                          padding: const EdgeInsets.only(bottom: 5.0),
                          // This is for can refresh cards if the cards size is less to 3
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _cardsScrollController,
                          itemCount: dataWidgets.length,
                          itemBuilder: (BuildContext context, int index) {
                            return dataWidgets[index];
                          }
                        ),
                      ),
                    ),
                  ),
                ]
              ),
          ]),
        );
      }
    );
  }

  void fillCards(CatBreedState state) {
    if(state is CatBreedLoaded) {
      if(state.catBreeds.isNotEmpty) {
        // Add activities by state
        for(CatBreedEntity breeds in state.catBreeds) {
          dataWidgets.add(CatBreedCard(catBreedEntity: breeds));
        }
      }
    }
  }

}