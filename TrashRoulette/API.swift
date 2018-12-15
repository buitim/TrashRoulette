//  This file was automatically generated and should not be edited.

import Apollo

public final class GetShowQuery: GraphQLQuery {
  public let operationDefinition =
    "query getShow($showID: Int) {\n  Media(id: $showID, type: ANIME) {\n    __typename\n    id\n    title {\n      __typename\n      romaji\n      english\n      native\n    }\n  }\n}"

  public var showID: Int?

  public init(showID: Int? = nil) {
    self.showID = showID
  }

  public var variables: GraphQLMap? {
    return ["showID": showID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("Media", arguments: ["id": GraphQLVariable("showID"), "type": "ANIME"], type: .object(Medium.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(media: Medium? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "Media": media.flatMap { (value: Medium) -> ResultMap in value.resultMap }])
    }

    /// Media query
    public var media: Medium? {
      get {
        return (resultMap["Media"] as? ResultMap).flatMap { Medium(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Media")
      }
    }

    public struct Medium: GraphQLSelectionSet {
      public static let possibleTypes = ["Media"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        GraphQLField("title", type: .object(Title.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, title: Title? = nil) {
        self.init(unsafeResultMap: ["__typename": "Media", "id": id, "title": title.flatMap { (value: Title) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The id of the media
      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
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
    }
  }
}