import 'country_model.dart';

abstract class MainInterface {
  Future<List<CountryModel>> getInformation(String name);
}
