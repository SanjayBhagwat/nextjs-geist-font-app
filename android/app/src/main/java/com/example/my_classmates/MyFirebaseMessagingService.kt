package com.example.my_classmates

import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class MyFirebaseMessagingService : FirebaseMessagingService() {
    
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
        
        // Handle FCM messages here
        remoteMessage.notification?.let {
            // Handle notification
            val title = it.title
            val body = it.body
            // You can show notification here
        }
    }
    
    override fun onNewToken(token: String) {
        super.onNewToken(token)
        // Handle token refresh
    }
}
