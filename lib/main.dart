import 'dart:developer';

import 'package:bloc_lesson/main_cubit.dart';
import 'package:bloc_lesson/main_state.dart';
import 'package:bloc_lesson/one_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: const MyHomePage(
          title: "Bloc",
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
    return Scaffold(
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
            BlocBuilder<CounterCubit, MainState>(
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
            BlocBuilder<CounterCubit, MainState>(
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
                                context.read<CounterCubit>().addName(name.text);
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
                      )));
            },
          ),
        ],
      ),
    );
  }
}
