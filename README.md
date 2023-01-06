# StravaSwiftSDK

This is an **!unofficial & WIP!** easy to use StravaSDK written in Swift for iOS and macOS. It uses async/await for the requests. It handles the OAuth authentication with another swift package i wrote ([OAuth](https://github.com/tomislaveric/oauth)). It will have all API endpoints implemented and all models.

### Currently working API endpoints
- [x] `GET /athlete/activities`
- [x] `GET /athlete`
- [x] `GET /athlete/zones`
- [x] `GET /activities/{id}`
- [x] `GET /activities/{id}/zones`
- [x] `GET /activities/{id}/laps`
- [ ] .. TBD

### Currently added [Strava API](https://developers.strava.com/docs/reference/) Models
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
- [ ] ActivityStats
- [ ] ActivityTotal
- [ ] BaseStream
- [ ] Comment
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
- [ ] SummaryAthlete
- [ ] TemperatureStream
- [ ] TimeStream
- [ ] DetailedClub
- [ ] ActivityType -> (Deprecated)
