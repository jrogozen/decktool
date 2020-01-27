module MarvelChampions
  class Ally < MarvelChampions::Card
    attr_accessor :card

    def create_image
      this = self

      layouts = [
        File.expand_path(File.join(File.dirname(__FILE__), '..', 'card_layout.yml')),
        File.absolute_path('ally.yml', __dir__),
      ]

      puts self.resources.inspect

      Squib::Deck.new(layout: layouts) do
        puts Pango.version_string

        png  layout: 'background_image', file: this.background_image_url

        svg layout: 'template_ally_header_background', data: this.sub_colors(File.read(File.absolute_path('ally_header_background.svg', __dir__)))
        svg layout: 'template_ally_footer_background', data: this.sub_colors(File.read(File.absolute_path('ally_footer_background.svg', __dir__)))

        svg layout: 'template_outline', data: File.read(File.absolute_path('ally_outline.svg', __dir__))
        svg layout: 'template_ally_header_colors', data: this.sub_colors(File.read(File.absolute_path('ally_header_colors.svg', __dir__)))
        svg layout: 'template_ally_description_colors', data: this.sub_colors(File.read(File.absolute_path('ally_description_colors.svg', __dir__)))
        svg layout: 'template_ally_header_text_background', data: File.read(File.absolute_path('ally_header_text_background.svg', __dir__))
        svg layout: 'template_ally_description_text_background', data: File.read(File.absolute_path('ally_description_text_background.svg', __dir__))
        svg layout: 'template_ally_cost_background', data: File.read(File.absolute_path('ally_cost_background.svg', __dir__))
        svg layout: 'template_ally_footer_splash', data: this.sub_colors(File.read(File.absolute_path('ally_footer_splash.svg', __dir__)))

        svg data: File.read(File.absolute_path('resource_background.svg', __dir__)), x: 2, y: 958.27
        
        # last
        svg data: File.read(File.absolute_path('ally_border.svg', __dir__)), x: 0, y: 0

        text layout: 'title', str: %q{<span>B</span><span size="x-small">LACK</span> <span>C</span><span size="x-small">AT</span>}
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

        png layout: 'splash_image', file: this.set_icon_url

        b = StringIO.new
        self.cards[0].cairo_surface.write_to_png(b)

        this.card = b.string
      end

      self.cleanup_temp_images
      return @card
    end
  end
end

