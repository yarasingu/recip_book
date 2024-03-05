import 'package:flutter/material.dart';
import 'package:myapp/models/recip.dart';
import 'package:myapp/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [_recipTypeButton(), _reciplist()],
        ),
    );
  }

  Widget _recipTypeButton() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: FilledButton(onPressed: () {}, child: const Text("Snack")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child:
                FilledButton(onPressed: () {}, child: const Text("Break Fast")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: FilledButton(onPressed: () {}, child: const Text("Lunch")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: FilledButton(onPressed: () {}, child: const Text("Dinner")),
          ),
        ],
      ),
    );
  }

  Widget _reciplist() {
    return Expanded(
        child: FutureBuilder(
            future: DataService().getrecip(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Una ble to load data"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Recip recipe = snapshot.data![index];
                  return ListTile(
                    contentPadding: const EdgeInsets.only(top: 20.0),
                    isThreeLine: true,
                    subtitle: Text("${recipe.cuisine}\nDifficulty: ${recipe.difficulty}"),
                    leading: Image.network(recipe.image),
                    title: Text(
                      recipe.name,
                    ),
                    trailing: Text("${recipe.rating.toString()}⭐  ",
                    style: const TextStyle(fontSize: 15),),
                  );
                },
              );
            }));
  }
}
