import 'package:flutter/material.dart';

import '../../../database/copyfrom DB.dart';
import '../ayat/ayat.dart';

class Sora extends StatelessWidget {
  const Sora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(
          child: Text("السور"),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: QuraanDB.retrieve(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  separatorBuilder: (context, i) => const Divider(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    var soraName = snapshot.data[i]["name"];
                    var soraPlace = snapshot.data[i]["place"];
                    var soraid = snapshot.data[i]["soraid"];
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Ayat(soraName,soraid)));
                        },
                        child: ListTile(
                          trailing: Text("${snapshot.data[i]["soraid"]}"),
                          title: Text(soraName),
                          subtitle: soraPlace == 1
                              ? const Text("مكية")
                              : const Text("مدنيه"),
                          leading: soraPlace == 1
                              ? Image.asset(
                                  "assets/images/kaba.png",
                                  height: 60,
                                  width: 60,
                                )
                              : Image.asset(
                                  "assets/images/medina.png",
                                  height: 60,
                                  width: 60,
                                ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
