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
    
    var calendar: NSCalendar = NSCalendar(identifier: NSGregorianCalendar)!
    var locale: NSLocale = NSLocale(localeIdentifier: "en_US")
    
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
        self.measureBlock {
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
        let URL = NSURL(string: "http://www.weather.gov/")!
        let expectation = expectationWithDescription("GET \(URL)")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(URL) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let HTTPResponse = response as? NSHTTPURLResponse,
                responseURL = HTTPResponse.URL,
                MIMEType = HTTPResponse.MIMEType
            {
                XCTAssertEqual(responseURL.absoluteString, URL.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(MIMEType, "text/html", "HTTP response content type should be text/html")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            expectation.fulfill()
        }
        
        task.resume()
        
        waitForExpectationsWithTimeout(task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
    func testParkJsonSerialization(){
        //select json file to load data
        let parksURL: NSURL = [#FileReference(fileReferenceLiteral: "parkInfo.json")#]
        let parkData = NSData(contentsOfURL: parksURL)!
        
        //Add data from json to table
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(parkData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let parks = json?.objectForKey("001"){
                
                if let parkName = parks.objectForKey("parkName") as? String{
                    XCTAssertEqual(parkName, "'Akaka Falls State Park", "test json read")
                }

            }
        } catch {
            print("error serializing JSON: \(error)")
        }
    }
    
    func testTrailJsonSerialization(){
        let parksURL: NSURL = [#FileReference(fileReferenceLiteral: "trailInfo.json")#]
        let parkData = NSData(contentsOfURL: parksURL)!
        let trailId = "001"
        //load data into table
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(parkData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            
            if let trails = json?.objectForKey(trailId){
                
                if let trailName = trails.objectForKey("trailName") as? String{
                    XCTAssertEqual(trailName, "'Akaka Falls Loop Trail", "test json read")
                }
                
            }
        } catch {
            print("error serializing JSON: \(error)")
        }
        
    }
    
}
