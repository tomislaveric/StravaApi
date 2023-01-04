import Foundation

// MARK: - SportType
/// This is a swift representation of current SportType
/// source: https://developers.strava.com/docs/reference/#api-models-SportType
public enum SportType: String, Decodable, Equatable {
    case AlpineSki
    case BackcountrySki
    case Canoeing
    case Crossfit
    case EBikeRide
    case Elliptical
    case Golf
    case Handcycle
    case Hike
    case IceSkate
    case InlineSkate
    case Kayaking
    case Kitesurf
    case NordicSki
    case MountainBikeRide
    case Ride
    case RockClimbing
    case RollerSki
    case Rowing
    case Run
    case Sail
    case Skateboard
    case Snowboard
    case Snowshoe
    case Soccer
    case StairStepper
    case StandUpPaddling
    case Surfing
    case Swim
    case Velomobile
    case VirtualRide
    case VirtualRun
    case Walk
    case WeightTraining
    case Wheelchair
    case Windsurf
    case Workout
    case Yoga
}
