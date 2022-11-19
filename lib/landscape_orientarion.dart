import 'package:flutter/material.dart';
import 'package:week_15_butterflies/buterflies_item.dart';
import 'package:week_15_butterflies/info.dart';

class LandscapeOrientation extends StatefulWidget {
  ButterFliesItem? selectedKey;
  ButterFliesItem? unknownKey;
  Function checkButterFly;
  LandscapeOrientation(
      {required this.selectedKey,
      required this.unknownKey,
      required this.checkButterFly,
      super.key});

  @override
  State<LandscapeOrientation> createState() => _LandscapeOrientationState();
}

class _LandscapeOrientationState extends State<LandscapeOrientation> {
  TextEditingController controller = TextEditingController();
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
    return Row(
      children: [
        SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.only(left: 30),
          width: MediaQuery.of(context).size.width / 2,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 4,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
                onChanged: ((value) {
                  print(value);
                  checkButterFly(value);
                  setState(() {
                    selectedKey;
                  });
                  print(selectedKey!.name);
                }),
              ),
            ),
            // widget.selectedKey == widget.unknownKey
            //     ? const Text(
            //         'Такой бабочки в списке нет!',
            //         style: TextStyle(
            //             color: Colors.red, fontWeight: FontWeight.bold),
            //       )
            //     : SizedBox(
            //         height: 20,
            //       ),
            for (var i = 0; i < butterfliesList.length; i++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedKey = butterfliesList[i];
                    print('второе ${widget.selectedKey!.name}');
                  });
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(butterfliesList[i].image),
                                  fit: BoxFit.fill),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(butterfliesList[i].name),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
          ]),
        )),
        SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              widget.selectedKey == null ||
                      widget.selectedKey == widget.unknownKey
                  ? SizedBox()
                  : Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(widget.selectedKey!.image),
                            fit: BoxFit.fill),
                      ),
                    ),
              widget.selectedKey == null ||
                      widget.selectedKey == widget.unknownKey
                  ? SizedBox()
                  : Text(widget.selectedKey!.description),
            ],
          ),
        )),
      ],
    );
  }
}
