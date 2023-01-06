import Foundation

// MARK: - ActivityStats
/// A set of rolled-up statistics and totals for an athlete
/// source: https://developers.strava.com/docs/reference/#api-models-ActivityStats
public struct ActivityStats: Decodable, Equatable {
    /// The longest distance ridden by the athlete.
    public let biggest_ride_distance: Double?
    /// The highest climb ridden by the athlete.
    public let biggest_climb_elevation_gain: Double?
    /// The recent (last 4 weeks) ride stats for the athlete.
    public let recent_ride_totals: ActivityTotal?
    /// The recent (last 4 weeks) run stats for the athlete.
    public let recent_run_totals: ActivityTotal?
    /// The recent (last 4 weeks) swim stats for the athlete.
    public let recent_swim_totals: ActivityTotal?
    /// The year to date ride stats for the athlete.
    public let ytd_ride_totals: ActivityTotal?
    /// The year to date run stats for the athlete.
    public let ytd_run_totals: ActivityTotal?
    /// The year to date swim stats for the athlete.
    public let ytd_swim_totals: ActivityTotal?
    /// The all time ride stats for the athlete.
    public let all_ride_totals: ActivityTotal?
    /// The all time run stats for the athlete.
    public let all_run_totals: ActivityTotal?
    /// The all time swim stats for the athlete.
    public let all_swim_totals: ActivityTotal?
    
}
