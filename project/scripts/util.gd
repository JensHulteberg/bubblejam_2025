extends Node

signal gathered_signal
var counter: int = 0
var mutex: Mutex

func _ready():
	mutex = Mutex.new()

func await_signals(signals: Array):
	if signals.size() == 0:
		return
	
	mutex.lock()
	var fingerprint = counter
	counter += 1
	mutex.unlock()
	
	var emitteds = []
	for index in range(signals.size()):
		var signal_callback = func callback(
			_arg0=null,
			_arg1=null,
			_arg2=null,
			_arg3=null,
			_arg4=null,
			_arg5=null,
			_arg6=null,
			_arg7=null,
			_arg8=null,
			_arg9=null, # this ugly hack allows signals with up to 10 arguments
		):
			emitteds[index] = true
			var all_true = true
			for emitted in emitteds:
				all_true = all_true and emitted
			if all_true:
				gathered_signal.emit(fingerprint)
		
		emitteds.append(false)
		var signal_ = signals[index]
		signal_.connect(signal_callback)
	
	var value = null
	while value != fingerprint:
		value = await gathered_signal

func timer(seconds):
	var timer_instance = Timer.new()
	add_child(timer_instance)
	timer_instance.one_shot = true
	timer_instance.wait_time = seconds
	timer_instance.start()
	await timer_instance.timeout
	timer_instance.queue_free()
