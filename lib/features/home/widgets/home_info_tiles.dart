import 'package:flutter/material.dart';
import 'package:p_fit/core/common_widgets/tiles/clickable_grid_tile.dart';
import 'package:p_fit/core/constants/colors.dart';
import 'package:p_fit/core/constants/spacing.dart';
import 'package:p_fit/core/routes/routes.dart';

class HomeInfoTiles extends StatelessWidget {
  const HomeInfoTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      crossAxisSpacing: Spacing.normalGridSpacing,
      mainAxisSpacing: Spacing.normalGridSpacing,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ClickableGridTile(
          text: 'Super Foods',
          onTap: () {
            Navigator.of(context).pushNamed(Routes.superFoodsScreen);
          },
          color: AppColors.homeTileColors[1],
        ),
        ClickableGridTile(
          text: 'Info Cards',
          onTap: () {
            Navigator.of(context).pushNamed(Routes.infoCardsScreen);
          },
          color: AppColors.homeTileColors[2],
        ),
        ClickableGridTile(
          text: 'Catalog',
          onTap: () {
            Navigator.of(context).pushNamed(Routes.catalogScreen);
          },
          color: AppColors.homeTileColors[3],
        ),
        ClickableGridTile(
          text: 'My Activity',
          onTap: () {
            Navigator.of(context).pushNamed(Routes.activityScreen);
          },
          color: AppColors.homeTileColors[5],
        ),
      ],
    );
  }
}
