import 'package:flutter/material.dart';
import 'package:untitled3/features/video_home/presentation/views/widgets/call_item.dart';

class CallsListview extends StatelessWidget {
  const CallsListview({super.key});

  @override
  Widget build(BuildContext context) {
     List<String> names = [
    'Shane Haq',
    'Gualtiero Cea',
    'Maria Zarco',
    'Rosita Marcos',
   'Shane Haq',
    'Gualtiero Cea',
    'Maria Zarco',
    'Rosita Marcos',
    'Shane Haq',
    'Gualtiero Cea',
    'Maria Zarco',
    'Rosita Marcos',
  ];
    return SizedBox(
       height: MediaQuery.of(context).size.height * ((names.length +1 )/10 ) ,
      child: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: names.length,
          itemBuilder: (context, index) {
            return   CallItem(
              name: names[index],
            ) ;
          },
        ),
      ),
    );
  }
}