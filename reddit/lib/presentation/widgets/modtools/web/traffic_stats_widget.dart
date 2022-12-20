import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';

class TrafficStatsWidget extends StatefulWidget {
  String screen = '';
  final String subredditId;

  TrafficStatsWidget(
      {required this.screen, required this.subredditId, super.key});

  @override
  State<TrafficStatsWidget> createState() => _TrafficStatsWidgetState();
}

class _TrafficStatsWidgetState extends State<TrafficStatsWidget> {
  @override
  void initState() {
    BlocProvider.of<ModtoolsCubit>(context)
        .getStatistics('639b27bbef88b3df0463d04b');
    super.initState();
  }

  Widget _buildTable() {
    return Container(
      height: 1000,
      width: MediaQuery.of(context).size.width - 320,
      color: defaultSecondaryColor,
    );
  }

  SideTitles get _bottomTitles {
    return SideTitles(
      reservedSize: 20,
      interval: 1,
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = '';
        switch (value.toInt()) {
          case 0:
            text = 'Jan';
            break;
          case 1:
            text = 'Feb';
            break;
          case 2:
            text = 'Mar';
            break;
          case 3:
            text = 'April';
            break;
          case 4:
            text = 'May';
            break;
          case 5:
            text = 'Jun';
            break;
          case 6:
            text = 'Jul';
            break;
          case 7:
            text = 'Aug';
            break;
          case 8:
            text = 'Sep';
            break;
          case 9:
            text = 'Oct';
            break;
          case 10:
            text = 'Nov';
            break;
          case 11:
            text = 'Dec';
            break;
        }

        return Text(text);
      },
    );
  }

  Widget _graph() {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width - 450,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 30, 30, 8),
        child: LineChart(LineChartData(
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(sideTitles: _bottomTitles),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                      interval: 1, reservedSize: 30, showTitles: true)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            maxX: 11,
            maxY: 11,
            minX: 0,
            minY: 0,
            lineBarsData: [
              LineChartBarData(spots: [
                const FlSpot(0, 0),
                const FlSpot(5, 5),
                const FlSpot(7, 2),
                const FlSpot(8, 7),
                const FlSpot(11, 0),
              ]),
              LineChartBarData(color: Colors.yellow, spots: [
                const FlSpot(0, 0),
                const FlSpot(3, 0),
                const FlSpot(4, 3),
                const FlSpot(8, 9),
                const FlSpot(11, 0),
              ]),
            ])),
      ),
    );
  }

  Widget _colorItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          color: color,
        ),
        Text('    $text')
      ],
    );
  }

  Widget _colorCode() {
    return Container(
        padding: const EdgeInsets.only(top: 50),
        width: 130,
        height: 150,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _colorItem(Colors.blue, 'New Reddit'),
          _colorItem(Colors.orange, 'Old Reddit'),
          _colorItem(Colors.red, 'Mobile Web'),
          _colorItem(Colors.cyanAccent, 'Reddit Apps'),
        ]));
  }

  Widget _rowItem(int number, int total) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      width: MediaQuery.of(context).size.width - 1130,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number.toString(),
            style: const TextStyle(fontSize: 30),
          ),
          Text(
            'TOTAL - LAST ${number.toString()} HOURS',
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildUpperGraph() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _rowItem(23, 13),
        _rowItem(315, 3),
        _rowItem(24, 21),
      ],
    ));
  }

  Widget _buildGraph() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_graph(), _colorCode()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.screen} ',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 600,
                  width: MediaQuery.of(context).size.width - 320,
                  color: defaultSecondaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildUpperGraph(),
                      _buildGraph(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
