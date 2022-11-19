import 'package:flutter/material.dart';
import 'package:week_15_butterflies/buterflies_item.dart';
import 'package:week_15_butterflies/info.dart';

class ButterFliesList {
  String name;
  String description;
  String image;
  ButterFliesList(this.name, this.description, this.image);
}

class ButterfliesList extends StatefulWidget {
  const ButterfliesList({Key? key}) : super(key: key);

  @override
  State<ButterfliesList> createState() => _ButterfliesListState();
}

class _ButterfliesListState extends State<ButterfliesList> {
  ButterFliesItem? selectedKey;
  ButterFliesItem? unknownKey = const ButterFliesItem(
      name: 'unknown', description: 'unknown', image: 'unknown');
  TextEditingController _controller = TextEditingController();
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
    return OrientationBuilder(
      builder: ((context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'Бабочки',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                body: isPortrait
                    ? Column(children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          height: MediaQuery.of(context).size.height / 9,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
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
                              padding: const EdgeInsets.only(top: 15),
                              child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
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
                      ])
                    : Row(
                        children: [
                          SingleChildScrollView(
                              child: Container(
                            padding: const EdgeInsets.only(left: 30),
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: TextField(
                                      controller: _controller,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      )),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                      onSubmitted: ((value) {
                                        checkButterFly(value);
                                        setState(() {
                                          selectedKey;
                                        });
                                      }),
                                    ),
                                  ),
                                  selectedKey == unknownKey
                                      ? const Text(
                                          'Такой бабочки в списке нет!',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : const SizedBox(
                                          height: 20,
                                        ),
                                  for (var i = 0;
                                      i < butterfliesList.length;
                                      i++)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedKey = butterfliesList[i];
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
                                                        image: AssetImage(
                                                            butterfliesList[i]
                                                                .image),
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
                                selectedKey == null || selectedKey == unknownKey
                                    ? SizedBox()
                                    : Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  selectedKey!.image),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                selectedKey == null || selectedKey == unknownKey
                                    ? SizedBox()
                                    : Text(selectedKey!.description),
                              ],
                            ),
                          )),
                        ],
                      )));
      }),
    );
  }
}
