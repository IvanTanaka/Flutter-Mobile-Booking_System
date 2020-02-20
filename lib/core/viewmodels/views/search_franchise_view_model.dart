import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/search_store_model.dart';
import 'package:member_apps/core/models/service_menu_model.dart';
import 'package:member_apps/core/viewmodels/base_viewmodel.dart';
import 'package:member_apps/ui/prototype_constant.dart';

class SearchFranchiseViewModel extends BaseViewmodel {
  ServiceMenuType type;

  List<SearchStoreModel> get searchStoreModel => [
        SearchStoreModel(
          id: "23123131",
          franchiseName: "Coco Bop",
          branches: [
            BranchModel(
                branchName: "Coco Bop",
                address: "Lippo Mall",
                phoneNumber: "+323 3232 32")
          ],
        ),
        SearchStoreModel(
          id: "321njkk2ni3",
          franchiseName: "Mie Akhun",
          branches: [
            BranchModel(
                branchName: "Cab. S. Parman",
                address: "Jl. S. Parman No 12A",
                phoneNumber: "+62 9292929"),
            BranchModel(
              branchName: "Cab. Wahidin",
              address: "Jl. Wahidin No 6",
              phoneNumber: "020 20101010",
            )
          ],
        ),
        SearchStoreModel(
          id: "23123131",
          franchiseName: "Coco Bop",
          branches: [
            BranchModel(
                branchName: "Coco Bop",
                address: "Lippo Mall",
                phoneNumber: "+323 3232 32")
          ],
        ),
        SearchStoreModel(
          id: "23123131",
          franchiseName: "Coco Bop",
          branches: [
            BranchModel(
                branchName: "Coco Bop",
                address: PrototypeConstant.LOREM_IPSUM,
                phoneNumber: "+323 3232 32")
          ],
        ),
        SearchStoreModel(
          id: "321njkk2ni3",
          franchiseName: "Mie Akhun",
          branches: [
            BranchModel(
                branchName: "Cab. S. Parman",
                address: PrototypeConstant.LOREM_IPSUM,
                phoneNumber: "+62 9292929"),
            BranchModel(
              branchName: "Cab. Wahidin",
              address: "Jl. Wahidin No 6",
              phoneNumber: "020 20101010",
            )
          ],
        ),
      ];

  // ignore: missing_return
  String get searchPageTitle {
    switch (this.type) {
      case ServiceMenuType.food:
        return "Search Restaurant";
        break;
      case ServiceMenuType.barber:
        return "Search Barbershop";
        break;
      case ServiceMenuType.karaoke:
        return "Search Karaoke";
        break;
      case ServiceMenuType.sport:
        return "Search Sport Field";
        break;
    }
  }

  // ignore: missing_return
  String get searchPagePlaceholder {
    switch (this.type) {
      case ServiceMenuType.food:
        return "Search restaurant name";
        break;
      case ServiceMenuType.barber:
        return "Search barbershop";
        break;
      case ServiceMenuType.karaoke:
        return "Search karaoke place";
        break;
      case ServiceMenuType.sport:
        return "Search court";
        break;
    }
  }

  Future getStore(String id) async {}
}
