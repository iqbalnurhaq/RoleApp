import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roleapp/data/models/role_model.dart';
import 'package:roleapp/presentation/provider/home_notifier.dart';
import 'package:roleapp/presentation/widgets/input/input_text_field.dart';
import 'package:roleapp/shared/state_enum.dart';
import 'package:roleapp/shared/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode addRoleFocus = FocusNode();
  final TextEditingController addRoleController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<HomeNotifier>(context, listen: false)..fetchAllRole());
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeNotifier>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Role App'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InputTextField(
                            title: 'Role Name',
                            textController: addRoleController,
                            focusNode: addRoleFocus,
                            icon: 'assets/icon/ic_add.svg',
                          ),
                          Container(
                            width: double.infinity,
                            height: 55,
                            margin: EdgeInsets.only(top: 24),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: kGreenColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () async {
                                var body = {
                                  "role_name": addRoleController.text,
                                  "is_admin": false,
                                  "is_superadmin": false
                                };
                                await provider.postAddRole(body);
                                if (provider.getAddRole) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: kGreenColor,
                                      content: Text(
                                        "Add Role Successfully",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: kRedColor,
                                      content: Text(
                                        provider.addRoleMessage,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child:
                                  provider.addRoleState == RequestState.Loading
                                      ? CircularProgressIndicator(
                                          color: kWhiteColor,
                                        )
                                      : Text(
                                          'Add',
                                          style: whiteTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: medium,
                                          ),
                                        ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
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
                  } else {
                    return Text(value.getAllRoleMessage);
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

  final FocusNode editRoleFocus = FocusNode();
  final TextEditingController editRoleController =
      TextEditingController(text: '');

  RoleList(this.roles);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeNotifier>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final role = roles[index];
            return Container(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                  onTap: () {},
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
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/img_popular_default.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 16),
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
                                  GestureDetector(
                                    onTap: () async {
                                      editRoleController.text = role.roleName;
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 30,
                                                      horizontal: 16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  InputTextField(
                                                    title: 'Role Name',
                                                    textController:
                                                        editRoleController,
                                                    focusNode: editRoleFocus,
                                                    icon:
                                                        'assets/icon/ic_add.svg',
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 55,
                                                    margin: EdgeInsets.only(
                                                        top: 24),
                                                    child: TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            kGreenColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        var body = {
                                                          "role_name":
                                                              editRoleController
                                                                  .text,
                                                          "is_admin": false,
                                                          "is_superadmin": false
                                                        };
                                                        await provider
                                                            .putEditRole(
                                                                body, role.id);
                                                        if (provider
                                                            .getEditRole) {
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              backgroundColor:
                                                                  kGreenColor,
                                                              content: Text(
                                                                "Edit Role Successfully",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          Navigator.pop(
                                                              context);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              backgroundColor:
                                                                  kRedColor,
                                                              content: Text(
                                                                provider
                                                                    .addRoleMessage,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: provider
                                                                  .addRoleState ==
                                                              RequestState
                                                                  .Loading
                                                          ? CircularProgressIndicator(
                                                              color:
                                                                  kWhiteColor,
                                                            )
                                                          : Text(
                                                              'Edit',
                                                              style:
                                                                  whiteTextStyle
                                                                      .copyWith(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    medium,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Icon(Icons.edit),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await provider.patchDeleteRole(role.id);
                                      if (provider.getDeleteRole) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: kGreenColor,
                                            content: Text(
                                              "Delete Role Successfully",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: kRedColor,
                                            content: Text(
                                              provider.deleteRoleMessage,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: kRedColor,
                                    ),
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
          padding: EdgeInsets.only(bottom: 120),
          itemCount: roles.length,
        ),
      ),
    );
  }
}
