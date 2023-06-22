import 'package:covid_tracker_app/models/WorldStatesModel.dart';
import 'package:covid_tracker_app/services/states_services.dart';
import 'package:covid_tracker_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  StatesServices statesServices = StatesServices();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  final colorList = const <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    apiCall()async{
      var information= await statesServices.fetchWorldStatesRecord();
    }
    apiCall();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),

                FutureBuilder(
                    future: statesServices.fetchWorldStatesRecord(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot){

                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              controller: _controller,
                            )
                        );
                      }
                      if(snapshot.hasData){
                        print('data is available');
                        print(snapshot.data);
                        // return const Center(child: Text('Data found!'),);
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(snapshot.data!['cases']!.toString()),
                                "Recovered": double.parse(snapshot.data!['recovered'].toString()),
                                "Deaths": double.parse(snapshot.data!['deaths'].toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true
                              ),
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              legendOptions:
                              const LegendOptions(legendPosition: LegendPosition.left),
                              animationDuration: const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReUsableRow(title: 'Total', value:snapshot.data!['cases'].toString()),
                                    ReUsableRow(title: 'Deaths', value: snapshot.data!['deaths'].toString()),
                                    ReUsableRow(title: 'Recovered', value: snapshot.data!['recovered'].toString()),
                                    ReUsableRow(title: 'Active', value: snapshot.data!['active'].toString()),
                                    ReUsableRow(title: 'Critical', value: snapshot.data!['critical'].toString()),
                                    ReUsableRow(title: 'Today Deaths', value: snapshot.data!['todayDeaths'].toString()),
                                    ReUsableRow(title: 'Today Recovered', value: snapshot.data!['todayRecovered'].toString()),
                                    ReUsableRow(title: 'Today Cases', value: snapshot.data!['todayCases'].toString()),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const CountriesList()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 50),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: const Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Center(
                                  child: Text('Track Countries', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),),
                                ),
                              ),
                            )
                          ],
                        );





                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(snapshot.data!.cases!.toString()),
                                "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true
                              ),
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              legendOptions:
                              const LegendOptions(legendPosition: LegendPosition.left),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReUsableRow(title: 'Total', value:snapshot.data!.cases.toString()),
                                    ReUsableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                    ReUsableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                    ReUsableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                    ReUsableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                    ReUsableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                    ReUsableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                    ReUsableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesList()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Text('Track Countries', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                      else{
                        print(snapshot);
                        return const Column(
                          children:
                         [
                           SizedBox(height:50,),
                           Text('NetWork Error! Please Check your internet Connection or Restart the app.',
                            style: TextStyle(color: Colors.white),),
                         ]
                        );
                      }
                    })

              ],
            ),
          ),
        ),
      ),
    );
  }
}



class ReUsableRow extends StatelessWidget {
  String title, value;
  ReUsableRow({Key? key, required this.title, required this.value}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}



