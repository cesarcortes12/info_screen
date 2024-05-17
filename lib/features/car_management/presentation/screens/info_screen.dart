import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantalla_informativa/features/car_management/domain/domain.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/car_management/car_management_cubit.dart';
import 'package:pantalla_informativa/features/car_management/presentation/screens/workshop_list_screen.dart';

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

class InfoScreen extends StatefulWidget {
  String title = 'Info Screen';

  InfoScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

@override
class _InfoScreenState extends State<InfoScreen> {
  late CarManagementCubit carManagementCubit;

  void initState() {
    super.initState();
    carManagementCubit = BlocProvider.of<CarManagementCubit>(context);
    carManagementCubit.getOrderCars(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 4, 67, 160),
      ),
      body: BlocBuilder<CarManagementCubit, CarManagementState>(
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < 1035) {
              return (carManagementCubit.state.carsOrderService.isEmpty)
                  ? const CustomEmptyState(
                      message: 'No hay bodegas para mostrar')
                  : SingleChildScrollView(
                      child: Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        child: Column(
                          children: [
                            _CardInfo2Small(
                              carOrderService: carManagementCubit
                                  .state.carsOrderService.first,
                            ),
                            Expanded(
                                child: _CardInfoSmall(
                                    carManagementCubit: carManagementCubit)),
                          ],
                        ),
                      ),
                    );
            } else {
              return (carManagementCubit.state.carsOrderService.isEmpty)
                  ? const CustomEmptyState(
                      message: 'No hay bodegas para mostrar')
                  : Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child: _CardInfo(
                                carManagementCubit: carManagementCubit),
                          ),
                          Expanded(
                            flex: 4,
                            child: _CardInfo2(
                              carOrderService: carManagementCubit
                                  .state.carsOrderService.first,
                            ),
                          )
                        ],
                      ),
                    );
            }
          });
        },
      ),
    );
  }
}

class _CardInfo extends StatelessWidget {
  final carManagementCubit;

  const _CardInfo({
    required this.carManagementCubit,
    super.key,
  });
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
                itemCount: carManagementCubit.state.carsOrderService.length,
                itemBuilder: (context, index) {
                  CarOrderService info =
                      carManagementCubit.state.carsOrderService[index];
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: size.width * 0.09,
                                    height: size.height * 0.12,
                                    child: ListTile(
                                      contentPadding: EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      title: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                            'Placa \n ${info.licensePlate}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                //fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  Shadow(
                                                    offset: Offset(2.0, 2.0),
                                                    blurRadius: 4.0,
                                                    color: Color.fromARGB(
                                                        128, 0, 0, 0),
                                                  )
                                                ])),
                                      ),
                                    )),
                                Container(
                                  width: size.width * 0.25,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                          title: Text(info.modelo.toUpperCase(),
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
                                                  info.name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(height: 6),
                                                Text(
                                                    'Asignado a: ${info.assignedTo}',
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
                              status: info.status.toString(),
                              time: info.deliveryTime.toString(),
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
  final CarOrderService carOrderService;

  const _CardInfo2({
    required this.carOrderService,
    super.key,
  });
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
          SizedBox(height: 70),
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
                              'PLACA : ${carOrderService.licensePlate}',
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
                                  '${carOrderService.name}',
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
          ])
        ]));
  }
}

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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: constraints.maxHeight * 0.35,
              decoration: BoxDecoration(
                color: getColorForStatus(status),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    status,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: constraints.maxWidth * 0.12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: Container(
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Hora de entrega',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: constraints.maxHeight * 0.12,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        time,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: constraints.maxHeight * 0.20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 4.0,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _CardInfo2Small extends StatelessWidget {
  final CarOrderService carOrderService;

  const _CardInfo2Small({
    required this.carOrderService,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 1,
        //height: size.height * 1,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Proximo a Entregar',
              style: TextStyle(
                  fontSize: 33,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Stack(children: [
            AspectRatio(
              aspectRatio: 3 / 1,
              child: Container(
                //width: size.width * 1,
                //height: size.height * 0.3,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/vehiculo_frontal_derecha.jpg',
                      fit: BoxFit.cover,
                      // width: double.infinity,
                      //height: double.infinity,
                    )),
              ),
            ),
            Positioned(
              left: size.width * 0.1,
              top: size.height * 0.03,
              child: Container(
                width: size.width * 0.70,
                height: size.width * 0.20,
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'PLACA : ${carOrderService.licensePlate}',
                                  style: TextStyle(
                                      fontSize: constraints.maxWidth * 0.06,
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
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'PROPIETARIO',
                                  style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.05,
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
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '${carOrderService.name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: constraints.maxWidth * 0.06,
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
          ])
        ]));
  }
}

class _CardInfoSmall extends StatelessWidget {
  final carManagementCubit;

  const _CardInfoSmall({
    required this.carManagementCubit,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width * 1,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Su Vehiculo',
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 05),
        Expanded(
          child: ListView.builder(
            itemCount: carManagementCubit.state.carsOrderService.length,
            itemBuilder: (context, index) {
              CarOrderService info =
                  carManagementCubit.state.carsOrderService[index];
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    width: size.width * 0.4,
                    height: constraints.maxWidth * 0.18,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: constraints.maxWidth * 0.20,
                                  height: constraints.maxWidth * 0.25,
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'Placa \n ${info.licensePlate}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              constraints.maxWidth * 0.045,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(2.0, 2.0),
                                              blurRadius: 4.0,
                                              color:
                                                  Color.fromARGB(128, 0, 0, 0),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.38,
                                  height: constraints.maxWidth * 1,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          info.modelo.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                constraints.maxWidth * 0.04,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                offset: Offset(2.0, 2.0),
                                                blurRadius: 4.0,
                                                color: Color.fromARGB(
                                                    128, 0, 0, 0),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 2),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              info.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    constraints.maxWidth * 0.04,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'Asignado a: ${info.assignedTo}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    constraints.maxWidth * 0.04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            height: 140,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Expanded(
                              child: _StateCard(
                                status: info.status.toString(),
                                time: info.deliveryTime.toString(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
