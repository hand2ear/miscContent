
----------------------------------
function printTable(aTable)
	local swapped = { }
	local key,value

	for key,value in pairs(aTable) do
		print(key,value)
	end
end
----------------------------------
function swappedTable(aTable)
	local swapped = { }
	local key,value

	for key,value in pairs(aTable) do
		swapped[value] = key
	end

	return swapped
end
----------------------------------
function concatenate(table1,table2)
	local resultTable = {}
	local key,value

	for key,value in pairs(table1) do
		resultTable[key] = value
	end

	for key,value in pairs(table2) do
		resultTable[key] = value
	end

	return resultTable
end
----------------------------------
function theNotesTable()
	local sharps = {}
	sharps[0] = "b#"
	sharps[1] = "c#"
	sharps[3] = "d#"
	sharps[5] = "e#"
	sharps[6] = "f#"
	sharps[8] = "g#"
	sharps[10] = "a#"
	sharps = swappedTable(sharps)

	local flats = {}
	flats[1] = "db"
	flats[3] = "eb"
	flats[4] = "fb"
	flats[6] = "gb"
	flats[8] = "ab"
	flats[10] = "bb"
	flats[11] = "cb"
	flats = swappedTable(flats)

	local naturals = {}
	naturals[0] = "c"
	naturals[2] = "d"
	naturals[4] = "e"
	naturals[5] = "f"
	naturals[7] = "g"
	naturals[9] = "a"
	naturals[11] = "b"
	naturals = swappedTable(naturals)

	local theNotes = {}

	theNotes = concatenate(flats,sharps)
	theNotes = concatenate(theNotes,naturals)

	return theNotes
end
----------------------------------
function pitchClass(notestring)
	local notes = theNotesTable()
	return notes[notestring]
end
----------------------------------
function pitchClassTableFrom(tableOfNoteStrings)
	local key,value
	local pitchClasses = {}
	for key,value in pairs(tableOfNoteStrings) do
		pitchClasses[key] = pitchClass(value)
	end
	return pitchClasses
end
----------------------------------
function noteString(pitchclass)
	local pitches = {}
	pitches[0] = "c"
	pitches[1] = "c#"
	pitches[2] = "d"
	pitches[3] = "eb"
	pitches[4] = "e"
	pitches[5] = "f"
	pitches[6] = "f#"
	pitches[7] = "g"
	pitches[8] = "ab"
	pitches[9] = "a"
	pitches[10] = "bb"
	pitches[11] = "b"
	return pitches[pitchclass]
end
----------------------------------
function mod12(number)
	return (number + 12) % 12
end
----------------------------------
function transpose(note,interval)
	return mod12(note+interval)
end
----------------------------------
function transposeTable(atable,interval)
	local transp = {}
	local key,value
	for key,value in pairs(atable) do
		transp[key] = noteString(transpose(pitchClass(value),interval))
	end
	return transp
end
----------------------------------
function invert(note,interval)
	return mod12(note - interval)
end
----------------------------------
function tableSize(atable)
	local size = 0
	local key,value
	for key,value in pairs(atable) do
		size = size + 1
	end
	return size
end
----------------------------------
function invertedRow(originalStr)
	local inverted = {}
	local pitch,nextPitch,i,inv

	inverted[1] = originalStr[1]
	inv = pitchClass(originalStr[1])

	local nItems = tableSize(originalStr)

	for i = 1,nItems-1,1 do
		pitch = pitchClass(originalStr[i])
		nextPitch = pitchClass(originalStr[i+1])
		interval = nextPitch - pitch
		inv = invert(inv,interval)
		inverted[i+1] = noteString(inv)
	end

	return inverted
end
----------------------------------
function pitchMatrix(tableOfNoteStrings)
	local pitchClasses = {}
	local key,value,first,transpVal
	local ikey,ivalue
	local outp = ""
	local transposed = 0
	local matrix = {}
	local rowCount = 1
	local row = {}

	pitchClasses = pitchClassTableFrom(tableOfNoteStrings)

	first = pitchClasses[1]

	for key,value in pairs(pitchClasses) do
		transpval = mod12(value - first)
		row = {}
		outp = ""
		for ikey,ivalue in pairs(pitchClasses) do
			transposed = transpose(ivalue,transpval)
			row[ikey] = noteString(transposed)
			outp = outp .. "  " .. noteString(transposed)
		end
		--print(outp)
		matrix[rowCount] = row
		rowCount = rowCount + 1
	end

	return matrix
end
----------------------------------
function fullpitchMatrix(tableOfNoteStrings)
	local pitchClasses = {}
	local key,value
	local ikey,ivalue
	local transposed = 0
	local matrix = {}
	local rowCount = 1
	local row = {}
	local invertedClasses = {}

	-- convert the string table into a numbers table
	pitchClasses = pitchClassTableFrom(tableOfNoteStrings)

	-- starting pich of the source row
	local first = pitchClasses[1]

	-- the source row inverted as a numbers table
	invertedClasses = pitchClassTableFrom(invertedRow(tableOfNoteStrings))

	-- this holds the transposition for each horizontal row
	local transpval = 0 -- first time, no transposition

	for key,value in pairs(pitchClasses) do
		row = {}

		-- creates a transposition of the source row using transpval
		for ikey,ivalue in pairs(pitchClasses) do
			transposed = transpose(ivalue,transpval)
			row[ikey] = noteString(transposed)
		end

		-- Add the row to the matrix
		matrix[rowCount] = row

		rowCount = rowCount + 1

		if (rowCount <= #invertedClasses) then
			transpval = mod12(invertedClasses[rowCount] - first)
		end

	end

	return matrix
end
----------------------------------
function printPitchMatrix(matrix)
	local rowKey,row
	local pitchKey,pitch
	local str = ""

	for rowKey,row in pairs(matrix) do
		str = ""
		for pitchKey,pitch in pairs(row) do
			if #pitch == 1 then
				str = str .. " "
			end
			str = str .. "  " .. pitch
		end
		print(str)
	end
end
----------------------------------
row = { "e","f#","g","a","b","c#","d" }

print("----")

originalMatrix = fullpitchMatrix(row)
printPitchMatrix(originalMatrix)

print("----")

--invertedMatrix = pitchMatrix(invertedRow(row))
--printPitchMatrix(invertedMatrix)


