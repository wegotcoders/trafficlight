
def method_one
	puts "Method one running"
end

def method_two
	puts "Method two running"
end

def method_three
	puts "Method three running"
end


while true
	sleep(1)
	method_one
	sleep(1)
	method_two
	sleep(1)
	method_three
end