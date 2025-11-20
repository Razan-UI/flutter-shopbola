NOTES:
untuk Changes di Project Django, terletak di repository sebelumnya (kakibola)
(it doesnt allow me to commit the Django folder from local into this repository and so, its synced with the old repository)




<!-- <!-- # flutter-shopbola

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

 -->


Tugas 8

1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
Ans: 
    Navigator.push() menambahkan route baru di paling atas stack navigasi yang ada sehingga user dapat "undo" atau kembali ke halaman sebelum via 'back button' sedangkan Navigator.pushReplacement() menggantikan route paling atas stack dengan route terbaru, sehingga 'history' terbaru dari stack hilang dan user tidak dapat kembali ke halaman tepat sebelum. 

    Pada saat ini, Navigator.push() digunakan untuk navigasi dari homepage ke page create product dan vice versa agar user dapat kembali ke halaman sebelumnya (tidak ada webpage yang memiliki info sensitif/temporary webpages dimana suatu webpage hanya diload sekali) sedangkan Navigator.pushReplacement() belum digunakan, tetapi kemungkinan besar akan berguna jika suatu sistem Checkout diimplementasi (user tidak boleh kembali ke page Checkout jika sudah melakukan pembayaran)

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
Ans:
    -Scaffold digunakan sebagain dasar struktur halaman (via penyediaan Material Design) yang digunakan untuk mengelola AppBar, Body, Drawer, dll
    - AppBar digunakan pada setiap halaman (2 Total) untuk menampilkan judul halaman, mengubah tampilan bagian atas halaman, dan meng-stylize text di bagian atas halaman
    - Drawer digunakan sebagai alat navigasi global yang dapat diakses oleh semua halaman

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
Ans:
    Layout Widget memungkinkan konfigurasi antar elemen dalam suatu form dengan mudah. Padding berguna untuk mengatur jarak antar-elemen. SingleChildScrollView digunakan untuk memastikan bahwa user dapat mengakses semua field di form jika isi dari form tersebut melebihi size dari display. ListView digunakan untuk menunjukkan list dari child widgets dengan linear, berguna untuk mendisplay item yang memiliki jumlah banyak. Layout Widget digunakan di projek ini pada file productlist_form.dart untuk menampilkan semua form field pada page tersebut dan memastikan bahwa pengalaman user terasa lebih responsif (i.e jika tidak ada SingleChildScrollView, user yang menambah produk dengan deskripsi panjang tidak dapat menavigasi deskripsi tersebut via scroll wheel)
    implementation:  child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === Title ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Product Name",
                        labelText: "Product Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _name = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Product Name Cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),

                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Price",
                        labelText: "Price",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _price = int.parse(value);
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Price cannot be empty";
                        }
                        if (int.tryParse(value) == null || int.parse(value) <= 0) {
                          return "Price must be a valid number greater than 0";
                        }
                        return null;
                      },
                    ),
                  ),
                                  // === Content ===
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Product Description",
                        labelText: "Product Description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _description = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Product Description cannot be empty!";
                        }
                        return null;
                      },
                    ),
                  ),
    
    4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Ans: 
    Saya menggunakan primary color scheme dengan:
     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
         .copyWith(secondary: Colors.blueAccent[400]),
    yang terdapat di main.dart, dimana color scheme tersebut akan dapat diakses oleh semua page di projek ini. Pada appBar productlist_form.dart, saya mengimplementasi color inherit via,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    agar header/appbar dari page form ini akan menggunakan secondary theme dari proyek ini, sehingga tema overall dari app ini dapat menjadi konsisten.
     -->

Tugas 9:
1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, 
Ans:
  Karena Dart bersifat type safe dan akan memastikan apakah data yang diakses memiliki tipe yang benar dan mencegah kecelakaan dimana data tertentu diolah menjadi tipe data yang lain (i.e int processed as a String, preventing + operators working mathematically) Jika tidak membuat model, hal yang tadi disebut dapat terjadi

2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
Ans:
  CookieRequest lebih advanced dan dapat mengelola cookies secara otomatis dan memiliki state persistence dimana cookies tsb akan disimpan di dalam device storage. Selain itu, cookierequest bersifat stateful dan tahu jika user sudah login atau belum.Di sisi lain, http perlu mengelola cookies secara manual dan tidak memiliki state. (CookieRequest digunakan untuk create product pada tugas ini dan akan memverifikasi apakah user yang membuat produk sudah diotentikasi atau belum)

3.Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Ans:
  Agar semua komponen mengerti bahwa user telah login di sesi tersebt dan memverifikasi kondisi user (apakah mereka masih authenticated atau tidak)

4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
Ans:
  10.0.2.2 perlu ditambahkan karena android emulator memerlukan akses khusus ke projek ini (utk server django, perlu 127.00:8000 atau semacamnya), CORS berupa mekanisme keamanan browser yang membatasi request dari origin yang berbeda, jika tidak ada, browser akan memblock request. SameSite digunakan untuk session persistence agar state authenticated/login tertahan di semua page aplikasi. Izin internet diperukan karena Android memerlukan permission khusus agar aplikasi dapat dihubungkan, jika tidak ada, android emulator akan tidak dapat mengakses aplikasi.

5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
Ans:
  Input -> Flutter validation dan check otentikasi -> Serialize dari Dart obj ke JSON -> HTTP Request ke Django w/ session cooki -> Django akan parse JSON, validate data tsb, dan akan create entry baru di models, Python objects akan diserialize balik ke JSON, -> HTTP Response ke Flutter -> Display via render widgets

6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
Ans: Register, create user baru di database -> Login, credentials divalidasi dan session cookie akan dibuat dan disimpan -> Cookies akan dikirim di setiap request setelah sudah diotentikasi -> Saat logout, session didelete dan cookies diclear/hilangkan

7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step!
Ans:
  1. Membuat model Dart untuk JSON via QuickType.io utk product_entry.dart
  2. Setup Django backend utk Flutter di settings.py dengan corsheaders dan session cookies
  3. Implement login, register, dan logout di authentication app dengan Django authenticate dan mereturn JSONResponse agar flutter dapat memprosesnya, di Flutter, flutter akan mem-parse data tsb agar dapat diproses sebagai Dart object.
  4. 
