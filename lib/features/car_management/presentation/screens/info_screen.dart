import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

List<Map<String, String>> infoList = [
  {
    'placa': 'ABC123',
    'nombre': 'Cesar Augusto Cortes zapata',
    'asignado_a': 'Juan Pérez López',
    'hora_entrega': '10:00 AM',
    'estado': 'En orden De taller'
  },
  {
    'placa': 'DEF456',
    'nombre': 'Jane Smith Johnson',
    'asignado_a': 'María García Pérez',
    'hora_entrega': '11:30 AM',
    'estado': 'En Ejecucion'
  },
  {
    'placa': 'GHI789',
    'nombre': 'Alice Wilson Rodríguez',
    'asignado_a': 'Pedro Rodríguez González',
    'hora_entrega': '1:00 PM',
    'estado': 'Pausado'
  },
  {
    'placa': 'JKL012',
    'nombre': 'Bob Brown Martínez',
    'asignado_a': 'Luis Martínez Martínez',
    'hora_entrega': '2:30 PM',
    'estado': 'facturado'
  },
  {
    'placa': 'MNO345',
    'nombre': 'Emily García López',
    'asignado_a': 'Carlos López García',
    'hora_entrega': '4:00 PM',
    'estado': 'listo para entrega'
  },
];

/*
en orden de taller
en ejecucion
pausado
finalizado
facturado
listo para entrega
entregado
 */

Color getColorForStatus(String state) {
  switch (state.toLowerCase()) {
    case 'en orden de taller':
      return Color.fromARGB(255, 161, 170, 221);

    case 'en ejecucion':
      return Color.fromARGB(205, 253, 186, 0);

    case 'pausado':
      return const Color.fromARGB(255, 243, 81, 81);

    case 'en revision':
      return Color.fromARGB(255, 77, 242, 236);

    case 'facturado':
      return Color.fromARGB(255, 243, 255, 5);

    case 'listo para entrega':
      return Color.fromARGB(255, 79, 215, 0);

    case 'entregado':
      return Colors.grey;

    default:
      return Colors.grey;
  }
}

class InfoScreen extends StatelessWidget {
  String title = 'Info Screen';

  InfoScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 4, 67, 160),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 1035) {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Column(
              children: [
                Expanded(child: _CardInfo2()),
                Expanded(child: _CardInfo()),
              ],
            ),
          );
        } else {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: _CardInfo(),
                ),
                Expanded(
                  flex: 4,
                  child: _CardInfo2(),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}

class _CardInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(30),
      width: size.width * 0.4,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Su Vehiculo',
            style: TextStyle(
                fontSize: 40,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Expanded(
            child: ListView.builder(
                itemCount: infoList.length,
                itemBuilder: (context, index) {
                  final info = infoList[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Color(0xFF0443A0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            //margin: EdgeInsets.only(right: 103),
                            //width: size.width * 0.10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                    title: Text('Placa : ${info['placa']}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 4.0,
                                                color: Color.fromARGB(
                                                    128, 0, 0, 0),
                                              )
                                            ])),
                                    subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 6),
                                          Text(
                                            'Nombre: ${info['nombre']}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                              'Asignado a: ${info['asignado_a']}',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          // SizedBox(height: 6),
                                          // Text(
                                          //     'Hora Entrega: ${info['hora_entrega']}',
                                          //     style: TextStyle(
                                          //         color: Colors.white)),
                                        ])),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: 116,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _StateCard(
                              status: info['estado'].toString(),
                              time: info['hora_entrega'].toString(),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }))
      ]),
    );
  }
}

class _CardInfo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.all(30),
        width: size.width > 1035 ? size.width * 0.6 : size.width,
        height: size.height * 1.0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Proximo a Entregar',
              style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 26),
          Stack(children: [
            Container(
              width: size.width > 1035 ? size.width * 1 : size.width * 1,
              height: size.height * 0.65,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/vehiculo_frontal_derecha.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              left: size.width * 0.045,
              top: size.height * 0.20,
              child: Container(
                width: size.width * 0.28,
                height: size.width * 0.18,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'PLACA : ${infoList[0]['placa'] ?? ''}',
                              style: TextStyle(
                                  fontSize: constraints.maxWidth * 0.1,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 4.0,
                                      color: Color.fromARGB(128, 0, 0, 0),
                                    )
                                  ]),
                            ),
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 10),
                            //   child: Text(
                            //     infoList[0]['placa'] ?? '',
                            //     style: TextStyle(
                            //       fontSize: constraints.maxWidth *
                            //           0.10, // Ajuste dinámico del tamaño del texto
                            //       fontWeight: FontWeight.bold,
                            //       color: Color.fromARGB(255, 4, 67, 160),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'PROPIETARIO',
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 4.0,
                                        color: Color.fromARGB(128, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Expanded(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '${infoList[0]['nombre']}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.08,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 4.0,
                                        color: Color.fromARGB(128, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   right: size.width * 0.02,
            //   top: size.height * 0.15,
            //   child: Container(
            //     width: size.width * 0.25,
            //     height: size.width * 0.15,
            //     decoration: BoxDecoration(
            //       color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
            //       borderRadius: BorderRadius.circular(10),
            //       boxShadow: [
            //         BoxShadow(
            //           color:
            //               const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            //           spreadRadius: 3,
            //           blurRadius: 5,
            //           offset: Offset(0, 3),
            //         ),
            //       ],
            //     ),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(10),
            //       child: BackdropFilter(
            //         filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            //         child: LayoutBuilder(
            //           builder: (context, constraints) {
            //             return Column(
            //               //mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Container(
            //                   margin: EdgeInsets.symmetric(horizontal: 10),
            //                   child: FittedBox(
            //                     fit: BoxFit.scaleDown,
            //                     child: Text(
            //                       'PROPIETARIO',
            //                       style: TextStyle(
            //                         fontSize: 50,
            //                         fontWeight: FontWeight.bold,
            //                         color: Color(0xFF000000),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Container(
            //                   margin: EdgeInsets.symmetric(horizontal: 10),
            //                   child: Text(
            //                     '${infoList[0]['nombre']}',
            //                     maxLines: 2,
            //                     overflow: TextOverflow.ellipsis,
            //                     style: TextStyle(
            //                       fontSize: constraints.maxWidth * 0.13,
            //                       fontWeight: FontWeight.bold,
            //                       color: Color.fromARGB(255, 4, 67, 160),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             );
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ])
        ]));
  }
}
//'${infoList[0]['nombre']}',

class _StateCard extends StatelessWidget {
  final String status;
  final String time;
  //final Map<String, String> info;

  const _StateCard({
    required this.status,
    Key? key,
    required this.time,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: getColorForStatus(status),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: Container(
            child: Column(
              children: [
                Text(
                  'Hora de entrega',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )
                      ]),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
