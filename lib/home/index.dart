import 'package:chapchapdeals_app/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  String dropdownValue = 'Tanzania';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              hintText: 'Search...',
              hintStyle: Theme.of(context).textTheme.caption),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.blueGrey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(13.0, 13.0, 0.0, 8.0),
                child: Text('All Categories',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13.0, 0.0, 0.0, 8.0),
                child: _filterChips(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13.0, 8.0, 13.0, 13.0),
                child: _contentLocations(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13.0, 8.0, 13.0, 13.0),
                child: _contentCategories(),
              ),
            ]),
      ),
    );
  }

  Widget _filterChips() => SizedBox(
        width: double.infinity,
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...chipsFilter.map((e) => Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Chip(
                    label: Text(e),
                    backgroundColor: Colors.grey[200],
                    side: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )),
          ],
        ),
      );

  Widget _contentLocations() => SizedBox(
        width: double.infinity,
        height: 60,
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.location_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              hintText: 'Select Location',
              hintStyle: Theme.of(context).textTheme.caption,
            ),
            borderRadius: BorderRadius.circular(20),
            icon: const Icon(
              Icons.arrow_downward_rounded,
              color: Colors.green,
            ),
            isExpanded: true,
            value: dropdownValue,
            items: contentLocations.map((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (String? newValue) => setState(() {
                  dropdownValue = newValue!;
                })),
      );

  Widget _contentCategories() => SizedBox(
    width: double.infinity,
    height: 160,
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Real Estate', style: Theme.of(context).textTheme.headline6),
            TextButton(onPressed: () => null,
             child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                Text('See All'),
                SizedBox(width: 5,),
                Icon(Icons.arrow_forward_ios, size: 15,),
              ],
            
            )),
          ],
        )
      

      ],
    ),
  );

  Widget _listItemCards(){
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...listItemCards.map((e) => Padding(
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  child: Column(
                    children: [
                      Image.asset(e.image),
                      Text(e.title),
                      Text(e.subtitle),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
