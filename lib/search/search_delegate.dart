import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:happy_postcode_flutter/components/app_theme.dart';
import 'package:happy_postcode_flutter/components/centered_message.dart';
import 'package:happy_postcode_flutter/models/address.dart';
import 'package:happy_postcode_flutter/pages/main_page.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:provider/provider.dart';

class DataSearch extends SearchDelegate {
  @override
  String get searchFieldLabel => "Av Tiradentes Maringá PR 87013-260";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<AddressProvider>(context, listen: false);

    return FutureBuilder(
      future: provider.findByQuery(context, query),
      builder: (BuildContext context, AsyncSnapshot<List<Address>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return ListSkeleton(
              style: SkeletonStyle(
                theme: SkeletonTheme.Dark,
                isShowAvatar: true,
                barCount: 2,
                isAnimation: true,
              ),
            );
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              final addresses = snapshot.data;
              if (addresses.isNotEmpty) {
                return ListView(
                    children: addresses.map((address) {
                  return Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.navigation, color: Colors.grey),
                          onPressed: () async {
                            final addressById =
                                await provider.findById(address.placeId);

                            provider.launchCoordinates(
                                addressById.latitude, addressById.longitude);
                          }),
                      Expanded(
                        child: ListTile(
                          title: Text(address.description),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.grey),
                        onPressed: () async {
                          final addressById =
                              await provider.findById(address.placeId);
                          provider.routeAdd(context, addressById);
                          this.close(context, MainPage());
                        },
                      ),
                    ],
                  );
                }).toList());
              }
            }
            return CenteredMessage(
              "Endereço não encontrado",
              icon: Icons.warning,
            );
            break;
          case ConnectionState.none:
            break;
        }
        return CenteredMessage(
          "Erro Desconhecido",
          icon: Icons.warning,
        );
      },
    );
  }

  @override
  TextStyle get searchFieldStyle =>
      TextStyle(color: Colors.white, fontSize: 16);

  @override
  ThemeData appBarTheme(BuildContext context) =>
      Provider.of<ThemeChanger>(context).currentTheme;
}
