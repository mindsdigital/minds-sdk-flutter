import 'package:flutter/material.dart';
import 'package:minds_digital/minds_digital.dart';
import 'app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MindsApiWrapper.initialize(
    environment: Environment.sandbox,
    token: 'token',
  );
  runApp(const AppWidget());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sample package',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final response = await MindsApiWrapper.service.enrollment(
                  request: const BiometricsRequest(
                    audio: "SW4gY29tcHV0ZXIgcHJvZ3JhbW1pbmcsIEJhc2U2NCB",
                    cpf: '00000000000',
                    externalId: '123',
                    externalCustomerId: '123',
                    extension: 'ogg',
                    phoneNumber: '21981564763',
                    showDetails: true,
                  ),
                );
                debugPrint(response.rawResponse.toString());
              },
              child: const Text('Enrollment'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final response = await MindsApiWrapper.service.authentication(
                  request: const BiometricsRequest(
                    audio: "SW4gY29tcHV0ZXIgcHJvZ3JhbW1pbmcsIEJhc2U2NCB",
                    cpf: '00000000000',
                    externalId: '123',
                    externalCustomerId: '123',
                    extension: 'ogg',
                    phoneNumber: '21981564763',
                    showDetails: true,
                  ),
                );
                debugPrint(response.rawResponse.toString());
              },
              child: const Text('Autenticação'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final response = await MindsApiWrapper.service.setPhoneBlocklist(
                  request: const RequestPhoneBlocklist(
                    phoneNumber: '11111111111',
                    externalId: '123',
                    description: 'foi constatado uma fraude com esse número',
                    createdBy: 'Vitor',
                  ),
                );
                debugPrint(response.toString());
              },
              child: const Text("Adição de um telefone na blocklist"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final response = await MindsApiWrapper.service.setVoiceBlocklist(
                  request: const RequestVoiceBlocklist(
                    audio: "SW4gY29tcHV0ZXIgcHJvZ3JhbW1pbmcsIEJhc2U2NCB...",
                    externalId: '123',
                    description: 'foi constatado uma fraude com esse número',
                    createdBy: 'Vitor',
                    extension: 'ogg',
                  ),
                );
                debugPrint(response.toString());
              },
              child: const Text("Adição de uma voz na blocklist"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final response = await MindsApiWrapper.service.enrollmentVerify(cpf: "00000000000");
                debugPrint(response.toString());
              },
              child: const Text("Verificação de biometria de voz"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final response = await MindsApiWrapper.service.enrollmentCertify(
                  request: const EnrollmentCertifyRequest(cpf: '00000000000'),
                );
                debugPrint(response.toString());
              },
              child: const Text("Certificação de biometria de voz "),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => FlowRecordAudio(
                      request: FlowRecordAudioRequest(
                        context: context,
                        biometricsRequest: const FlowBiometricsRequest(
                          cpf: '00000000000',
                          showDetails: true,
                        ),
                        processType: ProcessType.authentication,
                      ),
                      onResponse: (biometricsResponse) {
                        debugPrint("response $biometricsResponse");
                      },
                      onError: (error) {
                        debugPrint("error: $error");
                      },
                      style: const FlowStyle(),
                      customBuilder: (context, recordingState, flowBiometricsState, buttonRecord) =>
                          Scaffold(
                        appBar: AppBar(title: const Text('CustomBuilder')),
                        body: Builder(
                          builder: (context) {
                            if (flowBiometricsState.state is LoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: Text(
                                    flowBiometricsState.randomSentence.sentence.text,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: recordingState.isRecording,
                                      child: const Text(
                                        'Gravando:',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    _buildTimer(recordingState.recordDuration),
                                  ],
                                ),
                                buttonRecord,
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text("Exemplo Custom builder"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                FlowRecordAudio(
                  request: FlowRecordAudioRequest(
                    context: context,
                    biometricsRequest: const FlowBiometricsRequest(
                      cpf: '00000000000',
                      showDetails: true,
                    ),
                    processType: ProcessType.authentication,
                  ),
                  onResponse: (biometricsResponse) {
                    debugPrint("response: $biometricsResponse");
                  },
                  onError: (error) {
                    debugPrint("error: $error");
                  },
                  style: const FlowStyle(),
                ).show(context);
              },
              child: const Text('Dialog'),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildTimer(int recordDuration) {
  final String minutes = _formatNumber(recordDuration ~/ 60);
  final String seconds = _formatNumber(recordDuration % 60);

  return Text(
    '$minutes : $seconds',
  );
}

String _formatNumber(int number) {
  String numberStr = number.toString();
  if (number < 10) {
    numberStr = '0$numberStr';
  }

  return numberStr;
}
