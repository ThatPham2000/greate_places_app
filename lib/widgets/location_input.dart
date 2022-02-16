import 'package:location/location.dart';
import 'package:flutter/material.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    // print(locData.latitude);
    // print(locData.longitude);

    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude ?? 0, longitude: locData.longitude ?? 0);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
