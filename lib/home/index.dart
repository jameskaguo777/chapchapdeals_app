import 'package:chapchapdeals_app/data/controller/categories_controller.dart';
import 'package:chapchapdeals_app/data/controller/countries.dart';
import 'package:chapchapdeals_app/data/controller/posts_controller.dart';
import 'package:chapchapdeals_app/data/model/categories.dart';
import 'package:chapchapdeals_app/data/model/countries.dart';
import 'package:chapchapdeals_app/widgets/post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  final ScrollController _scrollController = ScrollController();
  late int currentPage = 1;
  @override
  void initState() {
    super.initState();
    _categoriesController.getCategories();
    dropdownValue = _countriesController.prefferedCountry.value;
    _postsController.getPostsByLocationP(dropdownValue);
    _scrollController.addListener(() {
      if (_postsController.meta.value.lastPage != currentPage) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          currentPage++;
          _postsController.getPostByLocationWithPagination(dropdownValue,
              page: currentPage);
          if (kDebugMode) {
            print('end of list current page $currentPage');
          }
        }
      }
    });
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
                    return _filterChips(_categoriesController.categories);
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13.0, 8.0, 13.0, 0.0),
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
                child: _obxPosts(),
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
            Chip(
              label: const Text('All'),
              backgroundColor: Colors.grey[200],
              side: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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

  Widget _obxPosts() {
    return Obx(() {
      if (_postsController.isLoading.value) {
        return const Center(
            child: CupertinoActivityIndicator(
          color: Colors.green,
        ));
      } else {
        return _postsController.posts.isEmpty
            ? const Center(
                child: Text('No Posts Found'),
              )
            : _gridPosts(_postsController.posts);
      }
    });
  }

  Widget _gridPosts(List<PostsModel> listPostModal) => SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.67,
      child: GestureDetector(
        child: GridView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: _postsController.posts.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (1 / 1), crossAxisCount: 2),
          itemBuilder: ((context, index) {
            if (index == _postsController.posts.length) {
              return Obx(() {
                if (_postsController.isPaginationLoading.value ||
                    _postsController.meta.value.lastPage != currentPage) {
                  return const CupertinoActivityIndicator();
                } else {
                  return const Center(
                    child: Text('End of page'),
                  );
                }
              });
            }
            return PostCard(
                onClick: () {
              
                  Navigator.pushNamed(context, '/post',
                      arguments:
                          listPostModal[index]);
                },
                postsModel: listPostModal[index],
                currency: _countriesController.prefferedCurreny.value);
          }),
        ),
      ));
}
