# Minds Digital



### Configuração Android 

Ao executar no sistema Android, se você receber um erro indicando que `minSdkVersion` precisa ser `24`.

tente adicionar o seguinte trecho ao arquivo `<project_directory>/android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:tools="http://schemas.android.com/tools" ....... >
    <uses-sdk tools:overrideLibrary="com.arthenica.ffmpegkit.flutter, com.arthenica.ffmpegkit" />
</manifest>
```
### Configuração iOS

Adicione as seguintes chaves ao seu arquivo **Info.plist**, localizado em `<project root>/ios/Runner/Info.plist`:
  ```ruby
  <key>NSMicrophoneUsageDescription</key>
  <string>Used to capture audio</string>
  ```

## Using package

In your Dart code, you can use:

```dart
import 'package:minds_digital/minds_digital.dart';
```

## Getting Started
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MindsApiWrapper.initialize(
    environment: Environment.staging,
    token:'token',
  );
  runApp(const AppWidget());
}
```

##  Utilização do Wrapper


### Enrollment
```dart
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
```


### Authentication
```dart
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
```


### Adição de um telefone na blocklist
```dart
final response = await MindsApiWrapper.service.setPhoneBlocklist(
    request: const RequestPhoneBlocklist(
    phoneNumber: '11111111111',
    externalId: '123',
    description: 'foi constatado uma fraude com esse número'
    createdBy: 'Vitor',
  ),
);
```

### Adição de uma voz na blocklist
```dart
final response = await MindsApiWrapper.service.setVoiceBlocklist(
 request: const RequestVoiceBlocklist(
    audio: "SW4gY29tcHV0ZXIgcHJvZ3JhbW1pbmcsIEJhc2U2NCB...",
    externalId: '123',
    description: 'foi constatado uma fraude com esse número',
    createdBy: 'Vitor',
    extension: 'ogg',
  ),
);
```


### Verificação de biometria de voz

```dart
final response = await MindsApiWrapper.service.enrollmentVerify(cpf: "00000000000");
```

### Certificação de biometria de voz

```dart
final response = await MindsApiWrapper.service.enrollmentCertify(cpf: "00000000000");
```

## Componente de captura de áudio

### Renderização em forma de dialog
```dart
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
    debugPrint("response $biometricsResponse");
  },
  onError: (error) {
    debugPrint("error: $error");
  },
  style: const FlowStyle(),
).show(context);
```

<img src="https://raw.githubusercontent.com/mindsdigital/minds-sdk-flutter/main/assets/samples/dialog.png" width="320px"/>

### Interface personalizada com Custom Builder

title: Documentação do CustomBuilder

O `CustomBuilder` é usado no widget `FlowRecordAudio` para permitir que a criação de uma interface personalizada para gravar áudio e lidar com os fluxos de biometria.

### Assinatura

```dart
typedef CustomBuilder = Widget Function(
  BuildContext context,
  RecordingState recordingState,
  FlowBiometricsState flowBiometricsState,
  Widget recordButton,
);
```
## Parâmetros

A função `CustomBuilder` retorna os seguintes parâmetros:

1. `context` (BuildContext): Um identificador para a localização de um widget na árvore de widgets.

2. `recordingState` (RecordingState): Uma instância da classe `RecordingState`, que representa o estado atual da gravação de áudio. Isso inclui informações como a duração da gravação, se a gravação está ocorrendo atualmente.

3. `flowBiometricsState` (FlowBiometricsState): Uma instância da classe `FlowBiometricsState`, que representa o estado atual do fluxo de biometria. Isso inclui informações como a resposta da frase aleatória e o estado geral do fluxo de biometria.

4. `recordButton` (Widget): Um widget retornado que faz todo o processo de gravação, tratamento e envio de áudio para API. Ele é retornado no `CustomBuilder` como um widget e pode ser utilizado em qualquer lugar da tela.

Esses parâmetros permitem que você crie uma interface personalizada de gravação de áudio com base no estado atual da gravação e no fluxo de biometria. O `recordingState` permite que você exiba informações relevantes sobre a gravação, como a duração atual. Já o `flowBiometricsState` permite que você mostre o estado atual do fluxo de biometria, incluindo detalhes sobre a frase aleatória. Além disso, o `recordButton` permite que você utilize o botão de gravação padrão para iniciar ou interromper a gravação de áudio.

Com esses parâmetros em mãos, você tem a flexibilidade para criar uma experiência de usuário personalizada e sob medida para a sua aplicação, ao mesmo tempo que utiliza a funcionalidade essencial de gravação de áudio e fluxo de biometria fornecida pelo widget `FlowRecordAudio`.


### Exemplo 
```dart
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
      customBuilder: (context, recordingState, flowBiometricsState, buttonRecord) => Scaffold(
        appBar: AppBar(),
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
```

<img src="https://raw.githubusercontent.com/mindsdigital/minds-sdk-flutter/main/assets/samples/custom_builder.png" width="320px"/>
