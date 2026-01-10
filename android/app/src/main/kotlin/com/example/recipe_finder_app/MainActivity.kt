package com.example.recipe_finder_app

import android.os.Bundle
import com.google.android.gms.common.ConnectionResult
import com.google.android.gms.common.GoogleApiAvailability
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity(){

    override fun onResume() {
        super.onResume()
        checkPlayServices()
    }

    private fun checkPlayServices(): Boolean {
        val apiAvailability = GoogleApiAvailability.getInstance()
        val resultCode = apiAvailability.isGooglePlayServicesAvailable(this)
        if (resultCode != ConnectionResult.SUCCESS) {
            if (apiAvailability.isUserResolvableError(resultCode)) {
                apiAvailability.getErrorDialog(this, resultCode, 9000)?.show()
            } else {
                finish()
            }
            return false
        }
        return true
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }
}

