import 'package:chapchapdeals_app/data/constants.dart';
import 'package:chapchapdeals_app/data/controller/categories_controller.dart';
import 'package:chapchapdeals_app/data/controller/countries.dart';
import 'package:chapchapdeals_app/data/controller/posts_controller.dart';
import 'package:chapchapdeals_app/data/model/categories.dart';
import 'package:chapchapdeals_app/data/model/countries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/posts.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  String dropdownValue = 'TZ';
  final PostsController _postsController = Get.put(PostsController());
  final CategoriesController _categoriesController =
      Get.put(CategoriesController());
  final CountriesController _countriesController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _categoriesController.getCategories();
    dropdownValue = _countriesController.prefferedCountry.value;
  }

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
        key: _scaffoldKey,
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
                child: Obx(() {
                  if (_categoriesController.isLoading.value) {
                    return const Center(
                        child: CupertinoActivityIndicator(
                      color: Colors.green,
                    ));
                  } else {
                    return _filterChips(
                        _categoriesController.categories.reversed.toList());
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13.0, 8.0, 13.0, 13.0),
                child: Obx(() {
                  if (_countriesController.isLoading.value) {
                    return const Center(
                        child: CupertinoActivityIndicator(
                      color: Colors.green,
                    ));
                  } else {
                    return _contentLocations(_countriesController.countries);
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13.0, 8.0, 13.0, 13.0),
                child: _categoriesItems(),
              ),
            ]),
      ),
    );
  }

  Widget _filterChips(List<CategoriesModel> categoriesModelList) => SizedBox(
        width: double.infinity,
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...categoriesModelList.map((e) => Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Chip(
                    label: Text(e.name!),
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

  Widget _contentLocations(List<CountriesModel> countryModelList) => SizedBox(
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
            items: countryModelList
                .map((e) => DropdownMenuItem(
                      value: e.code,
                      child: Text(e.name!),
                    ))
                .toList(),
            onChanged: (String? newValue) => setState(() {
                  dropdownValue = newValue!;
                  _countriesController.setPrefferedCountry(dropdownValue);
                })),
      );

  Widget _listItemCards() {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // ...listItemCards.map((e) => Padding(
          //       padding: const EdgeInsets.all(3.0),
          //       child: Card(
          //         child: Column(
          //           children: [
          //             Image.asset(e.image),
          //             Text(e.title),
          //             Text(e.subtitle),
          //           ],
          //         ),
          //       ),
          //     )),
        ],
      ),
    );
  }

  Widget _categoriesItems() {
    return GetX<CategoriesController>(builder: (_) {
      if (_categoriesController.isLoading.value) {
        return const Center(child: CupertinoActivityIndicator());
      } else {
        return ListView.builder(
            itemCount: _categoriesController.categories.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (itemBuilder, index) {
              CategoriesModel categoriesModel =
                  _categoriesController.categories[index];

              late List<PostsModel> postsModelList = [];
              _postsController
                  .getPostsByCategoryLocation((categoriesModel.id.toString()),
                      _countriesController.prefferedCountry.value)
                  .then((value) {
                postsModelList = value;
              });
              return Obx((){
                if (_postsController.isLoading.value) {
                  return const Center(
                      child: CupertinoActivityIndicator(
                    color: Colors.green,
                  ));
                } else {
                  return _contentCategories(categoriesModel, postsModelList);
                }
                  
                
              });
            });
      }
    });
  }

  Widget _contentCategories(
          CategoriesModel model, List<PostsModel> postModelList) =>
      SizedBox(
        width: double.infinity,
        height: 160,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(model.name!, style: Theme.of(context).textTheme.headline6),
                TextButton(
                    onPressed: () => null,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: const [
                        Text('See All'),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ],
                    )),
              ],
            ),
            ...postModelList.map((e) {
              return _contentPost(e);
            })
          ],
        ),
      );

  Widget _contentPost(PostsModel postModel) {
    return Container(
      width: 160,
      height: 160,
      color: Colors.black,
      child: Column(
        children: [
          Text(postModel.title!),
          Text(postModel.description!),
        ],
      ),
    );
  }
}
