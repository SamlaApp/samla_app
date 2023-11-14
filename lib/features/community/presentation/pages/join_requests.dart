import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/core/widgets/image_viewer.dart';
import 'package:samla_app/features/community/data/models/RequestToJoin.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/presentation/cubits/RequestsManager/requests_cubit.dart';

class JoinRequestsPage extends StatelessWidget {
  const JoinRequestsPage(
      {super.key, required this.community, required this.joinRequestsCubit});
  final Community community;
  final RequestsCubit joinRequestsCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Requests'),
      ),
      body: BlocBuilder<RequestsCubit, RequestsState>(
        bloc: joinRequestsCubit,
        builder: (context, state) {
          if (state is RequestsCubitsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RequestsCubitsLoaded &&
              state.requests.isNotEmpty) {
            return _buildJoinRequestsList(state.requests);
          }
          return Center(
            child: Text('No Pending Join Requests'),
          );
        },
      ),
    );
  }

  Widget _buildJoinRequestsList(List<RequestToJoin> requests) {
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            leading: ImageViewer.network(
              imageURL: requests[index].user.photoUrl,
              placeholderImagePath: 'images/defaults/user.png',
              viewerMode: false,
            ),
            title: Text(requests[index].user.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    joinRequestsCubit.acceptRequest(requests[index]);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    joinRequestsCubit.rejectRequest(requests[index]);
                  },
                ),
              ],
            ));
      },
    );
  }
}
