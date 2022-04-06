package com.bondidos.wot_statistic

import android.content.res.Configuration
import android.content.res.Configuration.UI_MODE_NIGHT_YES
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            when(call.method){
                GET_THEME -> {
                    result.success(if(isDarkThemeOn())  DARK_THEME else LIGHT_THEME)
                }
            }
            result.error("UNAVAILABLE", "Platform error", null)
        }
    }

    private fun isDarkThemeOn(): Boolean{
        return resources.configuration.uiMode and
                Configuration.UI_MODE_NIGHT_MASK == UI_MODE_NIGHT_YES
    }

    companion object{
       private const val CHANNEL = "com.bondidos.wot_statistic/theme"
        const val DARK_THEME = "Dark"
        const val LIGHT_THEME = "Light"
        const val GET_THEME = "getTheme"
    }
}
