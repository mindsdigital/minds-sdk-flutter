import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import '../helpers/theme/asset_paths.dart';
import '../helpers/theme/design_system_constants.dart';
import '../helpers/theme/theme_colors.dart';
import '../stores/flow_biometrics/flow_biometrics_store.dart';
import 'helpers/base_state.dart';

class FlowRecordAudio extends StatefulWidget {
  const FlowRecordAudio({super.key});

  @override
  State<FlowRecordAudio> createState() => _FlowRecordAudioState();

  Future show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => this,
    );
  }
}

class _FlowRecordAudioState extends State<FlowRecordAudio> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final FlowBiometricsStore _store;
  late final StreamSubscription _stream;

  @override
  void initState() {
    super.initState();
    _store = GetIt.instance.get<FlowBiometricsStore>();
    _store.fetchRandomSentence();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _controller.repeat();
    _stream = _store.stream.listen((event) {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _stream.cancel();
    _store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700),
        width: MediaQuery.of(context).size.width * 0.5,
        //height: MediaQuery.of(context).size.height * 0.6,
        child: Stack(
          children: [
            Positioned(
              right: 10,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    AssetPaths.circleClose,
                    package: DesignSystemConstants.packageName,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
            BlocBuilder<FlowBiometricsStore, FlowBiometricsState>(
                bloc: _store,
                builder: (context, bloc) {
                  if (bloc.state is LoadingState) {
                    return Center(child: CircularProgressIndicator(color: ThemColors.primaryColor));
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 45, 24, 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Cadastre sua voz",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Clique no microfone, diga a frase de segurança e envie sua biometria.",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ThemColors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          bloc.randomSentence.sentence.text,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: 200,
                            child: Lottie.asset(
                              AssetPaths.lootieSpectro,
                              controller: _controller,
                              animate: true,
                              onLoaded: (composition) {},
                              package: DesignSystemConstants.packageName,
                              repeat: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(
                                AssetPaths.mic,
                                package: DesignSystemConstants.packageName,
                                width: 28,
                                height: 28,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(8),
                              backgroundColor: ThemColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
