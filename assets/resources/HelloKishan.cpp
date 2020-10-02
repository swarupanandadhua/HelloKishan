AdMob { // App ID: ca-app-pub-8285249568639559~5250421163
    1. Create AdMob app , get App ID.
    2. Create ad unit.
    3. ENable user metrics
    4. Link AdMob app to firebase app.
    5. Add AdMob App ID to AndroidManifest.xml
}

Authenticating Your Client { // https://developers.google.com/android/guides/client-auth
    https://developer.android.com/studio/publish/app-signing
    TAGS: SHA1, keytool, OAuth2

    Get debug certificate fingerprint {
        Generate : keytool -genkey -v -keystore ~/.android/debug.keystore -storepass android -alias androiddebugkey -keypass android -keyalg RSA -keysize 2048 -validity 10000
        Print : keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore
        // default password: android
        // ~/.android/debug.keystore will be automatically generated. Delete it & build to get a new SHA1.
        // add the SHA1 to the project
        // download the google-services.json
    }
    // Similar for release key also
}

Release {
    https://flutter.dev/docs/deployment/android#shrinking-your-code-with-r8
    flutter build apk --split-per-abi
}

adb {
    /c/Users/swarupan/AppData/Local/Android/Sdk/platform-tools/adb
    adb install [-s] example.apk // -s installs on the SD Card
}

Finance {
    NFX Guild - digital network & marketplace
    CrunchBase - Place for companies & investores
}

Vision & Mission {
    Vision  : To provide access to buy and sell agricultural products in 1 click
    Mission :   1. To balance out price difference in the agricultural market
                2. To maximize the gain of Farmers and minimize the hassle
                3. To minimize the expense of a household on vegetables
}

4 pillars of a company {
    Engineering (Frontend, Backend, Security, Data Science)
    Sales   ----------------handles customer, complaints etc
    Marketing --------------brings customers
    Operations --------------Lawyers, Accountants, HR
}

MISTAKE 1 Already doing {
    Focusing on little details of the app.
    REMEDY: Focus on the general flow of the app i.e. making the deal online
}

Django : https://www.django-rest-framework.org/

Django 1 { // https://dev.to/amartyadev/flutter-app-authentication-with-django-backend-1-21cp
    Django REST Framework(DRF) : PostgreSQL in Django + SQLite in Frontend

    BLoC works on sinks and streams: The widgets monitor state changes & send them to BloC using sinks & other widgets monitor those by subscribing to streams.

    Go to the desired folder & activate virtual environment : https://docs.python.org/3/library/venv.html

    STEP1: // Making project & app
        `django-admin startproject project_name` # create project
        `cd project_directroy`
        `python manage.py startapp app_name` # create an app

    STEP2: // Installing REST
        `pip install djangorestframework`   # Install DRF
        ...

    STEP3: // Exposing Endpoints

    Accessing your API:
}

Django 2 { // https://dev.to/amartyadev/flutter-signup-login-application-with-django-backend-2-4kn5
    Host your application:
        Option 1 : on a VPS (you need to configure gunicorn and Nginx)
            https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu-18-04
        Option 2 : Heroku

    Hosting your application on Heroku:
}

Django 3 { // https://dev.to/amartyadev/flutter-signup-login-application-with-django-backend-3-oo2

}

Send Notification on Data change in firebase Database : https://www.youtube.com/watch?v=lL_HaaPbMF4

Firebase Cloud Functions {
    Install Node.JS // https://nodejs.org/en/about/
    Install Firebase Command Line Tools using npm : `npm install -g firebase-tools`  #npm stands for Node Package Manager
    Login to Firebase from CLI : `firebase login`
    Initialize a project : `firebase init` // Need to delete firestore.json and .firebaserc to init in an existing directory
    Deploy Project : `firebase deploy [--only functions] [--only "functions:func_name"]
}

Firebase Extentions {
    Resize Images { // Installed
        Cloud Functions {
            generateResizedImage
        }
    }
    Translate Text {

    }
}