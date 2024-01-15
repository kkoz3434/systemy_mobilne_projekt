package com.example.kotlin_animation


import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.animation.Animation
import android.view.animation.AnimationUtils
import android.widget.ImageView
import android.widget.MediaController
import android.widget.TextView
import android.widget.VideoView
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.floatingactionbutton.FloatingActionButton
import java.time.Duration
import java.time.LocalDateTime


class MainActivity : AppCompatActivity() {
    var start = 2
    var end = 100000

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

            val image : ImageView = findViewById(R.id.imageView)

            val rotation = AnimationUtils.loadAnimation(this, R.anim.rotate)

            image.animation = rotation

            image.animation.setAnimationListener(object: Animation.AnimationListener{
                override fun onAnimationStart(animation: Animation?) {

                }

                override fun onAnimationEnd(animation: Animation?) {
                    Log.i("MyApp", "END OF ANIMATION")
                    val endTime = LocalDateTime.now()
                    val timeTV: TextView = findViewById(R.id.timeTV)

                    timeTV.text = Duration.between(startTime, endTime).toMillis().toString()
                }

                override fun onAnimationRepeat(animation: Animation?) {
                }

            })
            image.startAnimation(rotation)

//            val endTime = LocalDateTime.now()
//            val timeTV: TextView = findViewById(R.id.timeTV)
//
//            timeTV.text = Duration.between(startTime, endTime).toMillis().toString()


            // starting the video
        }
    }


}