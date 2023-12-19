import 'dart:typed_data';
import 'package:citame/Widgets/cuadro.dart';
import 'package:citame/Widgets/worker.dart';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/pages_4/pages_5/profile_inside.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/re_render_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuPage extends ConsumerWidget {
  MenuPage({
    super.key,
  });

  final TextEditingController servicio = TextEditingController();
  final TextEditingController precio = TextEditingController();
  final TextEditingController duracion = TextEditingController();
  final GlobalKey<FormState> validacion = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(reRenderProvider);
    //List<Servicio> listaDeServicios = ref.watch(serviceProvider);
    /*List<CajaDeServicios> servicios = listaDeServicios.map((servicio) => {
      return CajaDeServicios(/*aca van las props del widget que vamos a crear*/ );
    }).toList;*/
    ReRenderNotifier reRender = ref.read(reRenderProvider.notifier);
    List<Worker> workers =
        ref.watch(myBusinessStateProvider.notifier).obtenerWorkers();
    List<WorkerBox> trabajadores = workers
        .map((e) => WorkerBox(worker: e, ref: ref, imagen: e.imgPath[0]))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Color.fromRGBO(240, 240, 240, 1),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Text('Menu', style: API.estiloJ24negro)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.construction_sharp),
                    color: Colors.black,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                  )
                ],
              ),
              Text('Crea tu menú para que los clientes puedan darte su dinero',
                  style: API.estiloJ14gris),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: 01),
                    Expanded(
                        child: Text(
                      'Servicios',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'Precios',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Duracion',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: validacion,
                child: Row(
                  children: [],
                ),
              ),
              //servicios.isNotEmpty?ListView(children:servicios ):Text(''),
              ElevatedButton.icon(
                onPressed: () async {
                  await showDialog<void>(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            right: -40,
                            top: -40,
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                          Form(
                            key: validacion,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Cuadro(
                                      control: servicio, texto: 'servicio'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      Cuadro(control: precio, texto: 'precio'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Cuadro(
                                      control: duracion,
                                      texto: 'tiempo maximo de duracion'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    child: const Text('confirmar'),
                                    onPressed: () {
                                      if (validacion.currentState!.validate()) {
                                        validacion.currentState!.save();
                                        Navigator.pop(context);
                                        API.reRender(ref);
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.add),
                label: Text('Agregar servicio'),
              ),
              Text('Jornada de atención', style: API.estiloJ24negro),
              Text(
                'Días de atención general del negocio, dentro de cada perfíl de trabajador puedes escoger que días trabaja.',
                style: API.estiloJ14gris,
              ),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['lunes'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('lunes', value);
                    reRender.reRender();
                  },
                  title: Text('Lunes')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['martes'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('martes', value);
                    reRender.reRender();
                  },
                  title: Text('Martes')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['miercoles'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('miercoles', value);
                    reRender.reRender();
                  },
                  title: Text('Miércoles')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['jueves'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('jueves', value);
                    reRender.reRender();
                  },
                  title: Text('Jueves')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['viernes'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('viernes', value);
                    reRender.reRender();
                  },
                  title: Text('Viernes')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['sabado'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('sabado', value);
                    reRender.reRender();
                  },
                  title: Text('Sábado')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['domingo'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('domingo', value);
                    reRender.reRender();
                  },
                  title: Text('Domingo')),
              Text('Perfiles', style: API.estiloJ24negro),
              Text(
                  'Crea los perfiles de tu personal para que tus clientes puedan conocerlos.',
                  style: API.estiloJ14gris),
              workers.isNotEmpty
                  ? ListView(shrinkWrap: true, children: trabajadores)
                  : Container(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileInsidePage(),
                      ));
                },
                icon: Icon(Icons.plus_one),
                label: Text('Agregar más'),
              ),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
