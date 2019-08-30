//  This file was automatically generated and should not be edited.

import Apollo

public final class ArQuery: GraphQLQuery {
  /// query ar {
  ///   articles {
  ///     __typename
  ///     range(limit: 1000) {
  ///       __typename
  ///       data {
  ///         __typename
  ///         teaser {
  ///           __typename
  ///           ...PostDetails
  ///         }
  ///       }
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query ar { articles { __typename range(limit: 1000) { __typename data { __typename teaser { __typename ...PostDetails } } } } }"

  public let operationName = "ar"

  public var queryDocument: String { return operationDefinition.appending(PostDetails.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("articles", type: .nonNull(.object(Article.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(articles: Article) {
      self.init(unsafeResultMap: ["__typename": "Query", "articles": articles.resultMap])
    }

    public var articles: Article {
      get {
        return Article(unsafeResultMap: resultMap["articles"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "articles")
      }
    }

    public struct Article: GraphQLSelectionSet {
      public static let possibleTypes = ["ArticleList"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("range", arguments: ["limit": 1000], type: .nonNull(.object(Range.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(range: Range) {
        self.init(unsafeResultMap: ["__typename": "ArticleList", "range": range.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var range: Range {
        get {
          return Range(unsafeResultMap: resultMap["range"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "range")
        }
      }

      public struct Range: GraphQLSelectionSet {
        public static let possibleTypes = ["ArticleRange"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("data", type: .nonNull(.list(.nonNull(.object(Datum.selections))))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(data: [Datum]) {
          self.init(unsafeResultMap: ["__typename": "ArticleRange", "data": data.map { (value: Datum) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var data: [Datum] {
          get {
            return (resultMap["data"] as! [ResultMap]).map { (value: ResultMap) -> Datum in Datum(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Datum) -> ResultMap in value.resultMap }, forKey: "data")
          }
        }

        public struct Datum: GraphQLSelectionSet {
          public static let possibleTypes = ["Article"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("teaser", type: .nonNull(.object(Teaser.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(teaser: Teaser) {
            self.init(unsafeResultMap: ["__typename": "Article", "teaser": teaser.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var teaser: Teaser {
            get {
              return Teaser(unsafeResultMap: resultMap["teaser"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "teaser")
            }
          }

          public struct Teaser: GraphQLSelectionSet {
            public static let possibleTypes = ["ArticleTeaser"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PostDetails.self),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(title: String? = nil, photo: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "ArticleTeaser", "title": title, "photo": photo])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var postDetails: PostDetails {
                get {
                  return PostDetails(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}

public struct PostDetails: GraphQLFragment {
  /// fragment PostDetails on ArticleTeaser {
  ///   __typename
  ///   title
  ///   photo
  /// }
  public static let fragmentDefinition =
    "fragment PostDetails on ArticleTeaser { __typename title photo }"

  public static let possibleTypes = ["ArticleTeaser"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("photo", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(title: String? = nil, photo: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "ArticleTeaser", "title": title, "photo": photo])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var title: String? {
    get {
      return resultMap["title"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var photo: String? {
    get {
      return resultMap["photo"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "photo")
    }
  }
}
