/**
 *  Licenses
 *
 *  Copyright (c) 2017 Mahmud Ahsan. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import Foundation

/**
 *  Protocol to detect whether user tap a library
 */
public protocol Analytics {
    func libraryClicked(libName: String)
}

/**
 *  LibDetail is used for specify the library detail
 */
struct LibDetail{
    var title:String
    var license:String
    var url:String
    var desc:String
}

class License{
    var libraryList:NSArray?
    
    /**
     *  Read raw .plist formatted data and assigned in portfolioList
     */
    func loadLibraryAndLicenseList(listName: String?){
        guard let listName = listName else {
            libraryList = nil
            return
        }
        
        var libListDict: NSDictionary?
        if let path = Bundle.main.path(forResource: listName, ofType: "plist") {
            libListDict = NSDictionary(contentsOfFile: path)
        }
        
        guard let arr = libListDict?.object(forKey: "libraries") as? NSArray else {
            libraryList = nil
            return
        }
        libraryList = arr
    }
}
