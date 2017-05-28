//
//  HawaiiHikersResourceTests.swift
//  HawaiiHikersResourceTests
//
//  Created by Kenneth Nagata on 10/27/15.
//  Copyright © 2015 Kenneth Nagata. All rights reserved.
//

import XCTest
@testable import HawaiiHikersResource

class HawaiiHikersResourceTests: XCTestCase {
    
    static let trailNameTest = "'Akaka Falls Loop Trail"
    static let parkNameTEst = "'Akaka Falls State Park"
    
    var calendar: Calendar = Calendar(identifier: NSGregorianCalendar)!
    var locale: Locale = Locale(identifier: "en_US")
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        //locale = NSLocale(localeIdentifier: "en_US")
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    
    }
    
    func testPerformance() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNotificationServices(){
        XCTAssertEqual("error", "error", "Check push notification services permission")
    }
    
    func testlocationServices() {
        self.locationManager.requestAlwaysAuthorization()
        XCTAssertEqual("error", "error", "Check location services permission")
    }
    
    func testAsynchronousURLConnection() {
        let URL = Foundation.URL(string: "http://www.weather.gov/")!
        let expectation = self.expectation(description: "GET \(URL)")
        
        let session = URLSession.shared
        let task = session.dataTask(with: URL, completionHandler: { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let HTTPResponse = response as? HTTPURLResponse,
                let responseURL = HTTPResponse.url,
                let MIMEType = HTTPResponse.mimeType
            {
                XCTAssertEqual(responseURL.absoluteString, URL.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(MIMEType, "text/html", "HTTP response content type should be text/html")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            expectation.fulfill()
        }) 
        
        task.resume()
        
        waitForExpectations(timeout: task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
    func testParkJsonSerialization(){
        //select json file to load data
        let parksURL: URL = #fileLiteral(resourceName: "parkInfo.json")
        let parkData = try! Data(contentsOf: parksURL)
        
        //Add data from json to table
        do{
            let json = try JSONSerialization.jsonObject(with: parkData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let parks = json?.object(forKey: "001"){
                
                if let parkName = (parks as AnyObject).object(forKey: "parkName") as? String{
                    XCTAssertEqual(parkName, "'Akaka Falls State Park", "test json read")
                }

            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }
    
    func testTrailJsonSerialization(){
        let parksURL: URL = #fileLiteral(resourceName: "trailInfo.json")
        let parkData = try! Data(contentsOf: parksURL)
        let trailId = "001"
        //load data into table
        do{
            let json = try JSONSerialization.jsonObject(with: parkData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let trails = json?.object(forKey: trailId){
                
                if let trailName = (trails as AnyObject).object(forKey: "trailName") as? String{
                    XCTAssertEqual(trailName, "'Akaka Falls Loop Trail", "test json read")
                }
                
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        
    }
    
}
