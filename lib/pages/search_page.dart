import 'package:flutter/material.dart';
import 'package:redbull/data/choice_chips.dart';
import 'package:redbull/models/choice_chip_model.dart';
import 'package:redbull/pages/filter_page.dart';
import 'package:redbull/services/search_api_services.dart';
import 'package:redbull/utils/tiles.dart';
import 'package:redbull/utils/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isTapped = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController searchText = TextEditingController();
  final AutovalidateMode _autovalid = AutovalidateMode.disabled;
  final double spacing = 8;
  List<ChoiceChipData> choiceChips = ChoiceChips.all;
  String selectedChip = "Top";
  Widget btn = searchBtn(Image.asset("assets/icons/search.png"));
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            searchBar(),
            SizedBox(
              height: 50,
              child: chioceChip(),
            ),
            searchText.text == ""
                ? Center(
                    child: Image.asset(
                    "assets/undraw_Personal_info_re_ur1n.png",
                    width: size.width * 0.9,
                    height: size.width > 500 ? 300 : size.width * 0.8,
                  ))
                : buildPages()
          ],
        ),
      ),
    );
  }

  Widget buildPages() {
    switch (selectedChip) {
      case "Top":
        return postMethod(searchText.text.trim());
      case "Latest":
        return searchComments(searchText.text.trim());
      case "People":
        return profileMethod(searchText.text.trim());
      case "Comments":
        return searchComments(searchText.text.trim());
      case "Photos":
        return postMethod(searchText.text.trim());
      case "Videos":
        return searchComments("TODO");
      case "Shopbuzz":
        return searchComments("TODO");
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
                  labelStyle: const TextStyle(
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
                  selectedColor: const Color.fromARGB(255, 185, 238, 204),
                  backgroundColor: Colors.white,
                ),
              ))
          .toList(),
    );
  }

  Form searchBar() {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalid,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isTapped = false;
                btn = searchBtn(Image.asset("assets/icons/search.png"));
                searchText.clear();
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.3),
              ),
              child: TextFormField(
                controller: searchText,
                showCursor: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter search",
                ),
                onChanged: (value) {
                  setState(() {
                    if (searchText.text == "") {
                      isTapped = false;
                      btn = searchBtn(Image.asset("assets/icons/search.png"));
                    } else {
                      isTapped = true;
                      btn = searchBtn(Image.asset("assets/icons/filter.svg"));
                    }
                  });
                },
                // in Futurer if we need any validation like no numbers included in search text we can
                // put condition over here
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
          InkWell(
            onTap: () {
              final isValid = _formKey.currentState!.validate();
              if (isTapped) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilterPage()),
                );
              }
              if (isValid) {
                setState(() {
                  isTapped = true;
                  btn = searchBtn(Image.asset("assets/icons/filter.svg"));
                  SearchApi().fetchPost(searchText.text.trim());
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: btn,
            ),
          )
        ],
      ),
    );
  }
}
