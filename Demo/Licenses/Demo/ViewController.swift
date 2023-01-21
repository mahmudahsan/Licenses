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

import UIKit

class ViewController: UIViewController {

    @IBAction func showLicenseUI(_ sender: Any) {
        let bundle = Bundle(for: LicensesViewController.self)
        let storyboard = UIStoryboard(name: "Licenses", bundle: bundle)
        
        let licenseVC = storyboard.instantiateInitialViewController() as! LicensesViewController
        licenseVC.title = "Licenses"
        licenseVC.loadLicenseList(name: "licenses", viewStyle: .DESC)
        licenseVC.analytics = self
        self.navigationController?.pushViewController(licenseVC, animated: true)
    }
    
    @IBAction func showLicenseUIURL(_ sender: Any) {
        let bundle = Bundle(for: LicensesViewController.self)
        let storyboard = UIStoryboard(name: "Licenses", bundle: bundle)
        
        let licenseVC = storyboard.instantiateInitialViewController() as! LicensesViewController
        licenseVC.title = "Licenses"
        licenseVC.loadLicenseList(name: "licenses", viewStyle: .URL)
        licenseVC.analytics = self
        self.navigationController?.pushViewController(licenseVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : Analytics {
    func libraryClicked(libName: String) {
        print("Libname: \(libName)")
    }
}

