class DataController < ApplicationController


  before_action :set_default_response_format

  def set_default_response_format
    request.format = :json
  end

  #routes that will serve JSON data that is useful for visualization
  #all data in returned in JSON
  def spell_freq
    path = 'data/viz_data/natr/spellFreq.json'
    file = File.read(path)
    render :json => file
  end

  def book_freq
    path = 'data/viz_data/natr/bookFreq.json'
    file = File.read(path)
    render :json => file
  end

  def spell_def_sent
    path = 'data/viz_data/nlp/NLPSpellPerEffect.json'
    file = File.read(path)
    render :json => file
  end

  def spell_in_men_sent
    path = 'data/viz_data/nlp/NLPSpellPerMentionAvg.json'
    file = File.read(path)
    render :json => file
  end

  def book_sent
    path = 'data/viz_data/nlp/NLPBookPerMentionAvg.json'
    file = File.read(path)
    render :json => file
  end

  def pos_men_sent
    path = 'data/viz_data/nlp/NLPPositionSentiment.json'
    file = File.read(path)
    render :json => file
  end

end
