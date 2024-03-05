import 'package:flutter/material.dart';
import 'package:myapp/models/recip.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key, required this.recipe});

  final Recip recipe;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white60,
        title: const Text("Recipe Book"),
      ),
      body: _buildUI(context,),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Column(
      children: [
        _recipeImage(context,),
      ],
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height *0.40,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(recipe.image
          ),
        ),
      ),
    );
  }
}
