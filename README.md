# flutter-shopbola

1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
    Ans: Widgets themselves are what make up a flutter app's UI. A widget tree is a tree structure where each node is a widget which will determine how the app's UI is going to be displayed. These widgets are arranged hierarchically and can form a parent-child relationship. 
    Parent widgets provide structure, organize child widgets, and passes data to Children through constructor parameters. On the other hand, child widgets add visual or functional elements for the app.




2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
    Ans: MyApp (on main.dart) : Controls the primary and secondary color scheme of the app
    - MyHomePage: Main page that displays the greeting text, AppBar, and grid items.
    - ItemCard: Shows the buttons {All Products, My Products, Create Products} alongside their respective icons, names, and colors.
    - AppBar: Displays the title of the app at the top section of the screen
    - SnackBar: Displays temporary notification at the bottom section of the screen upon clicking specific buttons
    - Material: Provides visual and behavioral characteristics of Material Design elements to its children. (Such as the Color attribute used for the buttons)
    - MaterialApp: Root widget that provides the Material Design theme


3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
     Ans: In essence, MaterialApp provides the overall structure and base configuration for the entirety of the application. It is mostly used as the root widget since it is able to manage top-level navigation systems/routing for different pages. In this project's case, it sets MyHomePage() as the default webpage (the home page) of the application. Moreover, it also provides a centralized theme system that can be accessed by all of its child widgets via usage of 'Theme.of(context)'. In addition, it can also be used to control the language of the application and control the title of the app.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
    Ans: StatelessWidget: Immutable, Only has itself as an object, static display once rendered
    StatefulWidget: Mutable, has a State object that controls its state, Changes dynamically once rendered, has setState() method to change its state.
    Stateless is used on elements that won't change over the course of the application's usage, such as Text and Icons. Specifically, things like titles or descriptions. On the other hand, StatefullWidgets are used when we want the elements to be interactive or have dynamic data/animation such as a Timer or Progress Bar.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
    Ans: 
    BuildContext is an object that stores info related to a widget's location in the Widget Tree (Tl;dr it is a reference to a widget). It enables widgets to find and access its parents' characteristics. in this project's case, it is used in the build method to access the app's primary colors, access the screen's width, and to display SnackBars.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
    Ans:
    -Hot Reload: Renders code changes into a Virtual Machine and reconstructs the Widget Tree while maintaining the application's state. Extremely fast and will only run the build() method. Very useful for displaying widget-related changes quickly without restarting the entire application.
    -Hot Restart: Similar to Hot Reload, it renders code changes into a VM but its restarts the application from the start, erasing any and all states that were saved. main() and initState() will be run upon doing it.
