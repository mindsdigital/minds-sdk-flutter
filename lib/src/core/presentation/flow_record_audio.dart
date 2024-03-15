import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:minds_digital/minds_digital.dart';
import 'package:minds_digital/src/core/helpers/constants.dart';
import 'package:minds_digital/src/core/presentation/widgets/record_button.dart';
import '../domain/entities/validator_sdk/init_validator_request.dart';
import '../helpers/theme/asset_paths.dart';
import '../helpers/theme/design_system_constants.dart';
import '../helpers/theme/theme_colors.dart';
import '../stores/flow_biometrics/flow_biometrics_store.dart';
import 'recording_helper.dart';

typedef CustomBuilder = Widget Function(
  BuildContext context,
  RecordingState recordingState,
  FlowBiometricsState flowBiometricsState,
  Widget recordButton,
);

class FlowStyle {
  final String? title;
  final String? subtitle;
  final Color? loadingColor;
  final Color? animationRecorderColor;
  final Color? buttonColor;
  final bool fullScreenDialog;
  const FlowStyle({
    this.title,
    this.subtitle,
    this.loadingColor,
    this.animationRecorderColor,
    this.buttonColor,
    this.fullScreenDialog = false,
  });
}

class FlowRecordAudioRequest {
  final FlowBiometricsRequest biometricsRequest;
  final ProcessType processType;
  final BuildContext context;

  FlowRecordAudioRequest({
    required this.biometricsRequest,
    required this.processType,
    required this.context,
  });
}

class FlowRecordAudio extends StatefulWidget {
  final FlowRecordAudioRequest request;
  final Function(BiometricsResponse) onResponse;
  final Function(Exception) onError;
  final Function()? onExit;
  final FlowStyle? style;
  final CustomBuilder? customBuilder;
  final bool exitEnabled;
  const FlowRecordAudio({
    super.key,
    required this.request,
    required this.onError,
    required this.onResponse,
    required this.style,
    this.onExit,
    this.customBuilder,
    this.exitEnabled = true,
  });

  @override
  State<FlowRecordAudio> createState() => _FlowRecordAudioState();

  Future show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => this,
      barrierDismissible: false,
    );
  }
}

class _FlowRecordAudioState extends State<FlowRecordAudio> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final FlowBiometricsStore _store;
  late final StreamSubscription _stream;
  RecordingHelper recordingHelper = RecordingHelper();
  FlowRecordAudioRequest get request => widget.request;
  BuildContext get buildContext => request.context;
  InitValidatorRequest get initValidatorRequest => InitValidatorRequest(
        document: request.biometricsRequest.cpf,
        phoneNumber: request.biometricsRequest.phoneNumber ?? "",
        phoneCountryCode: request.biometricsRequest.phoneCountryCode,
        rate: MindsSDKConstants.samplingRate,
        isAuthentication: request.processType == ProcessType.authentication,
      );
  FlowStyle? get style => widget.style;
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();
    _store = GetIt.instance.get<FlowBiometricsStore>();
    _store.sdkInitValidator(initValidatorRequest);
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _controller.repeat();
    _stream = _store.stream.listen((event) {
      if (event.state is FailureSdkInitState) {
        widget.onError(Exception((event.state as FailureSdkInitState).message));
        Navigator.of(buildContext).pop();
      }
      if (event.state is SuccessSdkInitState) {
        _store.fetchRandomSentence();
        recordingHelper.hasPermissionMic();
      }
    });
  }

  Future<LottieComposition> _loadComposition() async {
    final String asset =
        'packages/${DesignSystemConstants.packageName}/${AssetPaths.lootieSpectro}';
    var assetData = await rootBundle.load(asset);
    return await LottieComposition.fromByteData(assetData);
  }

  @override
  void dispose() {
    recordingHelper.dispose();
    _controller.dispose();
    _stream.cancel();
    _store.close();
    super.dispose();
  }

  Future<bool> onExit() async {
    if (widget.exitEnabled) {
      widget.onExit?.call();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlowBiometricsStore, FlowBiometricsState>(
      bloc: _store,
      builder: (context, bloc) {
        return ValueListenableBuilder(
          valueListenable: recordingHelper.recordState,
          builder: (context, recordState, _) {
            if (widget.customBuilder != null) {
              return widget.customBuilder!(
                context,
                recordState,
                bloc,
                buttonRecord(recordState, bloc),
              );
            }
            return FutureBuilder<LottieComposition>(
              future: _composition,
              builder: (context, snapshot) {
                var composition = snapshot.data;

                if (composition != null) {
                  if (style?.fullScreenDialog ?? false) {
                    return PopScope(
                      canPop: false,
                      onPopInvoked: (didPop) {
                        if (didPop) {
                          return;
                        }
                        widget.onExit?.call();
                      },
                      child: Dialog.fullscreen(
                        child: content(
                            recordState, bloc, composition, style?.fullScreenDialog ?? false),
                      ),
                    );
                  }
                  return PopScope(
                    onPopInvoked: (didPop) {
                      if (didPop) {
                        return;
                      }
                      widget.onExit?.call();
                    },
                    child: Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child:
                          content(recordState, bloc, composition, style?.fullScreenDialog ?? false),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: style?.loadingColor != null
                        ? style!.loadingColor!
                        : ThemeColors.primaryColor,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget content(
    RecordingState recordState,
    FlowBiometricsState bloc,
    LottieComposition composition,
    bool fullscreen,
  ) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Stack(
        children: [
          Visibility(
            visible: widget.exitEnabled && !recordState.isRecording,
            child: Positioned(
              right: 10,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  onTap: widget.onExit ?? () => Navigator.of(context).pop(),
                  child: Image.asset(
                    AssetPaths.circleClose,
                    package: DesignSystemConstants.packageName,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
          ),
          if (bloc.state is LoadingState) ...[
            Center(
              child: CircularProgressIndicator(
                color:
                    style?.loadingColor != null ? style!.loadingColor! : ThemeColors.primaryColor,
              ),
            )
          ],
          if (bloc.state is FailureFetchRandomSentenceState) ...[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Falha ao carregar a frase",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async => await _store.fetchRandomSentence(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar novammente'),
                  )
                ],
              ),
            ),
          ] else ...[
            Visibility(
              visible: bloc.state is! LoadingState,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 45, 24, 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      fullscreen ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                  mainAxisSize: fullscreen ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          style?.title != null
                              ? style!.title!
                              : request.processType == ProcessType.enrollment
                                  ? "Cadastre sua voz"
                                  : "Autentique sua voz",
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          style?.subtitle != null
                              ? style!.subtitle!
                              : !kIsWeb
                                  ? "Segure o botão para iniciar a gravação e leia o texto abaixo."
                                  : "Clique no microfone, diga a frase de segurança e envie sua biometria.",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ThemeColors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Flexible(
                      child: Text(
                        bloc.randomSentence.sentence.text,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (recordState.isRecording) ...[
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 200,
                          child: Lottie(
                            composition: composition,
                            controller: _controller,
                            animate: true,
                            repeat: true,
                            delegates: LottieDelegates(
                              values: [
                                ValueDelegate.color(
                                  const ['**'],
                                  value: style?.animationRecorderColor != null
                                      ? style!.animationRecorderColor
                                      : ThemeColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(child: _buildTimer(recordState.recordDuration)),
                    ],
                    SizedBox(
                        height: recordState.isRecording
                            ? 25
                            : MediaQuery.of(context).size.height * 0.25),
                    SizedBox(
                      child: Center(child: buttonRecord(recordState, bloc)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ],
      ),
    );
  }

  Widget buttonRecord(RecordingState recordState, FlowBiometricsState bloc) => PressAndHoldButton(
        isRecording: recordState.isRecording,
        buttonColor: style?.buttonColor,
        onLongPressStart: () async => recordAudio(recordState, bloc),
        onLongPressEnd: () async => recordAudio(recordState, bloc),
        onTap: () async {
          if (kIsWeb) {
            recordAudio(recordState, bloc);
            return;
          }
          Fluttertoast.showToast(
            msg: "Segure para gravar, solte para enviar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: ThemeColors.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
      );

  void recordAudio(RecordingState recordState, FlowBiometricsState bloc) async {
    try {
      if (!recordState.isRecording) {
        _store.setLoading(true);
        recordingHelper.startRecord();
        _store.setLoading(false);
      } else {
        _store.setLoading(true);
        final path = await recordingHelper.stopRecord();
        _store.setLoading(false);
        if ((recordState.recordDuration % 60) < 5) {
          showInfoInvalidLenght();
          return;
        }
        if (path != null) {
          final response = await _store.sendAudio(
            currentBlobUrl: kIsWeb ? recordingHelper.recordState.value.currentBlobUrl : null,
            path: path,
            processType: request.processType,
            request: BiometricsRequest(
              audio: kIsWeb ? path : await AudioHelper.convertPathToBase64(path),
              document: request.biometricsRequest.cpf,
              externalId: request.biometricsRequest.externalId,
              externalCustomerId: request.biometricsRequest.externalCustomerId,
              extension: kIsWeb ? 'flac' : 'ogg',
              phoneNumber: request.biometricsRequest.phoneNumber,
              showDetails: request.biometricsRequest.showDetails,
              sentenceId: bloc.randomSentence.sentence.text.isNotEmpty
                  ? bloc.randomSentence.sentence.id.toString()
                  : null,
            ),
          );
          widget.onResponse.call(response);
          Navigator.of(buildContext).pop();
        }
      }
    } on Exception catch (error) {
      _store.setLoading(false);
      widget.onError.call(error);
      Navigator.of(buildContext).pop();
      //rethrow;
    }
  }

  void showInfoInvalidLenght() {
    showDialog(
      context: context,
      builder: (context) {
        return kIsWeb || Platform.isAndroid
            ? AlertDialog(
                title: const Text('Duranção inválida', style: TextStyle(fontFamily: "Inter")),
                content: const Text("É preciso que o áudio tenha mais que 5 segundos de duração",
                    style: TextStyle(fontFamily: "Inter")),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "TENTAR NOVAMENTE",
                      style: TextStyle(fontFamily: "Inter", color: ThemeColors.primaryColor),
                    ),
                  )
                ],
              )
            : CupertinoAlertDialog(
                title: const Text('Duranção inválida', style: TextStyle(fontFamily: "Inter")),
                content: const Text("É preciso que o áudio tenha mais que 5 segundos de duração",
                    style: TextStyle(fontFamily: "Inter")),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "TENTAR NOVAMENTE",
                      style: TextStyle(fontFamily: "Inter", color: Colors.blueAccent),
                    ),
                  )
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
