require 'json'
require 'httparty'

class Spell

  def initialize(params)
    @classification = params["Classification"]
    @effect = params["Effect"]
    @name = params["Spell(Lower)"]
    @formatted_name = params["Spell"]
  end

  attr_reader :classification, :effect, :name, :formatted_name

  def self.data
    path = 'data/spells.json'
    file = File.read(path)
    JSON.parse(file)
  end

  def self.random
    new(data.sample)
  end

  def self.effects
    data.map{|el| el["Effect"]}
  end

  # These two methods are used to validate answers
  def self.is_spell_name?(str)
    data.index { |el| el["Spell(Lower)"] == (str.downcase) }
  end

  def self.is_spell_name_for_effect?(name, effect)
    data.index { |el| el["Spell(Lower)"] == name && el["Effect"] == effect }
  end

  # To get access to the collaborative repository, complete the methods below.

  # Spell 1: Reverse
  # This instance method should return the reversed name of a spell
  # Tests: `bundle exec rspec -t reverse .`
  def reverse_name
    return name.reverse
  end

  # Spell 2: Counter
  # This instance method should return the number
  # (integer) of mentions of the spell.
  # Tests: `bundle exec rspec -t counter .`
  def mention_count
    count = 0
    mentionArr = Mention.data
    for mention in mentionArr
      if name == mention["Spell"]
        count = count + 1
      end
    end
    return count
  end

  # Spell 3: Letter
  # This instance method should return an array of all spell names
  # which start with the same first letter as the spell's name
  # Tests: `bundle exec rspec -t letter .`
  def names_with_same_first_letter
    arr = []
    spellArr = Spell.data

    for spell in spellArr

      if name[0] == spell["Spell(Lower)"][0]
        arr.push(spell["Spell(Lower)"])
      end
    end
    return arr
  end

  # Spell 4: Lookup
  # This class method takes a Mention object and
  # returns a Spell object with the same name.
  # If none are found it should return nil.
  # Tests: `bundle exec rspec -t lookup .`
  def self.find_by_mention(mention)

    spellName = mention.name
    spellArr = Spell.data

    for spell in spellArr
      if spell["Spell(Lower)"] == spellName
        spellCreated = Spell.new({"Classification" => spell["Classification"],
                      "Effect" => spell["Effect"],
                      "Spell(Lower)" => spell["Spell(Lower)"],
                      "Spell" => spell["Spell"]})
        return spellCreated
      end
    end
    return nil
  end

  #function to find the counts of all the spells in mention
  #returns an array
  def self.findCountsOfAllSpellsInMention
    map = Hash.new(0)
    mentionArr = Mention.data
    for mention in mentionArr
      map[mention["Spell"]] = map[mention["Spell"]] + 1
    end
    return map
  end


  #function to return a map of spells and their sentiment sentiment
  #score by using the google NLP API
  def self.sentimentPerSpellWriteFile
    map = Hash.new(0.0)
    spells = Spell.data

    for spell in spells
      eff = spell["Effect"]
      params = {"document"=>{"type"=>"PLAIN_TEXT","content"=>eff}}
      res = HTTParty.post('https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyBOAfHGMstijDScEPO4E2_HRzd7-UoVR7g',
                          :body => params.to_json, :headers => {'Content-Type' => 'application/json'})
      map[spell["Spell"]] = res["documentSentiment"]["score"]
    end
    #now we want to cache this map to JSON format to decrease running time
    File.open("./data/NLPSpellPerEffect.json", "w") do |f|
      f.write(map.to_json)
    end
    return true
  end




end
