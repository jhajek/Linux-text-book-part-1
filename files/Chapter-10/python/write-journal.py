#!/usr/bin/python3

from systemd import journal

# https://pypi.org/project/systemd/
journal.send("Hello Lennart")
