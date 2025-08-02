
# Existing dontwarns (keep them)
-dontwarn com.google.android.play.core.**
-dontwarn com.google.api.client.http.**
-dontwarn io.sentry.android.**
-dontwarn org.bouncycastle.**
-dontwarn org.conscrypt.**
-dontwarn org.joda.time.**
-dontwarn org.openjsse.**

# New keep rules
-keep class com.google.android.play.core.** { *; }
-keep class com.google.api.client.http.** { *; }
-keep class io.sentry.** { *; }
-keep class org.bouncycastle.** { *; }
-keep class org.conscrypt.** { *; }
-keep class org.joda.time.** { *; }
-keep class org.openjsse.** { *; }
