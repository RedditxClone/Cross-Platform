import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/modtools/taffic_stats_model.dart';

class TrafficStatsWidget extends StatefulWidget {
  String screen = '';
  final String subredditId;

  TrafficStatsWidget(
      {required this.screen, required this.subredditId, super.key});

  @override
  State<TrafficStatsWidget> createState() => _TrafficStatsWidgetState();
}

class _TrafficStatsWidgetState extends State<TrafficStatsWidget> {
  List<TrafficStats> trafficStats = [];
  List<FlSpot> joined = [];
  List<FlSpot> left = [];
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
            text = DateFormat.MMMMd()
                .format(DateTime.now().subtract(const Duration(days: 6)));
            break;
          case 1:
            text = DateFormat.MMMMd()
                .format(DateTime.now().subtract(const Duration(days: 5)));
            break;
          case 2:
            text = DateFormat.MMMMd()
                .format(DateTime.now().subtract(const Duration(days: 4)));
            break;
          case 3:
            text = DateFormat.MMMMd()
                .format(DateTime.now().subtract(const Duration(days: 3)));
            break;
          case 4:
            text = DateFormat.MMMMd()
                .format(DateTime.now().subtract(const Duration(days: 2)));
            break;
          case 5:
            text = DateFormat.MMMMd()
                .format(DateTime.now().subtract(const Duration(days: 1)));
            break;
          case 6:
            text = DateFormat.MMMMd().format(DateTime.now());
            break;
          // case 7:
          //   text = 'Aug';
          //   break;
          // case 8:
          //   text = 'Sep';
          //   break;
          // case 9:
          //   text = 'Oct';
          //   break;
          // case 10:
          //   text = 'Nov';
          //   break;
          // case 11:
          //   text = 'Dec';
          //   break;
        }

        return Text(text);
      },
    );
  }

  void _initPoints() {
    double index = 6;
    joined.add(const FlSpot(0, 0));
    trafficStats.forEach((element) {
      joined.add(FlSpot(index, element.joined as double));
      // print('joined point : ($index , ${element.joined as double})');
      index--;
    });
    index = 6;
    left.add(const FlSpot(0, 0));
    trafficStats.forEach((element) {
      left.add(FlSpot(index, element.left as double));
      // print('left point : ($index , ${element.left as double})');
      index--;
    });
  }

  Widget _graph() {
    _initPoints();
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
            maxX: 6,
            maxY: 6,
            minX: 0,
            minY: 0,
            lineBarsData: [
              LineChartBarData(color: Colors.blue, spots: joined),
              LineChartBarData(color: Colors.yellow, spots: left),
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
        height: 100,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _colorItem(Colors.blue, 'Joined'),
          _colorItem(Colors.orange, 'Left'),
          // _colorItem(Colors.red, 'Mobile Web'),
          // _colorItem(Colors.cyanAccent, 'Reddit Apps'),
        ]));
  }

  Widget _rowItem(String number, int total, String label) {
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
            'TOTAL - LAST $label',
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
        _rowItem('N/A', 13, '24 HOURS'),
        _rowItem('0', 3, '7 DAYS'),
        _rowItem('0', 21, 'MONTH'),
      ],
    ));
  }

  Widget _buildGraph() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _graph(),
        _colorCode(),
      ],
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
                BlocBuilder<ModtoolsCubit, ModtoolsState>(
                  builder: (context, state) {
                    if (state is TrafficStatsAvailable) {
                      trafficStats = state.tafficstats;
                      return Container(
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
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // _buildTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
