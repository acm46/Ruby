def queryClasses(data, criteria)
  operations = [:filter, :sort_by, :limit, :select]
  output = data
  operations.each do |operation|
  	if criteria[operation] != nil
  		if operation == :select
  			output = send(:fieldselect, output, criteria[:select])  			
  		else
  			output = send(operation, output, criteria[operation])
  		end
  	end
  end
  return output
end

def sort_by(data, criteria)
	data.each do |course|
		course.default = 1.0/0.0
	end
	return data.sort_by {|course| course[criteria]}
end

def limit(data, criteria)
	return data if criteria == 0
	return data[0...criteria]
end

def fieldselect(data, criteria)
	return data if criteria.length == 0
	output = []
	data.each do |course|
		selections = {}
		criteria.each do |field|
			selections[field] = course[field] if course.include?(field)
		end
		output.push(selections)
	end
	return output
end

def filter(data, criteria)
	operators = {:gt => [1], :gte => [0,1], :lt => [-1], 
		:lte => [0,-1], :eq => [0], :neq => [-1,1]}
	data.each do |course|
		course.default = false
	end
	output = data
	criteria.each do |field, operations|
		operations.each do |operator, operand|
			output = output.find_all do |course|
				if operator == :exists
					course.include?(field) <=> operand
				else
					(operators[operator]).member?(course[field] <=> operand)
				end
			end
		end
	end
	return output
end


data = [{
  :department => 'CS',
  :number => 101,
  :name => 'Intro to Computer Science',
  :credits => 1.00
}, {
  :department => 'CS',
  :number => 82,
  :name => 'The Internet Seminar',
  :credits => 0.5
}, {
  :department => 'ECE',
  :number => 52,
  :name => 'Intro to Digital Logic'
  # Note that the :credits key-value pair is missing
}]
criteria = {
  :filter => {
    :number => {
      :gt => 30,
      :lt => 200
    },
    :credits => {
      :exists => true
    }
  },
  :sort_by => :number,
  :select => [:number, :name],
  :limit => 1
}
 
puts queryClasses(data, criteria).inspect