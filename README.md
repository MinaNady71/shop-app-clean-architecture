# flutter_advanced_clean_architecture

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---------------------------------------------------MinaMakin------------------------------------------------------------------------

steps to create app with clean architecture 
1- create dart file response
2- and add it to app service client 
3- go to mapper
4- repository in domain layer // note we create it because we want to implement it in use case
5- create use case.dart in domain
6- remote data source
7- repositoryImpl in data layer
8- view model 
9- di dependency injection
10- add it to rote manager


---------------------------
we will create instance from view model in view 
    -> we created instance from usecase in view model 
      -> we created instance from repository in useCase.dat 
        -> we implemented repository in repositoryImpl and then we created instance from remote data source 
          ->  we implemented remote data source in remote data source impl and then we created instance from app crevice client



