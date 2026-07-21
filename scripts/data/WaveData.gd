extends Node
## Defines all 30 waves. Each wave is a dictionary of groups to spawn.
## group format: { enemy: String, count: int, interval: float, delay: float }

static func get_all_waves() -> Array:
	return [
		# Round 1 - Tutorial: just cultists
		{"groups": [{"enemy":"cultist","count":6,"interval":2.0,"delay":0.0}]},
		# Round 2
		{"groups": [{"enemy":"cultist","count":10,"interval":1.5,"delay":0.0}]},
		# Round 3 - first deep ones
		{"groups": [{"enemy":"cultist","count":8,"interval":1.5,"delay":0.0},{"enemy":"deep_one","count":2,"interval":3.0,"delay":4.0}]},
		# Round 4
		{"groups": [{"enemy":"cultist","count":10,"interval":1.2,"delay":0.0},{"enemy":"deep_one","count":4,"interval":2.5,"delay":3.0}]},
		# Round 5 - first mist wraith
		{"groups": [{"enemy":"cultist","count":8,"interval":1.2,"delay":0.0},{"enemy":"mist_wraith","count":3,"interval":2.0,"delay":5.0}]},
		# Round 6
		{"groups": [{"enemy":"deep_one","count":6,"interval":2.0,"delay":0.0},{"enemy":"mist_wraith","count":4,"interval":2.0,"delay":4.0}]},
		# Round 7
		{"groups": [{"enemy":"cultist","count":12,"interval":1.0,"delay":0.0},{"enemy":"deep_one","count":5,"interval":2.0,"delay":2.0}]},
		# Round 8
		{"groups": [{"enemy":"mist_wraith","count":6,"interval":1.5,"delay":0.0},{"enemy":"deep_one","count":6,"interval":2.0,"delay":3.0}]},
		# Round 9 - first brine brute
		{"groups": [{"enemy":"cultist","count":10,"interval":1.0,"delay":0.0},{"enemy":"brine_brute","count":1,"interval":5.0,"delay":6.0}]},
		# Round 10 - milestone
		{"groups": [{"enemy":"deep_one","count":8,"interval":1.5,"delay":0.0},{"enemy":"mist_wraith","count":5,"interval":1.5,"delay":3.0},{"enemy":"brine_brute","count":2,"interval":5.0,"delay":8.0}]},
		# Round 11
		{"groups": [{"enemy":"cultist","count":15,"interval":0.9,"delay":0.0},{"enemy":"brine_brute","count":2,"interval":4.0,"delay":5.0}]},
		# Round 12
		{"groups": [{"enemy":"deep_one","count":10,"interval":1.3,"delay":0.0},{"enemy":"mist_wraith","count":6,"interval":1.5,"delay":4.0}]},
		# Round 13 - first oracle
		{"groups": [{"enemy":"cultist","count":12,"interval":1.0,"delay":0.0},{"enemy":"oracle_of_rot","count":1,"interval":5.0,"delay":8.0}]},
		# Round 14
		{"groups": [{"enemy":"deep_one","count":10,"interval":1.2,"delay":0.0},{"enemy":"oracle_of_rot","count":2,"interval":6.0,"delay":6.0}]},
		# Round 15 - midpoint
		{"groups": [{"enemy":"brine_brute","count":3,"interval":4.0,"delay":0.0},{"enemy":"mist_wraith","count":8,"interval":1.2,"delay":5.0},{"enemy":"oracle_of_rot","count":2,"interval":5.0,"delay":8.0}]},
		# Round 16
		{"groups": [{"enemy":"cultist","count":20,"interval":0.8,"delay":0.0},{"enemy":"deep_one","count":8,"interval":1.2,"delay":4.0}]},
		# Round 17
		{"groups": [{"enemy":"brine_brute","count":4,"interval":3.5,"delay":0.0},{"enemy":"oracle_of_rot","count":3,"interval":4.0,"delay":5.0}]},
		# Round 18
		{"groups": [{"enemy":"mist_wraith","count":10,"interval":1.0,"delay":0.0},{"enemy":"deep_one","count":10,"interval":1.2,"delay":3.0}]},
		# Round 19
		{"groups": [{"enemy":"cultist","count":15,"interval":0.7,"delay":0.0},{"enemy":"brine_brute","count":3,"interval":3.5,"delay":4.0},{"enemy":"oracle_of_rot","count":3,"interval":4.0,"delay":8.0}]},
		# Round 20 - milestone
		{"groups": [{"enemy":"deep_one","count":12,"interval":1.0,"delay":0.0},{"enemy":"mist_wraith","count":8,"interval":1.0,"delay":4.0},{"enemy":"brine_brute","count":4,"interval":3.5,"delay":8.0}]},
		# Round 21 - first spawn of sleeper
		{"groups": [{"enemy":"cultist","count":20,"interval":0.7,"delay":0.0},{"enemy":"spawn_of_the_sleeper","count":1,"interval":10.0,"delay":15.0}]},
		# Round 22
		{"groups": [{"enemy":"deep_one","count":12,"interval":1.0,"delay":0.0},{"enemy":"oracle_of_rot","count":4,"interval":4.0,"delay":5.0},{"enemy":"spawn_of_the_sleeper","count":1,"interval":10.0,"delay":12.0}]},
		# Round 23
		{"groups": [{"enemy":"brine_brute","count":5,"interval":3.0,"delay":0.0},{"enemy":"mist_wraith","count":12,"interval":0.9,"delay":5.0}]},
		# Round 24
		{"groups": [{"enemy":"cultist","count":25,"interval":0.6,"delay":0.0},{"enemy":"spawn_of_the_sleeper","count":2,"interval":8.0,"delay":12.0}]},
		# Round 25 - milestone
		{"groups": [{"enemy":"deep_one","count":15,"interval":0.9,"delay":0.0},{"enemy":"brine_brute","count":5,"interval":3.0,"delay":5.0},{"enemy":"oracle_of_rot","count":5,"interval":3.5,"delay":8.0}]},
		# Round 26
		{"groups": [{"enemy":"mist_wraith","count":15,"interval":0.8,"delay":0.0},{"enemy":"spawn_of_the_sleeper","count":2,"interval":8.0,"delay":10.0}]},
		# Round 27
		{"groups": [{"enemy":"cultist","count":20,"interval":0.5,"delay":0.0},{"enemy":"deep_one","count":15,"interval":0.8,"delay":4.0},{"enemy":"brine_brute","count":4,"interval":3.0,"delay":10.0}]},
		# Round 28
		{"groups": [{"enemy":"oracle_of_rot","count":6,"interval":3.0,"delay":0.0},{"enemy":"spawn_of_the_sleeper","count":3,"interval":7.0,"delay":8.0}]},
		# Round 29
		{"groups": [{"enemy":"cultist","count":25,"interval":0.5,"delay":0.0},{"enemy":"mist_wraith","count":15,"interval":0.7,"delay":5.0},{"enemy":"brine_brute","count":6,"interval":2.5,"delay":10.0}]},
		# Round 30 - FINAL BOSS WAVE
		{"groups": [
			{"enemy":"cultist","count":20,"interval":0.5,"delay":0.0},
			{"enemy":"deep_one","count":15,"interval":0.8,"delay":5.0},
			{"enemy":"mist_wraith","count":12,"interval":0.8,"delay":8.0},
			{"enemy":"oracle_of_rot","count":6,"interval":2.5,"delay":12.0},
			{"enemy":"brine_brute","count":5,"interval":3.0,"delay":14.0},
			{"enemy":"spawn_of_the_sleeper","count":4,"interval":6.0,"delay":20.0}
		]},
		{"groups": [{"enemy":"cultist","count":22,"interval":0.48,"delay":0.0},{"enemy":"deep_one","count":13,"interval":0.89,"delay":8.3}]},
		{"groups": [{"enemy":"cultist","count":25,"interval":0.47,"delay":0.0},{"enemy":"deep_one","count":15,"interval":0.87,"delay":8.9}]},
		{"groups": [{"enemy":"deep_one","count":16,"interval":0.85,"delay":0.0},{"enemy":"cultist","count":27,"interval":0.46,"delay":9.8}]},
		{"groups": [{"enemy":"deep_one","count":18,"interval":0.84,"delay":0.0},{"enemy":"cultist","count":30,"interval":0.44,"delay":10.6}]},
		{"groups": [{"enemy":"deep_one","count":19,"interval":0.83,"delay":0.0},{"enemy":"mist_wraith","count":16,"interval":0.62,"delay":10.9},{"enemy":"deep_one","count":19,"interval":0.83,"delay":18.8}]},
		{"groups": [{"enemy":"cultist","count":34,"interval":0.41,"delay":0.0},{"enemy":"spawn_of_the_sleeper","count":3,"interval":4.91,"delay":10.0},{"enemy":"oracle_of_rot","count":7,"interval":1.91,"delay":20.3}]},
		{"groups": [{"enemy":"mist_wraith","count":18,"interval":0.59,"delay":0.0},{"enemy":"cultist","count":37,"interval":0.4,"delay":8.3},{"enemy":"mist_wraith","count":18,"interval":0.59,"delay":18.7}]},
		{"groups": [{"enemy":"mist_wraith","count":20,"interval":0.58,"delay":0.0},{"enemy":"cultist","count":39,"interval":0.4,"delay":8.8},{"enemy":"brine_brute","count":10,"interval":2.38,"delay":19.6}]},
		{"groups": [{"enemy":"cultist","count":42,"interval":0.4,"delay":0.0},{"enemy":"mist_wraith","count":21,"interval":0.56,"delay":11.4},{"enemy":"cultist","count":42,"interval":0.4,"delay":20.3}]},
		{"groups": [{"enemy":"deep_one","count":26,"interval":0.75,"delay":0.0},{"enemy":"oracle_of_rot","count":9,"interval":1.85,"delay":12.8},{"enemy":"cultist","count":44,"interval":0.4,"delay":24.1},{"enemy":"deep_one","count":26,"interval":0.75,"delay":35.9}]},
		{"groups": [{"enemy":"deep_one","count":28,"interval":0.74,"delay":0.0},{"enemy":"cultist","count":46,"interval":0.4,"delay":13.4},{"enemy":"deep_one","count":28,"interval":0.74,"delay":25.6},{"enemy":"oracle_of_rot","count":9,"interval":1.83,"delay":38.9}]},
		{"groups": [{"enemy":"mist_wraith","count":24,"interval":0.52,"delay":0.0},{"enemy":"cultist","count":49,"interval":0.4,"delay":9.2},{"enemy":"deep_one","count":29,"interval":0.72,"delay":22.0},{"enemy":"cultist","count":49,"interval":0.4,"delay":35.5}]},
		{"groups": [{"enemy":"cultist","count":51,"interval":0.4,"delay":0.0},{"enemy":"brine_brute","count":13,"interval":2.31,"delay":13.2},{"enemy":"cultist","count":51,"interval":0.4,"delay":31.2},{"enemy":"mist_wraith","count":26,"interval":0.5,"delay":44.4}]},
		{"groups": [{"enemy":"deep_one","count":32,"interval":0.69,"delay":0.0},{"enemy":"mist_wraith","count":27,"interval":0.49,"delay":14.0},{"enemy":"brine_brute","count":13,"interval":2.29,"delay":23.7},{"enemy":"cultist","count":54,"interval":0.4,"delay":41.5}]},
		{"groups": [{"enemy":"cultist","count":56,"interval":0.4,"delay":0.0},{"enemy":"mist_wraith","count":28,"interval":0.47,"delay":14.2},{"enemy":"cultist","count":56,"interval":0.4,"delay":23.8},{"enemy":"deep_one","count":34,"interval":0.68,"delay":38.0},{"enemy":"cultist","count":56,"interval":0.4,"delay":52.5}]},
		{"groups": [{"enemy":"oracle_of_rot","count":12,"interval":1.76,"delay":0.0},{"enemy":"deep_one","count":35,"interval":0.66,"delay":13.6},{"enemy":"brine_brute","count":15,"interval":2.26,"delay":28.1},{"enemy":"oracle_of_rot","count":12,"interval":1.76,"delay":48.1},{"enemy":"cultist","count":58,"interval":0.4,"delay":61.6}]},
		{"groups": [{"enemy":"deep_one","count":36,"interval":0.65,"delay":0.0},{"enemy":"mist_wraith","count":30,"interval":0.44,"delay":14.7},{"enemy":"deep_one","count":36,"interval":0.65,"delay":24.3},{"enemy":"mist_wraith","count":30,"interval":0.44,"delay":39.0},{"enemy":"brine_brute","count":15,"interval":2.25,"delay":48.6}]},
		{"groups": [{"enemy":"mist_wraith","count":32,"interval":0.43,"delay":0.0},{"enemy":"cultist","count":63,"interval":0.4,"delay":9.9},{"enemy":"oracle_of_rot","count":13,"interval":1.73,"delay":25.5},{"enemy":"deep_one","count":38,"interval":0.63,"delay":39.7},{"enemy":"spawn_of_the_sleeper","count":6,"interval":4.73,"delay":54.7}]},
		{"groups": [{"enemy":"cultist","count":66,"interval":0.4,"delay":0.0},{"enemy":"mist_wraith","count":33,"interval":0.41,"delay":16.2},{"enemy":"cultist","count":66,"interval":0.4,"delay":26.0},{"enemy":"oracle_of_rot","count":13,"interval":1.72,"delay":42.2},{"enemy":"mist_wraith","count":33,"interval":0.41,"delay":56.3}]},
		{"groups": [{"enemy":"mist_wraith","count":34,"interval":0.4,"delay":0.0},{"enemy":"deep_one","count":41,"interval":0.6,"delay":9.8},{"enemy":"brine_brute","count":17,"interval":2.2,"delay":25.1},{"enemy":"deep_one","count":41,"interval":0.6,"delay":46.8},{"enemy":"mist_wraith","count":34,"interval":0.4,"delay":62.1},{"enemy":"spawn_of_the_sleeper","count":7,"interval":4.7,"delay":71.9}]},
		{"groups": [{"enemy":"deep_one","count":42,"interval":0.58,"delay":0.0},{"enemy":"brine_brute","count":18,"interval":2.19,"delay":15.2},{"enemy":"cultist","count":70,"interval":0.4,"delay":37.9},{"enemy":"oracle_of_rot","count":14,"interval":1.69,"delay":54.9},{"enemy":"cultist","count":70,"interval":0.4,"delay":69.7},{"enemy":"brine_brute","count":18,"interval":2.19,"delay":86.7}]},
		{"groups": [{"enemy":"spawn_of_the_sleeper","count":7,"interval":4.67,"delay":0.0},{"enemy":"cultist","count":73,"interval":0.4,"delay":19.3},{"enemy":"oracle_of_rot","count":15,"interval":1.67,"delay":36.9},{"enemy":"mist_wraith","count":36,"interval":0.4,"delay":52.5},{"enemy":"spawn_of_the_sleeper","count":7,"interval":4.67,"delay":62.7},{"enemy":"deep_one","count":44,"interval":0.57,"delay":82.0}]},
		{"groups": [{"enemy":"brine_brute","count":19,"interval":2.16,"delay":0.0},{"enemy":"spawn_of_the_sleeper","count":8,"interval":4.66,"delay":23.5},{"enemy":"mist_wraith","count":38,"interval":0.4,"delay":45.2},{"enemy":"oracle_of_rot","count":15,"interval":1.66,"delay":55.8},{"enemy":"spawn_of_the_sleeper","count":8,"interval":4.66,"delay":71.2},{"enemy":"mist_wraith","count":38,"interval":0.4,"delay":92.9}]},
		{"groups": [{"enemy":"spawn_of_the_sleeper","count":8,"interval":4.64,"delay":0.0},{"enemy":"cultist","count":78,"interval":0.4,"delay":21.6},{"enemy":"brine_brute","count":19,"interval":2.14,"delay":40.2},{"enemy":"mist_wraith","count":39,"interval":0.4,"delay":63.5},{"enemy":"spawn_of_the_sleeper","count":8,"interval":4.64,"delay":74.3},{"enemy":"deep_one","count":47,"interval":0.54,"delay":95.8}]},
		{"groups": [{"enemy":"cultist","count":80,"interval":0.4,"delay":0.0},{"enemy":"spawn_of_the_sleeper","count":8,"interval":4.62,"delay":19.0},{"enemy":"cultist","count":80,"interval":0.4,"delay":40.5},{"enemy":"oracle_of_rot","count":16,"interval":1.62,"delay":59.5},{"enemy":"brine_brute","count":20,"interval":2.12,"delay":75.4},{"enemy":"oracle_of_rot","count":16,"interval":1.62,"delay":99.6}]},
		{"groups": [{"enemy":"spawn_of_the_sleeper","count":8,"interval":4.61,"delay":0.0},{"enemy":"mist_wraith","count":41,"interval":0.4,"delay":21.4},{"enemy":"deep_one","count":49,"interval":0.51,"delay":32.6},{"enemy":"brine_brute","count":21,"interval":2.11,"delay":48.1},{"enemy":"oracle_of_rot","count":16,"interval":1.61,"delay":73.3},{"enemy":"spawn_of_the_sleeper","count":8,"interval":4.61,"delay":89.2}]},
		{"groups": [{"enemy":"cultist","count":85,"interval":0.4,"delay":0.0},{"enemy":"brine_brute","count":21,"interval":2.1,"delay":20.0},{"enemy":"cultist","count":85,"interval":0.4,"delay":45.0},{"enemy":"brine_brute","count":21,"interval":2.1,"delay":65.0},{"enemy":"spawn_of_the_sleeper","count":8,"interval":4.59,"delay":90.1},{"enemy":"deep_one","count":51,"interval":0.5,"delay":111.5}]},
		{"groups": [{"enemy":"mist_wraith","count":44,"interval":0.4,"delay":0.0},{"enemy":"cultist","count":87,"interval":0.4,"delay":11.8},{"enemy":"brine_brute","count":22,"interval":2.08,"delay":32.2},{"enemy":"spawn_of_the_sleeper","count":9,"interval":4.58,"delay":58.1},{"enemy":"cultist","count":87,"interval":0.4,"delay":81.7},{"enemy":"mist_wraith","count":44,"interval":0.4,"delay":102.1}]},
		{"groups": [{"enemy":"deep_one","count":54,"interval":0.47,"delay":0.0},{"enemy":"spawn_of_the_sleeper","count":9,"interval":4.57,"delay":15.7},{"enemy":"oracle_of_rot","count":18,"interval":1.56,"delay":39.3},{"enemy":"cultist","count":90,"interval":0.4,"delay":56.3},{"enemy":"oracle_of_rot","count":18,"interval":1.56,"delay":77.3},{"enemy":"brine_brute","count":22,"interval":2.06,"delay":94.3}]},
		{"groups": [{"enemy":"deep_one","count":55,"interval":0.45,"delay":0.0},{"enemy":"brine_brute","count":23,"interval":2.05,"delay":15.4},{"enemy":"deep_one","count":55,"interval":0.45,"delay":42.0},{"enemy":"oracle_of_rot","count":18,"interval":1.55,"delay":57.3},{"enemy":"deep_one","count":55,"interval":0.45,"delay":74.3},{"enemy":"mist_wraith","count":46,"interval":0.4,"delay":89.7}]},
		{"groups": [{"enemy":"brine_brute","count":24,"interval":2.04,"delay":0.0},{"enemy":"oracle_of_rot","count":19,"interval":1.54,"delay":27.5},{"enemy":"spawn_of_the_sleeper","count":9,"interval":4.54,"delay":45.1},{"enemy":"mist_wraith","count":47,"interval":0.4,"delay":68.5},{"enemy":"brine_brute","count":24,"interval":2.04,"delay":80.9},{"enemy":"oracle_of_rot","count":19,"interval":1.54,"delay":108.4}]},
		{"groups": [{"enemy":"spawn_of_the_sleeper","count":10,"interval":4.52,"delay":0.0},{"enemy":"deep_one","count":58,"interval":0.42,"delay":25.6},{"enemy":"spawn_of_the_sleeper","count":10,"interval":4.52,"delay":40.8},{"enemy":"deep_one","count":58,"interval":0.42,"delay":66.4},{"enemy":"brine_brute","count":24,"interval":2.02,"delay":81.6},{"enemy":"spawn_of_the_sleeper","count":10,"interval":4.52,"delay":108.8}]},
		{"groups": [{"enemy":"brine_brute","count":25,"interval":2.0,"delay":0.0},{"enemy":"deep_one","count":60,"interval":0.41,"delay":28.0},{"enemy":"spawn_of_the_sleeper","count":10,"interval":4.5,"delay":43.3},{"enemy":"mist_wraith","count":50,"interval":0.4,"delay":68.8},{"enemy":"cultist","count":99,"interval":0.4,"delay":81.8},{"enemy":"oracle_of_rot","count":20,"interval":1.5,"delay":104.6}]},
		{"groups": [{"enemy":"brine_brute","count":25,"interval":1.99,"delay":0.0},{"enemy":"oracle_of_rot","count":20,"interval":1.49,"delay":27.9},{"enemy":"mist_wraith","count":51,"interval":0.4,"delay":45.8},{"enemy":"spawn_of_the_sleeper","count":10,"interval":4.49,"delay":59.0},{"enemy":"cultist","count":102,"interval":0.4,"delay":84.4},{"enemy":"spawn_of_the_sleeper","count":10,"interval":4.49,"delay":107.8}]},
		{"groups": [{"enemy":"brine_brute","count":26,"interval":1.98,"delay":0.0},{"enemy":"deep_one","count":62,"interval":0.4,"delay":28.7},{"enemy":"spawn_of_the_sleeper","count":10,"interval":4.47,"delay":44.1},{"enemy":"mist_wraith","count":52,"interval":0.4,"delay":69.5},{"enemy":"brine_brute","count":26,"interval":1.98,"delay":82.9},{"enemy":"oracle_of_rot","count":21,"interval":1.48,"delay":111.6}]},
		{"groups": [{"enemy":"cultist","count":106,"interval":0.4,"delay":0.0},{"enemy":"brine_brute","count":27,"interval":1.96,"delay":24.2},{"enemy":"deep_one","count":64,"interval":0.4,"delay":53.7},{"enemy":"brine_brute","count":27,"interval":1.96,"delay":69.5},{"enemy":"deep_one","count":64,"interval":0.4,"delay":98.9},{"enemy":"spawn_of_the_sleeper","count":11,"interval":4.46,"delay":114.7}]},
		{"groups": [{"enemy":"cultist","count":109,"interval":0.4,"delay":0.0},{"enemy":"oracle_of_rot","count":22,"interval":1.45,"delay":24.8},{"enemy":"spawn_of_the_sleeper","count":11,"interval":4.45,"delay":43.8},{"enemy":"mist_wraith","count":54,"interval":0.4,"delay":71.2},{"enemy":"spawn_of_the_sleeper","count":11,"interval":4.45,"delay":85.0},{"enemy":"mist_wraith","count":54,"interval":0.4,"delay":112.5}]},
		{"groups": [{"enemy":"oracle_of_rot","count":22,"interval":1.43,"delay":0.0},{"enemy":"spawn_of_the_sleeper","count":11,"interval":4.43,"delay":18.7},{"enemy":"brine_brute","count":28,"interval":1.93,"delay":46.1},{"enemy":"spawn_of_the_sleeper","count":11,"interval":4.43,"delay":76.1},{"enemy":"cultist","count":111,"interval":0.4,"delay":103.5},{"enemy":"oracle_of_rot","count":22,"interval":1.43,"delay":128.7}]},
		{"groups": [{"enemy":"oracle_of_rot","count":23,"interval":1.42,"delay":0.0},{"enemy":"cultist","count":114,"interval":0.4,"delay":19.3},{"enemy":"mist_wraith","count":57,"interval":0.4,"delay":45.1},{"enemy":"oracle_of_rot","count":23,"interval":1.42,"delay":59.5},{"enemy":"mist_wraith","count":57,"interval":0.4,"delay":78.9},{"enemy":"spawn_of_the_sleeper","count":11,"interval":4.42,"delay":93.3}]},
	]
