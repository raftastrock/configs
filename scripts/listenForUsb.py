#!/usr/bin/env python3

import glib
import os

from pyudev import Context, Monitor

try:
    from pyudev.glib import MonitorObserver

    def device_event(observer, device):
        print 'TRY event {0} on device {1}'.format(device.action, device)
        os.system("xmodmap ~/.Xmodmap")
except:
    from pyudev.glib import GUDevMonitorObserver as MonitorObserver

    def device_event(observer, action, device):
        print 'EXCEPT event {0} on device {1}'.format(action, device)

context = Context()
monitor = Monitor.from_netlink(context)

monitor.filter_by(subsystem='usb')
observer = MonitorObserver(monitor)

observer.connect('device-event', device_event)
monitor.start()

glib.MainLoop().run()
