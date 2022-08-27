import 'package:chapchapdeals_app/data/api.dart';
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
import 'package:url_launcher/url_launcher.dart';

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

  // static final AdRequest request = AdRequest(
  //   keywords: <String>['foo', 'bar'],
  //   contentUrl: 'http://foo.com/bar.html',
  //   nonPersonalizedAds: true,
  // );

  // InterstitialAd? _interstitialAd;
  // int _numInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();

    _categoriesController.getCategories();
    dropdownValue = _countriesController.prefferedCountry.value;
    if (_categoriesController.prefferedCategory.value == 'All') {
      _postsController.getPostsByLocationP(dropdownValue);
    } else {
      _postsController.getPostsByCategoryLocation(
          _categoriesController.prefferedCategory.value, dropdownValue);
    }
    _scrollController.addListener(() {
      if (_postsController.meta.value.lastPage != currentPage &&
          _categoriesController.prefferedCategory.value == 'All') {
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
    // _createInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            onTap: () => launchUrl(Uri.parse(domainUrl),
                mode: LaunchMode.inAppWebView),
            leading: const Icon(CupertinoIcons.person_alt_circle),
            title: const Text('Login to post Ad'),
          ),
          ListTile(
            onTap: () => launchUrl(Uri.parse('$domainUrl/en/page/terms'),
                mode: LaunchMode.inAppWebView),
            leading: const Icon(CupertinoIcons.umbrella),
            title: const Text('Terms & Privacy'),
          ),
        ],
      )),
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
        primary: true,
        leadingWidth: 40,
        leading: Builder(builder: (context) {
          return IconButton(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              iconSize: 30,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              icon: Icon(
                CupertinoIcons.circle_grid_3x3,
                color: Theme.of(context).colorScheme.primary,
              ));
        }),
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
        child: Obx(() {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ActionChip(
                onPressed: () {
                  _categoriesController.prefferedCategory.value = 'All';
                  _postsController
                      .getPostByLocationWithPagination(dropdownValue);
                },
                label: Text(
                  'All',
                  style: _categoriesController.prefferedCategory.value == 'All'
                      ? Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary)
                      : Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                ),
                backgroundColor:
                    _categoriesController.prefferedCategory.value == 'All'
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.background,
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
                    child: ActionChip(
                      onPressed: () {
                        _categoriesController.prefferedCategory.value =
                            e.translationOf!;
                        _postsController.getPostsByCategoryLocation(
                            e.translationOf!, dropdownValue);
                      },
                      label: Text(
                        e.name!,
                        style: _categoriesController.prefferedCategory.value ==
                                e.translationOf
                            ? Theme.of(context).textTheme.caption!.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary)
                            : Theme.of(context).textTheme.caption!.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                      ),
                      backgroundColor:
                          _categoriesController.prefferedCategory.value ==
                                  e.translationOf
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.background,
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
          );
        }),
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
              CupertinoIcons.arrowtriangle_down_fill,
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
                  _postsController
                      .getPostByLocationWithPagination(dropdownValue);
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
                    _postsController.meta.value.lastPage != currentPage &&
                        _categoriesController.prefferedCategory.value ==
                            'All') {
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
                  // _showInterstitialAd();
                  Navigator.pushNamed(context, '/post',
                      arguments: listPostModal[index]);
                },
                postsModel: listPostModal[index],
                currency: _countriesController.prefferedCurreny.value);
          }),
        ),
      ));

  // void _createInterstitialAd() {
  //   InterstitialAd.load(
  //       adUnitId: Platform.isAndroid
  //           ? 'ca-app-pub-3940256099942544/1033173712'
  //           : 'ca-app-pub-3940256099942544/4411468910',
  //       request: request,
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (InterstitialAd ad) {
  //           print('$ad loaded');
  //           _interstitialAd = ad;
  //           _numInterstitialLoadAttempts = 0;
  //           _interstitialAd!.setImmersiveMode(true);
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           print('InterstitialAd failed to load: $error.');
  //           _numInterstitialLoadAttempts += 1;
  //           _interstitialAd = null;
  //           if (_numInterstitialLoadAttempts < 4) {
  //             _createInterstitialAd();
  //           }
  //         },
  //       ));
  // }

  // void _showInterstitialAd() {
  //   if (_interstitialAd == null) {
  //     print('Warning: attempt to show interstitial before loaded.');
  //     return;
  //   }
  //   _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (InterstitialAd ad) =>
  //         print('ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       print('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //       print('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       _createInterstitialAd();
  //     },
  //   );
  //   _interstitialAd!.show();
  //   _interstitialAd = null;
  // }
}
