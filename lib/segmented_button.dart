import 'package:flutter/material.dart';
import 'package:inventory/string_utilities.dart';

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
    int paddingSpaces = 3;
    return <ButtonSegment<HomePageSegmentedButtonType>>[
      ButtonSegment<HomePageSegmentedButtonType>(
          value: HomePageSegmentedButtonType.warning,
          label: Text(
            '${StringUtils.getSpaces(paddingSpaces)}Expiring${StringUtils.getSpaces(paddingSpaces)}',
            style: const TextStyle(color: Colors.white),
          ),
          //icon: Icon(Icons.new_releases)),
          icon: const Icon(Icons.alarm)),
      ButtonSegment<HomePageSegmentedButtonType>(
          value: HomePageSegmentedButtonType.toss,
          label: Text(
            '${StringUtils.getSpaces(paddingSpaces)}Expired${StringUtils.getSpaces(paddingSpaces)}',
            style: const TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.warning)),
      ButtonSegment<HomePageSegmentedButtonType>(
          value: HomePageSegmentedButtonType.recent,
          label: Text(
            '${StringUtils.getSpaces(paddingSpaces)}Recent${StringUtils.getSpaces(paddingSpaces)}',
            style: const TextStyle(color: Colors.white),
          ),
          //icon: Icon(Icons.fiber_new)),
          icon: const Icon(Icons.access_time)),
    ];
  }
}
