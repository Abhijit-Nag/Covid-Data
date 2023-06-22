import 'package:covid_tracker_app/services/states_services.dart';
import 'package:covid_tracker_app/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  StatesServices statesServices = StatesServices();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              child: TextField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: statesServices.countriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child:Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10, width: 89, color: Colors.white,),
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(height: 10, width: 89, color: Colors.white,),
                                    )
                                  ],
                                )
                              );
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name= snapshot.data![index]['country'];
                              if(searchController.text.isEmpty){
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                      country: name,
                                      active: snapshot.data![index]['active'].toString(),
                                      tests: snapshot.data![index]['tests'].toString(),
                                      cases: snapshot.data![index]['cases'].toString(),
                                      critical: snapshot.data![index]['critical'].toString(),
                                      deaths: snapshot.data![index]['deaths'].toString(),
                                      flag: snapshot.data![index]['countryInfo']['flag'].toString(),
                                      recovered: snapshot.data![index]['recovered'].toString(),
                                    )));
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title:
                                        Text(snapshot.data![index]['country']),
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                        ),
                                        subtitle: Text(snapshot.data![index]
                                        ['cases']
                                            .toString()),
                                      )
                                    ],
                                  ),
                                );
                              }
                              else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                      country: name,
                                      active: snapshot.data![index]['active'].toString(),
                                      tests: snapshot.data![index]['tests'].toString(),
                                      cases: snapshot.data![index]['cases'].toString(),
                                      critical: snapshot.data![index]['critical'].toString(),
                                      deaths: snapshot.data![index]['deaths'].toString(),
                                      flag: snapshot.data![index]['countryInfo']['flag'].toString(),
                                      recovered: snapshot.data![index]['recovered'].toString(),
                                    )));
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title:
                                        Text(snapshot.data![index]['country']),
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                        ),
                                        subtitle: Text(snapshot.data![index]
                                        ['cases']
                                            .toString()),
                                      )
                                    ],
                                  ),
                                );
                              }
                              else{
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height*1,
                                  child: const Center(
                                    child: Text('No such Country Found!'),
                                  ),
                                );
                              }

                            });
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
