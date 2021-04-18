import '../models/post.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  final List<PostForm> formlist;
  final Function editHandler;
  final Function deleteHandler;
  PostList(this.formlist, this.editHandler, this.deleteHandler);
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 200, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(formlist[index].title,
                                style: Theme.of(context).textTheme.title),
                            Text(
                              formlist[index].body,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editHandler(formlist[index].id);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteHandler(formlist[index].id, context);
                        },
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
