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
            expect(data).to(be(Data(base64Encoded: data!)))
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
        }
    }
}
