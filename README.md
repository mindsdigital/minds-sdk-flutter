# Visão Geral

## Sobre este SDK

O SDK Flutter da Minds Digital foi projetado para proporcionar uma integração rápida, simplificada e abstraída das jornadas de biometria de voz em suas aplicações Flutter.

Nosso pacote fornece um wrapper da API que contém as funcionalidades já abstraídas, permitindo que você se concentre na lógica do seu aplicativo, em vez de se preocupar com a complexidade da manipulação e captura de áudio, integração com nossas APIs em nuvem e desenvolvimento das telas referentes aos fluxos mencionados.

## Compatibilidade

| Configuração | Versão mínima                           |
| ------------ | --------------------------------------- |
| Android      | Versão mínima do SDK Android igual a 19 |
| iOS          | Versão 11 ou superior                   |

## Funcionalidades disponíveis

A SDK iOS da Minds Digital disponibiliza as seguintes funcionalidades:

-   Cadastro de biometria de voz;
-   Autenticação via biometria de voz;
-   Customização da interface de forma dinâmica; 
-  Wrapper
    -  Adição de um telefone na blocklist;
    -  Adição de uma voz na blocklist;
    -  Verificação de biometria de voz;
    -  Certificação de biometria de voz;


> Observação: A utilização do pacote não obriga a usar o componente `FlowRecordAudioRequest`, que basicamente é o componente que possui a captura de áudio implementada. Se desejar, é possível utilizar apenas as chamadas do wrapper e construir sua própria interface. Outra opção é a utilização do custom builder, que permite personalizar a tela da forma que você desejar, mantendo o fluxo de captura de áudio que já está pronto.


### Configuração Android 

Ao executar no sistema Android, se você receber um erro indicando que `minSdkVersion` precisa ser `24`.

tente adicionar o seguinte trecho ao arquivo `<project_directory>/android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:tools="http://schemas.android.com/tools" ....... >
    <uses-sdk tools:overrideLibrary="com.arthenica.ffmpegkit.flutter, com.arthenica.ffmpegkit" />
</manifest>
```
### Configuração iOS

Adicione a seguinte chave ao seu arquivo **Info.plist**, localizado em `<project root>/ios/Runner/Info.plist`:
  ```ruby
  <key>NSMicrophoneUsageDescription</key>
  <string>Used to capture audio</string>
  ```

## Usando o pacote

No seu código Dart, você pode usar:

```dart
import 'package:minds_digital/minds_digital.dart';
```

## Primeiros Passos
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   // Inicialize a SDK com o ambiente desejado (sandbox, staging ou production)
  MindsApiWrapper.initialize(
    environment: Environment.staging,
    token:'token', // Substitua "token" pelo token de acesso fornecido para a integração com a API.
  );
  runApp(const AppWidget());
}
```

##  Utilização do Wrapper


### Criação de biometria de voz

* Criar/atualizar uma biometria por voz para um cliente

Veja aqui os parâmetros que podem ser enviados na [documentação oficial](https://api.minds.digital/docs/api/rotas/biometria_voz/criacao_biometria).
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


### Autenticação

* Validar o processo de biometria de voz de um cliente que já possui uma biometria por voz cadastrada.
  
Veja aqui os parâmetros que podem ser enviados na [documentação oficial](https://api.minds.digital/docs/api/rotas/autenticacao_voz/criacao_autenticacao_voz).

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

Veja aqui os parâmetros que podem ser enviados na [documentação oficial](https://api.minds.digital/docs/api/rotas/blocklist/adicao_telefone).


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


Veja aqui os parâmetros que podem ser enviados na [documentação oficial](https://api.minds.digital/docs/api/rotas/blocklist/adicao_voz).



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

* Verificar se um cliente já possui biometria de voz.

```dart
final response = await MindsApiWrapper.service.enrollmentVerify(cpf: "00000000000");
```

### Certificação de biometria de voz

* Adicionar um cliente na lista de clientes confiáveis

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
  onResponse: (BiometricsResponse response) {
    // Lidar com a resposta da biometria aqui
  },
  onError: (Exception error) {
    // Lidar com os erros aqui
  },
  style: const FlowStyle(),
).show(context); // Método .show() exibe o widget como dialog na tela
```
<img src="https://raw.githubusercontent.com/mindsdigital/minds-sdk-flutter/main/assets/samples/dialog.png" width="320px"/>

#### Classe de Estilização: FlowStyle

A classe `FlowStyle` é utilizada para definir o estilo e configurações visuais para a interface do widget `FlowRecordAudio`. Ela contém diversos parâmetros opcionais que permitem personalizar a aparência do componente de gravação de áudio e fluxo de biometria.

### Propriedades

A classe `FlowStyle` possui as seguintes propriedades:

1. `title` (String?): Uma string opcional que define o título da interface de gravação de áudio.

2. `subtitle` (String?): Uma string opcional que define o subtítulo da interface de gravação de áudio. Esse subtítulo pode ser usado para fornecer informações adicionais ou instruções ao usuário.

3. `loadingColor` (Color?): Uma cor opcional que define a cor de loding

4. `animationRecorderColor` (Color?): Uma cor opcional que define a cor utilizada na animação de gravação de áudio.

5. `buttonColor` (Color?): Uma cor opcional que define a cor de destaque do botão de gravação de áudio. 

6. `fullScreenDialog` (bool): Um valor booleano opcional que indica se a interface de gravação de áudio deve ser exibida como um diálogo em tela cheia (`true`) ou não (`false`). O valor padrão é `false`.



### Exemplo de Uso

Aqui está um exemplo de como utilizar a classe `FlowStyle` para personalizar a interface do widget `FlowRecordAudio`:

```dart
FlowRecordAudio(
  request: FlowRecordAudioRequest(
    biometricsRequest: biometricsRequest,
    processType: processType,
    context: context,
  ),
  onResponse: (BiometricsResponse response) {
    // Lidar com a resposta da biometria aqui
  },
  onError: (Exception error) {
    // Lidar com os erros aqui
  },
  style: FlowStyle(
    title: 'Gravação de Áudio',
    subtitle: 'Pressione o botão para começar a gravar',
    loadingColor: Colors.blue,
    animationRecorderColor: Colors.red,
    buttonColor: Colors.green,
    fullScreenDialog: true,
  ),
)
```

### Interface personalizada com Custom Builder

O `CustomBuilder` é usado no widget `FlowRecordAudio` para permitir que a criação de uma interface personalizada para gravar áudio e lidar com os fluxos de biometria.

* Caso opte pela utilização do Custom Builder, não é necessário o uso do método show, visto que ele é utilizado apenas para renderizar um dialog padrão. Com o Custom Builder, você pode personalizar completamente a interface de gravação de áudio, incluindo a exibição em tela cheia ou em qualquer outra posição da tela.Caso opte pelo utilização do Custom Builder não é necessário a utilização do método show, visto que ele só é utilzado caso for para renderizar um dialog.

### Assinatura

```dart
typedef CustomBuilder = Widget Function(
  BuildContext context,
  RecordingState recordingState,
  FlowBiometricsState flowBiometricsState,
  Widget recordButton,
);
```
## Custom Builder

A função `CustomBuilder` é um typedef que representa uma função que retorna um `widget` e recebe os seguintes parâmetros:

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
