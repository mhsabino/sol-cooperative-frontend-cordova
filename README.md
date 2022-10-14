# Aplicação para gerenciar os builds hibridos do repósitório sol-cooperative-frontend

```
npm -version
6.9.0

node --version
v10.16.0

gradle --version
Gradle 6.0.1

cordova --version
9.0.0 (cordova-lib@9.0.1)

```

- Criar symlink da pasta `/dist` - `ln -s ../sol-cooperative-frontend/dist www`
- Adicionar plataforma Android `cordova platform add android 8.1.0`
- Listar plataformas instaladas `cordova platform ls`
- Listar requisitos `cordova requirements`

```
Android Studio project detected

Requirements check results for android:
Java JDK: installed 1.8.0
Android SDK: installed true
Android target: installed android-30,android-29,android-28
Gradle: installed /home/mateus/.sdkman/candidates/gradle/6.0.1/bin/gradle
```

Cada plataforma necessita de requisitos diferentes que podem ser [listados aqui](https://cordova.apache.org/docs/en/latest/guide/cli/#install-pre-requisites-for-building)

Exemplo de paths adicionado no `~/.bashrc` ou `~/.zshrc` ou ``~/.bash_profile``

```
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=${JAVA_HOME}/bin:${PATH}
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools
```

Para adicionar `Android target` você precisa fazer isso pela GUI do Android Studio (`Preferences... > Appearance & Behavior > System Settings > Android SDK > aba SDK Platform`).

- Editar arquivo /platforms/android/project.properties com as opções do firebase, uma vez que o plugin `cordova-plugin-firebase` não instala corretamente:

```
cordova.gradle.include.1=cordova-plugin-firebase/cooperative-build.gradle
cordova.system.library.1=com.google.android.gms:play-services-tagmanager:+
cordova.system.library.2=com.google.firebase:firebase-core:16.0.8
cordova.system.library.3=com.google.firebase:firebase-messaging:17.5.0
cordova.system.library.4=com.google.firebase:firebase-config:16.4.1
cordova.system.library.5=com.google.firebase:firebase-perf:16.2.4
```

- Atualizar `platforms/androd/cordova-plugin-firebase/cooperative-build.gradle

`compile 'com.google.firebase:firebase-auth:+'`

- Se necessário atualizar a versão do google-services para a 4.2.0 no arquivo `platforms/android/build.gradle`: 

`com.google.gms:google-services:4.2.0`

- Em alguns casos é necessário execurar `cordova clean android` para atualizar o processo de build

> Obs.: Há um script "assign.sh" que executa todo o processo de build do android e assinatura. Esse se encotnra na raiz do diretório desse projeto. Basta executá-lo e o mesmo irá realizar os próximos passos para versão 30 e assinatura v2.

# Passo a passo para criar builds android
- Buildar a aplicação do repositório `sol-cooperative-frontend` com `yarn run build`
- Criar build android `cordova build android`


# Passo para gerar o apk para release
- Gerar chave para assinar o apk (uma única vez)
`keytool -genkey -v -keystore android.keystore -alias br.gov.pb.cooperar.sol.associacao -keyalg RSA -keysize 2048 -validity 10000`

- Gerar apk
`cordova build android --release`

- Assinar apk (acessar local onde o apk foi gerado)
`jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore android.keystore app-release-unsigned.apk br.gov.pb.cooperar.sol.associacao`

- Otimizar apk
`zipalign -v 4 app-release-unsigned.apk app-release.apk`

- Atualizar play store com o apk gerado `app-release.apk`


# Passo bônus para gerar o apk para release
- Executar o comando `yarn build:android`
- Informar senha do certificado
- Atualizar play store com o apk gerado `app-release.apk`
