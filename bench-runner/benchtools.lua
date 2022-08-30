local bencher = {}

function bencher.findPercentile(tbl, percentile)
	return tbl[math.floor(#tbl * percentile)]
end

function bencher.findMicroPercentile(tbl, percentile)
	local number = bencher.findPercentile(tbl, percentile)
	return number * 1000000
end


function bencher.benchmark(calls : number, fn : (...any) -> (),paramGenerator)
	local MeasuredTable = table.create(calls)
	local MetrixTable = {
		["10th Percentile"] = 0,
		["50th Percentile"] = 0,
		["90th Percentile"] = 0,
		["100th Percentile"] = 0,
		["MAX"] = 0,
		["MIN"] = '',
		["AVERAGE"] = 0,
		["TOTAL"] = 0
	}
	
	local ALL_TIME_SUM = 0
	
	for i = 1, calls do
        local generatedParams = {paramGenerator()}
		local TIME_START = os.clock()
		fn(table.unpack(generatedParams))
		local TIME_END = os.clock()
		 
		local TIME_DIFFERENCE =(TIME_END - TIME_START) * 1000000
		
		ALL_TIME_SUM += TIME_DIFFERENCE
		
		if TIME_DIFFERENCE > MetrixTable.MAX then
			MetrixTable.MAX = TIME_DIFFERENCE
		elseif MetrixTable.MIN == '' or TIME_DIFFERENCE < MetrixTable.MIN  then
			MetrixTable.MIN = TIME_DIFFERENCE
		end
		
		table.insert(MeasuredTable, TIME_DIFFERENCE )
	end
	


	table.sort(MeasuredTable)
	
	MetrixTable.TOTAL = ALL_TIME_SUM
	MetrixTable.AVERAGE = (ALL_TIME_SUM / calls) 
	
	MetrixTable["10th Percentile"] = bencher.findPercentile(MeasuredTable, 0.1)
	MetrixTable["50th Percentile"] = bencher.findPercentile(MeasuredTable, 0.5)
	MetrixTable["90th Percentile"] = bencher.findPercentile(MeasuredTable, 0.9)
	MetrixTable["100th Percentile"] = bencher.findPercentile(MeasuredTable, 1)

	return MeasuredTable, MetrixTable	
end




function bencher.compare(calls, fn1, fn2,...)
	local _, fn1Result = bencher.benchmark(calls, fn1,...)
	local _, fn2Result = bencher.benchmark(calls, fn2, ...)
	
	local finalResult = {}
	
	for Title, Content in fn1Result do
		local fn2Content = fn2Result[Title]
		
		if fn2Result[Title] > Content then
			finalResult[Title] = "fn1 does better at "..Title.." with: "..Content.." against: "..fn2Content
		else
			
			finalResult[Title] = "fn2 does better at "..Title.." with: "..fn2Content.." against: "..Content
		end
	end
	
	return finalResult
end

return bencher