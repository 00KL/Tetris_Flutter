# Tetris_flutter

Simple Tetris-like game made in flutter

# Setup da máquina

**Crie interface de conexão com o dispositivo**

Para usar este projeto como um app mobile você precisará ter alguma das opções abaixo configurada em sua máquina:

- Emulação de IOS e interface usb (não há como instlar separadamente) (https://blog.cod3r.com.br/configurando-o-emulador-ios/)
- Emulação de Android (https://developer.android.com/studio instale o Android Studio e ele abra ele, ele irá permitir que o flutter encontre e execute um emulação do android)
  - Uma alternativa para máquinas que estejam usando Linux pode ser encontrada no link: https://computingforgeeks.com/install-android-studio-on-ubuntu-linux/ (testado no Ubuntu 18.04).
- Interface ADB configurada em sua máquina para conexão com seu dispositivo Android via USB (https://www.xda-developers.com/install-adb-windows-macos-linux/)
- Gerenciador de pacotes específico necessário. Homebrew para MacOS ou Linux (https://brew.sh/index_pt-br) e Choco para Windows (https://docs.chocolatey.org/en-us/choco/setup).

:warning: Recomendação: Não use o WSL (1 ou 2) para este projeto, a configuração de conectividade do dispositivo é difícil e sem certeza de sucesso. Estando no Windows faça as instalações no proprio Windows.

**Instale o Flutter**

https://docs.flutter.dev/get-started/install

**Instale e configure o FVM**

Para instalar siga este link: https://fvm.app/docs/getting_started/installation

Em seguida rode os seguintes comandos:

```
fvm install stable
fvm global stable
```

Dessa forma é garantida que a versão estável mais recente do flutter está sendo usada no processo.

**Instale o vscode**

https://code.visualstudio.com

Ao abrir o projeto o vscode sugerirá a instalação de diversos complementos para auxiliar no desenvolvimento Flutter, aceite e instale todos.

# Rodando o projeto

**Clone o repositório**
Caso o usuário tenha configurado uma chave ssh em sua máquina use o link de clonagem a seguir:

```
git clone git@bitbucket.org:kaffeetecteam/coffee-classifier-mobile-flutter.git
```

Caso contrário use o link de clonagem a seguir:

```
git clone https://00kl@bitbucket.org/kaffeetecteam/coffee-classifier-mobile-flutter.git
```

**Vá até a pasta do projeto e execute o comando abaixo para instalar as dependências**

```
flutter pub get
```

**Ainda na pasta do projeto, abra o vscode com o comando abaixo**

```
code .
```

**Inicie o emulador ou dispositivo externo**

Para isso assista ao vídeo a seguir: https://youtube.com/clip/UgkxXUIv1Nely_V9ARew0u3sR-xNt8UihuiOm </br>
:warning: Os nomes dos emuladores podem estar diferentes!
:warning: Caso o usuário esteja usando um dispositivo conectado via ADB ele será listado como um emulador comum, é necessário seleciona-lo antes de rodar a aplicação.

**Abra o arquivo principal do projeto**

Abra o arquivo main que está localizado na pasta lib (./lib/main.dart)

**Execute o projeto**

Com o arquivo aberto clique no botão de play que se encontra no canto superior direito da página do arquivo:</br>
![Alt text](/assets/images/start_app_buttom.png)

:construction: Projeto em construção :construction:
