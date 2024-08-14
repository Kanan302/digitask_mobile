import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/features/anbar/data/model/anbar_item_model.dart';
import 'package:digi_task/features/anbar/presentation/notifier/anbar_notifier.dart';
import 'package:digi_task/features/anbar/presentation/notifier/anbar_state.dart';
import 'package:digi_task/features/anbar/presentation/view/widgets/idxal_dialog.dart';
import 'package:digi_task/features/anbar/presentation/view/widgets/ixrac_dialog.dart';
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
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  List<AnbarItemModel> filterAnbarItems(List<AnbarItemModel> items) {
    return items.where((item) {
      final matchesWarehouse =
          selectedWarehouseId == 0 || item.warehouse == selectedWarehouseId;
      final matchesSearch = item.equipmentName
              ?.toLowerCase()
              .contains(searchQuery.toLowerCase()) ??
          false;
      return matchesWarehouse && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _buildHeaderText(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: context.typography.body1SemiBold.copyWith(
            color: context.colors.neutralColor20,
          ),
        ),
      ),
    );
  }

  Widget _buildItemText(String? text,
      {int flex = 1, TextAlign align = TextAlign.start}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Text(
          text ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: align,
          style: context.typography.body2SemiBold.copyWith(
            color: context.colors.primaryColor50,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16, top: 24, bottom: 20),
      child: Column(
        children: [
          CustomSearchBar(
            controller: searchController,
            fillColor: context.colors.neutralColor100,
            hintText: 'Anbarda axtar',
            isAnbar: true,
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
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
                  _buildHeaderText('Avadanlıq', flex: 3),
                  _buildHeaderText('Marka', flex: 2),
                  _buildHeaderText('Model', flex: 2),
                  _buildHeaderText('Sayı', flex: 2),
                  _buildHeaderText('', flex: 1),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<AnbarNotifier>(
              builder: (context, notifier, child) {
                if (notifier.state is AnbarLoading) {
                  return const Center(child: CustomProgressIndicator());
                } else if (notifier.state is AnbarSuccess) {
                  final state = notifier.state as AnbarSuccess;
                  final filteredItems = filterAnbarItems(state.anbarList);
                  return Container(
                    decoration: BoxDecoration(
                      color: context.colors.neutralColor100,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return Column(
                          children: [
                            Divider(
                              color: context.colors.neutralColor90,
                              height: 0,
                            ),
                            const SizedBox(height: 7),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildItemText(item.equipmentName, flex: 3),
                                  _buildItemText(item.brand, flex: 2),
                                  _buildItemText(item.model,
                                      flex: 2, align: TextAlign.center),
                                  _buildItemText(item.number?.toString(),
                                      flex: 2, align: TextAlign.center),
                                  PopupMenuButton<String>(
                                    onSelected: (String value) async {
                                      if (value == 'idxal') {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return IdxalDialog(itemId: item.id);
                                          },
                                        );
                                      } else if (value == 'ixrac') {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return IxracDialog(itemId: item.id);
                                          },
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.more_vert),
                                    itemBuilder: (BuildContext context) => [
                                      const PopupMenuItem<String>(
                                        value: 'ixrac',
                                        child: Row(
                                          children: [
                                            Text('İxrac'),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'idxal',
                                        child: Row(
                                          children: [
                                            Text('İdxal'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
