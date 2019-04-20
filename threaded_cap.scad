include <quickthread.scad>
//big tube
big_tube_inner_r=101.24/2-.4;
big_tube_outer_r=105.8/2+.6;
big_socket_outer_wall=2.4;
big_socket_tube_overlap=20;
big_socket_thread_h=12;
big_socket_slope=10;
big_socket_inner_wall=2.4+.4;
printed_line=.8;
insert_roof=2;

//inner smaller tube
small_tube_inner_r=77.3/2-.4;
small_tube_outer_r=80/2+.2+.2;
small_socket_outer_wall=2.4;
small_socket_tube_overlap=20;
small_socket_thread_h=12;
small_socket_slope=10;
small_socket_inner_wall=2.4+.4;
small_inline_thread_female_d=(small_tube_inner_r)*2-.8;
small_inline_thread_male_d=(small_tube_inner_r)*2-.8-.4;
small_endcap_r=big_tube_inner_r-big_socket_inner_wall-.8;
small_cap_t=10;
small_cap_floor=2.4;

finger_r=12;
finger_l=12;
grab_outset=8;

ep=0.01;
$fs=1;
$fa=2;
bevel=1;



//outer ring test

/*difference()
{
  cylinder(r=big_tube_outer_r+4,h=5);
  cylinder(r=big_tube_outer_r,h=5*3,center=true);
}*/
//inner ring test

/*difference()
{
  cylinder(r=big_tube_inner_r,h=5);
  cylinder(r=big_tube_inner_r-4,h=5*3,center=true);
}*/
//big_socket();
small_endcap();
//small_inline_socket();
//small_inline_plug();
module big_socket()
{
  difference()
  {
    hull()
    {
      //main portion of the socket, which extends above the tube
      translate([0,0,-big_socket_tube_overlap])cylinder(r=big_tube_outer_r+big_socket_outer_wall,h=big_socket_tube_overlap+big_socket_thread_h);
      //necked down part
      translate([0,0,-big_socket_slope-big_socket_tube_overlap])cylinder(r=big_tube_outer_r+printed_line,h=big_socket_slope);
    }
    //thread
    isoThread(d=big_tube_outer_r+big_tube_inner_r,h=big_socket_thread_h+ep,pitch=3,angle=40,internal=true,$fn=60);
    //space for the inner tube
    cylinder(r=big_tube_inner_r-big_socket_inner_wall,h=100,center=true);
    translate([0,0,-big_socket_tube_overlap-big_socket_slope-ep])cylinder(r2=big_tube_inner_r-big_socket_inner_wall,r1=big_tube_inner_r-printed_line,h=big_socket_slope);
    //tube insert
    translate([0,0,-(big_socket_tube_overlap+big_socket_tube_overlap+ep)-insert_roof])difference()
    {
      cylinder(r=big_tube_outer_r,h=big_socket_tube_overlap+big_socket_tube_overlap);
      translate([0,0,-ep/2])cylinder(r=big_tube_inner_r,h=big_socket_tube_overlap+big_socket_tube_overlap+ep);
    }
  }
    
}

module small_endcap()
{
  difference()
  {
    hull()
    {
      //main portion of the socket, which extends above the tube
      translate([0,0,-small_socket_tube_overlap])hull()
      {
        translate([0,0,bevel])cylinder(r=small_endcap_r,h=small_socket_tube_overlap+small_cap_t-bevel*2);
        cylinder(r=small_endcap_r-bevel,h=small_socket_tube_overlap+small_cap_t);
      }
      //necked down part
      translate([0,0,-small_socket_slope-small_socket_tube_overlap])cylinder(r=small_tube_outer_r+printed_line,h=small_socket_slope);
    }

    //space for the inner tube
    translate([0,0,-25])cylinder(r=small_tube_inner_r-big_socket_inner_wall,h=50,center=true);
    translate([0,0,-small_socket_tube_overlap-small_socket_slope-ep])cylinder(r2=small_tube_inner_r-small_socket_inner_wall,r1=small_tube_inner_r-printed_line,h=small_socket_slope);
    //tube insert
    translate([0,0,-(small_socket_tube_overlap+small_socket_tube_overlap+ep)-insert_roof])difference()
    {
      cylinder(r=small_tube_outer_r,h=small_socket_tube_overlap+small_socket_tube_overlap);
      translate([0,0,-ep/2])cylinder(r=small_tube_inner_r,h=small_socket_tube_overlap+small_socket_tube_overlap+ep);
    }
    //finger grabs
    for(theta=[0:90:360])
    {
      rotate([0,0,theta])translate([0,0,small_cap_t])
      {
        hull()
        {
          hull()
          {
            translate([finger_r+grab_outset,0,0])cylinder(r=finger_r,h=bevel*2,center=true);
            translate([finger_r+grab_outset+finger_l,0,0])cylinder(r=finger_r,h=bevel*2,center=true);
          }
          hull()
          {
            translate([finger_r+grab_outset,0,0])cylinder(r=finger_r+bevel,h=ep,center=true);
            translate([finger_r+grab_outset+finger_l,0,0])cylinder(r=finger_r+bevel,h=ep,center=true);
          }
        }
        hull()
        {
          translate([finger_r+grab_outset,0,0])cylinder(r=finger_r,h=2*(small_cap_t-small_cap_floor),center=true);
          translate([finger_r+grab_outset+finger_l,0,0])cylinder(r=finger_r,h=2*(small_cap_t-small_cap_floor),center=true);
        }
      }
    }
  }
}

module small_inline_socket()
{
  difference()
  {
    hull()
    {
      //main portion of the socket, which extends above the tube
      translate([0,0,-small_socket_tube_overlap])cylinder(r=small_tube_outer_r-ep,h=small_socket_tube_overlap+small_socket_thread_h);
      //necked down part
      translate([0,0,-small_socket_slope-small_socket_tube_overlap])cylinder(r=small_tube_outer_r-ep,h=small_socket_slope);
    }
    //thread
    isoThread(d=small_inline_thread_female_d,h=small_socket_thread_h+ep,pitch=3,angle=40,internal=true,$fn=60);
    //space for the inner tube
    cylinder(r=small_tube_inner_r-small_socket_inner_wall,h=100,center=true);
    translate([0,0,-small_socket_tube_overlap-small_socket_slope-ep])cylinder(r2=small_tube_inner_r-small_socket_inner_wall,r1=small_tube_inner_r-printed_line,h=small_socket_slope);
    //tube insert
    translate([0,0,-(small_socket_tube_overlap+small_socket_tube_overlap+ep)-insert_roof])difference()
    {
      cylinder(r=small_tube_outer_r,h=small_socket_tube_overlap+small_socket_tube_overlap);
      translate([0,0,-ep/2])cylinder(r=small_tube_inner_r,h=small_socket_tube_overlap+small_socket_tube_overlap+ep);
    }
  }
    
}
module small_inline_plug()
{
  difference()
  {
    hull()
    {
      //main portion of the socket, which extends above the tube
      translate([0,0,-small_socket_tube_overlap])cylinder(r=small_tube_outer_r-ep,h=small_socket_tube_overlap);
      //necked down part
      translate([0,0,-small_socket_slope-small_socket_tube_overlap])cylinder(r=small_tube_outer_r-ep,h=small_socket_slope);
    }
    
    //space for the inner tube
    translate([0,0,-50-insert_roof])cylinder(r=small_tube_inner_r-small_socket_inner_wall,h=100,center=true);
    translate([0,0,-small_socket_tube_overlap-small_socket_slope-ep])cylinder(r2=small_tube_inner_r-small_socket_inner_wall,r1=small_tube_inner_r-printed_line,h=small_socket_slope);
    //tube insert
    translate([0,0,-(small_socket_tube_overlap+small_socket_tube_overlap+ep)-insert_roof])difference()
    {
      cylinder(r=small_tube_outer_r,h=small_socket_tube_overlap+small_socket_tube_overlap);
      translate([0,0,-ep/2])cylinder(r=small_tube_inner_r,h=small_socket_tube_overlap+small_socket_tube_overlap+ep);
    }
  }
  //thread
  isoThread(d=small_inline_thread_male_d,h=small_socket_thread_h+ep,pitch=3,angle=40,internal=false,$fn=60);
    
}
  

/*difference()
{
  translate([0,0,1])cylinder(d=22,h=10,$fn=6);
  render(convexity=5)

  isoThread(d=15.6,h=15,pitch=3,angle=40,internal=true,$fn=60);
}*/