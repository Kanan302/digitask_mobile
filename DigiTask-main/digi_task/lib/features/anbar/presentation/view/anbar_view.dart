import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/features/anbar/data/model/anbar_item_model.dart';
import 'package:digi_task/features/anbar/presentation/notifier/anbar_notifier.dart';
import 'package:digi_task/features/anbar/presentation/notifier/anbar_state.dart';
import 'package:digi_task/features/anbar/presentation/view/widgets/select_dropdown_field.dart';
import 'package:digi_task/presentation/components/custom_progress_indicator.dart';
import 'package:digi_task/shared/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnbarView extends StatefulWidget {
  const AnbarView({super.key});

  @override
  State<AnbarView> createState() => _AnbarViewState();
}

class _AnbarViewState extends State<AnbarView> {
  int? selectedWarehouseId = 0;

  List<AnbarItemModel> filterAnbarItems(List<AnbarItemModel> items) {
    if (selectedWarehouseId == 0) {
      return items;
    }
    return items
        .where((item) => item.warehouse?.id == selectedWarehouseId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16, top: 24, bottom: 24),
      child: Column(
        children: [
          CustomSearchBar(
            fillColor: context.colors.neutralColor100,
            hintText: 'Anbarda axtar',
            isAnbar: true,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SelectDropdownField(
                  title: "Anbar:",
                  onChanged: (value) {
                    setState(() {
                      selectedWarehouseId = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: context.colors.primaryColor95,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Avadanlıq',
                      maxLines: 1,
                      style: context.typography.body1SemiBold
                          .copyWith(color: context.colors.neutralColor20),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Marka',
                      style: context.typography.body1SemiBold
                          .copyWith(color: context.colors.neutralColor20),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Model',
                        style: context.typography.body1SemiBold
                            .copyWith(color: context.colors.neutralColor20),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Sayı',
                        style: context.typography.body1SemiBold
                            .copyWith(color: context.colors.neutralColor20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<AnbarNotifier>(
              builder: (context, notifier, child) {
                if (notifier.state is AnbarLoading) {
                  return const Center(
                    child: CustomProgressIndicator(),
                  );
                } else if (notifier.state is AnbarSuccess) {
                  final state = notifier.state as AnbarSuccess;
                  final filteredItems = filterAnbarItems(state.anbarList);
                  return Container(
                    decoration: BoxDecoration(
                        color: context.colors.neutralColor100,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12))),
                    child: ListView.builder(
                      itemCount: filteredItems.length,
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
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: Text(
                                        "${filteredItems[index].warehouse?.name}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.typography.body2SemiBold
                                            .copyWith(
                                                color: context
                                                    .colors.primaryColor50),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 12.0),
                                      child: Text(
                                        "${filteredItems[index].brand}",
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
                                        "${filteredItems[index].model}",
                                        maxLines: 1,
                                        style: context.typography.body2SemiBold
                                            .copyWith(
                                                color: context
                                                    .colors.primaryColor50),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        "${filteredItems[index].number}",
                                        style: context.typography.body2SemiBold
                                            .copyWith(
                                                color: context
                                                    .colors.primaryColor50),
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
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}
