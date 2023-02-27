import 'dart:developer';

import 'package:bloc_lesson/add_post_cubit.dart';
import 'package:bloc_lesson/country/country_cubit.dart';
import 'package:bloc_lesson/country/country_model.dart';
import 'package:bloc_lesson/country/main_repo.dart';
import 'package:bloc_lesson/main_cubit.dart';
import 'package:bloc_lesson/main_state.dart';
import 'package:bloc_lesson/one_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'country/county_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CountryModelAdapter());
  Hive.registerAdapter(CountryModelListAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: RepositoryProvider(
        create: (context) => MainRepo(),
        child: BlocProvider(
          create: (context) => CountryCubit(context.read<MainRepo>()),
          child: const CountryPage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("main build");
    return BlocListener<CounterCubit, CounterState>(
      listenWhen: (prev, current) {
        return prev.counter != current.counter || prev.name != current.name;
      },
      listener: (context, state) {
        if (state.counter == 5) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('5'),
                );
              });
        }
        if (state.name == "Najot Talim") {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Najot Talim'),
                );
              });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              BlocBuilder<CounterCubit, CounterState>(
                buildWhen: (prev, current) {
                  return current.counter != prev.counter;
                },
                builder: (context, state) {
                  print("bloc build counter");
                  return Text(
                    '${state.counter}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              BlocBuilder<CounterCubit, CounterState>(
                buildWhen: (prev, current) {
                  return current.name != prev.name;
                },
                builder: (context, state) {
                  print("bloc build name");
                  return Text(
                    state.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                context.read<CounterCubit>().increment();
              },
            ),
            const SizedBox(height: 4),
            FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () => context.read<CounterCubit>().decrement(),
            ),
            const SizedBox(height: 4),
            FloatingActionButton(
              child: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: TextFormField(
                            controller: name,
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<CounterCubit>()
                                      .addName(name.text);
                                  Navigator.pop(context);
                                },
                                child: Text("Save"))
                          ],
                        ));
              },
            ),
            const SizedBox(height: 4),
            FloatingActionButton(
              child: const Icon(Icons.ac_unit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<CounterCubit>(context),
                      child: const OnePage(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
