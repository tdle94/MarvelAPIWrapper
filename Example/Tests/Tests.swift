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
        // TODO: Test
    }
}
