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

enum Section : Int{
    case library
    case license
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
    
    public var analytics:Analytics?
    public var sectionLibraryTitle = "Licenses"
    public var sectionLicenseTitle = "License Terms"
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func loadLicenseList(name: String){
        license.loadLibraryAndLicenseList(listName: name)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        var section = 1
        if let licenseList = license.licenseList {
            if licenseList.count > 0 {
                section = section + 1
            }
        }
        return section
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if section == Section.library.rawValue {
            if let libraryList = license.libraryList {
                rows = libraryList.count
            }
        }
        else if section == Section.license.rawValue {
            if let licenseList = license.licenseList {
                rows = rows + licenseList.count
            }
        }
        return rows
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if section == Section.library.rawValue {
            title = sectionLibraryTitle
        }
        else if section == Section.license.rawValue {
            title = sectionLicenseTitle
        }
        return title
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
        
        if indexPath.section == Section.library.rawValue {
            //libraries
            let libraryItem    = license.libraryList?.object(at: indexPath.row) as? NSDictionary
            let title    = libraryItem?.value(forKey: "title") as? String
            let licenseT = libraryItem?.value(forKey: "license") as? String
            
            cell?.title.text = title
            cell?.subtitle.text = licenseT
            cell?.title.textColor = UIColor.black
        }
        else if indexPath.section == Section.license.rawValue {
            let licenseItem    = license.licenseList?.object(at: indexPath.row) as? NSDictionary
            let title    = licenseItem?.value(forKey: "title") as? String
            
            cell?.title.text = title
            cell?.subtitle.text = ""
            cell?.title.textColor = UIColor.init(hex: 0x1D79C1)
        }
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == Section.library.rawValue {
            let libraryItem    = license.libraryList?.object(at: indexPath.row) as? NSDictionary
            let title          = libraryItem?.value(forKey: "title") as? String
            let url            = libraryItem?.value(forKey: "url") as? String
            openUrl(title: title, url: url)
        }
        else if indexPath.section == Section.license.rawValue {
            let licenseItem    = license.licenseList?.object(at: indexPath.row) as? NSDictionary
            let title          = licenseItem?.value(forKey: "title") as? String
            let url            = licenseItem?.value(forKey: "url") as? String
            openUrl(title: title, url: url)
        }
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
