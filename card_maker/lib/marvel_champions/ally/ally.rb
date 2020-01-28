module MarvelChampions
  class Ally < MarvelChampions::Card
    def create_image
      # is there a better way to access this?
      this = self

      byteStream = StringIO.new

      position_layouts = [
        File.expand_path(File.join(File.dirname(__FILE__), '..', 'card_layout.yml')),
        File.absolute_path('ally.yml', __dir__),
      ]

      Squib::Deck.new(layout: position_layouts) do
        puts Pango.version_string

        png layout: 'background_image', file: this.background_image_url, width: :scale, height: 1051.92

        svg layout: 'template_ally_header_background', data: this.sub_colors(File.read(File.absolute_path('svg/ally_header_background.svg', __dir__)))
        svg layout: 'template_ally_footer_background', data: this.sub_colors(File.read(File.absolute_path('svg/ally_footer_background.svg', __dir__)))
        svg layout: 'template_outline', data: File.read(File.absolute_path('svg/ally_outline.svg', __dir__))
        svg layout: 'template_ally_header_colors', data: this.sub_colors(File.read(File.absolute_path('svg/ally_header_colors.svg', __dir__)))
        svg layout: 'template_ally_description_colors', data: this.sub_colors(File.read(File.absolute_path('svg/ally_description_colors.svg', __dir__)))
        svg layout: 'template_ally_header_text_background', data: File.read(File.absolute_path('svg/ally_header_text_background.svg', __dir__))
        svg layout: 'template_ally_description_text_background', data: File.read(File.absolute_path('svg/ally_description_text_background.svg', __dir__))
        svg layout: 'template_ally_cost_background', data: File.read(File.absolute_path('svg/ally_cost_background.svg', __dir__))

        if (this.set_icon_url)
          svg layout: 'template_ally_footer_splash', data: this.sub_colors(File.read(File.absolute_path('svg/ally_footer_splash.svg', __dir__)))
        end
        
        this.get_resources_html(self, 2, 958.27)
        
        svg data: File.read(File.absolute_path('svg/ally_border.svg',  __dir__)), x: 0, y: 0

        text layout: 'title', str: this.get_title_html()
        text layout: 'subtitle', str: this.subtitle.upcase
        text layout: 'cost_shadow', str: this.cost
        extents = text layout: 'cost', str: this.cost
        text layout: 'type', str: 'ally'.upcase, x: (145 - extents[0][:width]) / 2

        text layout: 'thw', str: 'thw'.upcase
        text layout: 'thw_value_shadow', str: this.thw
        text layout: 'thw_value', str: this.thw
        this.get_consequence_html(self, this.thw_consequence, 40, 240)

        text layout: 'atk', str: 'atk'.upcase
        text layout: 'atk_value_shadow', str: this.atk
        text layout: 'atk_value', str: this.atk
        this.get_consequence_html(self, this.atk_consequence, 40, 525)
        
        text layout: 'health_shadow', str: this.health
        text layout: 'health', str: this.health
        text layout: 'attributes', str: this.get_attributes_html()
        text(layout: 'description', str: this.description) do |embed|
          this.embed_svgs(embed)
        end
        text layout: 'quote', str: this.get_quote_html()
        text layout: 'set', str: this.get_set_html()
        png layout: 'set_icon', file: this.set_icon_url

        self.cards[0].cairo_surface.write_to_png(byteStream)
      end

      self.cleanup_temp_images

      byteStream.string
    end
  end
end

