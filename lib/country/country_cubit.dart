import 'package:bloc_lesson/country/main_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'country_model.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit(this._mainService) : super(CountryState());
  final MainInterface _mainService;
  Box<CountryModelList>? box;

  init() async {
    box = await Hive.openBox("countryWithName");
    List<CountryModelList> newList = box?.values.toList() ?? [];
    emit(CountryState(country: newList));
    // get from box and set state
  }

  getInformation(String name) async {
    List<CountryModel> newList = await _mainService.getInformation(name);
    CountryModelList newData =
        CountryModelList(countryList: newList, name: name);
    box?.put(name, newData);
    //  set box
    state.country?.add(newData);
    emit(CountryState(country: state.country));
    //  set state
  }


  delete(int index){
    box?.delete(state.country?[index].name);
    state.country?.removeAt(index);
    emit(CountryState(country: state.country));
  }

}
