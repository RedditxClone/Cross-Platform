import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/business_logic/cubit/modtools/modtools_cubit.dart';
import 'package:reddit/constants/strings.dart';
import 'package:reddit/constants/theme_colors.dart';
import 'package:reddit/data/model/auth_model.dart';

class ApprovedUsersScreen extends StatefulWidget {
  const ApprovedUsersScreen({super.key});

  @override
  State<ApprovedUsersScreen> createState() => _ApprovedUsersScreenState();
}

class _ApprovedUsersScreenState extends State<ApprovedUsersScreen> {
  List<User>? approvedUsers;
  @override
  void initState() {
    BlocProvider.of<ModtoolsCubit>(context)
        .getApprovedUsers('639b27bbef88b3df0463d04b');
    super.initState();
  }

  Widget listviewItem(context, index) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      InkWell(
        onTap: () => Navigator.pushNamed(context, otherProfilePageRoute,
            arguments: approvedUsers![index].username),
        child: Row(children: [
          approvedUsers![index].profilePic == null ||
                  approvedUsers![index].profilePic == ''
              ? const CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person))
              : CircleAvatar(
                  radius: 17,
                  backgroundImage:
                      NetworkImage(approvedUsers![index].profilePic!)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('u/${approvedUsers![index].username}'),
              const Text(
                '2 mo ago',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ]),
      ),
      IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultSecondaryColor,
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Aproved Users'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, addApprovedRoute),
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<ModtoolsCubit, ModtoolsState>(
        builder: (context, state) {
          if (state is ApprovedListAvailable) {
            approvedUsers = state.approved;
            print(approvedUsers!.length);
            if (approvedUsers!.isEmpty) {
              // return emptyUserManagement(context);
            }
            return ListView.builder(
                itemCount: approvedUsers!.length,
                itemBuilder: (context, index) {
                  return listviewItem(context, index);
                });
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
