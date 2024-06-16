import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/features/anbar/presentation/notifier/anbar_notifier.dart';
import 'package:digi_task/shared/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/path/icon_path.dart';
import '../../../../presentation/components/custom_progress_indicator.dart';
import '../notifier/anbar_state.dart';
import 'widgets/select_dropdown_field.dart';

class AnbarView extends StatelessWidget {
  const AnbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg)),
        title: Text('Anbar', style: context.typography.subtitle2Medium),
        actions: [
          SvgPicture.asset(IconPath.import.toPathSvg),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(IconPath.export.toPathSvg),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24, bottom: 24),
        child: Column(
          children: [
            CustomSearchBar(
              fillColor: context.colors.neutralColor100,
              hintText: 'Anbarda axtar',
              isAnbar: true,
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                SelectDropdownField(
                  title: "Anbar:",
                ),
                SizedBox(
                  width: 24,
                ),
                SelectDropdownField(
                  title: "Region:",
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: context.colors.primaryColor95,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Avadanlıq',
                        maxLines: 1,
                        style: context.typography.body1SemiBold.copyWith(color: context.colors.neutralColor20),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Marka',
                        style: context.typography.body1SemiBold.copyWith(color: context.colors.neutralColor20),
                      ),
                    ),
                    Expanded(
                      flex: 2,

                      child: Center(
                          child: Text(
                        'Model',
                        style: context.typography.body1SemiBold.copyWith(color: context.colors.neutralColor20),
                      )),
                    ),
                    Expanded(
                      flex: 2,

                      child: Center(
                          child: Text(
                        'Sayı',
                        style: context.typography.body1SemiBold.copyWith(color: context.colors.neutralColor20),
                      )),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<AnbarNotifier>(
              builder: (context, notifier, child) {
                if (notifier.state is AnbarLoading) {
                  return const Center(
                    child: CustomProgressIndicator(),
                  );
                } else if (notifier.state is AnbarSuccess) {
                  final state = notifier.state as AnbarSuccess;
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: context.colors.neutralColor100,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                      child: ListView.builder(
                        itemCount: state.anbarList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Divider(
                                color: context.colors.neutralColor90,
                                height: 0,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 12.0),
                                        child: Text(
                                          "${state.anbarList[index].warehouse?.name}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.typography.body2SemiBold
                                              .copyWith(color: context.colors.primaryColor50),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 12.0),
                                        child: Text(
                                          "${state.anbarList[index].brand}",
                                          style: context.typography.body2SemiBold,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          "${state.anbarList[index].model}",
                                          maxLines: 1,
                      
                                          style: context.typography.body2SemiBold
                                              .copyWith(color: context.colors.primaryColor50),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          "${state.anbarList[index].number}",
                                          style: context.typography.body2SemiBold
                                              .copyWith(color: context.colors.primaryColor50),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  );

                  // Column(
                  //     children: anbarList.anbarList
                  //         .map(
                  //           (e) => Column(
                  //             children: [
                  //               Divider(
                  //                 color: context.colors.neutralColor90,
                  //                 height: 0,
                  //               ),
                  //               const SizedBox(
                  //                 height: 7,
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 16.0, right: 16, top: 10),
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Flexible(
                  //                       child: Text(
                  //                         "${e.warehouse?.name}",
                  //                         maxLines: 1,
                  //                         style: context.typography.body2SemiBold
                  //                             .copyWith(color: context.colors.primaryColor50),
                  //                       ),
                  //                     ),
                  //                     Flexible(
                  //                       child: Text(
                  //                         "${e.brand}",
                  //                         style: context.typography.body2SemiBold,
                  //                       ),
                  //                     ),
                  //                     Flexible(
                  //                       child: Center(
                  //                         child: Text(
                  //                           "${e.model}",
                  //                           style: context.typography.body2SemiBold
                  //                               .copyWith(color: context.colors.primaryColor50),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Flexible(
                  //                       child: Center(
                  //                         child: Text(
                  //                           "${e.number}",
                  //                           style: context.typography.body2SemiBold
                  //                               .copyWith(color: context.colors.primaryColor50),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               const SizedBox(
                  //                 height: 10,
                  //               )
                  //             ],
                  //           ),
                  //         )
                  //         .toList());
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
