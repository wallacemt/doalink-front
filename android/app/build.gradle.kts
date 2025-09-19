import java.io.File
import java.util.Properties
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

fun loadDotEnv(projectDir: File): Properties {
    val envFile = File(projectDir.parentFile, ".env") 
    val properties = Properties()

    if (envFile.exists()) {
        envFile.forEachLine { line ->
            if (line.isNotBlank() && !line.trimStart().startsWith("#")) {
                val parts = line.split("=", limit = 2)
                if (parts.size == 2) {
                    val key = parts[0].trim()
                    val value = parts[1].trim()
                    properties[key] = value.removePrefix("\"").removeSuffix("\"").removePrefix("'").removeSuffix("'")
                }
            }
        }
    } else {
        logger.lifecycle("WARNING: .env file not found at ${envFile.absolutePath}. Environment variables will not be loaded from it.")
    }
    return properties
}

val dotEnvProperties = loadDotEnv(project.rootDir) 
fun getDotEnvProperty(key: String): String {
    return dotEnvProperties.getProperty(key) ?: error("Property '$key' not found in .env file or system environment.")
}

android {
    namespace = "com.example.test"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.test"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        manifestPlaceholders["googleMapsApiKey"] = getDotEnvProperty("GOOGLE_MAPS_API_KEY")
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
