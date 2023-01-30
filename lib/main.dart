// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unioncu/cubit/counter/counter_cubit.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: MyHomePage(title: 'Flutter frezee Demo'),
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            erorr: ((message, lastNumberBeforeError) {
              var snackBar =
                  SnackBar(content: Text('$message $lastNumberBeforeError '));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }));
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: state.when(
              initial: (initial) {
                return Center(child: Text('data $initial'));
              },
              loading: () => Center(child: CircularProgressIndicator()),
              loaded: (newData) {
                return Center(
                  child: Text('data $newData'),
                );
              },
              erorr: (e, lastNumber) {
                return Center(
                  child: Text(
                    'error ${e.toString()} $lastNumber ',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.add),
                    onPressed: () {
                      state.maybeWhen(
                          initial: (initial) => context
                              .read<CounterCubit>()
                              .incrementData(initial),
                          loaded: (currentNumber) => context
                              .read<CounterCubit>()
                              .incrementData(currentNumber),
                          orElse: () {});
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.remove),
                    onPressed: () {
                      state.maybeWhen(
                          initial: (initial) =>
                              context.read<CounterCubit>().decrement(initial),
                          loaded: (currentNumber) => context
                              .read<CounterCubit>()
                              .decrement(currentNumber),
                          orElse: () {});
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.restore),
                    onPressed: () {
                      context.read<CounterCubit>().resetCounter();
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
