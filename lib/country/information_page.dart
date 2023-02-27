import 'package:bloc_lesson/country/country_model.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  final CountryModelList countryModelList;

  const InformationPage({Key? key, required this.countryModelList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: countryModelList.countryList?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.lightBlueAccent,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(8),
              child: Text(countryModelList.countryList?[index].name ?? ""),
            );
          }),
    );
  }
}
