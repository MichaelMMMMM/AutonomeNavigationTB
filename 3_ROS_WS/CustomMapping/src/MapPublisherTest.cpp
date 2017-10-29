#include "ros/ros.h"
#include "nav_msgs/OccupancyGrid.h"
#include <sstream>

int main(int argc, char** argv)
{
	ros::init(argc, argv, "MapPublisherTest");
	ros::NodeHandle n;
	ros::Publisher chatter_pub = n.advertise<nav_msgs::OccupancyGrid>("CustomMap", 1000);
	ros::Rate loop_rate(10);

	nav_msgs::OccupancyGrid map;
	map.info.map_load_time = ros::Time::now();	//The time at which the map was loaded
	map.info.resolution    = 0.1F; 				//The map resolution [m/cell]
	map.info.width         = 200U;				//Map width [cells]
	map.info.height	 	   = 200U;				//Map height [cells]
	//The origin of the map [m,m,rad]
	map.info.origin.position.x    = -10.0F;
	map.info.origin.position.y    = -10.0F;
	map.info.origin.position.z    = -10.0F;
	map.info.origin.orientation.x = 0.0F;
	map.info.origin.orientation.y = 0.0F;
	map.info.origin.orientation.z = 0.0F;
	map.info.origin.orientation.w = 0.0F;

	char myMap[200][200] = {0U};

	for(int x = 0; x < 100; x++)
	{
		myMap[50+x][50]  = 100;
		myMap[50+x][150] = 100;
		myMap[50][50+x]  = 100;
		myMap[150][50+x] = 100;
	}

	map.data[1] = 1;
	//map.data = myMap[0];

	unsigned long seq(0U);

	while(ros::ok())
	{
		map.header.seq = seq;
		seq++;
		map.header.stamp = ros::Time::now();

		chatter_pub.publish(map);
		ros::spinOnce();
		loop_rate.sleep();
	}
}
