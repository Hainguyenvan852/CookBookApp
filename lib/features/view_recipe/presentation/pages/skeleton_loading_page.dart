import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1D15),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Skeleton(height: 40, width: 40, borderRadius: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Skeleton(height: 10, width: 80),
                SizedBox(height: 6),
                Skeleton(height: 14, width: 150),
              ],
            )
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Skeleton(height: 30, width: 30, borderRadius: 15),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(height: 20, width: 120),
              const SizedBox(height: 15),

              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  separatorBuilder: (_, __) => const SizedBox(width: 15),
                  itemBuilder: (_, __) => const Skeleton(width: 300, borderRadius: 24),
                ),
              ),

              const SizedBox(height: 30),

              const Skeleton(height: 20, width: 150),
              const SizedBox(height: 15),

              Column(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildFeaturedItemSkeleton()),
                      const SizedBox(width: 15),
                      Expanded(child: _buildFeaturedItemSkeleton()),
                    ],
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildFeaturedItemSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Skeleton(height: 180, width: double.infinity, borderRadius: 20),
        SizedBox(height: 10),
        Skeleton(height: 14, width: 120),
        SizedBox(height: 6),
        Skeleton(height: 10, width: 80),
      ],
    );
  }
}

class RecipeDetailShimmer extends StatelessWidget {
  const RecipeDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1D15),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Skeleton(height: 350, width: double.infinity, borderRadius: 0,),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeleton(height: 32, width: 200),
                  const SizedBox(height: 15),

                  const Skeleton(height: 14, width: double.infinity),
                  const SizedBox(height: 8),
                  const Skeleton(height: 14, width: double.infinity),
                  const SizedBox(height: 8),
                  const Skeleton(height: 14, width: 250),

                  const SizedBox(height: 30),

                  const Row(
                    children: [
                      Expanded(child: Skeleton(height: 80)),
                      SizedBox(width: 15),
                      Expanded(child: Skeleton(height: 80)),
                      SizedBox(width: 15),
                      Expanded(child: Skeleton(height: 80)),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Skeleton(height: 24, width: 120),
                  const SizedBox(height: 15),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, __) => const Skeleton(height: 70, width: double.infinity),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final double borderRadius;

  const Skeleton({
    super.key,
    this.height,
    this.width,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF162921),
      highlightColor: const Color(0xFF2C3E34),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}