import 'package:contact_list/screens/home_page/home_page_controller.dart';
import 'package:contact_list/models/contact_model.dart';
import 'package:contact_list/screens/edit_contact/editing_contact.dart';
import 'package:contact_list/screens/home_page/widgets/show_dailog.dart';
import 'package:contact_list/screens/new_contatact/new_contact_controller.dart';
import 'package:contact_list/screens/index_page.dart';
import 'package:flutter/material.dart';
import '../../controller/data/share_prefs.dart';
import '../new_contatact/new_contact.dart';
import 'widgets/list_isempty.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Homecontroller();
  final _newController = NewContactController();

  @override
  void initState() {
    super.initState();
    _controller.drop.addListener(() {
      setState(() {});
    });
    _controller.listselect.addListener(() {
      setState(() {});
    });
    _controller.getcontacts(key: keylist);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder<List<ContactModel>>(
                    valueListenable: _controller,
                    builder: (context, data, child) {
                      return data.isEmpty
                          ? const ListIsempt()
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                 if (data.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                return ListTile(
                                  leading: data[index].image.length == 2
                                      ? CircleAvatar(
                                          radius: 30,
                                          child: Text(
                                              data[index].image.toString()))
                                      : CircleAvatar(
                                          radius: 30,
                                          backgroundImage: MemoryImage(
                                              _newController.convert64ToInmage(
                                                  data[index].image)),
                                        ),
                                  title: Text(
                                    data[index].name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: height * 0.022,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${data[index].number}\n${data[index].email}',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: height * 0.022,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  visualDensity:
                                      VisualDensity.adaptivePlatformDensity,
                                  dense: true,
                                  focusColor: Colors.black,
                                  trailing: GestureDetector(
                                    onTap: () async {
                                      bool shouldDelete =
                                          await ShowDailog().showdailogg(
                                        context: context,
                                        contact: data[index].name,
                                        page: MaterialPageRoute(
                                          builder: (context) => EditingContact(
                                            index: index,
                                            image: data[index].image,
                                            name: data[index].name,
                                            number: data[index].number,
                                            email: data[index].email,
                                          ),
                                        ),
                                      );
                                      if (shouldDelete) {
                                        _controller.deletcontatc(key: keylist, index: index,);
                                      }
                                      // Atualizar a lista após a edição do contato
                                      _controller.getcontacts(key: keylist);
                                    },
                                    child: const Icon(Icons.settings),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
       floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16.0,
            left: 50.0,
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IndexPage(),
                  ),
                );
              },
              child: const Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewContact(),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

    );
  }
}
