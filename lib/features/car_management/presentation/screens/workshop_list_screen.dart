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
    pickingCubit.getAutos();
  }

  @override
  Widget build(BuildContext context) {
    //final pickingCubit_ = context.watch<PickingCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'lista!!',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 4, 67, 160),
      ),
      body: BlocBuilder<CarManagementCubit, CarManagementState>(
        builder: (context, state) {
          return (state.autos.length != 0)
              ? Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: ListView.builder(
                    itemCount: state.autos.length,
                    itemBuilder: (BuildContext context, int index) {
                      Auto wareHause = state.autos[index];
                      //print('wareHause ${wareHause}');
                      return WarehauseCard(warehause: wareHause);
                    },
                  ),
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
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: const Color(0xFF003F5A),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            //width: 125,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'BODEGA',
                    )),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'HOLAA ${widget.warehause.name}',
                    maxLines: 3,
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CustomFilledButton(
                      text: 'Ingresar',
                      onPressed: () async {
                        //GoRouter.of(context).go('/');
                        Navigator.pushNamed(context, '/info');

                        //if (!loginCubit.state.isPosting) {
                        //loginFormCubit.onSumit();
                        //}
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
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
