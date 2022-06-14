import 'package:flutter/material.dart';
import 'package:udemy_example/screes/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({
    Key? key,
    this.title,
    this.imgUrl,
    this.id,
  }) : super(key: key);
  final String? title;
  final String? id;
  final String? imgUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title!),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl!),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routerName,
                  arguments: id,
                );
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
