import 'package:flutter/material.dart';
import 'package:microblogging/core/common/widgets/color_loader.dart';

import 'package:microblogging/features/news/domain/entities/news_entity.dart';

class NewListTile extends StatelessWidget {
  const NewListTile(this.newEntity);

  final News newEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(
            news: newEntity,
          ),
          SizedBox(height: 10),
          Text('${newEntity.message.content}')
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final News news;

  const _Header({
    @required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          news.user.profilePicture,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) =>
              Container(height: 40, width: 40, child: ColorLoader()),
          errorBuilder: (context, error, stackTrace) => CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${news.user.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${news.message.createdAt}',
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
