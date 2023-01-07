# StravaSwiftSDK

This is an **!unofficial & WIP!** easy to use StravaSDK written in Swift for iOS and macOS. It uses async/await for the requests. It handles the OAuth authentication with another swift package i wrote ([OAuth](https://github.com/tomislaveric/oauth)). It will have all API endpoints implemented and all models.

>In the beginning i just wanted to use two Strava endpoints for my fun side project, but now i ended up implementing the whole API :). If you would like to contribute, i would really appreciate it!

## API Endpoints
### Athletes
- [x] `GET /athlete`
- [x] `GET /athlete/zones`
- [x] `GET /athlete/{id}/stats`
- [ ] `PUT /athlete`
### Activities
- [x] `GET /athlete/activities`
- [x] `GET /activities/{id}`
- [x] `GET /activities/{id}/zones`
- [x] `GET /activities/{id}/laps`
- [x] `GET /activities/{id}/comments`
- [x] `GET /activities/{id}/kudos`
- [x] `POST /activities`
- [ ] `PUT /activities/{id}`

### Segments
... To be done
### SegmentEfforts
... To be done
### Clubs
... To be done
### Gears
... To be done
### Routes
... To be done
### Uploads
... To be done
### Streams
... To be done

## Currently added [Strava API](https://developers.strava.com/docs/reference/) Models
- [x] Lap
- [x] MetaActivity
- [x] MetaAthlete
- [x] PhotosSummary
- [x] PolylineMap
- [x] Split
- [x] SportType
- [x] SummaryGear
- [x] SummaryPRSegmentEffort
- [x] SummarySegment
- [x] SummarySegmentEffort
- [x] DetailedSegmentEffort
- [x] SummaryClub
- [x] DetailedActivity
- [x] DetailedAthlete
- [x] ActivityZone
- [x] TimedZoneRange
- [x] LatLng (Implemented as Double array)
- [x] Comment
- [x] SummaryAthlete
- [x] Kudo
- [x] ActivityStats
- [x] ActivityTotal
- [ ] BaseStream
- [ ] Error
- [ ] ExplorerResponse
- [ ] ExplorerSegment
- [ ] Fault
- [ ] HeartRateZoneRanges
- [ ] MetaClub
- [ ] PhotosSummary_primary
- [ ] PowerZoneRanges
- [ ] Route
- [ ] StreamSet
- [ ] TimedZoneDistribution
- [ ] UpdatableActivity
- [ ] Upload
- [ ] ZoneRange
- [ ] ZoneRanges
- [ ] Zones
- [ ] AltitudeStream
- [ ] CadenceStream
- [ ] DetailedGear
- [ ] DetailedSegment
- [ ] DistanceStream
- [ ] HeartrateStream
- [ ] LatLngStream
- [ ] MovingStream
- [ ] PowerStream
- [ ] SmoothGradeStream
- [ ] SmoothVelocityStream
- [ ] SummaryActivity
- [ ] TemperatureStream
- [ ] TimeStream
- [ ] DetailedClub
- [ ] ActivityType -> (Deprecated)
