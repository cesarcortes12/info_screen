import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/auto.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/car_management/car_management_cubit.dart';
import 'package:pantalla_informativa/features/widgets/custom_filled_button.dart';

class WorkshopListScreen extends StatefulWidget {
  const WorkshopListScreen({super.key});

  @override
  State<WorkshopListScreen> createState() => _WorkshopListScreenState();
}

class _WorkshopListScreenState extends State<WorkshopListScreen> {
  late CarManagementCubit pickingCubit;

  void initState() {
    super.initState();
    pickingCubit = BlocProvider.of<CarManagementCubit>(context);
    pickingCubit.getWorkShop();
  }

  @override
  Widget build(BuildContext context) {
    //final pickingCubit_ = context.watch<PickingCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Bodegas',
            style: TextStyle(color: Colors.white),
          ),
        ),
        //backgroundColor: Color.fromARGB(255, 4, 67, 160),
      ),
      body: BlocBuilder<CarManagementCubit, CarManagementState>(
        builder: (context, state) {
          return (state.autos.isNotEmpty)
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      width: 800,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: ListView.builder(
                        itemCount: state.autos.length,
                        itemBuilder: (BuildContext context, int index) {
                          Auto wareHause = state.autos[index];
                          //print('wareHause ${wareHause}');
                          return WarehauseCard(warehause: wareHause);
                        },
                      )),
                )
              : const CustomEmptyState(message: 'No hay bodegas para mostrar');
        },
      ),
    );
  }
}

class WarehauseCard extends StatefulWidget {
  final Auto warehause;

  const WarehauseCard({
    required this.warehause,
    super.key,
  });

  @override
  State<WarehauseCard> createState() => _WarehauseCardState();
}

class _WarehauseCardState extends State<WarehauseCard> {
  //late PickingCubit pickingCubit;
  @override
  void initState() {
    print('ENTRA en card initstate');
    //pickingCubit = BlocProvider.of<PickingCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth > 500
          ? Container(
              margin: EdgeInsets.all(10),
              //width: size.width * 0.4,
              height: 150,
              width: 80,
              decoration: BoxDecoration(
                //color: Color(0xFF0443A0),
                borderRadius: BorderRadius.circular(7),
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 216, 216, 216),
                  width: 1.0, // Ajusta el ancho del borde aquí
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image(
                            image: AssetImage('assets/images/img_workshop.jpg'),
                            width: 100,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 200,
                          height: 97,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.warehause.name,
                                  style: TextStyle(
                                    //color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(' ${widget.warehause.address}',
                                    style: TextStyle(
                                        //color: Colors.white
                                        )),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(' ${widget.warehause.city}',
                                    style: TextStyle(
                                        //color: Colors.white
                                        )),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(' ${widget.warehause.phone}',
                                    style: TextStyle(
                                        //color: Colors.white
                                        )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: CustomFilledButton(
                      text: Text('Ingresar'),
                      onPressed: () async {
                        //GoRouter.of(context).go('/');
                        Navigator.pushNamed(context, '/infoScreen');

                        //}
                      },
                    ),
                  ),
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.all(10),
              //width: size.width * 0.4,
              height: 200,
              width: 80,
              decoration: BoxDecoration(
                //color: Color(0xFF0443A0),
                borderRadius: BorderRadius.circular(7),
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 216, 216, 216),
                  width: 1.0, // Ajusta el ancho del borde aquí
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 148, 42, 42).withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image(
                            image: AssetImage('assets/images/img_workshop.jpg'),
                            width: 100,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.warehause.name,
                                style: TextStyle(
                                  //color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(' ${widget.warehause.address}',
                                  style: TextStyle(
                                      //color: Colors.white
                                      )),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(' ${widget.warehause.city}',
                                  style: TextStyle(
                                      //color: Colors.white
                                      )),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(' ${widget.warehause.phone}',
                                  style: TextStyle(
                                      //color: Colors.white
                                      )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: CustomFilledButton(
                                text: Text('Ingresar'),
                                onPressed: () async {
                                  //GoRouter.of(context).go('/');
                                  Navigator.pushNamed(context, '/info');

                                  //}
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
    });
  }
}

class CustomEmptyState extends StatelessWidget {
  final String message;

  const CustomEmptyState({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline,
              size: 50,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(color: Colors.grey, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String message;
  final String svgPicture;

  const _TabButton({Key? key, required this.message, required this.svgPicture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Column(
        children: [
          SvgPicture.asset(
            svgPicture,
            width: 26,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
