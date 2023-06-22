import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  String country, flag, cases, deaths, recovered, active,tests, critical;
   DetailScreen({Key? key,
     required this.country,
     required this.flag,
     required this.cases,
     required this.deaths,
     required this.recovered,
     required this.active,
     required this.tests,
     required this.critical

   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(country, style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),),
              const SizedBox(height: 30,),
              Image(image: NetworkImage(flag)),
              const SizedBox(height: 30,),
              CustomRow(name: 'Total Cases :', value: cases),
              CustomRow(name: 'Deaths :', value: deaths),
              CustomRow(name: 'Recovered :', value: recovered),
              CustomRow(name: 'Tests :', value: tests),
              CustomRow(name: 'Active :', value: active),
              CustomRow(name: 'Critical :', value: critical)
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  String name, value;
   CustomRow({Key? key, required this.name, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),),
              Text(value, style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ))
            ],
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}

