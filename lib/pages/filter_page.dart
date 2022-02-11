import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redbull/data/enum.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  People _people = People.fromAnyone;
  Location _location = Location.anywhere;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.cancel_outlined,
              color: Colors.black,
            )),
        elevation: 0,
        title: Row(
          children: [
            const Text(
              "Search Filter",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Apply",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: const Color.fromRGBO(112, 214, 92, 1.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            const SizedBox(width: 15)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("People",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('From Anyone'),
                  leading: Radio<People>(
                    value: People.fromAnyone,
                    activeColor: const Color.fromARGB(255, 93, 211, 69),
                    groupValue: _people,
                    onChanged: (People? value) {
                      setState(() {
                        _people = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('People You Follow'),
                  leading: Radio<People>(
                    value: People.peopleYouFollw,
                    activeColor: const Color.fromARGB(255, 93, 211, 69),
                    groupValue: _people,
                    onChanged: (People? value) {
                      setState(() {
                        _people = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Text("Location",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Anywhere'),
                  leading: Radio<Location>(
                    value: Location.anywhere,
                    activeColor: const Color.fromARGB(255, 93, 211, 69),
                    groupValue: _location,
                    onChanged: (Location? value) {
                      setState(() {
                        _location = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Near You'),
                  leading: Radio<Location>(
                    value: Location.nearYou,
                    activeColor: const Color.fromARGB(255, 93, 211, 69),
                    groupValue: _location,
                    onChanged: (Location? value) {
                      setState(() {
                        _location = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
