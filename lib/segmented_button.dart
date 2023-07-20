import 'package:flutter/material.dart';

class SegmentedButtonApp extends StatelessWidget {
  const SegmentedButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.blueGrey,
      ),
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              SingleChoice(),
              SizedBox(height: 20),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

enum HomePageSegmentedButtonType { warning, toss, recent }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  HomePageSegmentedButtonType expiryView = HomePageSegmentedButtonType.warning;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<HomePageSegmentedButtonType>(
      segments: const <ButtonSegment<HomePageSegmentedButtonType>>[
        ButtonSegment<HomePageSegmentedButtonType>(
            value: HomePageSegmentedButtonType.warning,
            label: Text(
              'Expiring',
              style: TextStyle(color: Colors.white),
            ),
            //icon: Icon(Icons.new_releases)),
            icon: Icon(Icons.alarm)),
        ButtonSegment<HomePageSegmentedButtonType>(
            value: HomePageSegmentedButtonType.toss,
            label: Text(
              'Expired',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(Icons.warning)),
        ButtonSegment<HomePageSegmentedButtonType>(
            value: HomePageSegmentedButtonType.recent,
            label: Text(
              'Recent',
              style: TextStyle(color: Colors.white),
            ),
            //icon: Icon(Icons.fiber_new)),
            icon: Icon(Icons.access_time)),
      ],
      selected: <HomePageSegmentedButtonType>{expiryView},
      showSelectedIcon: false,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return const Color.fromARGB(185, 0, 135, 205);
              }
              return const Color.fromARGB(255, 0, 135, 255);
            },
          ),
          iconColor: MaterialStateProperty.all(Colors.white)),
      onSelectionChanged: (Set<HomePageSegmentedButtonType> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          expiryView = newSelection.first;
        });
      },
    );
  }
}
/*
enum Sizes { extraSmall, small, medium, large, extraLarge }

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  Set<Sizes> selection = <Sizes>{Sizes.large, Sizes.extraLarge};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Sizes>(
      segments: const <ButtonSegment<Sizes>>[
        ButtonSegment<Sizes>(value: Sizes.extraSmall, label: Text('XS')),
        ButtonSegment<Sizes>(value: Sizes.small, label: Text('S')),
        ButtonSegment<Sizes>(value: Sizes.medium, label: Text('M')),
        ButtonSegment<Sizes>(
          value: Sizes.large,
          label: Text('L'),
        ),
        ButtonSegment<Sizes>(value: Sizes.extraLarge, label: Text('XL')),
      ],
      selected: selection,
      onSelectionChanged: (Set<Sizes> newSelection) {
        setState(() {
          selection = newSelection;
        });
      },
      multiSelectionEnabled: true,
    );
  }
}*/
