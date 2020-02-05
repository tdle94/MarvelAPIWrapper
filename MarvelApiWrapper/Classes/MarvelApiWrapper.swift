
import Foundation

/// A Wrapper around API GET Request to characters, comics, creators, events, series and stories revolving around Marvel.
open class MarvelApiWrapper {
    // MARK: - Properties
    /// URL share session across function wrapper
    private lazy var session: URLSession = URLSession.shared

    /// User must provide public key from https://developer.marvel.com/
    public let publicKey: String

    /// User must provide private key from https://developer.marvel.com/
    public let privateKey: String

    /// Common character URL
    public let characterURL = "https://gateway.marvel.com:443/v1/public/characters"

    /// Common comic URL
    public let comicURL = "https://gateway.marvel.com:443/v1/public/comics"

    /// Common creator URL
    public let creatorURL = "https://gateway.marvel.com:443/v1/public/creators"
    
    /// Common event URL
    public let eventURL = "https://gateway.marvel.com:443/v1/public/events"

    /// Common series URL
    public let serieURL = "https://gateway.marvel.com:443/v1/public/series"
    
    /// Common story URL
    public let storyURL = "https://gateway.marvel.com:443/v1/public/stories"

    /// A timestamp (or other long string which can change on a request-by-request basis)
    public let timestamp: String = "thesoer"

    /// A md5 digest of the ts parameter, your private key and your public key (e.g. md5(ts+privateKey+publicKey)
    var hash: String {
        return (timestamp + privateKey + publicKey).md5
    }

    // MARK: - Initialize
    public init(publicKey: String, privateKey: String) {
        self.publicKey = publicKey
        self.privateKey = privateKey
    }

    // MARK: - Wrapper function for querying Marvel API
    /// Fetches lists of comic characters with optional filters
    /// - Parameters:
    ///     - config: Filter option for GET parameters
    ///     - completion: Closure to pass back data
    open func getAllCharacterWith(config: CharacterConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var characterUrlComponent = getURLComponent(withUrl: characterURL)

        /// Optional params
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.name)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.nameStartsWith)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "stories", item: config.stories)

        /// API call
        if let url = characterUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }
    
    /// This method fetches a single character resource. It is the canonical URI for any character resource provided by the API.
    /// - Parameters:
    ///     - id: Character id
    ///     - completion: Closure to pass back data
    open func getSingleCharacterWith(id: Int, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var characterUrlComponent = getURLComponent(withUrl: characterURL)
        
        characterUrlComponent?.queryItems?.append(URLQueryItem(name: "id", value: "\(id)"))

        /// API call
        if let url = characterUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }
    

    /// Fetches lists of comics containing a specific character, with optional filters
    /// - Parameters
    ///     - id: Character id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getComicsWith(characterId: Int, config: CharacterComicConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var characterUrlComponent = getURLComponent(withUrl: characterURL + "/\(characterId)/comics")

        /// Optional params
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.formatType)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.dateDescriptor)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.titleStartsWith)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.diamondCode)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.upc)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.isbn)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.ean)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.issn)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "format", item: config.format)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "sharedAppearances", item: config.sharedAppearances)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "collaborators", item: config.collaborators)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "noVariants", item: config.noVariants)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "dataRange", item: config.dateRange)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "startYear", item: config.startYear)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "issueNumber", item: config.issueNumber)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "digitalId", item: config.digitalId)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "hasDigitalIssue", item: config.hasDigitalIssue)

        /// API call
        if let url = characterUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of events in which a specific character appears, with optional filters.
    /// - Parameters
    ///     - id: Character id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getEventsWith(characterId: Int, config: CharacterEventConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var characterUrlComponent = getURLComponent(withUrl: characterURL + "/\(characterId)/events")

        /// Optional params
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.nameStartsWith)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "offset", item: config.offset)

        /// API call
        if let url = characterUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic series in which a specific character appears, with optional filters.
    /// - Parameters
    ///     - id: Character id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getSeriesWith(characterId: Int, config: CharacterSerieConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var characterUrlComponent = getURLComponent(withUrl: characterURL + "/\(characterId)/series")

        /// Optional params
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.titleStartWith)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.seriesType)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.contains)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "startYear", item: config.startYear)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "offset", item: config.offset)

        /// API call
        if let url = characterUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic stories featuring a specific character with optional filters.
    /// - Parameters
    ///     - id: Character id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getStoriesWith(characterId: Int, config: CharacterStoryConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var characterUrlComponent = getURLComponent(withUrl: characterURL + "/\(characterId)/stories")

        /// Optinal params
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &characterUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &characterUrlComponent, name: "offset", item: config.offset)

        /// API call
        if let url = characterUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comics with optional filters.
    /// - Parameters
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getAllComicWith(config: ComicConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var comicUrlComponent = getURLComponent(withUrl: comicURL)

        /// Optional params
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "format", item: config.format)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "sharedAppearances", item: config.sharedAppearances)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "collaborators", item: config.collaborators)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "noVariants", item: config.noVariants)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "dateRange", item: config.dateRange)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "startyear", item: config.startYear)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "issueNumber", item: config.issueNumber)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "digitalId", item: config.digitalId)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "hasDigitalIssue", item: config.hasDigitalIssue)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.formatType)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.dateDescriptor)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.titleStartsWith)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.diamondCode)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.upc)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.isbn)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.ean)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.issn)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.orderBy)

        /// API call
        if let url = comicUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// This method fetches a single comic resource. It is the canonical URI for any comic resource provided by the API.
    /// - Parameters
    ///     - id: comic Id
    ///     - completion: Closure to pass back data
    open func getSingleComicWith(id: Int, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var comicUrlComponent = getURLComponent(withUrl: comicURL)
        
        comicUrlComponent?.queryItems?.append(URLQueryItem(name: "id", value: "\(id)"))
        
        /// API call
        if let url = comicUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of characters which appear in a specific comic with optional filters. See notes on individual parameters below.
    /// - Parameters
    ///     - id: Comic  id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getCharactersWith(comicId: Int, config: ComicCharacterConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var comicUrlComponent = getURLComponent(withUrl: comicURL + "/\(comicId)/characters")
        /// Optional params
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.nameStartsWith)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.name)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "offset", item: config.offset)

        /// API call
        if let url = comicUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic creators whose work appears in a specific comic, with optional filters.
    /// - Parameters
    ///     - id: Comic  id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getCreatorsWith(comicId: Int, config: ComicCreatorConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var comicUrlComponent = getURLComponent(withUrl: comicURL + "/\(comicId)/creators")

        /// Optional params
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.firstName)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.middleName)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.lastName)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.suffix)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.nameStartsWith)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.firstNameStartsWith)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.middleNameStartsWith)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.lastName)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "offset", item: config.offset)

        /// API call
        if let url = comicUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of events in which a specific comic appears, with optional filters.
    /// - Parameters
    ///     - id: Comic  id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getEventsWith(comicId: Int, config: ComicEventConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var comicUrlComponent = getURLComponent(withUrl: comicURL + "/\(comicId)/events")

        /// Optional params
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.name)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.nameStartsWith)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.orderBy)

        /// API call
        if let url = comicUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic stories in a specific comic issue, with optional filters.
    /// - Parameters
    ///     - id: Comic  id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getStoriesWith(comicId: Int, config: ComicStoryConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var comicUrlComponent = getURLComponent(withUrl: comicURL + "/\(comicId)/stories")

        /// Optional params
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &comicUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &comicUrlComponent, name: "offset", item: config.offset)

        /// API call
        if let url = comicUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic creators with optional filters
    /// - Parameters
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getAllCreatorWith(config: CreatorConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var creatorUrlComponent = getURLComponent(withUrl: creatorURL)

        /// Optional params
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "comis", item: config.comics)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.firstName)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.firstNameStartsWith)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.lastName)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.lastNameStartsWith)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.middleName)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.middleNameStartsWith)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.nameStartsWith)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.suffix)

        /// API call
        if let url = creatorUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// This method fetches a single creator resource.
    /// - Parameters
    ///     - id: creator Id
    ///     - completion: Closure to pass back data
    open func getSingleCreatorWith(id: Int, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var creatorUrlComponent = getURLComponent(withUrl: creatorURL)
        creatorUrlComponent?.queryItems?.append(URLQueryItem(name: "id", value: "\(id)"))

        /// API call
        if let url = creatorUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comics in which the work of a specific creator appears, with optional filters.
    /// - Parameters
    ///     - id: creator Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getComicsCreatedBy(creatorId: Int, config: CreatorComicConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var creatorUrlComponent = getURLComponent(withUrl: creatorURL + "/\(creatorId)/comics")

        /// Optional params
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "collaborators", item: config.collaborators)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "dataRange", item: config.dateRange)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "digitalId", item: config.digitalId)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "format", item: config.format)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "issueNumber", item: config.issueNumber)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "sharedAppearances", item: config.sharedAppearances)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "startYear", item: config.startYear)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "hasDigitalIssue", item: config.hasDigitalIssue)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "noVariants", item: config.noVariants)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.dateDescriptor)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.diamondCode)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.ean)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.formatType)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.isbn)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.issn)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.upc)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.titleStartsWith)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = creatorUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of events featuring the work of a specific creator with optional filters.
    /// - Parameters
    ///     - id: creator Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getEventsFeaturing(creatorId: Int, config: CreatorEventConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var creatorUrlComponent = getURLComponent(withUrl: creatorURL + "/\(creatorId)/events")
        
        /// Optional params
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "charactor", item: config.characters)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.name)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.nameStartsWith)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.orderBy)

        /// API call
        if let url = creatorUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic series in which a specific creator's work appears, with optional filters.
    /// - Parameters
    ///     - id: creator Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getSeriesWithAnAppearanceOf(creatorId: Int, config: CreatorSerieConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var creatorUrlComponent = getURLComponent(withUrl: creatorURL + "/\(creatorId)/series")

        /// Optional params
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "charactor", item: config.characters)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "startYear", item: config.startYear)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.contains)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.seriesType)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.titleStartsWith)

        /// API call
        if let url = creatorUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic stories by a specific creator with optional filters.
    /// - Parameters
    ///     - id: creator Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getStoriesCreatedBy(creatorId: Int, config: CreatorStoryConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var creatorUrlComponent = getURLComponent(withUrl: creatorURL + "/\(creatorId)/stories")
        
        /// Optional params
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "charactor", item: config.characters)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &creatorUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &creatorUrlComponent, item: config.orderBy)

        /// API call
        if let url = creatorUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of events with optional filters.
    /// - Parameters
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getAllEventWith(config: EventConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var eventUrlComponent = getURLComponent(withUrl: eventURL)
        
        /// Optional params
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "charactor", item: config.characters)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.name)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.nameStartsWith)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.orderBy)

        /// API call
        if let url = eventUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// This method fetches a single event resource. It is the canonical URI for any event resource provided by the API.
    /// - Parameters
    ///     - id: event Id
    ///     - completion: Closure to pass back data
    open func getSingleEventWith(id: Int, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var eventUrlComponent = getURLComponent(withUrl: eventURL)
        eventUrlComponent?.queryItems?.append(URLQueryItem(name: "id", value: "\(id)"))

        /// API call
        if let url = eventUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of characters which appear in a specific event, with optional filters.
    /// - Parameters
    ///     - eventId: event Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getCharacterAppearIn(eventId: Int, config: EventCharacterConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var eventUrlComponent = getURLComponent(withUrl: eventURL + "/\(eventId)/characters")

        addQueryItemTo(urlComponent: &eventUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "series", item: config.series)

        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.name)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.nameStartsWith)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.orderBy)

        /// API call
        if let url = eventUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comics which take place during a specific event, with optional filters.
    /// - Parameters
    ///     - eventId: event Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getComicsDuringSpecific(eventId: Int, config: EventComicConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var eventUrlComponent = getURLComponent(withUrl: eventURL + "/\(eventId)/comics")

        /// Optional params
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "collaborators", item: config.collaborators)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "dataRange", item: config.dateRange)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "digitalId", item: config.digitalId)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "format", item: config.format)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "issueNumber", item: config.issueNumber)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "sharedAppearances", item: config.sharedAppearances)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "startYear", item: config.startYear)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "hasDigitalIssue", item: config.hasDigitalIssue)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "noVariants", item: config.noVariants)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.dateDescriptor)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.diamondCode)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.ean)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.formatType)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.isbn)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.issn)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.upc)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.titleStartsWith)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = eventUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic creators whose work appears in a specific event, with optional filters.
    /// - Parameters
    ///     - eventId: event Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getCreatorsAppearIn(eventId: Int, config: EventCreatorConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var eventUrlComponent = getURLComponent(withUrl: eventURL + "/\(eventId)/creators")

        /// Optional params
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = eventUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic series in which a specific event takes place, with optional filters.
    /// - Parameters
    ///     - eventId: event Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getSeriesFrom(eventId: Int, config: EventSerieConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var eventUrlComponent = getURLComponent(withUrl: eventURL + "/\(eventId)/series")

        /// Optional params
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "startYear", item: config.startYear)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.titleStartsWith)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = eventUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic stories from a specific event, with optional filters.
    /// - Parameters
    ///     - eventId: event Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getStoriesFrom(eventId: Int, config: EventStoryConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var eventUrlComponent = getURLComponent(withUrl: eventURL + "/\(eventId)/stories")

        /// Optional params
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &eventUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &eventUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = eventUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic series with optional filters.
    /// - Parameters
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getAllSerieWith(config: SerieConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var serieUrlComponent = getURLComponent(withUrl: serieURL)

        /// Optional params
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "startYear", item: config.startYear)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.contains)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.seriesType)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.titleStartsWith)

        /// API call
        if let url = serieUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// This method fetches a single comic series resource.
    /// - Parameters
    ///     - seriesId: series Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getSingleSerieWith(seriesId: Int, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var serieUrlComponent = getURLComponent(withUrl: serieURL)
        serieUrlComponent?.queryItems?.append(URLQueryItem(name: "id", value: "\(seriesId)"))

        /// API call
        if let url = serieUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of characters which appear in specific series, with optional filters.
    /// - Parameters
    ///     - seriesId: series Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getCharactersAppearIn(seriesId: Int, config: SerieCharacterConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var serieUrlComponent = getURLComponent(withUrl: serieURL + "/\(seriesId)/characters")

        /// Optional params
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.name)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.nameStartsWith)

        /// API call
        if let url = serieUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comics which are published as part of a specific series, with optional filters.
    /// - Parameters
    ///     - seriesId: series Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getComicsPartOf(seriesId: Int, config: SerieComicConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var serieUrlComponent = getURLComponent(withUrl: serieURL + "/\(seriesId)/comics")

        /// Optional params
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "collaborators", item: config.collaborators)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "dataRange", item: config.dateRange)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "digitalId", item: config.digitalId)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "format", item: config.format)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "issueNumber", item: config.issueNumber)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "sharedAppearances", item: config.sharedAppearances)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "startYear", item: config.startYear)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "hasDigitalIssue", item: config.hasDigitalIssue)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "noVariants", item: config.noVariants)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.dateDescriptor)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.diamondCode)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.ean)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.formatType)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.isbn)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.issn)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.upc)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.titleStartsWith)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = serieUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic creators whose work appears in a specific series, with optional filters.
    /// - Parameters
    ///     - seriesId: series Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getCreatorsAppearIn(seriesId: Int, config: SerieCreatorConfig,  completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var serieUrlComponent = getURLComponent(withUrl: serieURL + "/\(seriesId)/creators")

        /// Optional params
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "stories", item: config.stories)
         addQueryItemTo(urlComponent: &serieUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = serieUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of events which occur in a specific series, with optional filters.
    /// - Parameters
    ///     - seriesId: series Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getEventsOccurIn(seriesId: Int, config: SerieEventConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var serieUrlComponent = getURLComponent(withUrl: serieURL + "/\(seriesId)/events")

        /// Optional params
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "stories", item: config.stories)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "creators", item: config.creators)
         addQueryItemTo(urlComponent: &serieUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = serieUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic stories from a specific series with optional filters
    /// /// - Parameters
    ///     - seriesId: series Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data.
    open func getStoriesFrom(seriesId: Int, config: SerieStoryConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var serieUrlComponent = getURLComponent(withUrl: serieURL + "/\(seriesId)/stories")

        /// Optional params
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &serieUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &serieUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = serieUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic stories with optional filters.
    /// - Parameters
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getAllStorieWith(config: StoryConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var storyUrlComponent = getURLComponent(withUrl: storyURL)

        /// Optional params
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.series)

        /// API call
        if let url = storyUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// This method fetches a single comic story resource.
    /// - Parameters
    ///     - storyId: story Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getSingleStoryWith(storyId: Int, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var storyUrlComponent = getURLComponent(withUrl: storyURL)
        storyUrlComponent?.queryItems?.append(URLQueryItem(name: "id", value: "\(storyId)"))

        /// API call
        if let url = storyUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic characters appearing in a single story, with optional filters.
    /// - Parameters
    ///     - storyId: story Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getCharactersAppearIn(storyId: Int, config: StoryCharacterConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var storyUrlComponent = getURLComponent(withUrl: storyURL + "/\(storyId)/characters")

        /// Optional params
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "comics", item: config.comics)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.modifiedSince)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.name)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.nameStartsWith)

        /// API call
        if let url = storyUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comics in which a specific story appears, with optional filters.
    /// - Parameters
    ///     - storyId: story Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getComicsAppearIn(storyId: Int, config: StoryComicConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var storyUrlComponent = getURLComponent(withUrl: storyURL + "/\(storyId)/comics")

        addQueryItemTo(urlComponent: &storyUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "collaborators", item: config.collaborators)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "dataRange", item: config.dateRange)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "digitalId", item: config.digitalId)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "format", item: config.format)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "issueNumber", item: config.issueNumber)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "sharedAppearances", item: config.sharedAppearances)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "startYear", item: config.startYear)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "hasDigitalIssue", item: config.hasDigitalIssue)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "noVariants", item: config.noVariants)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.dateDescriptor)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.diamondCode)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.ean)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.formatType)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.isbn)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.issn)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.upc)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.titleStartsWith)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = storyUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic creators whose work appears in a specific story, with optional filters.
    /// - Parameters
    ///     - storyId: story Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getCreatorsAppearIn(storyId: Int, config: StoryCreatorConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var storyUrlComponent = getURLComponent(withUrl: storyURL + "/\(storyId)/creators")

        addQueryItemTo(urlComponent: &storyUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = storyUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of events in which a specific story appears, with optional filters.
    /// - Parameters
    ///     - storyId: story Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getEventsWith(storyId: Int, config: StoryEventConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var storyUrlComponent = getURLComponent(withUrl: storyURL + "/\(storyId)/events")

        addQueryItemTo(urlComponent: &storyUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "series", item: config.series)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = storyUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }

    /// Fetches lists of comic series in which the specified story takes place.
    /// - Parameters
    ///     - storyId: story Id
    ///     - config: Optional filter for GET params
    ///     - completion: Closure to pass back data
    open func getSeriesWith(storyId: Int, config: StorySerieConfig, completion: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var storyUrlComponent = getURLComponent(withUrl: storyURL + "/\(storyId)/series")

        addQueryItemTo(urlComponent: &storyUrlComponent, name: "characters", item: config.characters)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "events", item: config.events)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "limit", item: config.limit)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "offset", item: config.offset)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "startYear", item: config.startYear)
        addQueryItemTo(urlComponent: &storyUrlComponent, name: "creators", item: config.creators)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.titleStartsWith)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.title)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.orderBy)
        addQueryItemTo(urlComponent: &storyUrlComponent, item: config.modifiedSince)

        /// API call
        if let url = storyUrlComponent?.url {
            fetchWith(url: url, and: completion)
        }
    }
}

/// Helper functions
extension MarvelApiWrapper {
    // MARK: - Helper functions
    
    /// Return URL request configuration
    /// - Parameters:
    ///     - url: URL provide
    /// - Returns: NSMutableURLRequest
    fileprivate func getNSMutableURLRequest(url: URL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        return request
    }

    /// Get Common query item for Character URL Component
    /// - Returns: A Character URLComponents.,
    fileprivate func getURLComponent(withUrl: String) -> URLComponents? {
        var characterUrlComponent = URLComponents(string: withUrl)

        characterUrlComponent?.queryItems = [
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "ts", value: "\(timestamp)"),
        ]

        return characterUrlComponent
    }

    /// Common API method for all wrapper functions
    /// - Parameters:
    ///     - url: Url provide by wrapper function
    ///     - callBack: Closure to pass back data, statusCode and error
    fileprivate func fetchWith(url: URL, and callBack: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        session.dataTask(with: getNSMutableURLRequest(url: url) as URLRequest) { data, response, error in
            callBack(data, response, error)
        }.resume()
    }

    /// Method for adding query item to url components for item of type String.
    /// - Parameters:
    ///     - urlComponent: Component to add query item to
    ///     - item: Item for URLQueryItem name and value parameters
    fileprivate func addQueryItemTo(urlComponent: inout URLComponents?, item: String?) {
        if let item = item {
            urlComponent?.queryItems?.append(URLQueryItem(name: item, value: item))
        }
    }

    /// Method for adding query item to url components for item of type Int.
    /// - Parameters:
    ///     - urlComponent: Component to add query item to
    ///     - name: Name of query item
    ///     - item: Item for URLQueryItem value parameters
    fileprivate func addQueryItemTo(urlComponent: inout URLComponents?, name: String, item: Int?) {
        if let item = item {
            urlComponent?.queryItems?.append(URLQueryItem(name: name, value: "\(item)"))
        }
    }

    /// Method for adding query item to url components for item of type Bool.
    /// - Parameters:
    ///     - urlComponent: Component to add query item to
    ///     - name: Name of query item
    ///     - item: Item for URLQueryItem name and value parameters
    fileprivate func addQueryItemTo(urlComponent: inout URLComponents?, name: String, item: Bool?) {
        if let item = item {
            urlComponent?.queryItems?.append(URLQueryItem(name: name, value: "\(item)"))
        }
    }
}
