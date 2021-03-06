open Ros_messages;; 
open Imandra_prelude;;

type incoming_msg = 
  | Clock  of Rosgraph_msgs.clock
  | Sensor of Sensor_msgs.laserScan

type outgoing_msg =
  | Twist of Geometry_msgs.twist

type direction = CW | CCW 
type mode = Driving | Turning 

type state =
  { mode : mode
  ; min_range : int option
  ; direction : direction option
  ; incoming  : incoming_msg option
  ; outgoing  : outgoing_msg option 
  }

let init_state = 
  { mode      = Driving 
  ; min_range = None
  ; direction = None
  ; incoming  = None
  ; outgoing  = None 
  }

let fold_left_i f acc lst = 
  let rec scan lst acc i = 
    match lst with
    | h::tl -> scan tl (f h acc i) (i+1) 
    | [] -> acc
    in 
  scan lst acc 0

let get_min_and_direction msg =
  let max = msg.Sensor_msgs.laserScan_range_max in
  let lst = msg.Sensor_msgs.laserScan_ranges in
  let min = fold_left_i 
    (fun a b i -> if a < fst b then (a,i) else b) (max, 0) in
  let min_range, idx = min lst in
  if idx < List.length lst / 2 then min_range, CW else min_range, CCW
  
let make_twist_message v omega=
  let open Geometry_msgs in
  let mkvector x y z = { vector3_x = x; vector3_y = y; vector3_z = z } in 
  Twist { twist_linear  = mkvector v 0 0
        ; twist_angular = mkvector 0 0 omega 
        } 

let print_state state =
  let mode = match state.mode with Driving -> "Driving" | Turning -> "Turning" in
  let dir = match state.direction with
    | None -> "None" | Some CW -> "CW" | Some CCW -> "CCW"
    in
  let minr = match state.min_range with 
    | None -> "None" | Some v -> string_of_int v
    in
  print_endline ( "State: " ^ mode ^ " " ^ dir ^ " " ^ minr )   

let process_clock_message state =
  match state.mode with 
  | Driving -> { state with outgoing = Some (make_twist_message 10000 0) } 
  | Turning -> begin
    match state.direction with 
    | None
    | Some ( CW ) -> { state with outgoing = Some (make_twist_message 0   10000) } 
    | Some (CCW ) -> { state with outgoing = Some (make_twist_message 0 (-10000))} 
  end

let process_sensor_message state min_range min_direction =
  match state.mode , state.min_range with 
  | Driving , _    ->
    if min_range < 20000 then 
      { state with 
        mode      = Turning
      ; direction = Some min_direction
      ; min_range = Some min_range 
      }
    else
      { state with mode = Driving; min_range = None; direction = None } 
  | Turning , None -> 
    if min_range > 25000 then 
      { state with mode = Driving; min_range = None; direction = None } 
    else
      { state with 
        direction = Some min_direction
      ; min_range = Some min_range
      } 
  | Turning , Some old_range -> 
    if min_range > 25000 then 
      { state with mode = Driving; min_range = None; direction = None } 
    else if min_range > old_range then state else 
    { state with 
      direction = Some min_direction
    ; min_range = Some min_range
    }   

  let one_step state =
  match state.incoming with None -> state | Some in_msg ->
  let state = { state with incoming = None; outgoing = None } in
  match in_msg with 
  | Sensor laserScan -> 
    let min_range, min_direction = get_min_and_direction laserScan in
    process_sensor_message state min_range min_direction
  | Clock  _ -> 
    process_clock_message state
