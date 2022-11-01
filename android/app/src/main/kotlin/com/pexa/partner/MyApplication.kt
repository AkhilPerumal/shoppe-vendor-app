//
//package com.pexa.partner
//
//import android.app.Notification
//import android.app.NotificationChannel
//import android.app.NotificationManager
//import android.content.Context
//import android.os.Build
//import androidx.core.app.NotificationCompat
//
//class MyApplication : FlutterApplication(), PluginRegistrantCallback {
//    override fun onCreate() {
//        super.onCreate()
//        this.registerChannel();
//        FlutterFirebaseMessagingService.setPluginRegistrant(this)
//    }
//
//    override fun registerWith(registry: PluginRegistry) {
//        GeneratedPluginRegistrant.registerWith(registry)
//    }
//
//
//    @TargetApi(Build.VERSION_CODES.O)
//    private fun registerChannel(){
//        val channel: NotificationChannel = NotificationChannel(
//            getString(R.string.default_notification_channel_id),
//            "CiggyGhar Delivery",
//            NotificationManager.IMPORTANCE_HIGH
//        ).also {
//
//            it.setSound(Uri.parse("android.resource://com.pexa.partner/${R.raw.notification}"), it.audioAttributes)
//        }
//        val manager:NotificationManager = getSystemService(NotificationManager::class.java) as NotificationManager
//        manager.createNotificationChannel(channel)
//    }
//}