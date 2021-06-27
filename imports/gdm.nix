{ config, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
			<monitors version="2">
				<configuration>
					<logicalmonitor>
						<x>0</x>
						<y>0</y>
						<scale>2</scale>
						<primary>yes</primary>
						<monitor>
							<monitorspec>
								<connector>DP-1</connector>
								<vendor>AOC</vendor>
								<product>U2790B</product>
								<serial>0x0002c15c</serial>
							</monitorspec>
							<mode>
								<width>3840</width>
								<height>2160</height>
								<rate>59.996623992919922</rate>
							</mode>
						</monitor>
					</logicalmonitor>
				</configuration>
			</monitors>
    ''}"
  ];
}
