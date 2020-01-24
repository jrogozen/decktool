Squib::Deck.new(layout: File.absolute_path('ally.yml', __dir__)) do
#   png  layout: 'background_image', file: File.absolute_path('blackcat_background_image.png', __dir__)

  # doc = Nokogiri::XML(File.absolute_path('ally.svg', __dir__))

  data = File.read(File.absolute_path('ally_inline.svg', __dir__))
    .gsub('${secondary_color}', '#000')
    .gsub('${primary_color}', '#ff0000')
    .gsub('${primary_color_texture}', '#000')
    .gsub('${tertiary_color}', '#d3d3d3')

  # puts doc
  svg layout: 'vector', data: data
  text layout: 'title', str: 'black cat'.upcase
  text layout: 'subtitle', str: 'felicia hardy'.upcase
  text layout: 'cost_shadow', str: 3
  extents = text layout: 'cost', str: 3
  text layout: 'type', str: 'ally'.upcase, x: (145 - extents[0][:width]) / 2
  text layout: 'thw', str: 'thw'.upcase
  text layout: 'thw_value_shadow', str: 1
  text layout: 'thw_value', str: 1
  text layout: 'atk', str: 'atk'.upcase
  text layout: 'atk_value_shadow', str: 1
  text layout: 'atk_value', str: 1
  text layout: 'health_shadow', str: 2
  text layout: 'health', str: 2
  text layout: 'attributes', str: 'hero for hire.'.upcase
  text layout: 'effect', str: '<b>Forced Response:</b> After you play Black Cat, discard the top 2 cards of your deck. Add each card with a printed resource discared this way to your hand.'
  text layout: 'quote', str: %q{"I'm not a hero. I'm a thief."}
  text layout: 'set', str: %q{<span>spider-man</span>  <span size="smaller">1/15</span>}, width: 280

  png layout: 'splash_image', file: File.absolute_path('spiderman_splash_image.png', __dir__)
  save_png prefix: 'mc_hero_deck_ally_'
end