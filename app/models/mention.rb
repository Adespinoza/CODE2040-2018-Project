require 'json'
require 'binaryheap'

class Mention

  def initialize(params)
    @book = params["Book"]
    @quote = params["Concordance"]
    @position = params["Position"]
    @name = params["Spell"]
  end

  attr_reader :book, :quote, :position, :name

  def self.data
    path = 'data/mentions.json'
    file = File.read(path)
    JSON.parse(file)
  end

  def self.random
    new(data.sample)
  end

  #function to find the frequency of each book in the data set
  def self.bookFrequency
    map = Hash.new(0)
    mentionArr = Mention.data
    for mention in mentionArr
      map[mention["Book"]] = map[mention["Book"]] + 1
    end
    return map
  end

  #function to create a map of books and all their spells (as well as their count)
  def self.spellsPerBook
    #we will map books to another map of spells to their counts
    bookToSpellsMap = Hash.new()

    books = ["1: SS", "2: CoS", "3: PoA", "4: GoF", "5: OotP", "6: HBP", "7: DH"]

    #populate bookToSpellsMap with other map that will eventually be a map of spells
    for b in books
      bookToSpellsMap[b] = Hash.new(0)
    end

    #iterate through mention data
    mentionArr = Mention.data
    for mention in mentionArr

      book = mention["Book"]
      spell = mention["Spell"]
      spellMapForBook = bookToSpellsMap[book]
      spellMapForBook[spell] = spellMapForBook[spell] + 1

      #update the bookToSpells map
      bookToSpellsMap[book] = spellMapForBook
    end
    return bookToSpellsMap
  end

  #function to find minimal size of number of spells out of all books
  def self.minimalSpellCountAmongAllBooks
    bookToSpellsMap = Mention.spellsPerBook
    minCount = Mention.data.size
    bookToSpellsMap.each do |k, v|
      if (minCount > v.size)
        minCount = v.size
      end
    end
    return minCount
  end

  #function to retrieve the top n spells per book
  def self.topNSpellsPerBook(n)
    bookToSpellsMap = Mention.spellsPerBook

    #we will return a map of books --> maps with the top n spells used
    #if there are non n spells used it only return as many as there are





  end

  #function to find the 8 most common names in mentions
  def self.topEightMostCommonNames
    bh = BinaryHeap.new
    map = Hash.new(0)
    mentionArr = Mention.data
    for mention in mentionArr
      map[mention["Book"]] = map[mention["Book"]] + 1
    end
    return map
  end


end
