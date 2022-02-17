import 'package:flutter/material.dart';
import '../providers/great_places.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    builder: (ctx, greatPlaces, child) =>
                        greatPlaces.items.length <= 0
                            ? child != null
                                ? child
                                : Center(
                                    child: Text('No places added yet!'),
                                  )
                            : ListView.builder(
                                itemCount: greatPlaces.items.length,
                                itemBuilder: (ctx, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(greatPlaces.items[i].image),
                                  ),
                                  title: Text(greatPlaces.items[i].title),
                                  // subtitle: Text(greatPlaces.items[i].location!.address!),
                                  onTap: () {},
                                ),
                              ),
                    child: Center(
                      child: Text('No places added yet'),
                    ),
                  ),
      ),
    );
  }
}
