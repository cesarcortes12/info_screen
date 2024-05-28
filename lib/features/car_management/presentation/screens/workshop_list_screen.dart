import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/warehouse.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/car_management/car_management_cubit.dart';
//import 'package:pantalla_informativa/features/car_management/presentation/presentation.dart';
import 'package:pantalla_informativa/features/widgets/custom_filled_button.dart';

class WorkshopListScreen extends StatefulWidget {
  const WorkshopListScreen({super.key});

  @override
  State<WorkshopListScreen> createState() => _WorkshopListScreenState();
}

class _WorkshopListScreenState extends State<WorkshopListScreen> {
  late CarManagementCubit carManagementCubit;
  late AuthCubit authCubit;

  void initState() {
    super.initState();
    carManagementCubit = BlocProvider.of<CarManagementCubit>(context);
    carManagementCubit.getWarehouses(false);
    authCubit = BlocProvider.of<AuthCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authCubit.logout();
              GoRouter.of(context).push('/');
            },
          ),
        ],
        title: Center(
          child: Text(
            'BODEGAS',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: BlocBuilder<CarManagementCubit, CarManagementState>(
        builder: (context, state) {
          return (carManagementCubit.state.loaded == LoadingStatus.checking)
              ? const CircularProgressIndicator(strokeWidth: 4)
              : SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: 800,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: (carManagementCubit.state.allWarehouses.isEmpty)
                            ? const CustomEmptyState(
                                message: 'No hay bodegas para mostrar')
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.allWarehouses.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Warehouse wareHouse =
                                      state.allWarehouses[index];
                                  return WarehouseCard(warehouse: wareHouse);
                                },
                              )),
                  ),
                );
        },
      ),
    );
  }
}

class WarehouseCard extends StatefulWidget {
  final Warehouse warehouse;

  const WarehouseCard({
    required this.warehouse,
    super.key,
  });

  @override
  State<WarehouseCard> createState() => _WarehouseCardState();
}

class _WarehouseCardState extends State<WarehouseCard> {
  late CarManagementCubit carManagementCubit;
  @override
  void initState() {
    print('ENTRA en card initstate');
    carManagementCubit = BlocProvider.of<CarManagementCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth > 770
          ? Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 216, 216, 216),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.warehouse.name,
                          style: TextStyle(
                            //color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text(' ${widget.warehouse.name}',
                        //   style: TextStyle(
                        //color: Colors.white
                        //    )),
                        Text(' ${widget.warehouse.city}',
                            style: TextStyle(
                                //color: Colors.white
                                )),
                        Text(' ${widget.warehouse.phone}',
                            style: TextStyle(
                                //color: Colors.white
                                )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: CustomFilledButton(
                      text: Text('Ingresar'),
                      onPressed: () async {
                        await carManagementCubit
                            .saveWarehouse(widget.warehouse);
                        GoRouter.of(context)
                            .push('/info/${widget.warehouse.id}');
                      },
                    ),
                  ),
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 216, 216, 216),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.warehouse.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    ' ${widget.warehouse.address}',
                  ),
                  const SizedBox(height: 5),
                  Text(
                    ' ${widget.warehouse.city}',
                  ),
                  const SizedBox(height: 5),
                  Text(
                    ' ${widget.warehouse.phone}',
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
