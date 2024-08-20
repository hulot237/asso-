// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/data/help_center_model.dart';

class HelpCenterState extends Equatable {
  final List<CategoriesHelpModel>? allCategorieHelp;
  final List<TopicsHelpModel>? allTopicsHelp;
  final CategoriesTopicsHelpModel? allCategorieTopicHelp;
  final bool isLoading;
  final bool isLoadingTransaction;

  HelpCenterState({
    this.allCategorieHelp,
    this.allCategorieTopicHelp,
    this.allTopicsHelp,
    this.isLoading = false,
    this.isLoadingTransaction = false,
  });

  @override
  List<Object?> get props => [
        allCategorieHelp,
        allCategorieTopicHelp,
        allTopicsHelp,
        isLoading,
        isLoadingTransaction,
      ];

  HelpCenterState copyWith({
    List<CategoriesHelpModel>? allCategorieHelp,
    List<TopicsHelpModel>? allTopicsHelp,
    CategoriesTopicsHelpModel? allCategorieTopicHelp,
    bool? isLoading,
    bool? isLoadingTransaction,
  }) {
    return HelpCenterState(
      allCategorieHelp: allCategorieHelp ?? this.allCategorieHelp,
      allTopicsHelp: allTopicsHelp ?? this.allTopicsHelp,
      allCategorieTopicHelp: allCategorieTopicHelp ?? this.allCategorieTopicHelp,
      isLoading: isLoading ?? this.isLoading,
      isLoadingTransaction: isLoadingTransaction ?? this.isLoadingTransaction,
    );
  }
}
