import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/core/widgets/net_image.dart';
import 'package:wssal/features/offers/data/models/offers_model.dart';
import 'package:wssal/features/offers/providers/offers_provider.dart';
import 'package:wssal/features/product/data/models/product_type_enum.dart';
import 'package:wssal/features/product/screens/all_products_screen.dart';

class OffersSlider extends StatelessWidget {
  const OffersSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OffersProvider>(
      builder: (_, provider, __) {
        if (provider.loading) return const AppLoader();
        if (provider.error != null) return const ErrorView();
        final offersList = provider.offersList;
        return offersList.isEmpty
            ? const EmptyView()
            : Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        height: 200,
                        onPageChanged: (index, reason) =>
                            provider.changeOfferIndex(index)),
                    items: List.generate(
                      offersList.length,
                      (index) => SliderWidget(
                        offer: offersList[index],
                      ),
                    ),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: provider.offerIndex,
                    count: provider.offersList.length,
                    effect: const SwapEffect(
                      activeDotColor: AppColors.secondColor,
                      dotHeight: 10,
                      dotWidth: 10
                    ),
                  )
                ],
              );
      },
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key, required this.offer}) : super(key: key);
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return AllProductsScreens(
                productType: ProductTypeEnum.offer,
                offerId: offer.id,
              );
            },
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.thirdColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: NetImage(
            offer.image ?? '',
          ),
        ),
      ),
    );
  }
}
