//
//  WFCWeatherDataBinderTests.m
//  WeatherFergCast
//
//  Created by Fergal Rooney on 3/20/14.
//  Copyright (c) 2014 Fergal Rooney. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WFCBinderFiveDayForecast.h"
#import "WFCBinderWeatherDataBase.h"
#import "WFCModelFiveDayForecast.h"
#import "WFCModelCurrentConditions.h"
#import "WFCModelSingleDayForecast.h"
#import "NSBundle+TestBundle.h"

@interface WFCWeatherDataBinderTests : XCTestCase

@end

@implementation WFCWeatherDataBinderTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 * @brief
 *      Tests that the base abstract class throws an NSAssertion when the binder
 *      method is accessed directly.
 */
- (void)testBaseClassIsAbstract
{
    WFCBinderWeatherDataBase *binder = [WFCBinderWeatherDataBase new];
    XCTAssertThrows([binder modelForWeatherData:nil parseError:nil],
                    @"Class and method are abstract, only intended to be subclassed");
}
/**
 * @brief
 *      Tests that the Simple Factory method returns the correct instance of the 
 *      Five day forecast binder.
 */
- (void) testSimpleFactory
{
    WFCBinderWeatherDataBase *binder = [WFCBinderWeatherDataBase binderForFeature:kWFCWeatherFeatureFiveDayForecast];
    XCTAssertNotNil(binder, @"A valid binder should have been returned for five day forcast");
    XCTAssert([binder isKindOfClass:[WFCBinderFiveDayForecast class]], @"Binder should be of type WFCFiveDayForecastBinder");
    
    binder = [WFCBinderWeatherDataBase binderForFeature:NSIntegerMax];
    XCTAssertNil(binder, @"Binder should be nil for unknown feature");
}
/**
 * @brief
 *      Tests that we get a nil model object back when we have a nil NSData object
 *      passed as an argument to the binder. Also tests that we get the correct error
 *      code back from the binder.
 */
- (void) testFiveDayForecastBinderNilArgument
{
    NSError *binderError = nil;
    
    WFCBinderFiveDayForecast *fiveDayForecaseBinder = [WFCBinderFiveDayForecast new];
    WFCModelDataAccessBase *model = [fiveDayForecaseBinder modelForWeatherData:nil parseError:&binderError];
    
    XCTAssertNil(model, @"Model should be nil when nil nsdata argument");
    XCTAssertNotNil(binderError, @"Binder error should not be nil");
    XCTAssertEqual(binderError.code, kWFCWeatherDataBinderErrorTypeNilArgumentError,
                   @"Nil argument should generate the correct error code.");
}
/**
 * @brief
 *      Tests that we get a nil model object back from the binder when there is a 
 *      problem parsing the response. Could be a bad JSON format. Also test that
 *      we get the correct error code back.
 */
- (void) testFiveDayForecastBinderParseError
{
    NSError *binderError = nil;
    
    WFCBinderFiveDayForecast *fiveDayForecaseBinder = [WFCBinderFiveDayForecast new];
    NSString *sampleBadResponseFilePath = [[NSBundle testBundle] pathForResource:@"SampleBadJson" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:sampleBadResponseFilePath];
    
    WFCModelDataAccessBase *model = [fiveDayForecaseBinder modelForWeatherData:data parseError:&binderError];
    XCTAssertNil(model, @"Model should be nil when nil nsdata argument");
    XCTAssertNotNil(binderError, @"Binder error should not be nil");
    XCTAssertEqual(binderError.code, kWFCWeatherDataBinderErrorTypeParsingError,
                   @"Bad response data should generate error with correct error type.");
}
/**
 * @brief
 *      Tests that we get a successful model object back from the binder when we get
 *      response expecting from the API.
 */
- (void) testFiveDayForecastBinderFullSuccess
{
    NSError *binderError = nil;
    
    WFCBinderFiveDayForecast *fiveDayForecaseBinder = [WFCBinderFiveDayForecast new];
    NSString *sampleBadResponseFilePath = [[NSBundle testBundle] pathForResource:@"SampleWeatherDubln" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:sampleBadResponseFilePath];
    
    WFCModelFiveDayForecast *model = (WFCModelFiveDayForecast *)[fiveDayForecaseBinder modelForWeatherData:data parseError:&binderError];
    XCTAssertNotNil(model, @"Model should be nil when nil nsdata argument");
    XCTAssertNil(binderError, @"Binder error should be nil");
    
    WFCModelCurrentConditions *currentConditions = model.currentConditions;
    NSArray *fiveDayForecastArray = model.fiveDayForecastArray;
    
    XCTAssertNotNil(currentConditions, @"Current Conditions Model should not be nil");
    XCTAssertNotNil(fiveDayForecastArray, @"Five day forecast array should not be nil");
    
    XCTAssertEqualObjects(currentConditions.cloudCover, @"25", @"Cloud cover should equal 25");
    XCTAssertEqualObjects(currentConditions.humidity, @"81", @"Humidity cover should equal 81");
    XCTAssertEqualObjects(currentConditions.observationTime, @"01:22 AM", @"Observation time should equal 01:22 AM");
    XCTAssertEqualObjects(currentConditions.precipMM, @"0.0", @"Precip MM should equal 0.0");
    XCTAssertEqualObjects(currentConditions.pressure, @"1000", @"Pressure should equal 1000");
    XCTAssertEqualObjects(currentConditions.tempC, @"4", @"Temp C should equal 4");
    XCTAssertEqualObjects(currentConditions.tempF, @"39", @"Temp F should equal 39");
    XCTAssertEqualObjects(currentConditions.visibility, @"10", @"Visibility should equal 10");
    XCTAssertEqualObjects(currentConditions.weatherCode, @"113", @"Weather code should equal 113");
    XCTAssertEqualObjects(currentConditions.weatherDescription, @"Clear", @"Weather description should equal clear");
    XCTAssertEqualObjects(currentConditions.weatherIconUrl, @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0008_clear_sky_night.png", @"Weather icon url should equal http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0008_clear_sky_night.png");
    XCTAssertEqualObjects(currentConditions.windDir16Point, @"SW", @"Wind Dir 16 point should equal SW");
    XCTAssertEqualObjects(currentConditions.windDirDegree, @"230", @"Wind Dir Degree should equal 230");
    XCTAssertEqualObjects(currentConditions.windSpeedKilometersPerHour, @"28", @"Wind speed kmph should equal 28");
    XCTAssertEqualObjects(currentConditions.windSpeedMilesPerHour, @"17", @"Wind Dir mph should equal 17");
    
    XCTAssert([fiveDayForecastArray count] == 5, @"There should be 5 Single Day forecast objects");
    
    WFCModelSingleDayForecast *singleDayForecast = fiveDayForecastArray[0];
    
    XCTAssertEqualObjects(singleDayForecast.date, @"2014-03-21", @"Date should equal 2014-03-21");
    XCTAssertEqualObjects(singleDayForecast.precipMM, @"2.8", @"Precip MM should equal 2.8");
    XCTAssertEqualObjects(singleDayForecast.tempMaxC, @"12", @"Temp Max C should equal 12");
    XCTAssertEqualObjects(singleDayForecast.tempMaxF, @"54", @"Temp Max F should equal 54");
    XCTAssertEqualObjects(singleDayForecast.tempMinC, @"1", @"Temp Min C should equal 1");
    XCTAssertEqualObjects(singleDayForecast.tempMinF, @"34", @"Temp Min F should equal 34");
    XCTAssertEqualObjects(singleDayForecast.weatherCode, @"119", @"Weather code should equal 119");
    XCTAssertEqualObjects(singleDayForecast.weatherDescription, @"Cloudy", @"Weather Description should equal Cloudy");
    XCTAssertEqualObjects(singleDayForecast.weatherIconUrl, @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0003_white_cloud.png", @"Weather icon url should equal http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0003_white_cloud.png");
    XCTAssertEqualObjects(singleDayForecast.windDir16Point, @"SW", @"Wind Dir 16 point should equal SW");
    XCTAssertEqualObjects(singleDayForecast.windDirDegree, @"214", @"Wind Dir Degree should equal 214");
    XCTAssertEqualObjects(singleDayForecast.windDirection, @"SW", @"Wind direction should equal SW");
    XCTAssertEqualObjects(singleDayForecast.windSpeedKilometersPerHour, @"40", @"Wind speed kmph should equal 40");
    XCTAssertEqualObjects(singleDayForecast.windSpeedMilesPerHour, @"25", @"Wind Dir mph should equal 25");
    
    singleDayForecast = fiveDayForecastArray[1];
    XCTAssertEqualObjects(singleDayForecast.date, @"2014-03-22", @"Date should equal 2014-03-22");
    XCTAssertEqualObjects(singleDayForecast.precipMM, @"1.0", @"Precip MM should equal 1.0");
    XCTAssertEqualObjects(singleDayForecast.tempMaxC, @"7", @"Temp Max C should equal 7");
    XCTAssertEqualObjects(singleDayForecast.tempMaxF, @"45", @"Temp Max F should equal 45");
    XCTAssertEqualObjects(singleDayForecast.tempMinC, @"4", @"Temp Min C should equal 4");
    XCTAssertEqualObjects(singleDayForecast.tempMinF, @"38", @"Temp Min F should equal 38");
    XCTAssertEqualObjects(singleDayForecast.weatherCode, @"116", @"Weather code should equal 116");
    XCTAssertEqualObjects(singleDayForecast.weatherDescription, @"Partly Cloudy", @"Weather Description should equal Partly Cloudy");
    XCTAssertEqualObjects(singleDayForecast.weatherIconUrl, @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png", @"Weather Icon url should equal http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png");
    XCTAssertEqualObjects(singleDayForecast.windDir16Point, @"W", @"Wind Dir 16 point should equal W");
    XCTAssertEqualObjects(singleDayForecast.windDirDegree, @"279", @"Wind Dir Degree should equal 279");
    XCTAssertEqualObjects(singleDayForecast.windDirection, @"W", @"Wind direction should equal W");
    XCTAssertEqualObjects(singleDayForecast.windSpeedKilometersPerHour, @"36", @"Wind speed kmph should equal 36");
    XCTAssertEqualObjects(singleDayForecast.windSpeedMilesPerHour, @"23", @"Wind Dir mph should equal 23");
    
    /*
     * TODO: Other 3 objects should be tested here but not needed for this example.
     */
}
/**
 * @brief
 *      Tests that we get a partial model object back from the binder in the case some
 *      of the data is missing. Mainly testing because of the dangers of a missing array
 *      in the response and want to ensure we test for that. Index out of bounds for example.
 */
- (void) testFiveDayForcaseBinderPartialSuccess
{
    WFCBinderFiveDayForecast *fiveDayForecaseBinder = [WFCBinderFiveDayForecast new];
    NSString *sampleBadResponseFilePath = [[NSBundle testBundle] pathForResource:@"SampleWeatherMissingData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:sampleBadResponseFilePath];
    NSError *binderError = nil;
    
    WFCModelFiveDayForecast *model = (WFCModelFiveDayForecast *)[fiveDayForecaseBinder modelForWeatherData:data
                                                                                                parseError:&binderError];
    
    XCTAssertNil(binderError, @"Binder error should be nil");
    XCTAssertNotNil(model, @"Model should not be nil");
    
    WFCModelCurrentConditions *currentConditons = model.currentConditions;
    XCTAssertNil(currentConditons, @"Current conditions should be nil as it was not in the response.");
    
    NSArray *fiveDayForecastArray = model.fiveDayForecastArray;
    XCTAssert([fiveDayForecastArray count] == 5, @"There should be 5 objects in the array");
    WFCModelSingleDayForecast *singleDayForecast = fiveDayForecastArray[0];
    
    XCTAssertNil(singleDayForecast.weatherIconUrl, @"Weather Icon URL is missinf and should be nil");
    XCTAssertNil(singleDayForecast.weatherDescription, @"Weather Description is missinf and should be nil");
    
}



@end
