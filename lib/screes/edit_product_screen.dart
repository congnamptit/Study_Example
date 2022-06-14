import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_example/models/product.dart';
import 'package:udemy_example/providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routerName = 'edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imgUrlFocusNode = FocusNode();
  final _imgUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  bool _isInit = true;

  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImgUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        _editProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productId as String);
        _initValues = {
          'title': _editProduct.title!,
          'description': _editProduct.description!,
          'price': _editProduct.price!.toString(),
          'imageUrl': '',
        };
        _imgUrlController.text = _editProduct.imageUrl!;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imgUrlFocusNode.removeListener(_updateImgUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgUrlController.dispose();
    _imgUrlFocusNode.dispose();

    super.dispose();
  }

  void _updateImgUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      if (_imgUrlController.text.isEmpty ||
          _imgUrlController.text.startsWith('https') &&
              !_imgUrlController.text.startsWith('https') ||
          _imgUrlController.text.endsWith('png') &&
              !_imgUrlController.text.endsWith('jpg') &&
              !_imgUrlController.text.endsWith('jpeg')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState?.save();
    if (_editProduct.id != null) {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editProduct.id!, _editProduct);
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(_editProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                initialValue: _initValues['title'],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provider a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                    title: value,
                    description: _editProduct.description,
                    isFavorite: _editProduct.isFavorite,
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                initialValue: _initValues['price'],
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than hero';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    price: double.parse(value!),
                    imageUrl: _editProduct.imageUrl,
                    title: _editProduct.title,
                    description: _editProduct.description,
                    isFavorite: _editProduct.isFavorite,
                  );
                },
              ),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                initialValue: _initValues['description'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Description';
                  }
                  if (value.length < 10) {
                    return 'Show be ai least 10 character';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                    id: _editProduct.id,
                    price: _editProduct.price,
                    imageUrl: _editProduct.imageUrl,
                    title: _editProduct.title,
                    description: value,
                    isFavorite: _editProduct.isFavorite,
                  );
                },
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
                      // initialValue: _initValues['imageUrl'],
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an Image Url';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'please enter a valid URL';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editProduct = Product(
                          id: _editProduct.id,
                          price: _editProduct.price,
                          imageUrl: value,
                          title: _editProduct.title,
                          description: _editProduct.description,
                          isFavorite: _editProduct.isFavorite,
                        );
                      },
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
