import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:teste_flash_courier/models/address_model.dart';
import 'package:teste_flash_courier/shared/config/size-config/size-config.dart';
import 'package:teste_flash_courier/shared/image/placeHolder/place-holder-image.dart';

class ImagemDetailsWidget extends StatefulWidget {
  const ImagemDetailsWidget(this.address, {Key? key}) : super(key: key);
  final AddressModel? address;

  @override
  State<ImagemDetailsWidget> createState() => _ImagemDetailsWidgetState();
}

class _ImagemDetailsWidgetState extends State<ImagemDetailsWidget> {
  int _current = 0;

  Widget _carrouselImages() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: CarouselSlider(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1,
              onPageChanged: (int index, _) {
                setState(
                  () {
                    _current = index;
                  },
                );
              },
            ),
            items: widget.address?.photoCountry
                .map(
                  (item) => Stack(
                    alignment: const Alignment(0, 0),
                    children: <Widget>[
                      const Center(
                        child: SpinKitFadingCircle(color: Colors.amber),
                      ),
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: (Radius.circular(10)),
                              topLeft: (Radius.circular(10)),
                            ),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: (Radius.circular(10)),
                              topLeft: (Radius.circular(10)),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: item,
                              placeholder: (context, url) =>
                                  const SpinKitFadingCircle(
                                      color: Colors.amber),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.address!.photoCountry.map(
            (image) {
              int? index = widget.address!.photoCountry.indexOf(image);
              return Expanded(
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? const Color.fromRGBO(0, 0, 0, 0.9)
                          : Colors.amber),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget _containerImages() {
    double heightContainer = SizeConfig.screenHeight!;
    double widthContainer = SizeConfig.screenWidth!;

    return Builder(
      builder: (context) {
        if (widget.address?.photoCountry == null) {
          return SizedBox(
            height: heightContainer * .40,
            width: widthContainer,
            child: Image.network(
              loadImagePlaceHolder,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return SizedBox(
            height: heightContainer * .40,
            width: widthContainer,
            child: _carrouselImages(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _containerImages();
  }
}
