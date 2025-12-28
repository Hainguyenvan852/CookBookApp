import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/widgets/recipe_card_type_4.dart';

import '../../../../core/themes/main_theme.dart';
import '../../data/models/recipe_model.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

  final tabs = ['Popular', 'Breakfast', 'Lunch', 'Dinner', 'Healthy'];

  int _selectedIndex = 0;

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      'All recipes',
                      style: TextStyle(
                          color: ColorThemes.textPrimary,
                          fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Discover your next meal',
                      style: TextStyle(
                          color: ColorThemes.textSecondary,
                          fontSize: FontSizeThemes.regularFont
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorThemes.cardBackground
                  ),
                  child: SvgPicture.asset("lib/core/icons/chef-hat.svg", width: 35,)
                ),
              ],
            ),
            const SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.transparent, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.transparent, width: 1),
                  ),
                fillColor: ColorThemes.inputFieldBackground2,
                filled: true,
                hintText: 'Search recipes . . .',
                hintStyle: TextStyle(
                  color: ColorThemes.textSecondary,
                  fontSize: FontSizeThemes.mediumFont
                ),
                prefixIcon: Icon(Icons.search_rounded, color: ColorThemes.primaryAccent,),
                suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.mic, color: ColorThemes.textSecondary,))
              ),
            ),
            const SizedBox(height: 20,),
            DefaultTabController(
              length: tabs.length,
              child: ButtonsTabBar(
                radius: 50,
                duration: 250,
                unselectedBackgroundColor: ColorThemes.iconBackground,
                unselectedLabelStyle: TextStyle(color: ColorThemes.textSecondary),
                decoration: BoxDecoration(
                  color: ColorThemes.primaryAccent,
                  borderRadius: BorderRadius.circular(50),
                ),
                buttonMargin: EdgeInsets.symmetric(horizontal: 10,),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 25),
                onTap: (index){
                  _selectedIndex = index;
                },
                tabs: tabs.map((tab) => Tab(
                  text: tab,
                  icon: tab.toLowerCase() == 'popular' ? Icon(Icons.local_fire_department, size: 18) : null,
                )).toList(),
              ),
            ),
            const SizedBox(height: 20,),

            Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: recipes.map((recipe){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecipeCardType4(recipe: recipe),
                      const SizedBox(height: 10,),
                      Text(
                        recipe.dishName,
                        style: TextStyle(
                            fontSize: FontSizeThemes.regularFont,
                            color: ColorThemes.textPrimary,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.local_fire_department_rounded, color: Colors.deepOrange,size: 20,),
                          const SizedBox(width: 5,),
                          Text(
                            'Easy - Breakfast',
                            style: TextStyle(
                              fontSize: FontSizeThemes.smallFont,
                              color: ColorThemes.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            // GridView.builder(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       childAspectRatio: 0.725
            //     ),
            //     itemBuilder: (context, index){
            //       return Center(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             RecipeCardType3(recipe: recipes[index]),
            //             const SizedBox(height: 10,),
            //             Text(
            //               recipes[index].dishName,
            //               style: TextStyle(
            //                   fontSize: FontSizeThemes.regularFont,
            //                   color: ColorThemes.textPrimary,
            //                   fontWeight: FontWeight.bold
            //               ),
            //             ),
            //             Wrap(
            //               crossAxisAlignment: WrapCrossAlignment.center,
            //               children: [
            //                 Icon(Icons.local_fire_department_rounded, color: Colors.deepOrange,size: 20,),
            //                 const SizedBox(width: 5,),
            //                 Text(
            //                   'Easy - Breakfast',
            //                   style: TextStyle(
            //                     fontSize: FontSizeThemes.smallFont,
            //                     color: ColorThemes.textSecondary,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   itemCount: recipes.length,
            // )
            //
          ],
        ),
      ),
    );
  }
}
