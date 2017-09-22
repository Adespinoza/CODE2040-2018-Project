require 'json'
require 'binaryheap'
require 'httparty'

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
  #used for error handling
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
    booksToSpellsTopN = Hash.new()

    #populate bookToSpellsTopN with other map that will eventually be a map of spells
    bookToSpellsMap.each do |k, v|
      booksToSpellsTopN[k] = Hash.new(0)
    end

    #iterate through bookToSpellsMap and for each v find the top n
    bookToSpellsMap.each do |k, v|
      if (n > v.size)
        booksToSpellsTopN[k] = Hash[v.sort_by{|k2, v2| v2}.reverse]
      else
        count = 0
        Hash[v.sort_by{|k2, v2| v2}.reverse].each do |k3, v3|
          if count == n
            break
          end
          booksToSpellsTopN[k][k3] = v3
          count = count + 1
        end
      end
    end
    #return mapping of books to topN spells per book
    return booksToSpellsTopN
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

  #function to find the sentiment analysis of mention of each spell then average it out
  #again, we will cache the results to improve loading time in the front-end
  def self.computeSentimentPerSpellUsingMentions
    map = Hash.new(0.0)
    mentions = Mention.data
    #retrive map of counts of all spells in mentions
    countsOfSpells = Spell.findCountsOfAllSpellsInMention

    #compute running sum of sentiment score per spell
    for mention in mentions
      spell = mention["Spell"]
      passage = mention["Concordance"]

      params = {"document"=>{"type"=>"PLAIN_TEXT","content"=>passage}}
      res = HTTParty.post('https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyBOAfHGMstijDScEPO4E2_HRzd7-UoVR7g',
                          :body => params.to_json, :headers => {'Content-Type' => 'application/json'})
      map[spell] = map[spell] + res["documentSentiment"]["score"]
    end

    #compute averages
    map.each do |k, v|
      map[k] = (v / (countsOfSpells[k]))
    end

    #cache the results
    File.open("./data/NLPSpellPerMentionAvg.json", "w") do |f|
      f.write(map.to_json)
    end

    return true
  end




end
