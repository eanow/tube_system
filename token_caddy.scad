include <quickthread.scad>

$fs=1;
ep=0.01;
$fa=1;

caddy_floor=1.2;
token_t=5;
token_angle=0;
token_r=25.4/2+.4;
token_outset=7.5;
token_count=2;

thread_h=4;
thread_tol=.4;
thread_d=12;
bevel=.8;

//inner smaller tube
small_tube_inner_r=77.3/2-.4;

inner_tol=1.6;
small_socket_inner_wall=2.4;

topper();

module token_slots()
{
  
  for(theta=[0:90:360])
  {
    rotate([0,0,theta])translate([token_r+token_outset,0,caddy_floor+ep])rotate([0,token_angle,0])
    {
      cylinder(r=token_r,h=token_t*token_count);
      translate([token_r,0,(token_t*token_count)/2])cube([token_r*2,token_r*1.75,token_t*token_count],center=true);
    }
  }
  
}

module stacker()
{
  difference()
  {
    //bevel the cylinder()
    hull(){
      cylinder(r=small_tube_inner_r-small_socket_inner_wall-inner_tol-bevel, h=token_t*token_count+caddy_floor);
      translate([0,0,bevel])cylinder(r=small_tube_inner_r-small_socket_inner_wall-inner_tol, h=token_t*token_count+caddy_floor-bevel*2);
    }
    token_slots();
    translate([0,0,-ep])isoThread(d=thread_d+thread_tol,h=thread_h+2,pitch=3,angle=40,internal=true,$fn=60);
    
  }
  translate([0,0,token_t*token_count+caddy_floor-ep])isoThread(d=thread_d,h=thread_h,pitch=3,angle=40,internal=false,$fn=60);
}

module topper()
{
    difference()
  {
    //bevel the cylinder()
    hull(){
      cylinder(r=small_tube_inner_r-small_socket_inner_wall-inner_tol-bevel, h=thread_h+4+caddy_floor);
      translate([0,0,bevel])cylinder(r=small_tube_inner_r-small_socket_inner_wall-inner_tol, h=thread_h+4+caddy_floor-bevel*2);
    }
    for(theta=[0:90:360])
    {
      rotate([0,0,theta])translate([token_r+token_outset,0,caddy_floor+ep])rotate([0,token_angle,0])
      {
        cylinder(r=token_r*7/8,h=token_t*token_count);
        translate([token_r,0,(token_t*token_count)/2])cube([token_r*2,token_r*1.75,token_t*token_count],center=true);
      }
    }
    translate([0,0,-ep])isoThread(d=thread_d+thread_tol,h=thread_h+2,pitch=3,angle=40,internal=true,$fn=60);
    
  }
  *translate([0,0,token_t*token_count+caddy_floor-ep])isoThread(d=thread_d,h=thread_h,pitch=3,angle=40,internal=false,$fn=60);
}