; Place at the end of "Before layer change G-Code" section on the "Machine G-Code" tab of your printer settings
; This is to allow for more direct control over the enclosure fans
; Repects any fan ramping in the slicer for the first few layers
; NOTE: These value will apply to all filaments of the same base material
; That is, they override the filament-specific settings
; Only for auxiliary and case fans
; The S argument to M106 is an 8-bit value with a range from 0-255
; Tested on ElegooSlicer v1.1.8.2
{if layer_num >= full_fan_speed_layer[current_extruder]}
    {if filament_type[current_extruder]=="PLA"} 
      ; PLA often likes a lot of air
      M106 P2 S255 ; aux 100%
      M106 P3 S255 ; case 100%
    {if filament_type[current_extruder]=="TPU"}
      ; TPU needs to stay relatively cool
      M106 P2 S128 ; aux 50%
      M106 P3 S128 ; case 50%
    {elsif filament_type[current_extruder]=="PETG"}
      ; PETG doesn't care that much
      M106 P2 S0 ; aux 0%
      M106 P3 S100 ; case ~40%
    {endif}
    {else}
      ; Turn off the enclosure fans for any other filament
      M106 P2 S0 ; aux 0%
      M106 P3 S0 ; case 0%
    {endif}
{endif}
