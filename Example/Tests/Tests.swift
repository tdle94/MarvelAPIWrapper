// https://github.com/Quick/Quick

import Quick
import Nimble
import MarvelApiWrapper
import SwiftyJSON

class TableOfContentsSpec: QuickSpec {
    func completion(_ data: Data?, _ statusCode: Int?, _ error: Error?) {
        if data == nil {
            expect(data).to(equal(nil))
        } else {
            expect(data).to(be(Data(data!)))
        }
    }

    override func spec() {
        let privateKey = "05b154e4641c958256743a9fa74bd16a"
        let publicKey = "8bd96a0e83daff033aa0e1aaf3fd1644aece99fe"
        let marvel = MarvelApiWrapper(publicKey: publicKey, privateKey: privateKey)
        
        describe("Marvel API call") {
            /// Characters
            describe("Character API call") {
                it("has valid data from getAllCharacterWith method") {
                    var config = CharacterConfig()
                    config.limit = 1
                    marvel.getAllCharacterWith(config: config, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getSingleCharacterWith method") {
                    let characterId = 1011334
                    marvel.getSingleCharacterWith(id: characterId, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicsWith method for a single character id") {
                    let characterId = 1011334
                    marvel.getComicsWith(characterId: characterId, config: CharacterComicConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getEventsWith method for a single character id") {
                    let characterId = 1011334
                    marvel.getComicsWith(characterId: characterId, config: CharacterComicConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valida data from getSeriesWith method for a single character id") {
                    let characterId = 1011334
                    marvel.getSeriesWith(characterId: characterId, config: CharacterSerieConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getStoriesWith method for a single character id") {
                    let characterId = 1011334
                    marvel.getStoriesWith(characterId: characterId, config: CharaterStoryConfig(), completion: self.completion(_:_:_:))
                }
            }
            
            /// Comics
            describe("Comic API call") {
                it("has valid data from getAllComicWith method") {
                    var config = ComicConfig()
                    config.limit = 1
                    marvel.getAllComicWith(config: config, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getSingleComicWith method for a single commic id") {
                    let comicId = 183
                    marvel.getSingleComicWith(id: comicId, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getChactersWith method for a single commic id") {
                    let comicId = 183
                    marvel.getChactersWith(comicId: comicId, config: ComicCharacterConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getCreatorsWith method for a single commic id") {
                    let comicId = 183
                    marvel.getCreatorsWith(comicId: comicId, config: ComicCreatorConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getEventsWith method for a single commic id") {
                    let comicId = 183
                    marvel.getEventsWith(comicId: comicId, config: ComicEventConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getSingleComicWith method for a single commic id") {
                    let comicId = 183
                    marvel.getStoriesWith(comicId: comicId, config: ComicStoryConfig(), completion: self.completion(_:_:_:))
                }
            }
            
            /// Creators
            describe("Creators API call") {
                it("has valid data from getAllComicCreator method") {
                    var config = CreatorConfig()
                    config.limit = 1
                    marvel.getAllCreatorWith(config: config, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getSingleCreatorWith method for a single creator id") {
                    let creatorId = 6606
                    marvel.getSingleCreatorWith(id: creatorId, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicsCreatedBy method for a single creator id") {
                    let creatorId = 6606
                    marvel.getComicsCreatedBy(creatorId: creatorId, config: CreatorComicConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getEventsFeaturing method for a single creator id") {
                    let creatorId = 6606
                    marvel.getEventsFeaturing(creatorId: creatorId, config: CreatorEventConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicSeriesWithAnAppearanceOf method for a single creator id") {
                    let creatorId = 6606
                    marvel.getComicSeriesWithAnAppearanceOf(creatorId: creatorId, config: CreatorSerieConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicStoriesCreatedBy method for a single creator id") {
                    let creatorId = 6606
                    marvel.getComicStoriesCreatedBy(creatorId: creatorId, config: CreatorStoryConfig(), completion: self.completion(_:_:_:))
                }
            }
            
            /// Events
            describe("Events API call") {
                it("has valid data from getAllEvents method") {
                    var config = EventConfig()
                    config.limit = 1
                    marvel.getAllEventWith(config: config, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getSingleComicWith method for a single event id") {
                    let eventId = 116
                    marvel.getSingleComicWith(id: eventId, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicSeriesFrom method for a single event id") {
                    let eventId = 116
                    marvel.getSeriesFrom(eventId: eventId, config: EventSerieConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicStoriesFrom method for a single event id") {
                    let eventId = 116
                    marvel.getStoriesFrom(eventId: eventId, config: EventStoryConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicSeriesFrom method for a single event id") {
                    let eventId = 116
                    marvel.getSeriesFrom(eventId: eventId, config: EventSerieConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicStoriesFrom method for a single event id") {
                    let eventId = 116
                    marvel.getStoriesFrom(eventId: eventId, config: EventStoryConfig(), completion: self.completion(_:_:_:))
                }
            }
            
            
            /// Series
            describe("Series API call") {
                it("has valid data from getAllComicSerie method") {
                    var config = SerieConfig()
                    config.limit = 1
                    marvel.getAllSerieWith(config: config, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getSingleComicSeriesWith method for a single serie id") {
                    let serieId = 28292
                    marvel.getSingleSerieWith(seriesId: serieId, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getCharactersAppearIn method for a single serie id") {
                    let serieId = 28292
                    marvel.getCharactersAppearIn(seriesId: serieId, config: SerieCharacterConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicsPartOf method for a single serie id") {
                    let serieId = 28292
                    marvel.getComicsPartOf(seriesId: serieId, config: SerieComicConfig(), completion:  self.completion(_:_:_:))
                }
                
                it("has valid data from getComicCreatorsAppearIn method for a single serie id") {
                    let serieId = 28292
                    marvel.getCreatorsAppearIn(seriesId: serieId, config: SerieCreatorConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getEventsOccurIn method for a single serie id") {
                    let serieId = 28292
                    marvel.getEventsOccurIn(seriesId: serieId, config: SerieEventConfig(), completion: self.completion(_:_:_:))
                }
            }
            
            /// Stories
            describe("Stories API call") {
                it("has valid data from getAllComicStories method") {
                    var config = StoryConfig()
                    config.limit = 1
                    marvel.getAllStorieWith(config: config, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getSingleComicStoryWith method for a single serie id") {
                    let storyId = 7
                    marvel.getSingleStoryWith(storyId: storyId, completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicsAppearIn method for a single serie id") {
                    let storyId = 7
                    marvel.getComicsAppearIn(storyId: storyId, config: StoryComicConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicCreatorsAppearIn method for a single serie id") {
                    let storyId = 7
                    marvel.getCreatorsAppearIn(storyId: storyId, config: StoryCreatorConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getEventsWith method for a single serie id") {
                    let storyId = 7
                    marvel.getEventsWith(storyId: storyId, config: StoryEventConfig(), completion: self.completion(_:_:_:))
                }
                
                it("has valid data from getComicSeriesWith method for a single serie id") {
                    let storyId = 7
                    marvel.getSeriesWith(storyId: storyId, config: StorySerieConfig(), completion: self.completion(_:_:_:))
                }
            }
        }
    }
}
