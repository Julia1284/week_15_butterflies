import 'package:flutter/material.dart';
import 'package:week_15_butterflies/buterflies_item.dart';
import 'package:week_15_butterflies/info.dart';

class PortrainOrientation extends StatefulWidget {
  // ButterFliesItem? selectedKey;
  // ButterFliesItem? unknownKey;
  // Function checkButterFly;
  const PortrainOrientation(
      {
      //   required this.selectedKey,
      // required this.unknownKey,
      // required this.checkButterFly,
      super.key});

  @override
  State<PortrainOrientation> createState() => _PortrainOrientationState();
}

class _PortrainOrientationState extends State<PortrainOrientation> {
  TextEditingController _controller = TextEditingController();
  ButterFliesItem? selectedKey;
  ButterFliesItem? unknownKey = const ButterFliesItem(
      name: 'unknown', description: 'unknown', image: 'unknown');
  checkButterFly(String value) {
    for (var butterFly in butterfliesList) {
      print(butterFly.name);
      //toLowerCase делаем, чтобы введенные данные не зависели от регистра букв
      if (butterFly.name.toLowerCase() == value.toLowerCase()) {
        selectedKey = butterFly;
        return;
      }
    }
    return selectedKey = unknownKey;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height / 9,
        width: MediaQuery.of(context).size.width / 1.5,
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22),
          onSubmitted: ((value) {
            print(value);
            checkButterFly(value);
            setState(() {
              selectedKey;
            });
            print(selectedKey!.name);
          }),
        ),
      ),
      Expanded(
        child: Container(
            // height: MediaQuery.of(context).size.height / 9 * 8,
            padding: EdgeInsets.only(top: 15),
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: butterfliesList.length,
                itemBuilder: (context, index) {
                  final butterflies = butterfliesList[index];
                  return ButterFliesItem(
                    name: butterflies.name,
                    image: butterflies.image,
                    description: butterflies.description,
                  );
                })),
      )
    ]);
  }
}
