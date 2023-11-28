import 'package:flutter/material.dart';

import 'package:flip_card/flip_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipCard',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  _renderBg() {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
    );
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0x00FFFFFF),
      ),
    );
  }

  _renderContent(context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
      color: const Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        side: CardSide.FRONT,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        front: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF006666),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Front', style: Theme.of(context).textTheme.displayLarge),
              Text('Click here to flip back',
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        back: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF006666),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Back', style: Theme.of(context).textTheme.displayLarge),
              Text('Click here to flip front',
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlipCard'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _renderBg(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _renderAppBar(context),
              Expanded(
                flex: 4,
                child: _renderContent(context),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          )
        ],
      ),
    );
  }
}