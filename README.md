Summary

    CookBook App is a cross-platform mobile application built with Flutter. This application is your ultimate companion for discovering and mastering the rich heritage of Vietnamese recipes****

### User Interfaces

|                             Screen                              |                          Screen                           |                                Screen                                 |                               Screen                               |                               Screen                               |
|:---------------------------------------------------------------:|:---------------------------------------------------------:|:---------------------------------------------------------------------:|:------------------------------------------------------------------:|:------------------------------------------------------------------:|
|    <img src="lib/assets/ui_pictures/login.png" width="160">     | <img src="lib/assets/ui_pictures/signup.png" width="160"> | <img src="lib/assets/ui_pictures/signup-with-google.png" width="160"> | <img src="lib/assets/ui_pictures/forgot-password.png" width="160"> | <img src="lib/assets/ui_pictures/change-password.png" width="160"> |
|   <img src="lib/assets/ui_pictures/about-us.png" width="160">   | <img src="lib/assets/ui_pictures/home-1.png" width="160"> |       <img src="lib/assets/ui_pictures/home-2.png" width="160">       |     <img src="lib/assets/ui_pictures/search.png" width="160">      |      <img src="lib/assets/ui_pictures/saved.png" width="160">      |
|   <img src="lib/assets/ui_pictures/profile.png" width="160">    | <img src="lib/assets/ui_pictures/detail.png" width="160"> |    <img src="lib/assets/ui_pictures/preparation.png" width="160">     |  <img src="lib/assets/ui_pictures/cooking-step.png" width="160">   |    <img src="lib/assets/ui_pictures/complete.png" width="160">     |
| <img src="lib/assets/ui_pictures/notification.png" width="160"> |                                                           |                                                                       |                                                                    |                                                                    |


Technologies

    Framework: Flutter (Dart)
    
    Backend: Supabase - Use services like Database, Authentication, Edge Fuctions and Storage.
    
    State Management: Cubit/BLoC
    
    Database: Supabase - Store and manage data efficiently.
    
    Authentication: Supabase Authentication - Manage registration and login securely for users include: Email, Google.

Project Structure

```
lib
├── main.dart        
│
├── assets 
│   ├── images         
│   └── icons  
│
├── core                   
│   ├── themes        
│   └── errors      
│
└── features           
    ├── authentication 
    │   ├── data
    │   │   ├── datasources
    │   │   ├── models   
    │   │   └── repositories
    │   ├── domain
    │   │   ├── entities   
    │   │   ├── repositories
    │   │   └── usecases  
    │   └── presentation
    │       ├── bloc     
    │       ├── pages   
    │       └── widgets
    │
    └── view_recipes 
        ├── data
        │   ├── datasources 
        │   ├── models     
        │   └── repositories
        ├── domain
        │   ├── entities  
        │   ├── repositories
        │   └── usecases  
        └── presentation
            ├── bloc    
            ├── pages     
            └── widgets   
```

