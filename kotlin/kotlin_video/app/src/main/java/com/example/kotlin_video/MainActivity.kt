package com.example.kotlin_video


import android.net.Uri
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.MediaController
import android.widget.TextView
import android.widget.VideoView
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.floatingactionbutton.FloatingActionButton
import java.time.LocalDateTime
import java.time.Duration

class MainActivity : AppCompatActivity() {
    var start = 2
    var end = 100000

    // declaring a null variable for VideoView
    var simpleVideoView: VideoView? = null

    // declaring a null variable for MediaController
    var mediaControls: MediaController? = null

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val fabAdd: FloatingActionButton = findViewById(R.id.idFABAdd)
        fabAdd.setOnClickListener() {
            Log.i("MyApp", "Hello")
            // Call battery manager service
            val bm = applicationContext.getSystemService(BATTERY_SERVICE) as BatteryManager
            // Get the battery percentage and store it in a INT variable
            val batLevel: Int = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
            val startTime = LocalDateTime.now();

            simpleVideoView = findViewById<View>(R.id.simpleVideoView) as VideoView

            if (mediaControls == null) {
                // creating an object of media controller class
                mediaControls = MediaController(this)

                // set the anchor view for the video view
                mediaControls!!.setAnchorView(this.simpleVideoView)
            }

            // set the media controller for video view
            simpleVideoView!!.setMediaController(mediaControls)

            simpleVideoView!!.setVideoURI(
                Uri.parse("android.resource://"
                    + packageName + "/" + R.raw.video_example))

            simpleVideoView!!.setOnPreparedListener { e ->
                simpleVideoView!!.start()
                val endTime = LocalDateTime.now()
                val timeTV: TextView = findViewById(R.id.timeTV)

                timeTV.text = Duration.between(startTime, endTime).toMillis().toString()
            }

            // starting the video
        }
    }


}