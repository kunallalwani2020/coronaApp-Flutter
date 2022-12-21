import 'package:corona_app/services/state_services.dart';
import 'package:corona_app/view/screen_details.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateService stateService = StateService();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchingController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: stateService.countriesApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade600,
                                highlightColor: Colors.grey.shade600,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white,
                                      ),
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ));
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (searchingController.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScreenDetails(
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalRecoverd:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    totalActive: snapshot
                                                        .data![index]['active'],
                                                    totalCritical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    todayRecovery:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                  )));
                                    },
                                    child: ListTile(
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag']))),
                                  ),
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                    searchingController.text.toLowerCase()) ||
                                name.toUpperCase().contains(
                                    searchingController.text.toUpperCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScreenDetails(
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalRecoverd:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    totalActive: snapshot
                                                        .data![index]['active'],
                                                    totalCritical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    todayRecovery:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                  )));
                                    },
                                    child: ListTile(
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag']))),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }))
        ],
      )),
    );
  }
}
