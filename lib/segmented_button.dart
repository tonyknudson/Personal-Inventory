import 'package:flutter/material.dart';

class SegmentedButtonBar extends StatelessWidget {
  const SegmentedButtonBar({super.key});

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
          child: SingleChoice(),
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
  HomePageSegmentedButtonType segmentedButtonSelection =
      HomePageSegmentedButtonType.warning;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<HomePageSegmentedButtonType>(
      segments: getButtonSegments(),
      selected: <HomePageSegmentedButtonType>{segmentedButtonSelection},
      showSelectedIcon: false,
      style: getButtonStyle(),
      onSelectionChanged: (Set<HomePageSegmentedButtonType> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          segmentedButtonSelection = newSelection.first;
        });
      },
    );
  }

  getButtonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const Color.fromARGB(185, 0, 135, 205);
            }
            return const Color.fromARGB(255, 0, 135, 255);
          },
        ),
        iconColor: MaterialStateProperty.all(Colors.white));
  }

  getButtonSegments() {
    return const <ButtonSegment<HomePageSegmentedButtonType>>[
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
    ];
  }
}
