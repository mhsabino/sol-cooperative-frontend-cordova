cordova build android --release &&
# jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore android.keystore platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk br.gov.ba.car.cooperative && 
# /home/mateus/Android/Sdk/build-tools/30.0.3/apksigner sign --ks-key-alias br.gov.ba.car.cooperative --ks android.keystore platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk &&
touch app-release.apk && rm app-release.apk &&
zipalign -v 4 platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk app-release.apk &&
/home/mateus/Android/Sdk/build-tools/30.0.3/apksigner sign --ks-key-alias br.gov.ba.car.cooperative --ks android.keystore app-release.apk &&
/home/mateus/Android/Sdk/build-tools/30.0.3/apksigner verify -v app-release.apk