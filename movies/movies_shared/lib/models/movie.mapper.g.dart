import 'package:dart_mappable/internals.dart';

import 'movie.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  MovieMapper._(),
  MovieRatingMapper._(),
  // enum mappers
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class MovieMapper extends BaseMapper<Movie> {
  MovieMapper._();

  @override Function get decoder => decode;
  Movie decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Movie fromMap(Map<String, dynamic> map) => Movie(map.get('id'), map.get('name'), map.get('genre'), map.get('ratings'));

  @override Function get encoder => (Movie v) => encode(v);
  dynamic encode(Movie v) => toMap(v);
  Map<String, dynamic> toMap(Movie m) => {'id': Mapper.toValue(m.id), 'name': Mapper.toValue(m.name), 'genre': Mapper.toValue(m.genre), 'ratings': Mapper.toValue(m.ratings)};

  @override String? stringify(Movie self) => 'Movie(id: ${Mapper.asString(self.id)}, name: ${Mapper.asString(self.name)}, genre: ${Mapper.asString(self.genre)}, ratings: ${Mapper.asString(self.ratings)})';
  @override int? hash(Movie self) => Mapper.hash(self.id) ^ Mapper.hash(self.name) ^ Mapper.hash(self.genre) ^ Mapper.hash(self.ratings);
  @override bool? equals(Movie self, Movie other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.name, other.name) && Mapper.isEqual(self.genre, other.genre) && Mapper.isEqual(self.ratings, other.ratings);

  @override Function get typeFactory => (f) => f<Movie>();
}

extension MovieMapperExtension  on Movie {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  MovieCopyWith<Movie> get copyWith => MovieCopyWith(this, $identity);
}

abstract class MovieCopyWith<$R> {
  factory MovieCopyWith(Movie value, Then<Movie, $R> then) = _MovieCopyWithImpl<$R>;
  ListCopyWith<$R, MovieRating, MovieRatingCopyWith<$R>> get ratings;
  $R call({String? id, String? name, String? genre, List<MovieRating>? ratings});
  $R apply(Movie Function(Movie) transform);
}

class _MovieCopyWithImpl<$R> extends BaseCopyWith<Movie, $R> implements MovieCopyWith<$R> {
  _MovieCopyWithImpl(Movie value, Then<Movie, $R> then) : super(value, then);

  @override ListCopyWith<$R, MovieRating, MovieRatingCopyWith<$R>> get ratings => ListCopyWith($value.ratings, (v, t) => MovieRatingCopyWith(v, t), (v) => call(ratings: v));
  @override $R call({String? id, String? name, String? genre, List<MovieRating>? ratings}) => $then(Movie(id ?? $value.id, name ?? $value.name, genre ?? $value.genre, ratings ?? $value.ratings));
}

class MovieRatingMapper extends BaseMapper<MovieRating> {
  MovieRatingMapper._();

  @override Function get decoder => decode;
  MovieRating decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  MovieRating fromMap(Map<String, dynamic> map) => MovieRating(map.get('rating'), map.get('author'));

  @override Function get encoder => (MovieRating v) => encode(v);
  dynamic encode(MovieRating v) => toMap(v);
  Map<String, dynamic> toMap(MovieRating m) => {'rating': Mapper.toValue(m.rating), 'author': Mapper.toValue(m.author)};

  @override String? stringify(MovieRating self) => 'MovieRating(rating: ${Mapper.asString(self.rating)}, author: ${Mapper.asString(self.author)})';
  @override int? hash(MovieRating self) => Mapper.hash(self.rating) ^ Mapper.hash(self.author);
  @override bool? equals(MovieRating self, MovieRating other) => Mapper.isEqual(self.rating, other.rating) && Mapper.isEqual(self.author, other.author);

  @override Function get typeFactory => (f) => f<MovieRating>();
}

extension MovieRatingMapperExtension  on MovieRating {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  MovieRatingCopyWith<MovieRating> get copyWith => MovieRatingCopyWith(this, $identity);
}

abstract class MovieRatingCopyWith<$R> {
  factory MovieRatingCopyWith(MovieRating value, Then<MovieRating, $R> then) = _MovieRatingCopyWithImpl<$R>;
  $R call({int? rating, String? author});
  $R apply(MovieRating Function(MovieRating) transform);
}

class _MovieRatingCopyWithImpl<$R> extends BaseCopyWith<MovieRating, $R> implements MovieRatingCopyWith<$R> {
  _MovieRatingCopyWithImpl(MovieRating value, Then<MovieRating, $R> then) : super(value, then);

  @override $R call({int? rating, String? author}) => $then(MovieRating(rating ?? $value.rating, author ?? $value.author));
}


// === GENERATED ENUM MAPPERS AND EXTENSIONS ===




// === GENERATED UTILITY CODE ===

class Mapper {
  Mapper._();

  static late MapperContainer i = MapperContainer(_mappers);

  static T fromValue<T>(dynamic value) => i.fromValue<T>(value);
  static T fromMap<T>(Map<String, dynamic> map) => i.fromMap<T>(map);
  static T fromIterable<T>(Iterable<dynamic> iterable) => i.fromIterable<T>(iterable);
  static T fromJson<T>(String json) => i.fromJson<T>(json);

  static dynamic toValue(dynamic value) => i.toValue(value);
  static Map<String, dynamic> toMap(dynamic object) => i.toMap(object);
  static Iterable<dynamic> toIterable(dynamic object) => i.toIterable(object);
  static String toJson(dynamic object) => i.toJson(object);

  static bool isEqual(dynamic value, Object? other) => i.isEqual(value, other);
  static int hash(dynamic value) => i.hash(value);
  static String asString(dynamic value) => i.asString(value);

  static void use<T>(BaseMapper<T> mapper) => i.use<T>(mapper);
  static BaseMapper<T>? unuse<T>() => i.unuse<T>();
  static void useAll(List<BaseMapper> mappers) => i.useAll(mappers);

  static BaseMapper<T>? get<T>([Type? type]) => i.get<T>(type);
  static List<BaseMapper> getAll() => i.getAll();
}

mixin Mappable {
  BaseMapper? get _mapper => Mapper.get(runtimeType);

  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);

  @override String toString() => _mapper?.stringify(this) ?? super.toString();
  @override bool operator ==(Object other) => identical(this, other) ||
      (runtimeType == other.runtimeType && (_mapper?.equals(this, other) 
      ?? super == other));
  @override int get hashCode => _mapper?.hash(this) ?? super.hashCode;
}

extension MapGet on Map<String, dynamic> {
  T get<T>(String key, {MappingHooks? hooks}) => _getOr(
      key, hooks, () => throw MapperException('Parameter $key is required.'));

  T? getOpt<T>(String key, {MappingHooks? hooks}) =>
      _getOr(key, hooks, () => null);

  T _getOr<T>(String key, MappingHooks? hooks, T Function() or) =>
      hooks.decode(this[key], (v) => v == null ? or() : Mapper.fromValue<T>(v));
}
