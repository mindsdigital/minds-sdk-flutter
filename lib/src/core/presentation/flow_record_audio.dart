import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:minds_digital/minds_digital.dart';
import 'package:minds_digital/src/core/domain/entities/biometrics_reponse/biometrics_response.dart';
import 'package:minds_digital/src/core/presentation/recording_helper.dart';
import '../helpers/theme/asset_paths.dart';
import '../helpers/theme/design_system_constants.dart';
import '../helpers/theme/theme_colors.dart';
import '../stores/flow_biometrics/flow_biometrics_store.dart';
import 'helpers/base_state.dart';

class FlowRecordAudioRequest {
  final BiometricsRequest biometricsRequest;
  final ProcessType processType;
  final BuildContext buildContext;
  FlowRecordAudioRequest({
    required this.biometricsRequest,
    required this.processType,
    required this.buildContext,
  });
}

class FlowRecordAudio extends StatefulWidget {
  final FlowRecordAudioRequest request;
  final Function(BiometricsResponse) onResponse;
  final Function(dynamic) onError;

  const FlowRecordAudio({
    super.key,
    required this.request,
    required this.onError,
    required this.onResponse,
  });

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
  RecordingHelper recordingHelper = RecordingHelper();
  FlowRecordAudioRequest get request => widget.request;

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
    recordingHelper.dispose();
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
                  child: ValueListenableBuilder(
                    valueListenable: recordingHelper.recordState,
                    builder: (context, recordState, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            request.processType == ProcessType.enrollment
                                ? "Cadastre sua voz"
                                : "Autentique sua voz",
                            style: const TextStyle(
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
                          if (recordState.isRecording) ...[
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
                            Center(child: _buildTimer(recordState.recordDuration)),
                          ],
                          const SizedBox(height: 25),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  if (!recordState.isRecording) {
                                    recordingHelper.startRecord();
                                  } else {
                                    final path = await recordingHelper.stopRecord();

                                    if ((recordState.recordDuration % 60) < 5) {
                                      showInfoInvalidLenght();
                                      return;
                                    }

                                    if (path != null) {
                                      final response = await _store.sendAudio(
                                        path: path,
                                        processType: request.processType,
                                        request: BiometricsRequest(
                                          audio: await AudioHelper.convertPathToBase64(path),
                                          cpf: request.biometricsRequest.cpf,
                                          externalId: request.biometricsRequest.externalId,
                                          externalCustomerId:
                                              request.biometricsRequest.externalCustomerId,
                                          extension: 'ogg',
                                          phoneNumber: request.biometricsRequest.phoneNumber,
                                          showDetails: request.biometricsRequest.showDetails,
                                          sentenceId: bloc.randomSentence.sentence.text.isNotEmpty
                                              ? bloc.randomSentence.sentence.id.toString()
                                              : null,
                                        ),
                                      );

                                      widget.onResponse.call(response);
                                      Navigator.of(request.buildContext).pop();
                                    }
                                  }
                                } catch (error) {
                                  widget.onError.call(error);
                                  Navigator.of(request.buildContext).pop();
                                  rethrow;
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: recordState.isRecording
                                    ? const Icon(Icons.stop)
                                    : Image.asset(
                                        AssetPaths.mic,
                                        package: DesignSystemConstants.packageName,
                                        width: 28,
                                        height: 28,
                                      ),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(8),
                                backgroundColor: ThemColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showInfoInvalidLenght() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Duranção inválida', style: TextStyle(fontFamily: "Inter")),
          content: const Text("É preciso que o áudio tenha mais que 5 segundos de duração",
              style: TextStyle(fontFamily: "Inter")),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("TENTAR NOVAMENTE", style: TextStyle(fontFamily: "Inter")))
          ],
        );
      },
    );
  }

  Widget _buildTimer(int recordDuration) {
    final String minutes = _formatNumber(recordDuration ~/ 60);
    final String seconds = _formatNumber(recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(fontFamily: 'Inter'),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }
}
