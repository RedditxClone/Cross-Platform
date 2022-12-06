import 'package:flutter/material.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';

class TrafficStatsWidget extends StatefulWidget {
  String screen = '';

  TrafficStatsWidget({required this.screen, super.key});

  @override
  State<TrafficStatsWidget> createState() => _TrafficStatsWidgetState();
}

class _TrafficStatsWidgetState extends State<TrafficStatsWidget> {
  User otherUser = User(
    userId: '1',
    name: 'bemoi_erian',
    displayName: 'Bemoi_01  ',
    email: 'bemoi@hotmail.com',
    coverPic: '',
    profilePic: '',
  );
  Widget _buildTable() {
    return Container(
      height: 1000,
      width: MediaQuery.of(context).size.width - 320,
      color: defaultSecondaryColor,
    );
  }

  Widget _buildGraph() {
    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width - 320,
      color: defaultSecondaryColor,
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
                _buildGraph(),
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
