
# Preparation

Android Studio: Disable Format on Save

# Screens:

1. Presentation, FullScreen
2. Vysor, Android Studio, Terminal
3. Chrome, pub.dev

(2nd Screen: Finder, VisualStudio Code)

# Terminal:

flutter --version
flutter create myapp

# Android Studio:

Open myapp folder

Run app

Enable KeyCastr (Option, CMD, K)

# Vysor

Switch to myapp

# Android Studio

Open Project Explorer

Explain Directories
- lib
- android/ios/web
- pubspec.yaml

# Slides

What is a Widget?

# Android Studio

Go over generated code

- void main() -> Entrypoint into App
- MyApp Widget
- Theme
- MyHomePage -> Stateful Widget

Show Widget Inspector

## Coding

=> Material App
debugShowCheckedModeBanner: false,

=> ThemeData
scaffoldBackgroundColor: Colors.grey.shade300,

=> HomePage.Scaffold
body: Placeholder(),

bottomNavigationBar: BottomNavigationBar(
  items: [
    // cats
    // favorites
  ],
),

BottomNavigationBarItem(
  label: "Cats",
  icon: Icon(Icons.style),
),

BottomNavigationBarItem(
  label: "Favorites",
  icon: Icon(Icons.favorite),
),

int pageIndex = 0;

currentIndex: pageIndex,
onTap: (index) {
  
},

setState(() {
  pageIndex = index;
});

body: Text("$pageIndex"),


# Slides

Basic Widgets

# Android Studio

body: pageIndex == 0
    ? Container(color: Colors.blue)
    : Container(color: Colors.red),

? CardStackPage()

[type] stless -> CardStackPage

## package.yml

swipe_stack: ^1.0.0
http: ^0.13.0

## main.dart

[type] SwipeStack(children: [])

List<dynamic> images = [];

[generate] void initState()

get(
  Uri.parse("https://api.thecatapi.com/v1/images/search?format=json&mime_types=jpg&limit=100"),
  headers: {"x-api-key": "0e9baaca-e7a5-435f-bcef-62505b79f53c"},
).then((result) {
  // TODO parse result into images
});

List<dynamic> catImages = jsonDecode(result.body);
setState(() {
  images = catImages;
});

children: images.map((image) {
  // TODO return image widget        
}).toList(),

return SwiperItem(builder: (position, progress) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.network(
      image["url"],
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    ),
  );
});

[wrap] Container(height: 600)
[wrap] Center()

onSwipe: (index, position) {

},

if (position == SwiperPosition.Right) {
  // TODO favorite image
} else if (position == SwiperPosition.Left) {
  // TODO discard image
}

List<dynamic> favorites = [];

void favorite(int index) {
  setState(() {
    var image = images.removeAt(index);
    favorites.add(image);
  });
}

void skip(int index) {
  setState(() {
    images.removeAt(index);
  });
}

[type] 
context.findAncestorStateOfType<_MyHomePageState>().favorite(index);
context.findAncestorStateOfType<_MyHomePageState>().skip(index);

[type] stless -> FavoritesPage

: FavoritesPage(favorites),

final List<dynamic> favorites;

[generate] FavoritesPage(this.favorites);

return ListView(
  children: [
    
  ],
);

children: favorites.map((i) {
  return Image.network(
    i["url"],
    fit: BoxFit.cover,
  );
}).toList(),


# IF TIME

[wrap] Column(children: ...)

mainAxisSize: MainAxisSize.min,

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

  ],
),

IconButton(
  color: Colors.red,
  icon: Icon(Icons.close),
  onPressed: () {
    
  },
),

IconButton(
  color: Colors.green,
  icon: Icon(Icons.check),
  onPressed: () {
    
  },
),

context.findAncestorStateOfType<_MyHomePageState>().skip(images.length - 1);

context.findAncestorStateOfType<_MyHomePageState>().favorite(images.length - 1);

# END

flutter build apk