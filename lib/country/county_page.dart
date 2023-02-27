import 'package:bloc_lesson/country/country_cubit.dart';
import 'package:bloc_lesson/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'information_page.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final name = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CountryCubit>().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CountryCubit, CountryState>(
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.country?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InformationPage(
                          countryModelList: state.country![index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.lightBlueAccent,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(8),
                    child: Text(state.country?[index].name ?? ""),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (con) {
                return AlertDialog(
                  title: TextFormField(
                    controller: name,
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context
                              .read<CountryCubit>()
                              .getInformation(name.text);
                        },
                        child: Text("Save"))
                  ],
                );
              });
        },
      ),
    );
  }
}
