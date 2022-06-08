import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geziapp/models/icerikdeneme.dart';
import 'package:geziapp/utils/database_helper.dart';

class IcerikDetay extends StatefulWidget {
  final String? baslik;
  // ignore: use_key_in_widget_constructors
  const IcerikDetay({this.baslik});

  @override
  State<IcerikDetay> createState() => _IcerikDetayState();
}

class _IcerikDetayState extends State<IcerikDetay> {
  //islemler
  // ignore: non_constant_identifier_names
  final List<IcerikDeneme> _IcerikDetayListesi =
      List<IcerikDeneme>.empty(growable: true);
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  //puanlama
  double? ratingBarValue;
  @override
  void initState() {
    super.initState();
    IcerikDetayAl();
  }

  // ignore: non_constant_identifier_names
  IcerikDetayAl() async {
    var icerikler =
        await _databaseHelper.readIcerikDetayBuIcerik(widget.baslik);
    icerikler.forEach((icerikdetay) {
      setState(() {
        var model = IcerikDeneme();
        model.icerikID = icerikdetay['icerikID'];
        model.kategoriAd = icerikdetay['kategoriAd'];
        model.DegerlendirmeID = icerikdetay['DegerlendirmeID'];
        model.icerikFotograf = icerikdetay['icerikFotograf'];
        model.icerikBilgi = icerikdetay['icerikBilgi'];
        model.icerikUcret = icerikdetay['icerikUcret'];
        model.icerikSaat = icerikdetay['icerikSaat'];
        model.icerikBaslik = icerikdetay['icerikBaslik'];

        _IcerikDetayListesi.add(model);
      });
    });
  }

  //islemler
  @override
  Widget build(BuildContext context) {
    String? tl = ' TL';
    return Scaffold(
        appBar: AppBar(title: Text(widget.baslik!)),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _IcerikDetayListesi.length,
                itemBuilder: (context, index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.arrow_drop_down_circle),
                          title: Text(_IcerikDetayListesi[index].icerikBaslik!),
                          subtitle: Text(
                            _IcerikDetayListesi[index].icerikSaat!,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                          trailing: Text(
                              _IcerikDetayListesi[index].icerikUcret! + tl),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _IcerikDetayListesi[index].icerikBilgi!,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Image.asset("assets/images/" +
                            _IcerikDetayListesi[index]
                                .icerikFotograf
                                .toString()),
                        //puanlama

                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                          child: RatingBar.builder(
                            onRatingUpdate: (newValue) =>
                                setState(() => ratingBarValue = newValue),
                            itemBuilder: (context, index) => Icon(
                              Icons.star_rounded,
                            ),
                            direction: Axis.horizontal,
                            initialRating: ratingBarValue ??= 3,
                            unratedColor: Color(0xFF9E9E9E),
                            itemCount: 5,
                            itemSize: 35,
                          ),
                        ),

                        //yorumlar
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 12, 12, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 8, 0),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEEEEEE),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.person,
                                              color: Color(0xFF4B39EF),
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                        Text('UserName'),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Overall',
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 4, 0),
                                              child: Text(
                                                '5',
                                              ),
                                            ),
                                            Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFF4B39EF),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Güzel.',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
