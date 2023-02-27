import 'package:bloc_lesson/country/country_model.dart';
import 'package:bloc_lesson/country/main_interface.dart';
import 'package:http/http.dart' as http;

class MainRepo implements MainInterface {
  @override
  Future<List<CountryModel>> getInformation(String name) async {
    var res = await http.get(
        Uri.parse("http://universities.hipolabs.com/search?country=$name"));
    return  countryModelFromJson(res.bodyBytes);
  }
}
