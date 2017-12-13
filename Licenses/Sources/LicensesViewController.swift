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

public enum LicensesViewStyle{
    case URL
    case DESC
}

//https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values
extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

public class LicensesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var license:License = License()
    var licenseViewStyle:LicensesViewStyle = .DESC
    
    public var analytics:Analytics?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func loadLicenseList(name: String, viewStyle: LicensesViewStyle){
        licenseViewStyle = viewStyle
        license.loadLibraryAndLicenseList(listName: name)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if let libraryList = license.libraryList {
            rows = libraryList.count
        }
        return rows
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.init(hex: 0xa0a0a0)
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        header.textLabel?.frame = header.frame
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:LicensesTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell") as? LicensesTableViewCell
        if cell == nil {
            let bundle = Bundle(for: License.self)
            cell = bundle.loadNibNamed("LicensesTableViewCell", owner: self, options: nil)?[0] as? LicensesTableViewCell
        }
        
        //libraries
        let libraryItem    = license.libraryList?.object(at: indexPath.row) as? NSDictionary
        let title    = libraryItem?.value(forKey: "title") as? String
        let licenseT = libraryItem?.value(forKey: "license") as? String
        
        cell?.title.text = title
        cell?.subtitle.text = licenseT
        cell?.title.textColor = UIColor.black
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let libraryItem    = license.libraryList?.object(at: indexPath.row) as? NSDictionary
        let title          = libraryItem?.value(forKey: "title") as? String
        let url            = libraryItem?.value(forKey: "url") as? String
        let desc           = libraryItem?.value(forKey: "desc") as? String
        
        if licenseViewStyle == .DESC {
            showLicenseDesc(title: title, desc: desc ?? "")
        }
        else {
            openUrl(title: title, url: url)
        }
    }
    
    func showLicenseDesc(title: String?, desc:String){
        let alert = UIAlertController(title: title, message: desc, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (ACTION :UIAlertAction!)in
            //println("User click Ok button")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openUrl(title:String?, url:String?){
        if let title = title {
            analytics?.libraryClicked(libName: title)
        }
        if let url = url {
            UIApplication.shared.openURL(NSURL(string : url)! as URL)
        }
    }
}
