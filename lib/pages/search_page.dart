import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:redbull/data/choice_chips.dart';
import 'package:redbull/models/choice_chip_model.dart';
import 'package:redbull/pages/filter_page.dart';
import 'package:redbull/services/search_api_services.dart';
import 'package:redbull/utils/tiles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  IconData searchIcon = Icons.search;
  final _formKey = GlobalKey<FormState>();
  TextEditingController searchText = TextEditingController();
  final AutovalidateMode _autovalid = AutovalidateMode.disabled;
  final double spacing = 8;
  List<ChoiceChipData> choiceChips = ChoiceChips.all;
  String selectedChip = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            formMethod(),
            SizedBox(
              height: 50,
              child: chioceChip(),
            ),
            searchText.text == ""
                ? Expanded(
                    child: Center(
                    child: Lottie.asset('assets/27506-search-for-employee.json',
                        width: 300, height: 300),
                  ))
                : buildPages()
          ],
        ),
      ),
    );
  }

  Widget buildPages() {
    switch (selectedChip) {
      case "All":
        return postMethod(searchText.text);
      case "People":
        return profileMethod(searchText.text);
      case "Comments":
        return searchComments(searchText.text);
      default:
        return Container();
    }
  }

  ListView chioceChip() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: choiceChips
          .map((choiceChip) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: ChoiceChip(
                  label: Text(choiceChip.label!),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  onSelected: (isSelected) => setState(() {
                    choiceChips = choiceChips.map((otherChip) {
                      final newChip = otherChip.copy(isSelected: false);
                      setState(() {
                        selectedChip = choiceChip.label!;
                      });
                      return choiceChip == newChip
                          ? newChip.copy(isSelected: isSelected)
                          : newChip;
                    }).toList();
                  }),
                  selected: choiceChip.isSelected!,
                  selectedColor: Color.fromARGB(255, 185, 238, 204),
                ),
              ))
          .toList(),
    );
  }

  Form formMethod() {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalid,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                searchIcon = Icons.search;
              });
            },
            child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                  ), //BoxShadow
                  //BoxShadow
                ],
              ),
              child: Expanded(
                child: TextFormField(
                  controller: searchText,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: " Enter search",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white60,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                  if (searchIcon == Icons.filter_list) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FilterPage()),
                    );
                  }
                  if (isValid) {
                    setState(() {
                      searchIcon = Icons.filter_list;
                      SearchApi().fetchPost(searchText.text);
                    });
                  }
                },
                child: Icon(
                  searchIcon,
                  size: 35,
                  color: Colors.black,
                )),
          )
        ],
      ),
    );
  }
}
