import 'package:chapchapdeals_app/data/api.dart';
import 'package:chapchapdeals_app/data/controller/countries.dart';
import 'package:chapchapdeals_app/data/model/posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../tools/comma_string.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final CountriesController _countryController = Get.find();

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as PostsModel;
    return Scaffold(
      floatingActionButton: Padding(
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
              padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 18.0),
              child: _description(post),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageSlider(PostsModel post) => PageView(
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
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                postsModel.address!,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              )
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            height: MediaQuery.of(context).size.width * .2,
            child: Text(
                '${_countryController.prefferedCurreny.value} ${postsModel.price == null ? 'ASK' : CommaString.toStringWithComma(double.parse(postsModel.price!))}',
                overflow: TextOverflow.visible,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface)),
          )
        ],
      );

  Widget _description(PostsModel postsModel) => Html(
      onLinkTap: ((url, context, attributes, element) {
        launchUrl(Uri.parse(url!));
      }),
      data: postsModel.description);

  // Widget _imageFrame() =>
}
