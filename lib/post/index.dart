import 'package:chapchapdeals_app/data/api.dart';
import 'package:chapchapdeals_app/data/controller/categories_controller.dart';
import 'package:chapchapdeals_app/data/controller/countries.dart';
import 'package:chapchapdeals_app/data/model/posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ad_helper.dart';
import '../tools/comma_string.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final CountriesController _countryController = Get.find();
  final CategoriesController _categoriesController = Get.find();
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();

    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as PostsModel;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 1.0, 0, 1.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  launchUrl(Uri.parse('sms:${post.phone!}'));
                },
                child: Icon(
                  CupertinoIcons.chat_bubble_2_fill,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 1.0, 0, 1.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  launchUrl(
                      Uri.parse(
                          'https://wa.me/${post.phone!}/?text=I\'m interested in ${post.title}'),
                      mode: LaunchMode.externalApplication);
                },
                child: ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: Image.asset(
                    'assets/whatsapp.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(post.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .3,
                child: _imageSlider(post)),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 1.0),
              child: _captions(post),
            ),
            if (_bannerAd != null)
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13.0, 1.0, 8.0, 1.0),
              child: Text(
                post.title!,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 100.0),
              child: _description(post),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageSlider(PostsModel post) => PageView(
    key: widget.key,
        scrollDirection: Axis.horizontal,
        children: [
          ...post.images!
              .map((e) => Image.network('$domainUrl/storage/${e.filename!}')),
        ],
      );

  Widget _captions(PostsModel postsModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                spacing: 3,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Theme.of(context).colorScheme.primary,
                    size: 10,
                  ),
                  Text(
                    postsModel.address!,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                spacing: 3,
                children: [
                  Icon(
                    CupertinoIcons.list_bullet_indent,
                    color: Theme.of(context).colorScheme.primary,
                    size: 10,
                  ),
                  Text(
                    _categoriesController.categories
                        .where((p0) => p0.translationOf == postsModel.cid)
                        .first
                        .name!,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            height: MediaQuery.of(context).size.width * .1,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                  '${_countryController.prefferedCurreny.value} ${postsModel.price == null ? 'ASK' : CommaString.toStringWithComma(double.parse(postsModel.price!))}',
                  overflow: TextOverflow.visible,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      );

  Widget _description(PostsModel postsModel) => Html(
      onLinkTap: ((url, context, attributes, element) {
        launchUrl(
          Uri.parse(url!), 
          mode: LaunchMode.inAppWebView,
          );
      }),
      data: postsModel.description);

  // Widget _imageFrame() =>
}
