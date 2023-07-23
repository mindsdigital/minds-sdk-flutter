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


Adicione também a permissão a seu arquivo PodFile:


```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'AUDIO_SESSION_MICROPHONE=0' #MIC PERMISSION
      ]
    end
  end
end
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

### Renderização em forma de tela usando CustomBuilder

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
