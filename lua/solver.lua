local letters <const> = "abcdefg"

function count(word, target)
  return select(2, string.gsub(word, target, ""))
end

function valid(word) 
  for idx = 1, #word do
    local letter = word:sub(idx, idx)

    if count(word, letter) > count(letters, letter) then
      return false
    end
  end

  return true
end

function loadValidWords()
  local words = {}

  local file = assert(io.open("dictionary.txt", "r"))
  local content = file:read("*all")
  file:close()

  for word in content:gmatch("[^\n\r]+") do
    if valid(word) then
      words[#words + 1] = word
    end
  end

  return words
end

function getScore(word)
  local scores <const> = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 
    1, 1, 11, 4, 4, 8, 4, 10}

  local total = 0

  for idx = 1, #word do
    total = total + scores[word:byte(idx) - 96]
  end

  return total
end

function sortWords(words)
  table.sort(words, function (a, b)
    return getScore(a) < getScore(b)
  end)
end

function displayWords(words)
  for idx = #words, 1, -1 do
    print(idx .. [[. ]] .. words[#words - idx + 1])
  end
end

function main()
  local words = loadValidWords()
  sortWords(words)
  displayWords(words)
end

main()
