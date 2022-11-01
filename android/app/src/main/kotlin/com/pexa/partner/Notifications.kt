//package com.pexa.partner
//
//import android.app.Notification
//import android.app.NotificationChannel
//import android.app.NotificationManager
//import android.content.Context
//import android.os.Build
//import androidx.core.app.NotificationCompat
//
//object Notifications {
//    const val NOTIFICATION_ID_BACKGROUND_SERVICE = 1
//
//    private const val CHANNEL_ID_BACKGROUND_SERVICE = "default"
//
//    fun createNotificationChannels(context: Context) {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            val channel = NotificationChannel(
//                getString(R.string.default_notification_channel_id),
//                "High Importance Notifications",
//                NotificationManager.IMPORTANCE_HIGH
//            ).also {
//
//                it.setSound(Uri.parse("android.resource://${packageName}/${R.raw.notification}"), it.audioAttributes)
//            }
//            val manager =
//                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
//            manager.createNotificationChannel(channel)
//        }
//    }
//
//    fun buildForegroundNotification(context: Context): Notification {
//        return NotificationCompat
//            .Builder(context, CHANNEL_ID_BACKGROUND_SERVICE)
//            .setSmallIcon(R.mipmap.ic_launcher)
//            .setContentTitle("High Importance Notifications")
//            .setContentText("Keeps app process on foreground.")
//            .build()
//    }
//}