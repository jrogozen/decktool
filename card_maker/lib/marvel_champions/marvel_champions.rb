module MarvelChampions
  class Card
    attr_reader :atk
    attr_reader :atk_consequence
    attr_reader :attributes
    attr_reader :background_image_url
    attr_reader :cost
    attr_reader :def
    attr_reader :description
    attr_reader :foreground_image_url
    attr_reader :health
    attr_reader :hit_points
    attr_reader :illustrator
    attr_reader :primary_color
    attr_reader :quote
    attr_reader :resources
    attr_reader :secondary_color
    attr_reader :set_icon_url
    attr_reader :set_name
    attr_reader :set_position
    attr_reader :subtitle
    attr_reader :tertiary_color
    attr_reader :thw
    attr_reader :thw_consequence
    attr_reader :title
    attr_reader :resource_svgs
    
    def initialize(args)
      @atk = args[:atk]
      @atk_consequence = args[:atk_consequence] ? args[:atk_consequence].to_i : 0
      @attributes = args[:attributes] || ''
      @background_image_url = get_image_from_url(args[:background_image_url])
      @cost = args[:cost]
      @def = args[:def]
      @description = args[:description]
      @foreground_image_url = get_image_from_url(args[:foreground_image_url])
      @health = args[:health]
      @hit_points = args[:hit_points]
      @illustrator = args[:illustrator]
      @primary_color = args[:primary_color]
      @quote = args[:quote]
      @resources = (args[:resources] || '').split(',')
        .map do |r|
          resource = r.split('=')
          { type: resource[0], count: resource[1] }
        end
      @secondary_color = args[:secondary_color]
      @set_icon_url = get_image_from_url(args[:set_icon_url])
      @set_name = args[:set_name] || ''
      @set_position = args[:set_position] || ''
      @subtitle = args[:subtitle] || ''
      @tertiary_color = args[:tertiary_color]
      @thw = args[:thw]
      @thw_consequence = args[:thw_consequence] ? args[:thw_consequence].to_i : 0
      @title = args[:title] || ''
      @resource_svgs = {
        background: Pathname.new(__FILE__).dirname.join('resources', 'resource_background.svg'),
        consequence: Pathname.new(__FILE__).dirname.join('resources', 'consequence_icon.svg'),
        energy: Pathname.new(__FILE__).dirname.join('resources', 'energy_icon.svg'),
        wild: Pathname.new(__FILE__).dirname.join('resources', 'wild_icon.svg'),
        mental: Pathname.new(__FILE__).dirname.join('resources', 'mental_icon.svg'),
        strength: Pathname.new(__FILE__).dirname.join('resources', 'strength_icon.svg')
      }
      @resource_background_colors = {
        energy: '#f1be48',
        wild: '#298a43',
        strength: '#782017',
        mental: '#4a68ae'
      }
    end

    def get_resources_html(deck, start_x, start_y)
      current_x = start_x
      current_y = start_y
      background_height = 70
      
      @resources.each do |resource|
        (0...resource[:count].to_i).each do
          icon_data = sub_fill_color(File.read(@resource_svgs[resource[:type].to_sym]), 'rgba(0,0,0,0.30)')

          deck.svg data: sub_fill_color(File.read(@resource_svgs[:background]), @resource_background_colors[resource[:type].to_sym]), x: current_x, y: current_y
          deck.svg data: icon_data, layout: 'resource_icon', x: current_x + 50, y: current_y + 28
          current_y -= background_height
        end
      end
    end

    def get_consequence_html(deck, count, start_x, end_x, start_y)
      width = end_x - start_x
      mid_point = width / 2
      icon_width = 35
      icon_mid_point = (icon_width * count) / 2

      current_x = start_x + (mid_point - icon_mid_point)
      current_y = start_y

      (0...count.to_i).each do
        deck.svg data: File.read(@resource_svgs[:consequence]), x: current_x, y: current_y
        current_x += icon_width
      end
    end

    def get_attributes_html
      @attributes.split(',')
        .map do |word|
          "#{word}."
        end
        .join(' ')
    end

    def get_quote_html
      return if @quote.nil? or @quote.eql? ''

      %Q{"#{@quote}"}
    end

    def get_set_html
      string = %Q{<span>#{@set_name.upcase}</span>}

      if !@set_position.eql?('')
        string += %Q{  <span>#{@set_position}</span>}
      end

      string
    end

    def get_image_from_url(url)
      return if url.nil? or url.eql? ''

      output_dir = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'temp_image_backgrounds'))
      filename = "#{output_dir}/#{url.split('/').last}"

      File.open(filename, "w") do |file|
        response = HTTParty.get(url, stream_body: true) do |fragment|
          if [301, 302].include?(fragment.code)
            print "skip writing for redirect"
          elsif fragment.code === 200
            print '.'
            file.write(fragment)
          else
            raise StandardError, "non-success status code while streaming #{fragment.code}"
          end
        end

        puts

        pp "file download success: #{response.success?}"
        pp File.stat(filename).inspect
      end

      filename
    end

    def get_title_html
      title_array = @title.upcase.split(' ')
      formatted_arr = title_array.map do |word|
        %Q{<span>#{word[0]}</span><span size="x-small">#{word[1...word.length]}</span>}
      end

      formatted_arr.join(' ')
    end

    def cleanup_temp_images
      downloaded_image_filepaths = [@background_image_url, @foreground_image_url, @set_icon_url]

      downloaded_image_filepaths.each do |file|
        next if file.nil? or file.eql? ''
        puts "deleting #{file} from temp dir"

        File.unlink(file)
      end
    end

    def sub_colors(str)
      str
        .gsub('{primary_color}', @primary_color)
        .gsub('{secondary_color}', @secondary_color)
        .gsub('{tertiary_color}', @tertiary_color)
    end

    def sub_fill_color(str, color)
      str.gsub('{fill_color}', color)
    end

    def embed_svgs(embed)
      embed.svg key: ':energy:', width: 22, height: 22, dx: 4, dy: 10, file: @resource_svgs[:energy]
      embed.svg key: ':wild:', width: 22, height: 22, dx: 4, dy: 10, file: @resource_svgs[:wild]
      embed.svg key: ':mental:', width: 22, height: 22, dx: 4, dy: 10, file: @resource_svgs[:mental]
      embed.svg key: ':strength:', width: 22, height: 22, dx: 4, dy: 10, file: @resource_svgs[:strength]
    end
  end
end