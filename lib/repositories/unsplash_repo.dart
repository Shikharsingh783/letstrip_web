import 'dart:developer';
import 'package:letstrip/utils/constants.dart';
import 'package:unsplash_client/unsplash_client.dart';

class UnsplashRepo {
  final UnsplashClient client = UnsplashClient(
    settings: const ClientSettings(
      credentials: AppCredentials(
          accessKey: unsplashAccessKey, secretKey: unsplashSecretKey),
    ),
  );

  Future<List<Photo>> searchImages(String country) async {
    try {
      final List<Photo> photos = await client.photos
          .random(
              query: country,
              count: 5,
              orientation: PhotoOrientation.portrait,
              contentFilter: ContentFilter.low)
          .goAndGet();

      return photos;
    } catch (ex) {
      log(ex.toString());
      return repeatImage(5);
    }
  }

  Future<List<Photo>> searchItineraryImages(String country) async {
    try {
      final List<Photo> photos = await client.photos
          .random(
              query: country,
              count: 2,
              orientation: PhotoOrientation.portrait,
              contentFilter: ContentFilter.low)
          .goAndGet();

      return photos;
    } catch (ex) {
      log(ex.toString());
      return repeatImage(1);
    }
  }

  Future<List<Photo>> searchFoodImages(String country) async {
    try {
      final List<Photo> photos = await client.photos
          .random(
              query: country,
              count: 2,
              orientation: PhotoOrientation.portrait,
              contentFilter: ContentFilter.low)
          .goAndGet();

      return photos;
    } catch (ex) {
      log(ex.toString());
      return repeatImage(2);
    }
  }
  Future<List<Photo>> searchHotelImages(String country) async {
    try {
      final List<Photo> photos = await client.photos
          .random(
              query: country,
              count: 1,
              orientation: PhotoOrientation.portrait,
              contentFilter: ContentFilter.low)
          .goAndGet();

      return photos;
    } catch (ex) {
      log(ex.toString());
      return repeatImage(2);
    }
  }

  List<Photo> repeatImage(int n) {
    List<Photo> result = [];
    for (int i = 0; i > n; i++) {
      result.add(photo);
    }
    return result;
  }

  Photo photo = Photo(
    id: "1234567890",
    createdAt: DateTime.now(),
    // Use DateTime.now() for current time
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    // Simulate update a day ago
    urls: PhotoUrls(
        raw: Uri.parse("https://example.com/photos/raw/1234567890.jpg"),
        full: Uri.parse(
            "https://st.depositphotos.com/2627021/4235/i/450/depositphotos_42357649-stock-photo-blue-earth-globe-isolated-usa.jpg"),
        regular: Uri.parse("https://example.com/photos/raw/1234567890.jpg"),
        small: Uri.parse("https://example.com/photos/raw/1234567890.jpg"),
        thumb: Uri.parse(
            "https://st.depositphotos.com/2627021/4235/i/450/depositphotos_42357649-stock-photo-blue-earth-globe-isolated-usa.jpg")),
    width: 1024,
    height: 768,
    color: "#F0E6C7",
    blurHash: "LEHV6Uxp00JofQozjFj[~qR*00fR",
    // Replace with a real blurHash value if desired
    downloads: 100,
    likes: 52,
    likedByUser: true,
    description: "A beautiful sunset over the mountains.",
    exif: null,
    location: null,
    user: User(
      followerCount: 1,
      followingCount: 1,
      instagramUsername: "",
      totalCollections: 3,
      totalLikes: 434,
      totalPhotos: 3,
      twitterUsername: "",
      updatedAt: DateTime.now(),
      uploadsRemaining: 3,
      lastName: "",
      links: UserLinks(
        self: Uri.parse("uri"),
        html: Uri.parse("uri"),
        photos: Uri.parse("uri"),
        likes: Uri.parse("uri"),
        portfolio: Uri.parse("uri"),
        followers: Uri.parse("uri"),
        following: Uri.parse("uri"),
      ),
      id: "9876543210",
      username: "johndoe",
      bio: "",
      location: "",
      portfolioUrl: Uri.parse("uri"),
      profileImage: ProfileImage(
        small: Uri.parse("uri"),
        medium: Uri.parse("uri"),
        large: Uri.parse("uri"),
      ),
      downloads: 1,
      email: "",
      firstName: "",
      followedByUser: true,
      badge: UserBadge(
          link: Uri.parse("uri"), primary: false, slug: "", title: ""),
      name: "John Doe",
    ),
    currentUserCollections: const [],

    // Replace with a list of Collection objects if applicable
    links: PhotoLinks(
      self: Uri.parse("https://example.com/photos/1234567890/download"),
      html: Uri.parse("https://example.com/photos/1234567890/download"),
      download: Uri.parse("https://example.com/photos/1234567890/download"),
      downloadLocation:
          Uri.parse("https://example.com/photos/1234567890/download"),
    ),
    tags: const [
      Tag(title: "sunset"),
      Tag(title: "mountains"),
    ],
  );
}
