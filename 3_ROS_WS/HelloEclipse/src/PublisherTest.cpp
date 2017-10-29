#include "ros/ros.h"
#include "std_msgs/String.h"
#include <sstream>

int main(int argc, char** argv)
{
	ros::init(argc, argv, "PublisherTest");
	ros::NodeHandle n;
	ros::Publisher chatter_pub = n.advertise<std_msgs::String>("message", 1000);
	ros::Rate loop_rate(10);
	int index(0);
	while(ros::ok())
	{
		std_msgs::String msg;
		std::stringstream ss;
		ss << "I am the Publisher-Node";
		ss << "Index: ";
		ss << index;
		index++;
		msg.data = ss.str();
		chatter_pub.publish(msg);
		ros::spinOnce();
		loop_rate.sleep();
	}
}
