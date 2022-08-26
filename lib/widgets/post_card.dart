import 'package:chapchapdeals_app/data/model/posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/api.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.postsModel, required this.currency, required this.onClick})
      : super(key: key);
  final PostsModel postsModel;
  final String currency;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .4,
      height: MediaQuery.of(context).size.width * .4,
      child: InkWell(
        onTap: onClick,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  '$domainUrl/storage/${postsModel.images![0].filename!}',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.width * .25,
                  errorBuilder: (context, error, stack) {
                    return const Center(child: Icon(Icons.error));
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    return Center(child: child);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 1.0, 1.0, 0.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).colorScheme.primary,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(postsModel.address!,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 1.0, 1.0, 0.0),
                child: Text(postsModel.title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 1.0, 1.0, 0.0),
                child: Text(
                    postsModel.price != null
                        ? '$currency ${postsModel.price}'
                        : 'Free',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
