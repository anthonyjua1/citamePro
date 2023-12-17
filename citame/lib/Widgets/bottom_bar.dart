import 'package:citame/pages/home_page.dart';
import 'package:citame/pages/pages_1/index_page.dart';
import 'package:citame/pages/pages_1/pages_2/chats_page.dart';
import 'package:citame/pages/pages_1/profile_page.dart';
import 'package:citame/providers/business_provider.dart';
import 'package:citame/providers/categories_provider.dart';
import 'package:citame/providers/navbar_provider.dart';
import 'package:citame/providers/page_provider.dart';
import 'package:citame/providers/user_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarraInferior extends ConsumerWidget {
  const BarraInferior({
    super.key,
    required this.searchBarController,
    required this.tip,
  });

  final TextEditingController searchBarController;
  final int tip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: Colors.white,
        selectedIndex: 0,
        onDestinationSelected: (value) async {
          ref.read(navbarProvider.notifier).changeState(value);
          if (value == 2) {
            if (context.mounted) {
              ref.read(pageProvider.notifier).actualizar(ProfilePage());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  )).then((_) {
                ref.read(pageProvider.notifier).actualizar(HomePage());
              });
            }
            ref.read(userProvider.notifier).cargar();
            ref.read(businessProvider.notifier).inicializar();
            ref.read(categoriesProvider.notifier).inicializar();
            ref.read(pageProvider.notifier).actualizar(ProfilePage());
            searchBarController.text = "";
          }
          if (value == 1) {
            ref.read(businessProvider.notifier).inicializar();
            ref.read(categoriesProvider.notifier).inicializar();
            searchBarController.text = "";
            if (context.mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IndexPage(),
                  ));
              await API.getAllUsers();
            }
          }
        },
        elevation: 0,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              size: 27,
            ),
            icon: Icon(
              Icons.home_outlined,
              size: 27,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.sticky_note_2, size: 27),
            icon: Icon(
              Icons.sticky_note_2_outlined,
              size: 27,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person_2,
              size: 27,
            ),
            icon: Icon(
              Icons.person_2_outlined,
              size: 27,
            ),
            label: '',
          ),
        ]);
  }
}
