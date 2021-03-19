import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:happy_postcode_flutter/components/app_theme.dart';
import 'package:happy_postcode_flutter/components/centered_message.dart';
import 'package:happy_postcode_flutter/components/navigate_button.dart';
import 'package:happy_postcode_flutter/components/time_line_route_list.dart';
import 'package:happy_postcode_flutter/providers/address_provider.dart';
import 'package:happy_postcode_flutter/routes/routes.dart';
import 'package:happy_postcode_flutter/search/search_delegate.dart';
import 'package:provider/provider.dart';

import 'mapa_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, provider, child) => MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            drawer: _MenuPrincipal(),
            appBar: AppBar(
              backgroundColor: AppTheme.buildTheme().appBarTheme.color,
              bottom: TabBar(
                tabs: [
                  Tab(text: "LISTA"),
                  Tab(text: "MAPA"),
                  Tab(text: "RESUMO"),
                ],
              ),
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text("Flex Box"),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(context: context, delegate: DataSearch());
                      })
                ],
              ),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      TimeLineRouteList(),
                      MapaPage(),
                      Container(
                        child: CenteredMessage(
                          'Em Construção',
                          icon: Icons.construction,
                        ),
                      ),
                    ],
                  ),
                ),
                provider.totalInRoute > 0 ? NavigateButton() : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.accentColor;

    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[

            SafeArea(
              child: Container(
                width: double.infinity,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: accentColor,
                  child: Text('FH', style: TextStyle( fontSize: 50),),
                ),
              ),
            ),


            Expanded(
                child: _ListaOpciones()
            ),


            ListTile(
              leading: Icon( Icons.lightbulb_outline, color: accentColor ),
              title: Text('Dark Mode'),
              trailing: Switch.adaptive(
                  value: appTheme.darkTheme ,
                  activeColor: accentColor,
                  onChanged: ( value ) => appTheme.darkTheme = value
              ),
            ),


            SafeArea(
              bottom: true,
              top: false,
              left: false,
              right: false,
              child: ListTile(
                leading: Icon( Icons.add_to_home_screen, color: accentColor ),
                title: Text('Custom Theme'),
                trailing: Switch.adaptive(
                    value: appTheme.customTheme,
                    activeColor: accentColor,
                    onChanged: ( value ) => appTheme.customTheme = value
                ),
              ),
            ),


          ],
        ),

      ),
    );
  }
}

class _ListaOpciones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: ( context, i) => Divider(
        color: appTheme.primaryColorLight,
      ),
      itemCount: pageRoutes.length,
      itemBuilder: (context, i) => ListTile(

        leading: FaIcon( pageRoutes[i].icon , color: appTheme.accentColor ),
        title: Text( pageRoutes[i].titulo ),
        trailing: Icon( Icons.chevron_right, color: appTheme.accentColor ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> pageRoutes[i].page ));
        },

      ),
    );
  }
}
