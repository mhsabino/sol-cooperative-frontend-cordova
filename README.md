# Aplicação para gerenciar os builds hibridos do repósitório sol-cooperative-frontend

```
npm -version
6.9.0

node --version
v10.16.0

gradle --version
Gradle 6.0.1

cordova --version
11.0.0 (cordova-lib@11.0.0)

```

- Criar symlink da pasta `/dist` - `ln -s ../sol-cooperative-frontend/dist www`
- Adicionar plataforma Android `cordova platform add android@11.0.0`
- Listar plataformas instaladas `cordova platform ls`
- Listar requisitos `cordova requirements`

```
Android Studio project detected

Requirements check results for android:
Java JDK: installed 11.0.17
Android SDK: installed true
Android target: installed android-32
Gradle: installed /home/user/.sdkman/candidates/gradle/6.0.1/bin/gradle
```

Exemplo de paths adicionado no `~/.bashrc` ou `~/.zshrc` ou ``~/.bash_profile``

```
JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
export PATH=${JAVA_HOME}/bin:${PATH}
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
```

Para adicionar `Android target` você precisa fazer isso pela GUI do Android Studio (`Preferences... > Appearance & Behavior > System Settings > Android SDK > aba SDK Platform`).

- Em alguns casos é necessário execurar `cordova clean android` para atualizar o processo de build

> Obs.: Há um script "assign.sh" que executa todo o processo de build do android e assinatura. Esse se encotnra na raiz do diretório desse projeto. Basta executá-lo e o mesmo irá realizar os próximos passos para versão 30 e assinatura v2.

# Passo a passo para criar builds android
- Buildar a aplicação do repositório `sol-cooperative-frontend` com `yarn run build`
- Criar build android `cordova build android`


# Passo para gerar o apk para release

- Gerar chave para assinar o apk (uma única vez)
`keytool -genkey -v -keystore android.keystore -alias br.gov.pb.cooperar.sol.associacao -keyalg RSA -keysize 2048 -validity 10000`

# Gerar arquivo .aab (Android App Bundle):

- Abrir Android Studio
- Importar projeto cordova /platforms/android no Android Studio selecionando a opção "Importar Projeto (Ecipse ADT, Gradle, etc)"
- Acessar menu Build -> Build Bundle(s)/APK(s) -> Build Bundle(s)
- Preencher as informações das chaves e senhas. Obs.: As senhas podem ser as mesmas
- Será gerado um arquivo .aab. O local do arquivo será informado no Anrdoid Studio

# Realizar a assinatura do arquivo aab:
- No android Studio, acessar o menu Build ->  Generate Signed Bundle / APK
- Selecionar a opção Bundle, que já vem pré-selecionada
  - Informar a chave gerada no item anterior e a senha cadastrada
- Será gerada uma private_key.pepk

