import 'package:covid19_tracker_application/ui/widgets/zone_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class SearchDistricts extends SearchDelegate {
  final List zoneList;
  final zoneData;

  SearchDistricts(this.zoneList, this.zoneData);

  var data;
  bool check = false;
  void getData() async {
    var res =
        await get("https://api.covid19india.org/state_district_wise.json");
    data = jsonDecode(res.body);
    check = true;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
//    getData();
    final suggestionList = query.isEmpty
        ? zoneList
        : zoneList
            .where((element) =>
                element['district'].toString().toLowerCase().startsWith(query))
            .toList();

    zoneColor(int index) {
      if (suggestionList[index]['zone'] == 'Green') {
        return Color(0xFFE1F2E8);
      } else if (suggestionList[index]['zone'] == 'Red') {
        return Color(0xFFFDE1E1);
      } else if (suggestionList[index]['zone'] == 'Orange') {
        return Colors.orange.withOpacity(.2);
      }
    }

    textColor(int index) {
      if (suggestionList[index]['zone'] == 'Green') {
        return Color(0xFF41A745);
      } else if (suggestionList[index]['zone'] == 'Red') {
        return Color(0xFFF83F38);
      } else if (suggestionList[index]['zone'] == 'Orange') {
        return Colors.orange;
      }
    }

    activeCases(int index) {
      getData();
      var statesData = zoneData['zones'][index]['state'];
      var districtsData = zoneData['zones'][index]['district'];
      var toRender =
          data[statesData]["districtData"][districtsData]["confirmed"];
      return toRender.toString();
    }

    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ZoneCard(
            color: zoneColor(index),
            district: suggestionList[index]['district'],
            state: suggestionList[index]['state'],
            textColor: textColor(index),
            activeCases: 'NA',
          );
        });
  }
}
