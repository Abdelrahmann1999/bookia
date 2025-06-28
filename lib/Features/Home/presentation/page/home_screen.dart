import 'package:bookia/Features/Home/presentation/cubit/home_cubit.dart';
import 'package:bookia/Features/Home/presentation/cubit/home_state.dart';
import 'package:bookia/Features/Home/presentation/widgets/best_seller_list.dart';
import 'package:bookia/Features/Home/presentation/widgets/home_slider.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: AppBar(
              toolbarHeight: 100,
              backgroundColor: Colors.white,
              elevation: 0,
              title: SvgPicture.asset(
                Appassetes.logoSvg,
                width: 100,
                height: 30,
              ),
              actions: [
                IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  onPressed: () {},
                  icon: SvgPicture.asset(Appassetes.searchSvg),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  homeSlider(sliders: cubit.sliders),
                  Gap(10),
                  BestSellerList(products: cubit.bestSellers),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
