//  This file was automatically generated and should not be edited.

import Apollo

/// Media type enum, anime or manga.
public enum MediaType: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Japanese Anime
  case anime
  /// Asian comic
  case manga
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ANIME": self = .anime
      case "MANGA": self = .manga
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .anime: return "ANIME"
      case .manga: return "MANGA"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: MediaType, rhs: MediaType) -> Bool {
    switch (lhs, rhs) {
      case (.anime, .anime): return true
      case (.manga, .manga): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public final class GetPopularAiringShowsQuery: GraphQLQuery {
  public let operationDefinition =
    "query getPopularAiringShows($type: MediaType) {\n  Page(page: 1, perPage: 100) {\n    __typename\n    media(status_in: RELEASING, isAdult: false, type: $type, sort: POPULARITY_DESC, format: TV, countryOfOrigin: JP) {\n      __typename\n      title {\n        __typename\n        romaji\n        english\n      }\n      averageScore\n      coverImage {\n        __typename\n        extraLarge\n      }\n      averageScore\n      studios(isMain: true) {\n        __typename\n        nodes {\n          __typename\n          name\n        }\n      }\n    }\n  }\n}"

  public var type: MediaType?

  public init(type: MediaType? = nil) {
    self.type = type
  }

  public var variables: GraphQLMap? {
    return ["type": type]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("Page", arguments: ["page": 1, "perPage": 100], type: .object(Page.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(page: Page? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "Page": page.flatMap { (value: Page) -> ResultMap in value.resultMap }])
    }

    public var page: Page? {
      get {
        return (resultMap["Page"] as? ResultMap).flatMap { Page(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Page")
      }
    }

    public struct Page: GraphQLSelectionSet {
      public static let possibleTypes = ["Page"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("media", arguments: ["status_in": "RELEASING", "isAdult": false, "type": GraphQLVariable("type"), "sort": "POPULARITY_DESC", "format": "TV", "countryOfOrigin": "JP"], type: .list(.object(Medium.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(media: [Medium?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Page", "media": media.flatMap { (value: [Medium?]) -> [ResultMap?] in value.map { (value: Medium?) -> ResultMap? in value.flatMap { (value: Medium) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var media: [Medium?]? {
        get {
          return (resultMap["media"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Medium?] in value.map { (value: ResultMap?) -> Medium? in value.flatMap { (value: ResultMap) -> Medium in Medium(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Medium?]) -> [ResultMap?] in value.map { (value: Medium?) -> ResultMap? in value.flatMap { (value: Medium) -> ResultMap in value.resultMap } } }, forKey: "media")
        }
      }

      public struct Medium: GraphQLSelectionSet {
        public static let possibleTypes = ["Media"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .object(Title.selections)),
          GraphQLField("averageScore", type: .scalar(Int.self)),
          GraphQLField("coverImage", type: .object(CoverImage.selections)),
          GraphQLField("averageScore", type: .scalar(Int.self)),
          GraphQLField("studios", arguments: ["isMain": true], type: .object(Studio.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: Title? = nil, averageScore: Int? = nil, coverImage: CoverImage? = nil, studios: Studio? = nil) {
          self.init(unsafeResultMap: ["__typename": "Media", "title": title.flatMap { (value: Title) -> ResultMap in value.resultMap }, "averageScore": averageScore, "coverImage": coverImage.flatMap { (value: CoverImage) -> ResultMap in value.resultMap }, "studios": studios.flatMap { (value: Studio) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The official titles of the media in various languages
        public var title: Title? {
          get {
            return (resultMap["title"] as? ResultMap).flatMap { Title(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "title")
          }
        }

        /// A weighted average score of all the user's scores of the media
        public var averageScore: Int? {
          get {
            return resultMap["averageScore"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "averageScore")
          }
        }

        /// The cover images of the media
        public var coverImage: CoverImage? {
          get {
            return (resultMap["coverImage"] as? ResultMap).flatMap { CoverImage(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "coverImage")
          }
        }

        /// The companies who produced the media
        public var studios: Studio? {
          get {
            return (resultMap["studios"] as? ResultMap).flatMap { Studio(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "studios")
          }
        }

        public struct Title: GraphQLSelectionSet {
          public static let possibleTypes = ["MediaTitle"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("romaji", type: .scalar(String.self)),
            GraphQLField("english", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(romaji: String? = nil, english: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "MediaTitle", "romaji": romaji, "english": english])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The romanization of the native language title
          public var romaji: String? {
            get {
              return resultMap["romaji"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "romaji")
            }
          }

          /// The official english title
          public var english: String? {
            get {
              return resultMap["english"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "english")
            }
          }
        }

        public struct CoverImage: GraphQLSelectionSet {
          public static let possibleTypes = ["MediaCoverImage"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("extraLarge", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(extraLarge: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "MediaCoverImage", "extraLarge": extraLarge])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
          public var extraLarge: String? {
            get {
              return resultMap["extraLarge"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "extraLarge")
            }
          }
        }

        public struct Studio: GraphQLSelectionSet {
          public static let possibleTypes = ["StudioConnection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "StudioConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var nodes: [Node?]? {
            get {
              return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Studio"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String) {
              self.init(unsafeResultMap: ["__typename": "Studio", "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The name of the studio
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }
        }
      }
    }
  }
}

public final class GetPopularShowsQuery: GraphQLQuery {
  public let operationDefinition =
    "query getPopularShows($type: MediaType) {\n  Page(page: 1, perPage: 300) {\n    __typename\n    media(isAdult: false, type: $type, sort: POPULARITY_DESC, format: TV, countryOfOrigin: JP) {\n      __typename\n      title {\n        __typename\n        romaji\n        english\n      }\n      averageScore\n      coverImage {\n        __typename\n        extraLarge\n      }\n      averageScore\n      studios(isMain: true) {\n        __typename\n        nodes {\n          __typename\n          name\n        }\n      }\n    }\n  }\n}"

  public var type: MediaType?

  public init(type: MediaType? = nil) {
    self.type = type
  }

  public var variables: GraphQLMap? {
    return ["type": type]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("Page", arguments: ["page": 1, "perPage": 300], type: .object(Page.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(page: Page? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "Page": page.flatMap { (value: Page) -> ResultMap in value.resultMap }])
    }

    public var page: Page? {
      get {
        return (resultMap["Page"] as? ResultMap).flatMap { Page(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Page")
      }
    }

    public struct Page: GraphQLSelectionSet {
      public static let possibleTypes = ["Page"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("media", arguments: ["isAdult": false, "type": GraphQLVariable("type"), "sort": "POPULARITY_DESC", "format": "TV", "countryOfOrigin": "JP"], type: .list(.object(Medium.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(media: [Medium?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Page", "media": media.flatMap { (value: [Medium?]) -> [ResultMap?] in value.map { (value: Medium?) -> ResultMap? in value.flatMap { (value: Medium) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var media: [Medium?]? {
        get {
          return (resultMap["media"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Medium?] in value.map { (value: ResultMap?) -> Medium? in value.flatMap { (value: ResultMap) -> Medium in Medium(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Medium?]) -> [ResultMap?] in value.map { (value: Medium?) -> ResultMap? in value.flatMap { (value: Medium) -> ResultMap in value.resultMap } } }, forKey: "media")
        }
      }

      public struct Medium: GraphQLSelectionSet {
        public static let possibleTypes = ["Media"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .object(Title.selections)),
          GraphQLField("averageScore", type: .scalar(Int.self)),
          GraphQLField("coverImage", type: .object(CoverImage.selections)),
          GraphQLField("averageScore", type: .scalar(Int.self)),
          GraphQLField("studios", arguments: ["isMain": true], type: .object(Studio.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(title: Title? = nil, averageScore: Int? = nil, coverImage: CoverImage? = nil, studios: Studio? = nil) {
          self.init(unsafeResultMap: ["__typename": "Media", "title": title.flatMap { (value: Title) -> ResultMap in value.resultMap }, "averageScore": averageScore, "coverImage": coverImage.flatMap { (value: CoverImage) -> ResultMap in value.resultMap }, "studios": studios.flatMap { (value: Studio) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The official titles of the media in various languages
        public var title: Title? {
          get {
            return (resultMap["title"] as? ResultMap).flatMap { Title(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "title")
          }
        }

        /// A weighted average score of all the user's scores of the media
        public var averageScore: Int? {
          get {
            return resultMap["averageScore"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "averageScore")
          }
        }

        /// The cover images of the media
        public var coverImage: CoverImage? {
          get {
            return (resultMap["coverImage"] as? ResultMap).flatMap { CoverImage(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "coverImage")
          }
        }

        /// The companies who produced the media
        public var studios: Studio? {
          get {
            return (resultMap["studios"] as? ResultMap).flatMap { Studio(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "studios")
          }
        }

        public struct Title: GraphQLSelectionSet {
          public static let possibleTypes = ["MediaTitle"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("romaji", type: .scalar(String.self)),
            GraphQLField("english", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(romaji: String? = nil, english: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "MediaTitle", "romaji": romaji, "english": english])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The romanization of the native language title
          public var romaji: String? {
            get {
              return resultMap["romaji"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "romaji")
            }
          }

          /// The official english title
          public var english: String? {
            get {
              return resultMap["english"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "english")
            }
          }
        }

        public struct CoverImage: GraphQLSelectionSet {
          public static let possibleTypes = ["MediaCoverImage"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("extraLarge", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(extraLarge: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "MediaCoverImage", "extraLarge": extraLarge])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
          public var extraLarge: String? {
            get {
              return resultMap["extraLarge"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "extraLarge")
            }
          }
        }

        public struct Studio: GraphQLSelectionSet {
          public static let possibleTypes = ["StudioConnection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "StudioConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var nodes: [Node?]? {
            get {
              return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Studio"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String) {
              self.init(unsafeResultMap: ["__typename": "Studio", "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The name of the studio
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }
        }
      }
    }
  }
}

public final class GetAiringShowQuery: GraphQLQuery {
  public let operationDefinition =
    "query getAiringShow($genre: String) {\n  Page(page: 1, perPage: 300) {\n    __typename\n    media(genre: $genre, season: WINTER, seasonYear: 2019, isAdult: false, type: ANIME, sort: POPULARITY_DESC, format: TV, countryOfOrigin: JP) {\n      __typename\n      coverImage {\n        __typename\n        extraLarge\n      }\n      title {\n        __typename\n        romaji\n        english\n        native\n      }\n      averageScore\n      studios(isMain: true) {\n        __typename\n        nodes {\n          __typename\n          name\n        }\n      }\n    }\n  }\n}"

  public var genre: String?

  public init(genre: String? = nil) {
    self.genre = genre
  }

  public var variables: GraphQLMap? {
    return ["genre": genre]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("Page", arguments: ["page": 1, "perPage": 300], type: .object(Page.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(page: Page? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "Page": page.flatMap { (value: Page) -> ResultMap in value.resultMap }])
    }

    public var page: Page? {
      get {
        return (resultMap["Page"] as? ResultMap).flatMap { Page(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Page")
      }
    }

    public struct Page: GraphQLSelectionSet {
      public static let possibleTypes = ["Page"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("media", arguments: ["genre": GraphQLVariable("genre"), "season": "WINTER", "seasonYear": 2019, "isAdult": false, "type": "ANIME", "sort": "POPULARITY_DESC", "format": "TV", "countryOfOrigin": "JP"], type: .list(.object(Medium.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(media: [Medium?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Page", "media": media.flatMap { (value: [Medium?]) -> [ResultMap?] in value.map { (value: Medium?) -> ResultMap? in value.flatMap { (value: Medium) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var media: [Medium?]? {
        get {
          return (resultMap["media"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Medium?] in value.map { (value: ResultMap?) -> Medium? in value.flatMap { (value: ResultMap) -> Medium in Medium(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Medium?]) -> [ResultMap?] in value.map { (value: Medium?) -> ResultMap? in value.flatMap { (value: Medium) -> ResultMap in value.resultMap } } }, forKey: "media")
        }
      }

      public struct Medium: GraphQLSelectionSet {
        public static let possibleTypes = ["Media"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("coverImage", type: .object(CoverImage.selections)),
          GraphQLField("title", type: .object(Title.selections)),
          GraphQLField("averageScore", type: .scalar(Int.self)),
          GraphQLField("studios", arguments: ["isMain": true], type: .object(Studio.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(coverImage: CoverImage? = nil, title: Title? = nil, averageScore: Int? = nil, studios: Studio? = nil) {
          self.init(unsafeResultMap: ["__typename": "Media", "coverImage": coverImage.flatMap { (value: CoverImage) -> ResultMap in value.resultMap }, "title": title.flatMap { (value: Title) -> ResultMap in value.resultMap }, "averageScore": averageScore, "studios": studios.flatMap { (value: Studio) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The cover images of the media
        public var coverImage: CoverImage? {
          get {
            return (resultMap["coverImage"] as? ResultMap).flatMap { CoverImage(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "coverImage")
          }
        }

        /// The official titles of the media in various languages
        public var title: Title? {
          get {
            return (resultMap["title"] as? ResultMap).flatMap { Title(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "title")
          }
        }

        /// A weighted average score of all the user's scores of the media
        public var averageScore: Int? {
          get {
            return resultMap["averageScore"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "averageScore")
          }
        }

        /// The companies who produced the media
        public var studios: Studio? {
          get {
            return (resultMap["studios"] as? ResultMap).flatMap { Studio(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "studios")
          }
        }

        public struct CoverImage: GraphQLSelectionSet {
          public static let possibleTypes = ["MediaCoverImage"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("extraLarge", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(extraLarge: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "MediaCoverImage", "extraLarge": extraLarge])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
          public var extraLarge: String? {
            get {
              return resultMap["extraLarge"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "extraLarge")
            }
          }
        }

        public struct Title: GraphQLSelectionSet {
          public static let possibleTypes = ["MediaTitle"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("romaji", type: .scalar(String.self)),
            GraphQLField("english", type: .scalar(String.self)),
            GraphQLField("native", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(romaji: String? = nil, english: String? = nil, native: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "MediaTitle", "romaji": romaji, "english": english, "native": native])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The romanization of the native language title
          public var romaji: String? {
            get {
              return resultMap["romaji"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "romaji")
            }
          }

          /// The official english title
          public var english: String? {
            get {
              return resultMap["english"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "english")
            }
          }

          /// Official title in it's native language
          public var native: String? {
            get {
              return resultMap["native"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "native")
            }
          }
        }

        public struct Studio: GraphQLSelectionSet {
          public static let possibleTypes = ["StudioConnection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "StudioConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var nodes: [Node?]? {
            get {
              return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Studio"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String) {
              self.init(unsafeResultMap: ["__typename": "Studio", "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The name of the studio
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }
        }
      }
    }
  }
}

public final class GetAllShowQuery: GraphQLQuery {
  public let operationDefinition =
    "query getAllShow($genre: String) {\n  Page(page: 1, perPage: 300) {\n    __typename\n    media(genre: $genre, isAdult: false, type: ANIME, sort: POPULARITY_DESC, format: TV, countryOfOrigin: JP) {\n      __typename\n      coverImage {\n        __typename\n        extraLarge\n      }\n      title {\n        __typename\n        romaji\n        english\n        native\n      }\n      averageScore\n      studios(isMain: true) {\n        __typename\n        nodes {\n          __typename\n          name\n        }\n      }\n    }\n  }\n}"

  public var genre: String?

  public init(genre: String? = nil) {
    self.genre = genre
  }

  public var variables: GraphQLMap? {
    return ["genre": genre]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("Page", arguments: ["page": 1, "perPage": 300], type: .object(Page.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(page: Page? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "Page": page.flatMap { (value: Page) -> ResultMap in value.resultMap }])
    }

    public var page: Page? {
      get {
        return (resultMap["Page"] as? ResultMap).flatMap { Page(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Page")
      }
    }

    public struct Page: GraphQLSelectionSet {
      public static let possibleTypes = ["Page"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("media", arguments: ["genre": GraphQLVariable("genre"), "isAdult": false, "type": "ANIME", "sort": "POPULARITY_DESC", "format": "TV", "countryOfOrigin": "JP"], type: .list(.object(Medium.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(media: [Medium?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Page", "media": media.flatMap { (value: [Medium?]) -> [ResultMap?] in value.map { (value: Medium?) -> ResultMap? in value.flatMap { (value: Medium) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var media: [Medium?]? {
        get {
          return (resultMap["media"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Medium?] in value.map { (value: ResultMap?) -> Medium? in value.flatMap { (value: ResultMap) -> Medium in Medium(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Medium?]) -> [ResultMap?] in value.map { (value: Medium?) -> ResultMap? in value.flatMap { (value: Medium) -> ResultMap in value.resultMap } } }, forKey: "media")
        }
      }

      public struct Medium: GraphQLSelectionSet {
        public static let possibleTypes = ["Media"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("coverImage", type: .object(CoverImage.selections)),
          GraphQLField("title", type: .object(Title.selections)),
          GraphQLField("averageScore", type: .scalar(Int.self)),
          GraphQLField("studios", arguments: ["isMain": true], type: .object(Studio.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(coverImage: CoverImage? = nil, title: Title? = nil, averageScore: Int? = nil, studios: Studio? = nil) {
          self.init(unsafeResultMap: ["__typename": "Media", "coverImage": coverImage.flatMap { (value: CoverImage) -> ResultMap in value.resultMap }, "title": title.flatMap { (value: Title) -> ResultMap in value.resultMap }, "averageScore": averageScore, "studios": studios.flatMap { (value: Studio) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The cover images of the media
        public var coverImage: CoverImage? {
          get {
            return (resultMap["coverImage"] as? ResultMap).flatMap { CoverImage(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "coverImage")
          }
        }

        /// The official titles of the media in various languages
        public var title: Title? {
          get {
            return (resultMap["title"] as? ResultMap).flatMap { Title(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "title")
          }
        }

        /// A weighted average score of all the user's scores of the media
        public var averageScore: Int? {
          get {
            return resultMap["averageScore"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "averageScore")
          }
        }

        /// The companies who produced the media
        public var studios: Studio? {
          get {
            return (resultMap["studios"] as? ResultMap).flatMap { Studio(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "studios")
          }
        }

        public struct CoverImage: GraphQLSelectionSet {
          public static let possibleTypes = ["MediaCoverImage"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("extraLarge", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(extraLarge: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "MediaCoverImage", "extraLarge": extraLarge])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
          public var extraLarge: String? {
            get {
              return resultMap["extraLarge"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "extraLarge")
            }
          }
        }

        public struct Title: GraphQLSelectionSet {
          public static let possibleTypes = ["MediaTitle"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("romaji", type: .scalar(String.self)),
            GraphQLField("english", type: .scalar(String.self)),
            GraphQLField("native", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(romaji: String? = nil, english: String? = nil, native: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "MediaTitle", "romaji": romaji, "english": english, "native": native])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The romanization of the native language title
          public var romaji: String? {
            get {
              return resultMap["romaji"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "romaji")
            }
          }

          /// The official english title
          public var english: String? {
            get {
              return resultMap["english"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "english")
            }
          }

          /// Official title in it's native language
          public var native: String? {
            get {
              return resultMap["native"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "native")
            }
          }
        }

        public struct Studio: GraphQLSelectionSet {
          public static let possibleTypes = ["StudioConnection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "StudioConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var nodes: [Node?]? {
            get {
              return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Studio"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String) {
              self.init(unsafeResultMap: ["__typename": "Studio", "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The name of the studio
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }
        }
      }
    }
  }
}