//
//  PopularMovieVC.swift
//  MoviesApp
//
//  Created by Muhammad Ahmad on 24/11/2023.
//

import UIKit

struct MovieDataCache {
    static var populorMovieName: GetClientListByName?
}
class PopularMovieVC: UIViewController {

    //Marks:- Outlets
    @IBOutlet weak var poplourTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetPopulorMovieName ()
        poplourTableView.delegate = self
        poplourTableView.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 2)
        {
            self.poplourTableView.reloadData()
        }
        self.title = "Popular Movies"
    }
    
 //Mark:- Function
    func GetPopulorMovieName ()
    {
        let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjExYmZmYWFlZDMxMzFmNzZhYjRlNjA4NWM4MDRhZiIsInN1YiI6IjY1NjBkMDMyMzY3OWExMDk3OTA1MzFkNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.cxt4065CMT7XdtvdwvaYvqoKveePuQ4PeYDf1TLn2Q0"
        
        ServerManager.withoutParmsFetchApiDataPostAppJson(APIMethodName: APIMethods.popularMovie.rawValue, Token: token) { (Result : GetClientListByName?) in
            
            //== check if api is responding or not
            guard Result != nil else {
               print("Some Thing Went Wrong")
                return
            }
            
            GlobalData.PopulorMovieName = Result!
          
            print(Result!)

        }
        
    }
    
    

}

extension PopularMovieVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GlobalData.PopulorMovieName?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.poplourTableView.dequeueReusableCell(withIdentifier: "PopularMovieCell") as! PopularMovieCell
        cell.lblPopularMovieName.text = GlobalData.PopulorMovieName?.results?[indexPath.row].originalTitle
        return cell
    }
    
    
}
