// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../database/copyfrom DB.dart';
import 'package:arabic_numbers/arabic_numbers.dart';

// ignore: must_be_immutable
class Ayat extends StatelessWidget {
  String soraname;
  var sora_id;
  Ayat(this.soraname, this.sora_id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Center(
            child: Text(soraname),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  "assets/images/quran_frame2.png",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 80),
                child: FutureBuilder(
                  future: QuraanDB.retrieveAyat(sora_id),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: RichText(
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            children: compineAyat(snapshot.data),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  compineAyat(ayat) {
    Map numbers = {
      '0': '۰',
      '1': '۱',
      '2': '۲',
      '3': '۳',
      '4': '٤',
      '5': '۵',
      '6': '٦',
      '7': '۷',
      '8': '۸',
      '9': '۹'
    };
    List<InlineSpan> widget = [];

    for (Map aya in ayat) {
      var numbers = convertToArabicNumber(aya["ayaid"].toString());
      if(aya["text"] == "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ"){
        widget.add(TextSpan(
                text: "${aya["text"]}",
          style: TextStyle(fontWeight: FontWeight.bold)
            ),);
        if (aya["page"] == 1){
          widget.add(WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/AyaNumber.png"),
                  child: Text("${numbers[0]}"),
                ),
              )
          ));
          widget.add(TextSpan(
            text: "\n",
          ),);
        }else{
          widget.add(TextSpan(
            text: "\n",
          ),);
        }
        continue;
      }
      widget.add(
          TextSpan(text: aya["text"],recognizer: TapGestureRecognizer()..onTap = (){
            print(aya["text"]);
          })
      );
      widget.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/AyaNumber.png"),
              child: Text("${numbers[0]}"),
            ),
          )));
    }

    return widget;
  }

  // arabic numbers function
  List <String> convertToArabicNumber(String number) {
    String num ='';
    List<String> res = ['',''];

    final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    number.characters.forEach((element) {
      num += arabics[int.parse(element)];
      //res += arabics[int.parse(element)];
    });
    res[0]=num;
    res[1]=number;
/*   final latins = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']; */
    return res;
  }
}
