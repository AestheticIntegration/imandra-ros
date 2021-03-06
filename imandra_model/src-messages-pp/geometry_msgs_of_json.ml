open Json_utils;;
open Basic_types_of_json;;
open Ros_messages.Geometry_msgs;;

let json_to_point_opt json = 
    jreq json "point_x" json_to_float64_opt @@ fun point_x ->
    jreq json "point_y" json_to_float64_opt @@ fun point_y ->
    jreq json "point_z" json_to_float64_opt @@ fun point_z ->
    Some {
    point_x;
    point_y;
    point_z;
    }

let json_to_vector3_opt json = 
    jreq json "vector3_x" json_to_float64_opt @@ fun vector3_x ->
    jreq json "vector3_y" json_to_float64_opt @@ fun vector3_y ->
    jreq json "vector3_z" json_to_float64_opt @@ fun vector3_z ->
    Some {
    vector3_x;
    vector3_y;
    vector3_z;
    }

let json_to_quaternion_opt json = 
    jreq json "quaternion_x" json_to_float64_opt @@ fun quaternion_x ->
    jreq json "quaternion_y" json_to_float64_opt @@ fun quaternion_y ->
    jreq json "quaternion_z" json_to_float64_opt @@ fun quaternion_z ->
    jreq json "quaternion_w" json_to_float64_opt @@ fun quaternion_w ->
    Some {
    quaternion_x;
    quaternion_y;
    quaternion_z;
    quaternion_w;
    }

let json_to_inertia_opt json = 
    jreq json "m" json_to_float64_opt @@ fun m ->
    jreq json "com" json_to_vector3_opt @@ fun com ->
    jreq json "ixx" json_to_float64_opt @@ fun ixx ->
    jreq json "ixy" json_to_float64_opt @@ fun ixy ->
    jreq json "ixz" json_to_float64_opt @@ fun ixz ->
    jreq json "iyy" json_to_float64_opt @@ fun iyy ->
    jreq json "iyz" json_to_float64_opt @@ fun iyz ->
    jreq json "izz" json_to_float64_opt @@ fun izz ->
    Some {
    m;
    com;
    ixx;
    ixy;
    ixz;
    iyy;
    iyz;
    izz;
    }

let json_to_pose2D_opt json = 
    jreq json "pose2D_x" json_to_float64_opt @@ fun pose2D_x ->
    jreq json "pose2D_y" json_to_float64_opt @@ fun pose2D_y ->
    jreq json "pose2D_theta" json_to_float64_opt @@ fun pose2D_theta ->
    Some {
    pose2D_x;
    pose2D_y;
    pose2D_theta;
    }

let json_to_pointStamped_opt json = 
    jreq json "pointStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun pointStamped_header ->
    jreq json "pointStamped_point" json_to_point_opt @@ fun pointStamped_point ->
    Some {
    pointStamped_header;
    pointStamped_point;
    }

let json_to_point32_opt json = 
    jreq json "point32_x" json_to_float32_opt @@ fun point32_x ->
    jreq json "point32_y" json_to_float32_opt @@ fun point32_y ->
    jreq json "point32_z" json_to_float32_opt @@ fun point32_z ->
    Some {
    point32_x;
    point32_y;
    point32_z;
    }

let json_to_quaternionStamped_opt json = 
    jreq json "quaternionStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun quaternionStamped_header ->
    jreq json "quaternionStamped_quaternion" json_to_quaternion_opt @@ fun quaternionStamped_quaternion ->
    Some {
    quaternionStamped_header;
    quaternionStamped_quaternion;
    }

let json_to_transform_opt json = 
    jreq json "translation" json_to_vector3_opt @@ fun translation ->
    jreq json "rotation" json_to_quaternion_opt @@ fun rotation ->
    Some {
    translation;
    rotation;
    }

let json_to_accel_opt json = 
    jreq json "accel_linear" json_to_vector3_opt @@ fun accel_linear ->
    jreq json "accel_angular" json_to_vector3_opt @@ fun accel_angular ->
    Some {
    accel_linear;
    accel_angular;
    }

let json_to_accelWithCovariance_opt json = 
    jreq json "accelWithCovariance_accel" json_to_accel_opt @@ fun accelWithCovariance_accel ->
    jreq json "accelWithCovariance_covariance" (jlist json_to_float64_opt) @@ fun accelWithCovariance_covariance ->
    Some {
    accelWithCovariance_accel;
    accelWithCovariance_covariance;
    }

let json_to_wrench_opt json = 
    jreq json "force" json_to_vector3_opt @@ fun force ->
    jreq json "torque" json_to_vector3_opt @@ fun torque ->
    Some {
    force;
    torque;
    }

let json_to_wrenchStamped_opt json = 
    jreq json "wrenchStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun wrenchStamped_header ->
    jreq json "wrenchStamped_wrench" json_to_wrench_opt @@ fun wrenchStamped_wrench ->
    Some {
    wrenchStamped_header;
    wrenchStamped_wrench;
    }

let json_to_pose_opt json = 
    jreq json "position" json_to_point_opt @@ fun position ->
    jreq json "orientation" json_to_quaternion_opt @@ fun orientation ->
    Some {
    position;
    orientation;
    }

let json_to_twist_opt json = 
    jreq json "twist_linear" json_to_vector3_opt @@ fun twist_linear ->
    jreq json "twist_angular" json_to_vector3_opt @@ fun twist_angular ->
    Some {
    twist_linear;
    twist_angular;
    }

let json_to_vector3Stamped_opt json = 
    jreq json "vector3Stamped_header" Std_msgs_of_json.json_to_header_opt @@ fun vector3Stamped_header ->
    jreq json "vector3Stamped_vector" json_to_vector3_opt @@ fun vector3Stamped_vector ->
    Some {
    vector3Stamped_header;
    vector3Stamped_vector;
    }

let json_to_inertiaStamped_opt json = 
    jreq json "inertiaStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun inertiaStamped_header ->
    jreq json "inertiaStamped_inertia" json_to_inertia_opt @@ fun inertiaStamped_inertia ->
    Some {
    inertiaStamped_header;
    inertiaStamped_inertia;
    }

let json_to_twistStamped_opt json = 
    jreq json "twistStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun twistStamped_header ->
    jreq json "twistStamped_twist" json_to_twist_opt @@ fun twistStamped_twist ->
    Some {
    twistStamped_header;
    twistStamped_twist;
    }

let json_to_transformStamped_opt json = 
    jreq json "transformStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun transformStamped_header ->
    jreq json "transformStamped_child_frame_id" json_to_string_opt @@ fun transformStamped_child_frame_id ->
    jreq json "transformStamped_transform" json_to_transform_opt @@ fun transformStamped_transform ->
    Some {
    transformStamped_header;
    transformStamped_child_frame_id;
    transformStamped_transform;
    }

let json_to_poseStamped_opt json = 
    jreq json "poseStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun poseStamped_header ->
    jreq json "poseStamped_pose" json_to_pose_opt @@ fun poseStamped_pose ->
    Some {
    poseStamped_header;
    poseStamped_pose;
    }

let json_to_polygon_opt json = 
    jreq json "points" (jlist json_to_point32_opt) @@ fun points ->
    Some {
    points;
    }

let json_to_accelStamped_opt json = 
    jreq json "accelStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun accelStamped_header ->
    jreq json "accelStamped_accel" json_to_accel_opt @@ fun accelStamped_accel ->
    Some {
    accelStamped_header;
    accelStamped_accel;
    }

let json_to_accelWithCovarianceStamped_opt json = 
    jreq json "accelWithCovarianceStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun accelWithCovarianceStamped_header ->
    jreq json "accelWithCovarianceStamped_accel" json_to_accelWithCovariance_opt @@ fun accelWithCovarianceStamped_accel ->
    Some {
    accelWithCovarianceStamped_header;
    accelWithCovarianceStamped_accel;
    }

let json_to_poseWithCovariance_opt json = 
    jreq json "poseWithCovariance_pose" json_to_pose_opt @@ fun poseWithCovariance_pose ->
    jreq json "poseWithCovariance_covariance" (jlist json_to_float64_opt) @@ fun poseWithCovariance_covariance ->
    Some {
    poseWithCovariance_pose;
    poseWithCovariance_covariance;
    }

let json_to_poseArray_opt json = 
    jreq json "poseArray_header" Std_msgs_of_json.json_to_header_opt @@ fun poseArray_header ->
    jreq json "poseArray_poses" (jlist json_to_pose_opt) @@ fun poseArray_poses ->
    Some {
    poseArray_header;
    poseArray_poses;
    }

let json_to_polygonStamped_opt json = 
    jreq json "polygonStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun polygonStamped_header ->
    jreq json "polygonStamped_polygon" json_to_polygon_opt @@ fun polygonStamped_polygon ->
    Some {
    polygonStamped_header;
    polygonStamped_polygon;
    }

let json_to_twistWithCovariance_opt json = 
    jreq json "twistWithCovariance_twist" json_to_twist_opt @@ fun twistWithCovariance_twist ->
    jreq json "twistWithCovariance_covariance" (jlist json_to_float64_opt) @@ fun twistWithCovariance_covariance ->
    Some {
    twistWithCovariance_twist;
    twistWithCovariance_covariance;
    }

let json_to_poseWithCovarianceStamped_opt json = 
    jreq json "poseWithCovarianceStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun poseWithCovarianceStamped_header ->
    jreq json "poseWithCovarianceStamped_pose" json_to_poseWithCovariance_opt @@ fun poseWithCovarianceStamped_pose ->
    Some {
    poseWithCovarianceStamped_header;
    poseWithCovarianceStamped_pose;
    }

let json_to_twistWithCovarianceStamped_opt json = 
    jreq json "twistWithCovarianceStamped_header" Std_msgs_of_json.json_to_header_opt @@ fun twistWithCovarianceStamped_header ->
    jreq json "twistWithCovarianceStamped_twist" json_to_twistWithCovariance_opt @@ fun twistWithCovarianceStamped_twist ->
    Some {
    twistWithCovarianceStamped_header;
    twistWithCovarianceStamped_twist;
    }

