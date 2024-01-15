package com.example.kotlin_calculations

import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.TextView
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import com.example.kotlin_calculations.R
import com.google.android.material.floatingactionbutton.FloatingActionButton
import java.time.LocalDateTime
import java.time.Duration

class MainActivity : AppCompatActivity() {
    var start = 2
    var end = 10000

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

            val primes = findPrimeNumbers(start, end)

            val result: TextView = findViewById(R.id.resultTV)
            result.text = "Found ${primes} in range (${start}, ${end})"

            val endTime = LocalDateTime.now()
            val timeTV: TextView = findViewById(R.id.timeTV)

            timeTV.text = Duration.between(startTime, endTime).toMillis().toString()
        }
    }

    fun findPrimeNumbers(start: Int, end: Int): Int {
        val primes = mutableListOf<Int>()
        for (number in start..end) {
            if (isPrime(number)) {
                primes.add(number)
            }
        }
        return primes.size
    }

    fun isPrime(num: Int): Boolean {
        if (num < 2) {
            return false
        }

        for (i in 2 until ((num+2)/2)) {
            if (num % i == 0) {
                return false
            }
        }

        return true
    }

}