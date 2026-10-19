{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 9,
			"minor": 0,
			"revision": 8,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [
			100.0,
			100.0,
			1150.0,
			380.0
		],
		"openrect": [
			0.0,
			0.0,
			490.0,
			169.0
		],
		"default_fontsize": 10.0,
		"default_fontname": "Arial Bold",
		"gridsize": [
			8.0,
			8.0
		],
		"boxanimatetime": 500,
		"boxes": [
			{
				"box": {
					"id": "obj-1",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						20.0,
						20.0,
						40.0,
						20.0
					],
					"outlettype": [
						"int"
					],
					"text": "midiin"
				}
			},
			{
				"box": {
					"id": "obj-2",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						20.0,
						60.0,
						47.0,
						20.0
					],
					"text": "midiout"
				}
			},
			{
				"box": {
					"id": "obj-3",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						200.0,
						20.0,
						90.0,
						20.0
					],
					"outlettype": [
						""
					],
					"text": "udpreceive 8000"
				}
			},
			{
				"box": {
					"id": "obj-4",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 3,
					"patching_rect": [
						200.0,
						50.0,
						170.0,
						20.0
					],
					"outlettype": [
						"",
						"",
						""
					],
					"text": "route /eeg/processed /eeg/range"
				}
			},
			{
				"box": {
					"id": "obj-5",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						200.0,
						80.0,
						50.0,
						20.0
					],
					"outlettype": [
						"float"
					],
					"text": "unpack f"
				}
			},
			{
				"box": {
					"id": "obj-6",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						200.0,
						110.0,
						75.0,
						20.0
					],
					"outlettype": [
						""
					],
					"text": "speedlim 700"
				}
			},
			{
				"box": {
					"id": "obj-7",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						200.0,
						140.0,
						80.0,
						20.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"presentation": 1,
					"presentation_rect": [
						8.0,
						128.0,
						72.0,
						18.0
					],
					"parameter_enable": 0,
					"format": 6
				}
			},
			{
				"box": {
					"id": "obj-8",
					"maxclass": "newobj",
					"numinlets": 6,
					"numoutlets": 1,
					"patching_rect": [
						200.0,
						170.0,
						160.0,
						20.0
					],
					"outlettype": [
						""
					],
					"text": "scale 119000. 122000. 35 54"
				}
			},
			{
				"box": {
					"id": "obj-9",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 1,
					"patching_rect": [
						200.0,
						200.0,
						70.0,
						20.0
					],
					"outlettype": [
						""
					],
					"text": "clip 35 54"
				}
			},
			{
				"box": {
					"id": "obj-10",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						200.0,
						230.0,
						30.0,
						20.0
					],
					"outlettype": [
						"int"
					],
					"text": "i"
				}
			},
			{
				"box": {
					"id": "obj-11",
					"maxclass": "number",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						250.0,
						230.0,
						40.0,
						20.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"presentation": 1,
					"presentation_rect": [
						392.0,
						128.0,
						40.0,
						18.0
					],
					"parameter_enable": 0
				}
			},
			{
				"box": {
					"id": "obj-12",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 2,
					"patching_rect": [
						200.0,
						260.0,
						100.0,
						20.0
					],
					"outlettype": [
						"float",
						"float"
					],
					"text": "makenote 100 500"
				}
			},
			{
				"box": {
					"id": "obj-13",
					"maxclass": "newobj",
					"numinlets": 3,
					"numoutlets": 0,
					"patching_rect": [
						200.0,
						300.0,
						60.0,
						20.0
					],
					"text": "noteout 2"
				}
			},
			{
				"box": {
					"id": "obj-14",
					"maxclass": "live.toggle",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						420.0,
						20.0,
						24.0,
						24.0
					],
					"outlettype": [
						""
					],
					"presentation": 1,
					"presentation_rect": [
						8.0,
						24.0,
						24.0,
						24.0
					],
					"parameter_enable": 1,
					"varname": "Auto Range",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Auto Range",
							"parameter_shortname": "Auto",
							"parameter_type": 2,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								1
							],
							"parameter_unitstyle": 0,
							"parameter_enum": [
								"off",
								"on"
							],
							"parameter_mmax": 1
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-15",
					"maxclass": "live.comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						450.0,
						20.0,
						70.0,
						18.0
					],
					"text": "Auto Range",
					"presentation": 1,
					"presentation_rect": [
						32.0,
						26.0,
						60.0,
						18.0
					],
					"textjustification": 1
				}
			},
			{
				"box": {
					"id": "obj-16",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						420.0,
						50.0,
						40.0,
						20.0
					],
					"outlettype": [
						"bang",
						"int"
					],
					"text": "t b i"
				}
			},
			{
				"box": {
					"id": "obj-17",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						470.0,
						80.0,
						40.0,
						20.0
					],
					"outlettype": [
						"int"
					],
					"text": "== 0"
				}
			},
			{
				"box": {
					"id": "obj-18",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						380.0,
						80.0,
						55.0,
						20.0
					],
					"outlettype": [
						""
					],
					"text": "gate 1 1"
				}
			},
			{
				"box": {
					"id": "obj-19",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						380.0,
						110.0,
						65.0,
						20.0
					],
					"outlettype": [
						"float",
						"float"
					],
					"text": "unpack f f"
				}
			},
			{
				"box": {
					"id": "obj-20",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						380.0,
						140.0,
						70.0,
						20.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"presentation": 1,
					"presentation_rect": [
						8.0,
						104.0,
						72.0,
						18.0
					],
					"parameter_enable": 0,
					"format": 6
				}
			},
			{
				"box": {
					"id": "obj-21",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						460.0,
						140.0,
						70.0,
						20.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"presentation": 1,
					"presentation_rect": [
						84.0,
						104.0,
						72.0,
						18.0
					],
					"parameter_enable": 0,
					"format": 6
				}
			},
			{
				"box": {
					"id": "obj-22",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						560.0,
						20.0,
						70.0,
						15.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						8.0,
						64.0,
						72.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "In Low",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "In Low",
							"parameter_shortname": "In Low",
							"parameter_type": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								119000.0
							],
							"parameter_unitstyle": 1,
							"parameter_mmin": 0.0,
							"parameter_mmax": 1000000.0
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-23",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						640.0,
						20.0,
						70.0,
						15.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						84.0,
						64.0,
						72.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "In High",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "In High",
							"parameter_shortname": "In High",
							"parameter_type": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								122000.0
							],
							"parameter_unitstyle": 1,
							"parameter_mmin": 0.0,
							"parameter_mmax": 1000000.0
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-24",
					"maxclass": "live.comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						560.0,
						0.0,
						140.0,
						18.0
					],
					"text": "Input range (raw EEG)",
					"presentation": 1,
					"presentation_rect": [
						8.0,
						46.0,
						150.0,
						18.0
					],
					"textjustification": 1
				}
			},
			{
				"box": {
					"id": "obj-25",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						560.0,
						50.0,
						120.0,
						20.0
					],
					"outlettype": [
						""
					],
					"text": "pak 119000. 122000."
				}
			},
			{
				"box": {
					"id": "obj-26",
					"maxclass": "newobj",
					"numinlets": 2,
					"numoutlets": 1,
					"patching_rect": [
						520.0,
						110.0,
						55.0,
						20.0
					],
					"outlettype": [
						""
					],
					"text": "gate 1 0"
				}
			},
			{
				"box": {
					"id": "obj-27",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						520.0,
						140.0,
						65.0,
						20.0
					],
					"outlettype": [
						"float",
						"float"
					],
					"text": "unpack f f"
				}
			},
			{
				"box": {
					"id": "obj-28",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						720.0,
						20.0,
						50.0,
						15.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						170.0,
						64.0,
						50.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "Note Low",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Note Low",
							"parameter_shortname": "Note Low",
							"parameter_type": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								35
							],
							"parameter_unitstyle": 8,
							"parameter_mmin": 0,
							"parameter_mmax": 127
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-29",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						780.0,
						20.0,
						50.0,
						15.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						224.0,
						64.0,
						50.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "Note High",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Note High",
							"parameter_shortname": "Note High",
							"parameter_type": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								54
							],
							"parameter_unitstyle": 8,
							"parameter_mmin": 0,
							"parameter_mmax": 127
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-30",
					"maxclass": "live.comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						720.0,
						0.0,
						80.0,
						18.0
					],
					"text": "Note range",
					"presentation": 1,
					"presentation_rect": [
						170.0,
						46.0,
						100.0,
						18.0
					],
					"textjustification": 1
				}
			},
			{
				"box": {
					"id": "obj-31",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						850.0,
						20.0,
						44.0,
						48.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						284.0,
						20.0,
						44.0,
						48.0
					],
					"parameter_enable": 1,
					"varname": "Note Every",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Note Every",
							"parameter_shortname": "Every",
							"parameter_type": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								700.0
							],
							"parameter_unitstyle": 2,
							"parameter_mmin": 50.0,
							"parameter_mmax": 2000.0
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-32",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 1,
					"patching_rect": [
						850.0,
						80.0,
						90.0,
						20.0
					],
					"outlettype": [
						""
					],
					"text": "expr 1000./$f1"
				}
			},
			{
				"box": {
					"id": "obj-33",
					"maxclass": "flonum",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						850.0,
						110.0,
						50.0,
						20.0
					],
					"outlettype": [
						"",
						"bang"
					],
					"presentation": 1,
					"presentation_rect": [
						284.0,
						104.0,
						44.0,
						18.0
					],
					"parameter_enable": 0,
					"format": 6
				}
			},
			{
				"box": {
					"id": "obj-34",
					"maxclass": "live.comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						900.0,
						110.0,
						50.0,
						18.0
					],
					"text": "notes/s",
					"presentation": 1,
					"presentation_rect": [
						284.0,
						124.0,
						44.0,
						18.0
					],
					"textjustification": 1
				}
			},
			{
				"box": {
					"id": "obj-35",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						960.0,
						20.0,
						44.0,
						48.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						336.0,
						20.0,
						44.0,
						48.0
					],
					"parameter_enable": 1,
					"varname": "Velocity",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Velocity",
							"parameter_shortname": "Velocity",
							"parameter_type": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								100
							],
							"parameter_unitstyle": 0,
							"parameter_mmin": 0,
							"parameter_mmax": 127
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-36",
					"maxclass": "live.dial",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						1010.0,
						20.0,
						44.0,
						48.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						384.0,
						20.0,
						44.0,
						48.0
					],
					"parameter_enable": 1,
					"varname": "Length",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Length",
							"parameter_shortname": "Length",
							"parameter_type": 0,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								500.0
							],
							"parameter_unitstyle": 2,
							"parameter_mmin": 20.0,
							"parameter_mmax": 4000.0
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-37",
					"maxclass": "live.numbox",
					"numinlets": 1,
					"numoutlets": 2,
					"patching_rect": [
						1060.0,
						20.0,
						40.0,
						15.0
					],
					"outlettype": [
						"",
						"float"
					],
					"presentation": 1,
					"presentation_rect": [
						436.0,
						64.0,
						40.0,
						15.0
					],
					"parameter_enable": 1,
					"varname": "Channel",
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_longname": "Channel",
							"parameter_shortname": "Channel",
							"parameter_type": 1,
							"parameter_initial_enable": 1,
							"parameter_initial": [
								2
							],
							"parameter_unitstyle": 0,
							"parameter_mmin": 1,
							"parameter_mmax": 16
						}
					}
				}
			},
			{
				"box": {
					"id": "obj-38",
					"maxclass": "live.comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						1060.0,
						0.0,
						50.0,
						18.0
					],
					"text": "MIDI ch",
					"presentation": 1,
					"presentation_rect": [
						436.0,
						46.0,
						50.0,
						18.0
					],
					"textjustification": 1
				}
			},
			{
				"box": {
					"id": "obj-39",
					"maxclass": "live.comment",
					"numinlets": 1,
					"numoutlets": 0,
					"patching_rect": [
						300.0,
						230.0,
						40.0,
						18.0
					],
					"text": "note",
					"presentation": 1,
					"presentation_rect": [
						392.0,
						108.0,
						40.0,
						18.0
					],
					"textjustification": 1
				}
			},
			{
				"box": {
					"id": "obj-40",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 3,
					"patching_rect": [
						560.0,
						200.0,
						90.0,
						20.0
					],
					"outlettype": [
						"bang",
						"int",
						"int"
					],
					"text": "live.thisdevice"
				}
			},
			{
				"box": {
					"id": "obj-41",
					"maxclass": "newobj",
					"numinlets": 1,
					"numoutlets": 9,
					"patching_rect": [
						560.0,
						230.0,
						160.0,
						20.0
					],
					"outlettype": [
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang"
					],
					"text": "t b b b b b b b b b"
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": [
						"obj-1",
						0
					],
					"destination": [
						"obj-2",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-3",
						0
					],
					"destination": [
						"obj-4",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-4",
						0
					],
					"destination": [
						"obj-5",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-5",
						0
					],
					"destination": [
						"obj-6",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-6",
						0
					],
					"destination": [
						"obj-7",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-7",
						0
					],
					"destination": [
						"obj-8",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-8",
						0
					],
					"destination": [
						"obj-9",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-9",
						0
					],
					"destination": [
						"obj-10",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						0
					],
					"destination": [
						"obj-11",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						0
					],
					"destination": [
						"obj-12",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-12",
						0
					],
					"destination": [
						"obj-13",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-12",
						1
					],
					"destination": [
						"obj-13",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-14",
						0
					],
					"destination": [
						"obj-16",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-16",
						1
					],
					"destination": [
						"obj-18",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-16",
						1
					],
					"destination": [
						"obj-17",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-4",
						1
					],
					"destination": [
						"obj-18",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-18",
						0
					],
					"destination": [
						"obj-19",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						0
					],
					"destination": [
						"obj-8",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						1
					],
					"destination": [
						"obj-8",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						0
					],
					"destination": [
						"obj-20",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-19",
						1
					],
					"destination": [
						"obj-21",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						0
					],
					"destination": [
						"obj-25",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-23",
						0
					],
					"destination": [
						"obj-25",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-16",
						0
					],
					"destination": [
						"obj-25",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-17",
						0
					],
					"destination": [
						"obj-26",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						0
					],
					"destination": [
						"obj-26",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-26",
						0
					],
					"destination": [
						"obj-27",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-27",
						0
					],
					"destination": [
						"obj-8",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-27",
						1
					],
					"destination": [
						"obj-8",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-28",
						0
					],
					"destination": [
						"obj-8",
						3
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-29",
						0
					],
					"destination": [
						"obj-8",
						4
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-28",
						0
					],
					"destination": [
						"obj-9",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-29",
						0
					],
					"destination": [
						"obj-9",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-31",
						0
					],
					"destination": [
						"obj-6",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-31",
						0
					],
					"destination": [
						"obj-32",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-32",
						0
					],
					"destination": [
						"obj-33",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-35",
						0
					],
					"destination": [
						"obj-12",
						1
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-36",
						0
					],
					"destination": [
						"obj-12",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						0
					],
					"destination": [
						"obj-13",
						2
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						0
					],
					"destination": [
						"obj-41",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						0
					],
					"destination": [
						"obj-14",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						1
					],
					"destination": [
						"obj-22",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						2
					],
					"destination": [
						"obj-23",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						3
					],
					"destination": [
						"obj-28",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						4
					],
					"destination": [
						"obj-29",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						5
					],
					"destination": [
						"obj-31",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						6
					],
					"destination": [
						"obj-35",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						7
					],
					"destination": [
						"obj-36",
						0
					]
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						8
					],
					"destination": [
						"obj-37",
						0
					]
				}
			}
		],
		"parameters": {
			"obj-14": [
				"Auto Range",
				"Auto",
				0
			],
			"obj-22": [
				"In Low",
				"In Low",
				0
			],
			"obj-23": [
				"In High",
				"In High",
				0
			],
			"obj-28": [
				"Note Low",
				"Note Low",
				0
			],
			"obj-29": [
				"Note High",
				"Note High",
				0
			],
			"obj-31": [
				"Note Every",
				"Every",
				0
			],
			"obj-35": [
				"Velocity",
				"Velocity",
				0
			],
			"obj-36": [
				"Length",
				"Length",
				0
			],
			"obj-37": [
				"Channel",
				"Channel",
				0
			],
			"parameterbanks": {
				"0": {
					"index": 0,
					"name": "",
					"parameters": [
						"Auto Range",
						"In Low",
						"In High",
						"Note Low",
						"Note High",
						"Note Every",
						"Velocity",
						"Length"
					]
				}
			},
			"inherited_shortname": 1
		},
		"dependency_cache": [],
		"latency": 0,
		"is_mpe": 0,
		"external_mpe_tuning_enabled": 0,
		"minimum_live_version": "",
		"minimum_max_version": "",
		"platform_compatibility": 0,
		"project": {
			"version": 1,
			"creationdate": 3590052786,
			"modificationdate": 3590052786,
			"viewrect": [
				0.0,
				0.0,
				300.0,
				500.0
			],
			"autoorganize": 1,
			"hideprojectwindow": 1,
			"showdependencies": 1,
			"autolocalize": 0,
			"contents": {
				"patchers": {}
			},
			"layout": {},
			"searchpath": {},
			"detailsvisible": 0,
			"amxdtype": 1835887981,
			"readonly": 0,
			"devpathtype": 0,
			"devpath": ".",
			"sortmode": 0,
			"viewmode": 0,
			"includepackages": 0
		},
		"autosave": 0,
		"saved_attribute_attributes": {
			"default_plcolor": {
				"expression": ""
			}
		},
		"oscreceiveudpport": 0,
		"openinpresentation": 1
	}
}