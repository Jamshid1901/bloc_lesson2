import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'country_model.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryState());
  Box<CountryModelList>? box;

  init() async {
    box = await Hive.openBox("countryWithName");
    List<CountryModelList> newList = box?.values.toList() ?? [];
    emit(CountryState(country: newList));
    // get from box and set state
  }

  getInformation(String name) async {
    var res = await http.get(
        Uri.parse("http://universities.hipolabs.com/search?country=$name"));
    List<CountryModel> newList = countryModelFromJson(res.body);
    CountryModelList newData =
        CountryModelList(countryList: newList, name: name);
    box?.put(name, newData);
    state.country?.add(newData);
    emit(CountryState(country: state.country));
  }
}
