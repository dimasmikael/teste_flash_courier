import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teste_flash_courier/shared/config/size-config/size-config.dart';
import 'package:teste_flash_courier/shared/image/placeHolder/place-holder-image.dart';

class PhotoWidget extends StatefulWidget {
  PhotoWidget({Key? key, required this.listImages, this.imageFileList})
      : super(key: key);
  final List<XFile> listImages;
  List<XFile>? imageFileList;

  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  double valorInicialFoto = 40;
  int _current = 0;
  bool isImage = false;
  final picker = new ImagePicker();
  final ImagePicker _picker = ImagePicker();
  //File? fotoCamera;
  dynamic _pickImageError;
  set _imageFile(XFile value) {
    widget.imageFileList = value == null ? null : [value];
  }

  Widget _buttonGaleria(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        try {
          PermissionStatus statusReadPermission =
              await Permission.storage.status;

          if (statusReadPermission.isDenied) await Permission.storage.request();

          _selecionarImagemGaleria(
            ImageSource.gallery,
            context: context,
            isMultiImage: true,
          );
        } catch (e) {
          throw e;
        }
      },
      icon: const Icon(Icons.photo_library),
      label: const Text('Galeria'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.amber.shade700,
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(60, 60),
        ),
      ),
    );
  }

  Widget _imagemMiniatura(indice, BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: altura * 0.035, left: 5, right: 5),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Container(
            width: largura / 3,
            height: largura / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: CachedNetworkImage(
                imageUrl: loadImagePlaceHolder,
                imageBuilder: (context, imageProvider) => Image.file(
                  File(widget.listImages[indice].path),
                  cacheHeight: 400,
                  cacheWidth: 400,
                  fit: BoxFit.contain,
                ),
                placeholder: (context, url) =>
                    const SpinKitFadingCircle(color: Colors.amber),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
          ),
          new Icon(
            Icons.delete,
            color: Colors.red[300],
          ),
        ],
      ),
    );
  }

  Widget _excluirImagem(indice, BuildContext context) {
    double altura = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: altura / 1.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: CachedNetworkImage(
                imageUrl: loadImagePlaceHolder,
                imageBuilder: (context, imageProvider) => Image.file(
                  File(
                    widget.listImages[indice].path,
                  ),
                  cacheHeight: 700,
                  cacheWidth: 700,
                  fit: BoxFit.contain,
                ),
                placeholder: (context, url) =>
                    const SpinKitFadingCircle(color: Colors.amber),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            TextButton(
              child: const Text(
                "Excluir",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                setState(
                  () {
                    widget.listImages.removeAt(indice);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selecionarImagemGaleria(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        final pickedFileList = await _picker.pickMultiImage(
          imageQuality: valorInicialFoto.round(),
        );
        setState(
          () {
            widget.imageFileList = pickedFileList;
            widget.listImages.addAll(widget.imageFileList!);
          },
        );
      } catch (e) {
        setState(
          () {
            _pickImageError = e;
          },
        );
      }
    } else {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
          imageQuality: 50,
        );
        setState(
          () {
            _imageFile = pickedFile!;
            widget.listImages.addAll(widget.imageFileList!);
          },
        );
      } catch (e) {
        setState(
          () {
            _pickImageError = e;
          },
        );
      }
    }
  }

  Widget _selectImagem(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(1),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: SizeConfig.screenWidth!,
            height:
            widget.listImages.isNotEmpty?
            SizeConfig.screenHeight! *    .32:SizeConfig.screenHeight! *    .15,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: _buttonGaleria(context),
                    ),
                  ],
                ),

                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.listImages.length + 1,
                    itemBuilder: (context, indice) {
                      if (indice == widget.listImages.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                        );
                      }
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    _excluirImagem(indice, context),
                              );
                            },
                            child: _imagemMiniatura(indice, context),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FormField<List>(
      initialValue: widget.listImages,
      validator: (images) {
        if (images!.isEmpty) {
          return "Necessário selecionar uma imagem!";
        }
        return null;
      },
      builder: (state) {
        return Column(
          children: <Widget>[
            _selectImagem(context),
            if (state.hasError)
              Text(
                "[${state.errorText}]",
                style: const TextStyle(color: Colors.red, fontSize: 14),
              )
          ],
        );
      },
    );
  }
}
