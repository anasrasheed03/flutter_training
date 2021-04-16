import '../models/post.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  final List<PostForm> formlist;
  PostList(this.formlist);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: formlist.isEmpty
          ? Column(
              children: [
                Text('NO record added Yet!!'),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(formlist[index].title,
                              style: Theme.of(context).textTheme.title),
                          Text(
                            formlist[index].body,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: formlist.length,
            ),
    );
  }
}
