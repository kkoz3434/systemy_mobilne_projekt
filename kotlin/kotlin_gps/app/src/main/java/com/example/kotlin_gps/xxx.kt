//=import android.content.Context
//import android.location.Location
//import com.google.android.gms.location.FusedLocationProviderClient
//import com.google.android.gms.location.LocationServices
//import java.util.concurrent.CountDownLatch
//
//class LocationTest(private val context: Context) {
//    private lateinit var locationClient: FusedLocationProviderClient
//    private lateinit var latch: CountDownLatch
//
//    fun startTest() {
//        locationClient = LocationServices.getFusedLocationProviderClient(context)
//        repeat(1000) {
//            latch = CountDownLatch(1)
//            requestLocation()
//            try {
//                latch.await() // Wait for the location callback
//            } catch (e: InterruptedException) {
//                e.printStackTrace()
//            }
//        }
//    }
//
//    private fun requestLocation() {
//        locationClient.lastLocation
//            .addOnSuccessListener { location: Location? ->
//                location?.let {
//                    val timeTaken = System.currentTimeMillis() // Process the location fix time
//                    // Store or process timeTaken and location data
//                }
//                latch.countDown() // Signal that the location request is complete
//            }
//            .addOnFailureListener {
//                // Handle failure
//                latch.countDown()
//            }
//    }
//}
//
