import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/presentation/provider/home_notifier.dart';
import 'package:roleapp/shared/state_enum.dart';
import 'package:roleapp/shared/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<HomeNotifier>(context, listen: false)..fetchAllRole());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Role App'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<HomeNotifier>(
                builder: (context, value, child) {
                  final state = value.getAllRoleState;
                  if (state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return RoleList(value.allRole);
                    // return HomePopularCard();
                  } else {
                    return Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleList extends StatelessWidget {
  final List<RoleModel> roles;

  RoleList(this.roles);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final role = roles[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
                onTap: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   MovieDetailPage.ROUTE_NAME,
                  //   arguments: movie.id,
                  // );
                },
                child: Container(
                  width: 230,
                  height: 243,
                  margin: EdgeInsets.only(right: 24),
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 7,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 120,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              role.roleName,
                              style: blackTextStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.delete,
                                  color: kRedColor,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        },
        itemCount: roles.length,
      ),
    );
  }
}
