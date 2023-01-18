// ignore: file_names
import 'InfoCard.dart';
import 'package:customer_ledger/blocs/app_state.dart';
import 'package:customer_ledger/rep/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_ledger/blocs/app_blocs.dart';
import 'package:customer_ledger/blocs/app_events.dart';
// import 'package:customer_ledger/blocs/app_state.dart';
// import 'blocs/app_blocs.dart';

class DetailedWidget extends StatelessWidget {
  final id;
  const DetailedWidget(this.id, {super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => LoadData(),
      child: BlocProvider(
        create: (context) =>
            UserBloc(RepositoryProvider.of<LoadData>(context), id)
              ..add(LoaderUserEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Details"),
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserDetailsLoadingState) {
                return const CircularProgressIndicator();
              }
              if (state is UserDetailsLoadedState) {
                return InfoCard(
                  id,
                  state.users.name,
                  state.users.username,
                  state.users.email,
                  state.users.website,
                  state.users.address,
                  state.users.company,
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
