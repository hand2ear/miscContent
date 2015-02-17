-- Create a new random word using a set of rules

-- originally written for android
-- require "android"

function stringToTableOfChars(theString)
 	local result = {}
	local i = 1

 	for i = 1,string.len(theString),1 do
 		result[i] = string.sub(theString,i,i) end

	return result
end
 -----------------------------------------------
function printTable(aTable)
 	local key,value
 	for key,value in pairs(aTable) do print(key,value) end
end
-----------------------------------------------
function randomTableChoice(aTable)
	local tableSize = 0
	local key,value
	local size = 0

	for key,value in pairs(aTable) do size = size + 1 end

	local choice = math.random(size)

 	repeat choice = math.floor(math.random(size))
 	until choice ~= 0

	return aTable[choice]
end
-----------------------------------------------
vowels = stringToTableOfChars("aeiouy")
consonants = stringToTableOfChars("bcdfghjklmnpqrstvwxz")
-----------------------------------------------
commonEndings = { "es","ed","er","ar","ous","ing","ation","tion","s" }
prefixes = { "qu","con","quo","ex","un"," in","re","de","be","mono","poly" }
-----------------------------------------------
function createRandomString(formatStr)
	local result = ""
	local i = 1
	local ch = " "

 	for i = 1,string.len(formatStr),1 do
		ch = string.sub(formatStr,i,i)

		if ch == "p" then
			result = result .. randomTableChoice(prefixes)
		end

 		if ch == "c" then
			result = result .. randomTableChoice(consonants)
			if result == "q" then
        			return "qu"
        		end
		end

 		if ch == "v" then
			result = result .. randomTableChoice(vowels)
		end

 		if ch == "e" then
			result = result .. randomTableChoice( commonEndings)
		end
	end

	return result
end
-----------------------------------------------
seed = os.time() % 100
math.randomseed(seed)
-- android.dialogCreateAlert("word",createRandomString("pvce"))
-- android.dialogShow()
print(createRandomString("pvce"))
