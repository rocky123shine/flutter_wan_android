class ApolloService {
  static String readRepositories = """
  query ReadRepositories(\$nRepositories: Int!) {
    viewer {
      repositories(last: \$nRepositories) {
        nodes {
          id
          name
          viewerHasStarred
        }
      }
    }
  }
""";

  static String AAA = """
  query AdvertList(\$types:[AdvertTypeEnum]) {
    advertList(types: \$types) {
      __typename
      _id
      name
      category
      video_address
      type
      weight
      cover_address
      info_cover_address
      use_link_type
      jump_link
      app_link
    }
  }
  """;
}
