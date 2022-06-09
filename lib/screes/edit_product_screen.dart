import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routerName = 'edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _focusPriceNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imgUrlController = TextEditingController();

  @override
  void initState() {}

  @override
  void dispose() {
    _focusPriceNode.dispose();
    _descriptionFocusNode.dispose();
    _imgUrlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Products')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focusPriceNode);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _focusPriceNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
              ),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imgUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imgUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imgUrlController,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
