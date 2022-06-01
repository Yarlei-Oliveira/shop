import 'package:flutter/material.dart';
import 'package:shop/provider/couter_provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(provider?.state.value.toString() ?? '0'),
            IconButton(onPressed: () {
              setState(() {
                provider?.state.inc();
              });
            }, 
            icon: Icon(Icons.add)),
            IconButton(onPressed: () {
              setState(() {
                provider?.state.dec();
              });
            }, 
            icon: Icon(Icons.remove))
          ],
        ),
      ),
    );
  }
}
