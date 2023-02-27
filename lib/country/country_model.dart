// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

part 'country_model.g.dart';

List<CountryModel> countryModelFromJson(dynamic str) => List<CountryModel>.from(
    json.decode(utf8.decode(str)).map((x) => CountryModel.fromJson(x)));

String countryModelToJson(List<CountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class CountryModelList extends HiveObject {
  CountryModelList({
    this.countryList,
    this.name
  });
  @HiveField(0)
  List<CountryModel>? countryList;
  @HiveField(1)
  String? name;
}

@HiveType(typeId: 0)
class CountryModel extends HiveObject {
  CountryModel({
    this.domains,
    this.name,
    this.webPages,
    this.stateProvince,
  });

  @HiveField(0)
  List<String>? domains;
  @HiveField(1)
  String? name;
  @HiveField(2)
  List<String>? webPages;
  @HiveField(3)
  dynamic stateProvince;

  CountryModel copyWith({
    List<String>? domains,
    String? name,
    List<String>? webPages,
    dynamic stateProvince,
  }) =>
      CountryModel(
        domains: domains ?? this.domains,
        name: name ?? this.name,
        webPages: webPages ?? this.webPages,
        stateProvince: stateProvince ?? this.stateProvince,
      );

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        domains: json["domains"] == null
            ? []
            : List<String>.from(json["domains"]?.map((x) => x)),
        name: json["name"],
        webPages: json["web_pages"] == null
            ? []
            : List<String>.from(json["web_pages"]?.map((x) => x)),
        stateProvince: json["state-province"],
      );

  Map<String, dynamic> toJson() => {
        "domains":
            domains == null ? [] : List<dynamic>.from(domains!.map((x) => x)),
        "name": name,
        "web_pages":
            webPages == null ? [] : List<dynamic>.from(webPages!.map((x) => x)),
        "state-province": stateProvince,
      };
}
