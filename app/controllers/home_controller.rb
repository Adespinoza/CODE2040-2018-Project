class HomeController < ApplicationController

  # GET /
  def index
    @name = Spell.random.name
    @other = Mention.random.quote
    @otherSpell = Spell.findCountsOfAllSpellsInMention
    @bookData = Mention.bookFrequency
  end

  # GET /about
  def about
    @your_name = 'alexis herrera'
    #
  end

end
