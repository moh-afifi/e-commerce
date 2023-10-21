
# Wssal

 This is an e-commerce app fully implemented using Dart programming language and Flutter framework.

## Framework Used:

Flutter was chosen for the following reasons:

    1- Flutter has a very good reputation in the cross-platform mobile development as we can build native-like performance mobile apps.
    2- Flutter has a very powerful commumnity which makes support much easier.
    3- Flutter has thousands of packages which makes app development much faster.
    4- Flutter has become more reliable in today's market and a lot of companies use flutter in large-scale mobile apps.
    5- Flutter saves a lot of time as we can build multi-paltform app using one single code-base.
    6- Flutter is open-source which makes it easier to understand deeper how code works and customize it if needed.

- Potential Drawbacks:
 
    1- Flutter apps have high performance but not as high as native apps (However, the difference is not big).
  
    2- Flutter uses Dart which is not widely used as many other languages.
  
    3- App size is a bit larger than native apps.

## Code Overview:

- This app conforms to the MVC pattern whic has three layers ( Model, View, controller)
- The code-base is well-organized using features and every feature conforms to the MVC pattern.
- A folder named "core" contains all the core files like, API-handler, common models, common widgtes, theme files,...etc.
- Main features included in the app:

    1- Login, register, forgot password
 
    2- Categories , sub-categories
  
    3- Brands
  
    4- Best Seller products
  
    5- Discount Products

    6- Offers
  
    7- Cart
  
    8- Favorites
  
    9- Orders (current, previous)
  
    10- Support
  
    11- Notifications (using Firebase Cloud Messaging FCM)
  
    12- Addresses
  
    13- Search for products

## Improvement Areas: 

- Add localization files for the app to supprt multiple languages (not only Arabic).
- Add navigator file to handle all app navigations in one single file.
- Edit the global error file to display error messages coming from back-end side. 

## How to run the code:
- Install Android studio and the setup the flutter SDK.( you can follow this link: https://docs.flutter.dev/get-started/install)
- Open the terminal and write the following commands:

    1- flutter pub get

    2- flutter run --flavor wssal

- Note that this app contains two flavors: one for releases and the other one is for demo.
- Also note that the base url in the project is for test-purposes and not a production one.

## Login Credentials:

To use the app with an authenticated test-user, use the following credentials:

- phone: 01020456040
- password: 123456
- 
## APK url: 

To download a direct APK file for android, use the this link: https://drive.google.com/file/d/1KNWoNAozYuSoiNslOeVIle0-yAoTxy_x/view?usp=share_link
