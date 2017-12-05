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

import XCTest
@testable import Licenses

class LicensesTests: XCTestCase {
    // MARK:- Test Sample File
    let sampleLicense = "licenses"
    
    // MARK:- Tests
    
    func testLicenseDataFromNoPlist(){
        let license = License()
        license.loadLibraryAndLicenseList(listName: nil)
        XCTAssertNil(license.libraryList)
        XCTAssertNil(license.licenseList)
    }
    
    func testLicenseDataFromWrongPlist(){
        let license = License()
        license.loadLibraryAndLicenseList(listName: "NO_PLIST")
        XCTAssertNil(license.libraryList)
        XCTAssertNil(license.licenseList)
    }
    
    func testLicenseDataFromSamplePlist(){
        let license = License()
        license.loadLibraryAndLicenseList(listName: sampleLicense)
        XCTAssert(license.libraryList?.count == 6)
        XCTAssert(license.licenseList?.count == 4)
    }
    
    func testLicenseDataLibraryListFirstItemDetail(){
        let license = License()
        license.loadLibraryAndLicenseList(listName: sampleLicense)
        
        let itemArray   = license.libraryList![0] as? NSDictionary
        let title       = itemArray?.value(forKey: "title") as! String
        let url         = itemArray?.value(forKey: "url") as! String
        let licenseT    = itemArray?.value(forKey: "license") as! String

        XCTAssertEqual(title, "Appirater")
        XCTAssertEqual(url, "https://github.com/arashpayan/appirater.git")
        XCTAssertEqual(licenseT, "MIT License")
    }
    
    func testLicenseDataLibraryListFirstLicenseDetail(){
        let license = License()
        license.loadLibraryAndLicenseList(listName: sampleLicense)
        
        let itemArray   = license.licenseList![0] as? NSDictionary
        let title       = itemArray?.value(forKey: "title") as! String
        let url         = itemArray?.value(forKey: "url") as! String
        
        XCTAssertEqual(title, "MIT License")
        XCTAssertEqual(url, "https://opensource.org/licenses/MIT")
    }
}
