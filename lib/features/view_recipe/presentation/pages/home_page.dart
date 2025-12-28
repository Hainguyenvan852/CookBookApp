import 'package:flutter/material.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/widgets/recipe_card_type_1.dart';

import '../../data/models/recipe_model.dart';
import '../widgets/recipe_card_type_2.dart';
import '../widgets/recipe_card_type_3.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final UserModel user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<RecipeModel> recipes = [
    RecipeModel(
        id: 1,
        dishName: 'Bang Bang Prawn Salad',
        description: 'This Asian-inspired Bang Bang Shrimp Salad places crispy, '
            'sweet and slightly spicy sauced shrimp atop a bed of greens and veggies '
            'tossed in a light and herby cilantro and shallot vinaigrette. The recipe '
            'for bang bang sauce is great for any time you want a creamy spicy treat!',
        prepTime: 15,
        cookingTime: 5,
        serving: 4,
        imgUrl: 'https://wcewshqgjxgjxhmkixiq.supabase.co/storage/v1/object/sign/cookbook-storage/prawn-salad.jpg?'
            'token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9jY2QxMjY0ZC0wNDZhLTQ3YmEtYjBkYS1hODM1YTg3MWM2NTIiLCJh'
            'bGciOiJIUzI1NiJ9.eyJ1cmwiOiJjb29rYm9vay1zdG9yYWdlL3ByYXduLXNhbGFkLmpwZyIsImlhdCI6MTc2NjY3NDA4NiwiZXhwIj'
            'oxNzk4MjEwMDg2fQ.T_mbQKUAilq01QynxaDN55Q1CcDKC3hEgdTvLpJmZCc'
    ),
    RecipeModel(
        id: 2,
        dishName: 'Barbecue Pork Buns',
        description: 'Traditional Vietnamese barbecue pork buns wrapped in a delicious and soft bread. The bun is '
            'eaten for breakfast, lunch or dinner and is one of the four heavenly kings’ dim sum dishes',
        prepTime: 25,
        cookingTime: 25,
        serving: 5,
        imgUrl: 'https://wcewshqgjxgjxhmkixiq.supabase.co/storage/v1/object/sign/cookbook-storage/barbecue-pork-buns.'
            'jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9jY2QxMjY0ZC0wNDZhLTQ3YmEtYjBkYS1hODM1YTg3MWM2NTIiLC'
            'JhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJjb29rYm9vay1zdG9yYWdlL2JhcmJlY3VlLXBvcmstYnVucy5qcGciLCJpYXQiOjE3NjY2NzQyMD'
            'gsImV4cCI6MTc2OTI2NjIwOH0.ia2_CMXTBz5iHHYC3lgza6hNrxsQFySgKtVCugHgQvg'
    ),
    RecipeModel(
        id: 3,
        dishName: 'Beef Pho',
        description: 'Beef pho is Vietnam\'s iconic noodle soup, featuring tender rice noodles, thinly sliced beef '
            '(raw, cooked, or both), and a deeply aromatic broth simmered for hours with charred aromatics and spices '
            'like star anise, cinnamon, and cloves, served with fresh herbs (basil, cilantro, mint), bean sprouts, lime,'
            ' and chili for customization. It\'s a flavorful, savory, and comforting dish, rich in spices and textures, perfect for any meal. ',
        prepTime: 25,
        cookingTime: 45,
        serving: 2,
        imgUrl: 'https://wcewshqgjxgjxhmkixiq.supabase.co/storage/v1/object/sign/cookbook-storage/beef-pho.jpg?token=ey'
            'JraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9jY2QxMjY0ZC0wNDZhLTQ3YmEtYjBkYS1hODM1YTg3MWM2NTIiLCJhbGciOiJIUzI1N'
            'iJ9.eyJ1cmwiOiJjb29rYm9vay1zdG9yYWdlL2JlZWYtcGhvLmpwZyIsImlhdCI6MTc2NjY3NDIzOCwiZXhwIjoxNzY5MjY2MjM4fQ.cohU'
            'XUERzBW-Mq3oVR_Qxj-xEj1sKr8sO9zXZql3qzg'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            floating: true,
            snap: true,
            pinned: false,
            title: RichText(
                text: TextSpan(
                    text: 'Good morning,',
                    style: TextStyle(
                        color: ColorThemes.textSecondary,
                        fontSize: FontSizeThemes.regularFont
                    ),
                    children: [
                      TextSpan(
                          text: '\nChef ${widget.user.name}!',
                          style: TextStyle(
                              color: ColorThemes.textPrimary,
                              fontSize: FontSizeThemes.mediumFont,
                              fontWeight: FontWeight.bold
                          )
                      )
                    ]
                )
            ),
            actions: [
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.notifications_rounded, color: ColorThemes.primaryAccent, size: 22,),
                style: IconButton.styleFrom(
                    backgroundColor: ColorThemes.iconBackground
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s dish',
                    style: TextStyle(
                        color: ColorThemes.textPrimary,
                        fontSize: FontSizeThemes.mediumFont,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 250,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return RecipeCardType1(recipe: recipes[index]);
                        },
                        separatorBuilder: (context, index){
                          return const SizedBox(width: 15,);
                        },
                        itemCount: recipes.length
                    ),
                  ),
                  SizedBox(height: 40,),
                  RichText(
                    text: TextSpan(
                      text: 'Featured recipes',
                      style: TextStyle(
                          color: ColorThemes.textPrimary,
                          fontSize: FontSizeThemes.mediumFont,
                          fontWeight: FontWeight.bold
                      ),
                      children: [
                        TextSpan(
                          text: '\nBuilt by top chefs',
                          style: TextStyle(
                            color: ColorThemes.textSecondary,
                            fontSize: FontSizeThemes.smallFont,
                            fontWeight: FontWeight.w400
                          ),
                        )
                      ]
                    )
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 270,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RecipeCardType3(recipe: recipes[index]),
                              SizedBox(height: 10,),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  maxLines: 2,
                                  recipes[index].dishName,
                                  style: TextStyle(
                                    fontSize: FontSizeThemes.regularFont,
                                    color: ColorThemes.textPrimary,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Text(
                                '${recipes[index].prepTime + recipes[index].cookingTime} minutes - Easy',
                                style: TextStyle(
                                    fontSize: FontSizeThemes.smallFont,
                                    color: ColorThemes.textSecondary,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index){
                          return const SizedBox(width: 15,);
                        },
                        itemCount: recipes.length
                    ),
                  ),
                  SizedBox(height: 40,),
                  Text(
                    'Newly update',
                    style: TextStyle(
                        color: ColorThemes.textPrimary,
                        fontSize: FontSizeThemes.mediumFont,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return RecipeCardType2(recipe: recipes[index]);
                      },
                      separatorBuilder: (context, index){
                        return const SizedBox(height: 15,);
                      },
                      itemCount: 3
                  ),
                  SizedBox(height: 30,),
                  Text(
                    'Daily cooking tips',
                    style: TextStyle(
                        color: ColorThemes.textPrimary,
                        fontSize: FontSizeThemes.mediumFont,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          height: 100,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: ColorThemes.cardBackground
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF0F542E)
                                ),
                                child: Icon(Icons.tips_and_updates, color: ColorThemes.primaryAccent, size: 28,),
                              ),
                              SizedBox(width: 15,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Keep vegetables fresh longer',
                                    style: TextStyle(
                                        color: ColorThemes.textPrimary,
                                        fontSize: FontSizeThemes.regularFont,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 280,
                                    child: Text(
                                      overflow: TextOverflow.clip,
                                      'Wrap the vegetables in damp paper and wrap them in an airtight container to keep them fresh all week.',
                                      style: TextStyle(
                                          color: ColorThemes.textSecondary,
                                          fontSize: FontSizeThemes.regularFont,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 100,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(20),
                              color: Color(0xFF31230E).withOpacity(0.7)
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF643F08)
                                ),
                                child: Icon(Icons.soup_kitchen_rounded, color: Colors.orange, size: 28,),
                              ),
                              SizedBox(width: 15,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Clear broth',
                                    style: TextStyle(
                                        color: ColorThemes.textPrimary,
                                        fontSize: FontSizeThemes.regularFont,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 280,
                                    child: Text(
                                      overflow: TextOverflow.clip,
                                      'Boil over low heat and skim the foam frequently for the perfect pot of water.',
                                      style: TextStyle(
                                        color: ColorThemes.textSecondary,
                                        fontSize: FontSizeThemes.regularFont,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}
