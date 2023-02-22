# Versão SDK 30 ou anterior:

  # cordova build android --release &&
  # touch app-release.apk && rm app-release.apk &&
  # zipalign -v 4 platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk app-release.apk &&
  # /home/mateus/Android/Sdk/build-tools/30.0.3/apksigner sign --ks-key-alias br.gov.pb.cooperar.sol.associacao --ks android_associacao_pb.keystore app-release.apk &&
  # /home/mateus/Android/Sdk/build-tools/30.0.3/apksigner verify -v app-release.apk

# Atualizado! Versão SDK 32:

# Gerar arquivo .aab (Android App Bundle) pelo Android:

  # Abrir Android Studio
  # Importar projeto cordova /platforms/android no Android Studio selecionando a opção "Importar Projeto (Ecipse ADT, Gradle, etc)"
  # Acessar menu Build -> Build Bundle(s)/APK(s) -> Build Bundle(s)
  # Preencher as informações das chaves e senhas. Obs.: As senhas podem ser as mesmas
  # Será gerado um arquivo .aab. O local do arquivo será informado no Anrdoid Studio
  # Após isso realizar a assinatura do arquivo aab:
  # Acessar o menu Build ->  Generate Signed Bundle / APK
  # Selecionar a opção Bundle, que já vem pré-selecionada
  # Será gerada uma private_key.pepk

# Gerar arquivo .aab (Android App Bundle) pelo cordova:

  # Gerar aplicativo (.aab)
  cordova build android --release -- --keystore=android_associacao_pb.keystore --storePassword=***** --alias=br.gov.pb.cooperar.sol.associacao --password=***** --packageType=bundle

  # Assinar o app
  jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore android_associacao_pb.keystore platforms/android/app/build/outputs/bundle/release/app-release.aab br.gov.pb.cooperar.sol.associacao
