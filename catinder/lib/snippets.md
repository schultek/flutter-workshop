
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

swipable_stack: ^2.0.0
http: ^0.13.0

## main.dart

[type] SwipableStack(builder: (context, props) {})

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

var image = widget.images[props.index];
return ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: Image.network(
    image["url"],
    width: double.infinity,
    height: double.infinity,
    fit: BoxFit.cover,
  ),
);

[wrap] Container(height: 600)
[wrap] Center()

itemCount: widget.images.length,

controller: SwipableStackController(),
stackClipBehaviour: Clip.none,

onSwipeCompleted: (index, direction) {

},

if (direction == SwipeDirection.right) {
  // TODO favorite image
}

List<dynamic> favorites = [];

void favorite(int index) {
  setState(() {
    var image = images[index];
    favorites.add(image);
  });
}

[type] 
context.findAncestorStateOfType<_MyHomePageState>().favorite(index);

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

SwipableStackController controller = SwipableStackController();

controller.next(swipeDirection: SwipeDirection.left);

controller.next(swipeDirection: SwipeDirection.right);

# END

flutter build apk